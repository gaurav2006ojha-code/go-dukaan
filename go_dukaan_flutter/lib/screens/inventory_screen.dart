import 'package:flutter/material.dart';

import '../client.dart';

/// GO Dukaan - Inventory management screen.
///
/// Includes:
/// - Product search and pull-to-refresh
/// - Add product
/// - Edit product (prefilled form)
/// - Stock and low-stock indicators
/// - Validation for numeric fields
/// - Loading/error/empty states
///
/// This screen calls the existing Serverpod methods:
/// client.product.getProducts()
/// client.product.createProduct(...)
/// client.product.updateProduct(productId: ...)
class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  static const Color _background = Color(0xFF07111F);
  static const Color _panel = Color(0xFF102238);
  static const Color _blue = Color(0xFF19B5FE);
  

  String _search = '';
  late Future<List<dynamic>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = client.product.getProducts();
  }

  Future<void> _loadProducts() async {
    final future = client.product.getProducts();

    if (mounted) {
      setState(() => _productsFuture = future);
    } else {
      _productsFuture = future;
    }

    try {
      await future;
    } catch (e) {
      if (mounted) {
        _showMessage('Products load failed: $e', error: true);
      }
    }
  }

  Future<void> _addProduct() async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: _panel,
      builder: (_) => const _ProductFormSheet(),
    );

    if (result == true && mounted) {
      await _loadProducts();
      if (mounted) _showMessage('Product added successfully.');
    }
  }

  Future<void> _editProduct(dynamic product) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: _panel,
      builder: (_) => _ProductFormSheet(product: product),
    );

    if (result == true && mounted) {
      await _loadProducts();
      if (mounted) _showMessage('Product updated successfully.');
    }
  }

  void _showMessage(String message, {bool error = false}) {
    if (!mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: error ? Colors.redAccent : const Color(0xFF087FBA),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(12),
        ),
      );
  }

  List<dynamic> _filterProducts(List<dynamic> products) {
    final query = _search.trim().toLowerCase();
    if (query.isEmpty) return products;

    return products.where((product) {
      final name = product.name.toString().toLowerCase();
      final category = product.category.toString().toLowerCase();
      final sku = (product.sku ?? '').toString().toLowerCase();
      final barcode = (product.barcode ?? '').toString().toLowerCase();

      return name.contains(query) ||
          category.contains(query) ||
          sku.contains(query) ||
          barcode.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _background,
        elevation: 0,
        title: const Text(
          'Inventory',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh inventory',
            onPressed: _loadProducts,
            icon: const Icon(Icons.refresh_rounded),
          ),
          const SizedBox(width: 4),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addProduct,
        backgroundColor: _blue,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Add Product',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
            child: TextField(
              onChanged: (value) => setState(() => _search = value),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search name, category, SKU or barcode...',
                hintStyle: TextStyle(color: Colors.white.withValues(alpha: .45)),
                prefixIcon: const Icon(Icons.search_rounded, color: _blue),
                suffixIcon: _search.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Clear search',
                        onPressed: () => setState(() => _search = ''),
                        icon: const Icon(Icons.close_rounded),
                      ),
                filled: true,
                fillColor: Colors.white.withValues(alpha: .06),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: _blue),
                  );
                }

                if (snapshot.hasError) {
                  return _ErrorState(
                    message: 'Unable to load inventory.\n${snapshot.error}',
                    onRetry: _loadProducts,
                  );
                }

                final products = snapshot.data ?? <dynamic>[];
                final filtered = _filterProducts(products);

                if (filtered.isEmpty) {
                  return _EmptyState(
                    searching: _search.trim().isNotEmpty,
                    onAdd: _addProduct,
                    onClearSearch: () => setState(() => _search = ''),
                  );
                }

                return RefreshIndicator(
                  color: _blue,
                  onRefresh: _loadProducts,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 110),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final product = filtered[index];
                      final int stock = (product.stockQuantity as num).toInt();
                      final int lowAlert = (product.lowStockAlert as num).toInt();
                      final bool isLowStock = stock <= lowAlert;

                      return _ProductCard(
                        product: product,
                        stock: stock,
                        isLowStock: isLowStock,
                        onEdit: () => _editProduct(product),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.product,
    required this.stock,
    required this.isLowStock,
    required this.onEdit,
  });

  final dynamic product;
  final int stock;
  final bool isLowStock;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final price = (product.sellingPrice as num).toDouble();
    final purchasePrice = (product.purchasePrice as num).toDouble();
    final sku = (product.sku ?? '').toString();
    final barcode = (product.barcode ?? '').toString();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .055),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isLowStock
              ? Colors.redAccent.withValues(alpha: .35)
              : Colors.white.withValues(alpha: .07),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF19B5FE), Color(0xFF6557FF)],
                  ),
                ),
                child: const Icon(
                  Icons.inventory_2_rounded,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.category.toString(),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: .58),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        _InfoChip(
                          icon: Icons.sell_outlined,
                          label: '₹${price.toStringAsFixed(2)}',
                        ),
                        _InfoChip(
                          icon: Icons.inventory_outlined,
                          label: '$stock ${product.unit}',
                          danger: isLowStock,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              IconButton(
                tooltip: 'Edit product',
                onPressed: onEdit,
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFF19B5FE).withValues(alpha: .13),
                  foregroundColor: const Color(0xFF19B5FE),
                ),
                icon: const Icon(Icons.edit_rounded),
              ),
            ],
          ),
          const SizedBox(height: 13),
          Divider(color: Colors.white.withValues(alpha: .08), height: 1),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _SmallDetail(
                  label: 'PURCHASE',
                  value: '₹${purchasePrice.toStringAsFixed(2)}',
                ),
              ),
              Expanded(
                child: _SmallDetail(
                  label: 'LOW STOCK AT',
                  value: '${product.lowStockAlert} ${product.unit}',
                ),
              ),
              if (isLowStock)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withValues(alpha: .14),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'LOW STOCK',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
            ],
          ),
          if (sku.isNotEmpty || barcode.isNotEmpty) ...[
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 12,
                runSpacing: 5,
                children: [
                  if (sku.isNotEmpty)
                    _MetaText(icon: Icons.qr_code_2_rounded, text: 'SKU: $sku'),
                  if (barcode.isNotEmpty)
                    _MetaText(icon: Icons.qr_code_scanner_rounded, text: 'Barcode: $barcode'),
                ],
              ),
            ),
          ],
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onEdit,
              icon: const Icon(Icons.edit_note_rounded, size: 19),
              label: const Text('Edit product details / stock'),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
    this.danger = false,
  });

  final IconData icon;
  final String label;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final color = danger ? Colors.redAccent : const Color(0xFF19B5FE);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .11),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: danger ? Colors.redAccent : Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallDetail extends StatelessWidget {
  const _SmallDetail({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: .42),
            fontSize: 9,
            fontWeight: FontWeight.w800,
            letterSpacing: .7,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _MetaText extends StatelessWidget {
  const _MetaText({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.white54),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white60, fontSize: 11),
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.searching,
    required this.onAdd,
    required this.onClearSearch,
  });

  final bool searching;
  final VoidCallback onAdd;
  final VoidCallback onClearSearch;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                color: const Color(0xFF19B5FE).withValues(alpha: .10),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.inventory_2_outlined,
                size: 40,
                color: Color(0xFF19B5FE),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              searching ? 'No matching products' : 'No products yet',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              searching
                  ? 'Try another product name, category, SKU or barcode.'
                  : 'Add your first product to start managing stock.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white.withValues(alpha: .55)),
            ),
            const SizedBox(height: 22),
            if (searching)
              OutlinedButton.icon(
                onPressed: onClearSearch,
                icon: const Icon(Icons.clear_all_rounded),
                label: const Text('Clear Search'),
              )
            else
              ElevatedButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add First Product'),
              ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off_rounded, color: Colors.redAccent, size: 46),
            const SizedBox(height: 16),
            const Text(
              'Inventory could not be loaded',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white60),
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Reused form for creating and editing a product.
/// If [product] is provided, existing values are placed into the controllers
/// and updateProduct is called instead of createProduct.
class _ProductFormSheet extends StatefulWidget {
  const _ProductFormSheet({this.product});

  final dynamic product;

  bool get isEditing => product != null;

  @override
  State<_ProductFormSheet> createState() => _ProductFormSheetState();
}

class _ProductFormSheetState extends State<_ProductFormSheet> {
  static const Color _blue = Color(0xFF19B5FE);

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _name;
  late final TextEditingController _sku;
  late final TextEditingController _barcode;
  late final TextEditingController _category;
  late final TextEditingController _purchasePrice;
  late final TextEditingController _sellingPrice;
  late final TextEditingController _stock;
  late final TextEditingController _lowStock;
  late final TextEditingController _unit;

  bool _saving = false;

  @override
  void initState() {
    super.initState();

    final p = widget.product;
    _name = TextEditingController(text: p == null ? '' : p.name.toString());
    _sku = TextEditingController(text: p == null ? '' : (p.sku ?? '').toString());
    _barcode = TextEditingController(text: p == null ? '' : (p.barcode ?? '').toString());
    _category = TextEditingController(text: p == null ? '' : p.category.toString());
    _purchasePrice = TextEditingController(
      text: p == null ? '' : (p.purchasePrice as num).toString(),
    );
    _sellingPrice = TextEditingController(
      text: p == null ? '' : (p.sellingPrice as num).toString(),
    );
    _stock = TextEditingController(
      text: p == null ? '' : p.stockQuantity.toString(),
    );
    _lowStock = TextEditingController(
      text: p == null ? '10' : p.lowStockAlert.toString(),
    );
    _unit = TextEditingController(text: p == null ? 'pcs' : p.unit.toString());
  }

  @override
  void dispose() {
    _name.dispose();
    _sku.dispose();
    _barcode.dispose();
    _category.dispose();
    _purchasePrice.dispose();
    _sellingPrice.dispose();
    _stock.dispose();
    _lowStock.dispose();
    _unit.dispose();
    super.dispose();
  }

  String? _requiredText(String? value, String label) {
    if (value == null || value.trim().isEmpty) return '$label is required';
    return null;
  }

  String? _validatePrice(String? value, String label) {
    final requiredError = _requiredText(value, label);
    if (requiredError != null) return requiredError;

    final parsed = double.tryParse(value!.trim());
    if (parsed == null || !parsed.isFinite) return 'Enter a valid $label';
    if (parsed < 0) return '$label cannot be negative';
    return null;
  }

  String? _validateInteger(String? value, String label) {
    final requiredError = _requiredText(value, label);
    if (requiredError != null) return requiredError;

    final parsed = int.tryParse(value!.trim());
    if (parsed == null) return 'Enter a whole number';
    if (parsed < 0) return '$label cannot be negative';
    return null;
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    final purchase = double.tryParse(_purchasePrice.text.trim());
    final selling = double.tryParse(_sellingPrice.text.trim());
    final stock = int.tryParse(_stock.text.trim());
    final lowStock = int.tryParse(_lowStock.text.trim());

    if (purchase == null || selling == null || stock == null || lowStock == null) {
      _message('Please check the price and stock fields.', error: true);
      return;
    }

    if (widget.isEditing && widget.product.id == null) {
      _message('Cannot edit this product because its ID is missing.', error: true);
      return;
    }

    setState(() => _saving = true);

    try {
      if (widget.isEditing) {
        await client.product.updateProduct(
          productId: widget.product.id as int,
          name: _name.text.trim(),
          sku: _sku.text.trim().isEmpty ? null : _sku.text.trim(),
          barcode: _barcode.text.trim().isEmpty ? null : _barcode.text.trim(),
          category: _category.text.trim(),
          purchasePrice: purchase,
          sellingPrice: selling,
          stockQuantity: stock,
          lowStockAlert: lowStock,
          unit: _unit.text.trim(),
        );
      } else {
        await client.product.createProduct(
          name: _name.text.trim(),
          sku: _sku.text.trim().isEmpty ? null : _sku.text.trim(),
          barcode: _barcode.text.trim().isEmpty ? null : _barcode.text.trim(),
          category: _category.text.trim(),
          purchasePrice: purchase,
          sellingPrice: selling,
          stockQuantity: stock,
          lowStockAlert: lowStock,
          unit: _unit.text.trim(),
        );
      }

      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      _message(
        '${widget.isEditing ? 'Product update' : 'Product save'} failed: $e',
        error: true,
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _message(String message, {bool error = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: error ? Colors.redAccent : const Color(0xFF087FBA),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, bottomInset + 20),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [_blue, Color(0xFF6557FF)],
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      widget.isEditing ? Icons.edit_rounded : Icons.add_box_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.isEditing ? 'Edit Product' : 'Add Product',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          widget.isEditing
                              ? 'Update product details and stock.'
                              : 'Enter product information to add it to inventory.',
                          style: const TextStyle(color: Colors.white60, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Close',
                    onPressed: _saving ? null : () => Navigator.pop(context, false),
                    icon: const Icon(Icons.close_rounded, color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              _sectionTitle('PRODUCT INFORMATION'),
              _field(
                controller: _name,
                label: 'Product Name',
                icon: Icons.inventory_2_outlined,
                validator: (v) => _requiredText(v, 'Product name'),
                textCapitalization: TextCapitalization.words,
              ),
              _field(
                controller: _category,
                label: 'Category',
                icon: Icons.category_outlined,
                validator: (v) => _requiredText(v, 'Category'),
                textCapitalization: TextCapitalization.words,
              ),
              Row(
                children: [
                  Expanded(
                    child: _field(
                      controller: _sku,
                      label: 'SKU (optional)',
                      icon: Icons.qr_code_2_rounded,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _field(
                      controller: _barcode,
                      label: 'Barcode (optional)',
                      icon: Icons.qr_code_scanner_rounded,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _sectionTitle('PRICING'),
              Row(
                children: [
                  Expanded(
                    child: _field(
                      controller: _purchasePrice,
                      label: 'Purchase Price (₹)',
                      icon: Icons.shopping_cart_outlined,
                      keyboard: const TextInputType.numberWithOptions(decimal: true),
                      validator: (v) => _validatePrice(v, 'purchase price'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _field(
                      controller: _sellingPrice,
                      label: 'Selling Price (₹)',
                      icon: Icons.sell_outlined,
                      keyboard: const TextInputType.numberWithOptions(decimal: true),
                      validator: (v) => _validatePrice(v, 'selling price'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _sectionTitle(widget.isEditing ? 'UPDATE STOCK' : 'INITIAL STOCK'),
              Row(
                children: [
                  Expanded(
                    child: _field(
                      controller: _stock,
                      label: widget.isEditing ? 'Current Stock' : 'Opening Stock',
                      icon: Icons.inventory_outlined,
                      keyboard: TextInputType.number,
                      validator: (v) => _validateInteger(v, 'stock'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _field(
                      controller: _lowStock,
                      label: 'Low Stock Alert',
                      icon: Icons.warning_amber_rounded,
                      keyboard: TextInputType.number,
                      validator: (v) => _validateInteger(v, 'low-stock alert'),
                    ),
                  ),
                ],
              ),
              _field(
                controller: _unit,
                label: 'Unit (pcs, kg, litre, etc.)',
                icon: Icons.straighten_outlined,
                validator: (v) => _requiredText(v, 'Unit'),
                textCapitalization: TextCapitalization.none,
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: _blue.withValues(alpha: .08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _blue.withValues(alpha: .18)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.info_outline_rounded, color: _blue, size: 19),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        widget.isEditing
                            ? 'Saving will update this product in your shop inventory. Enter the final stock quantity you want to keep.'
                            : 'Review the prices and opening stock before saving. SKU and barcode can be left blank.',
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: _saving ? null : _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _blue,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: _blue.withValues(alpha: .4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  icon: _saving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Icon(
                          widget.isEditing
                              ? Icons.save_as_rounded
                              : Icons.check_circle_outline_rounded,
                        ),
                  label: Text(
                    _saving
                        ? 'Saving...'
                        : widget.isEditing
                            ? 'Update Product'
                            : 'Save Product',
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 4),
      child: Text(
        title,
        style: const TextStyle(
          color: _blue,
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboard,
    String? Function(String?)? validator,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        validator: validator,
        textCapitalization: textCapitalization,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        cursorColor: _blue,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white.withValues(alpha: .62), fontSize: 12),
          prefixIcon: Icon(icon, color: _blue, size: 20),
          filled: true,
          fillColor: Colors.white.withValues(alpha: .055),
          errorMaxLines: 2,
          contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.white.withValues(alpha: .06)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: _blue, width: 1.3),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.redAccent),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.3),
          ),
        ),
      ),
    );
  }
}
