
import 'package:flutter/material.dart';
import '../client.dart';

const Color _bg = Color(0xFF07111F);
const Color _panel = Color(0xFF102238);
const Color _blue = Color(0xFF19B5FE);
const Color _green = Color(0xFF31D0AA);
const Color _muted = Color(0xFF91A4BB);

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  late Future<List<dynamic>> _productsFuture;
  late Future<List<dynamic>> _purchasesFuture;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  void _loadData() {
    _productsFuture = _getProducts();
    _purchasesFuture = _getPurchases();
  }

  Future<List<dynamic>> _getProducts() async {
    return (await client.product.getProducts()).cast<dynamic>();
  }

  Future<List<dynamic>> _getPurchases() async {
    return (await client.purchase.getPurchases()).cast<dynamic>();
  }

  Future<void> _refresh() async {
    setState(_loadData);
    try {
      await Future.wait([_productsFuture, _purchasesFuture]);
    } catch (_) {
      // FutureBuilder displays the error and offers retry.
    }
  }

  void _message(String message, {bool error = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: error ? Colors.redAccent : _green,
      ),
    );
  }

  Future<void> _openNewPurchase() async {
    final products = await _productsFuture;
    if (!mounted) return;

    if (products.isEmpty) {
      _message('Pehle Inventory mein product add karo.', error: true);
      return;
    }

    final saved = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => NewPurchaseScreen(products: products),
      ),
    );

    if (saved == true) {
      await _refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Purchase Center',
                style: TextStyle(fontWeight: FontWeight.w900)),
            Text('Stock • Supplier • Payments',
                style: TextStyle(color: _muted, fontSize: 11)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _refresh,
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Refresh',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openNewPurchase,
        backgroundColor: _blue,
        foregroundColor: _bg,
        icon: const Icon(Icons.add_shopping_cart_rounded),
        label: const Text('New Purchase',
            style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF155E91), Color(0xFF15314D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: _blue.withValues(alpha: .25)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('PURCHASE MANAGEMENT',
                            style: TextStyle(
                                fontSize: 10,
                                letterSpacing: 1.4,
                                color: Colors.white70,
                                fontWeight: FontWeight.w800)),
                        const SizedBox(height: 10),
                        const Text('Stock ko banao\nhamesha updated.',
                            style: TextStyle(
                                fontSize: 23,
                                height: 1.2,
                                fontWeight: FontWeight.w900)),
                        const SizedBox(height: 14),
                        FilledButton.icon(
                          onPressed: _openNewPurchase,
                          icon: const Icon(Icons.add_rounded),
                          label: const Text('Add Purchase'),
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF155E91),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .10),
                      borderRadius: BorderRadius.circular(23),
                    ),
                    child: const Icon(
                      Icons.inventory_2_rounded,
                      size: 43,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: _panel,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TabBar(
                controller: _tabs,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: _blue.withValues(alpha: .18),
                  borderRadius: BorderRadius.circular(11),
                ),
                labelColor: _blue,
                unselectedLabelColor: _muted,
                tabs: const [
                  Tab(
                    icon: Icon(Icons.receipt_long_rounded, size: 18),
                    text: 'Purchase History',
                  ),
                  Tab(
                    icon: Icon(Icons.inventory_2_rounded, size: 18),
                    text: 'Stock Overview',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: [
                _PurchaseHistory(
                  future: _purchasesFuture,
                  onRetry: _refresh,
                ),
                _StockOverview(
                  future: _productsFuture,
                  onRetry: _refresh,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NewPurchaseScreen extends StatefulWidget {
  final List<dynamic> products;

  const NewPurchaseScreen({super.key, required this.products});

  @override
  State<NewPurchaseScreen> createState() => _NewPurchaseScreenState();
}

class _NewPurchaseScreenState extends State<NewPurchaseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _supplier = TextEditingController();
  final _phone = TextEditingController();
  final _invoice = TextEditingController();
  final _paid = TextEditingController(text: '0');
  final _notes = TextEditingController();

  final Map<int, int> _quantities = {};
  final Map<int, TextEditingController> _prices = {};

  DateTime _date = DateTime.now();
  bool _saving = false;

  double get _total {
    double total = 0;
    for (final product in widget.products) {
      final id = product.id as int?;
      if (id == null) continue;
      final quantity = _quantities[id] ?? 0;
      final price =
          double.tryParse(_prices[id]?.text.trim() ?? '') ?? 0;
      total += quantity * price;
    }
    return total;
  }
double get _paidAmount =>
    double.tryParse(_paid.text.trim()) ?? 0;
  
  double get _due => _total - _paidAmount;

  List<dynamic> get _selectedProducts => widget.products.where((p) {
        final id = p.id as int?;
        return id != null && (_quantities[id] ?? 0) > 0;
      }).toList();

  @override
  void initState() {
    super.initState();
    for (final product in widget.products) {
      final id = product.id as int?;
      if (id != null) {
        _quantities[id] = 0;
        _prices[id] = TextEditingController(
          text: (product.purchasePrice as num).toString(),
        );
        _prices[id]!.addListener(_updateTotals);
      }
    }
    _paid.addListener(_updateTotals);
  }

  void _updateTotals() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _supplier.dispose();
    _phone.dispose();
    _invoice.dispose();
    _paid.removeListener(_updateTotals);
    _paid.dispose();
    _notes.dispose();
    for (final controller in _prices.values) {
      controller.removeListener(_updateTotals);
      controller.dispose();
    }
    super.dispose();
  }

  void _toast(String text, {bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
        backgroundColor: error ? Colors.redAccent : _green,
      ),
    );
  }

  Future<void> _pickDate() async {
    final chosen = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.dark(
            primary: _blue,
            surface: _panel,
          ),
        ),
        child: child!,
      ),
    );

    if (chosen != null) setState(() => _date = chosen);
  }

  Future<void> _savePurchase() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedProducts.isEmpty) {
      _toast('Kam se kam ek product select karo.', error: true);
      return;
    }

    if (!_paidAmount.isFinite ||
    _paidAmount < 0 ||
    _paidAmount > _total) {
      _toast('Paid amount total ke beech hona chahiye.',
          error: true);
      return;
    }

    for (final product in _selectedProducts) {
      final id = product.id as int;
      final price = double.tryParse(_prices[id]!.text.trim());
      if (price == null || !price.isFinite || price < 0) {
        _toast('${product.name}: valid purchase price daalo.',
            error: true);
        return;
      }
    }

    setState(() => _saving = true);

    try {
      final items = _selectedProducts.map((product) {
        final id = product.id as int;
        return <String, dynamic>{
          'productId': id,
          'quantity': _quantities[id]!,
          'unitPurchasePrice':
              double.parse(_prices[id]!.text.trim()),
        };
      }).toList();

      await client.purchase.createPurchase(
        supplierName: _supplier.text.trim(),
        supplierPhone:
            _phone.text.trim().isEmpty ? null : _phone.text.trim(),
        invoiceNumber: _invoice.text.trim(),
        paidAmount: _paidAmount,
        notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
        purchasedAt: _date,
        items: items,
      );

      if (!mounted) return;
      _toast('Purchase save ho gaya! Stock update ho chuka hai.');
      Navigator.pop(context, true);
    } catch (e) {
      if (mounted) {
        _toast('Purchase save nahi hua: $e', error: true);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        title: const Text('New Purchase',
            style: TextStyle(fontWeight: FontWeight.w900)),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
          children: [
            _section('Supplier Details', Icons.storefront_rounded),
            const SizedBox(height: 12),
            _field(_supplier, 'Supplier / Vendor Name',
                icon: Icons.person_outline_rounded, requiredField: true),
            const SizedBox(height: 12),
            _field(_phone, 'Phone Number',
                icon: Icons.phone_outlined, keyboard: TextInputType.phone),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _field(
                    _invoice,
                    'Invoice Number',
                    icon: Icons.receipt_long_rounded,
                    requiredField: true,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: _pickDate,
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _panel,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: Colors.white.withValues(alpha: .07)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Purchase Date',
                              style: TextStyle(
                                  fontSize: 11, color: _muted)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.calendar_month_rounded,
                                  color: _blue, size: 18),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  '${_date.day.toString().padLeft(2, '0')}/'
                                  '${_date.month.toString().padLeft(2, '0')}/'
                                  '${_date.year}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            _section('Select Products', Icons.inventory_2_rounded),
            const SizedBox(height: 5),
            const Text(
              'Quantity badhao aur purchase price set karo.',
              style: TextStyle(color: _muted, fontSize: 12),
            ),
            const SizedBox(height: 12),
            ...widget.products.map(_productRow),
            const SizedBox(height: 22),
            _section('Payment Details', Icons.account_balance_wallet_rounded),
            const SizedBox(height: 12),
            _field(
              _paid,
              'Amount Paid (₹)',
              icon: Icons.currency_rupee_rounded,
              keyboard: const TextInputType.numberWithOptions(decimal: true),
              requiredField: true,
            ),
            const SizedBox(height: 12),
            _field(
              _notes,
              'Notes (Optional)',
              icon: Icons.notes_rounded,
              maxLines: 3,
            ),
            const SizedBox(height: 18),
            _totalsCard(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 14),
        child: SizedBox(
          height: 54,
          child: FilledButton.icon(
            onPressed: _saving ? null : _savePurchase,
            icon: _saving
                ? const SizedBox(
                    width: 19,
                    height: 19,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.check_circle_outline_rounded),
            label: Text(
              _saving ? 'Saving Purchase...' : 'Save Purchase',
              style: const TextStyle(
                  fontWeight: FontWeight.w900, fontSize: 15),
            ),
            style: FilledButton.styleFrom(
              backgroundColor: _blue,
              foregroundColor: _bg,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _productRow(dynamic product) {
    final id = product.id as int?;
    if (id == null) return const SizedBox.shrink();

    final quantity = _quantities[id] ?? 0;
    final price = double.tryParse(_prices[id]?.text ?? '') ?? 0;
    final lineTotal = quantity * price;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: quantity > 0 ? const Color(0xFF102C43) : _panel,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: quantity > 0
              ? _blue.withValues(alpha: .6)
              : Colors.white.withValues(alpha: .06),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: _blue.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(Icons.inventory_2_outlined,
                    color: _blue),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    Text(
                      'Stock: ${product.stockQuantity} ${product.unit}',
                      style: const TextStyle(
                          color: _muted, fontSize: 11),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => setState(() {
                  _quantities[id] = quantity > 0 ? quantity - 1 : 0;
                }),
                icon: const Icon(Icons.remove_circle_outline_rounded),
                color: quantity > 0 ? _blue : _muted,
              ),
              Text('$quantity',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w900)),
              IconButton(
                onPressed: () => setState(() {
                  _quantities[id] = quantity + 1;
                }),
                icon: const Icon(Icons.add_circle_rounded),
                color: _blue,
              ),
            ],
          ),
          if (quantity > 0) ...[
            const Divider(color: Color(0xFF263C50), height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _prices[id],
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(fontWeight: FontWeight.w700),
                    decoration: InputDecoration(
                      labelText: 'Purchase price / unit',
                      prefixText: '₹ ',
                      filled: true,
                      fillColor: _bg,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Line Total',
                        style: TextStyle(color: _muted, fontSize: 11)),
                    const SizedBox(height: 5),
                    Text('₹${lineTotal.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: _green,
                            fontWeight: FontWeight.w900)),
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _totalsCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF123C58), Color(0xFF102238)],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _blue.withValues(alpha: .25)),
      ),
      child: Column(
        children: [
          _totalLine('Selected products', '${_selectedProducts.length}'),
          const SizedBox(height: 12),
          _totalLine('Total Amount', '₹${_total.toStringAsFixed(2)}'),
          const SizedBox(height: 12),
         _totalLine(
  'Paid Amount',
  '₹${_paidAmount.toStringAsFixed(2)}',
  color: _green,
),
          const Divider(color: Color(0xFF34516B), height: 25),
          _totalLine('Balance Due', '₹${_due.toStringAsFixed(2)}',
              color: _due < 0 ? Colors.redAccent : Colors.orangeAccent,
              bold: true),
        ],
      ),
    );
  }
}

class _PurchaseHistory extends StatelessWidget {
  final Future<List<dynamic>> future;
  final VoidCallback onRetry;

  const _PurchaseHistory({
    required this.future,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(color: _blue));
        }

        if (snapshot.hasError) {
          return _errorView(snapshot.error.toString(), onRetry);
        }

        final purchases = snapshot.data ?? [];

        if (purchases.isEmpty) {
          return _emptyView(
            Icons.receipt_long_rounded,
            'No purchases yet',
            'Nayi purchase add karoge to history yahan dikhegi.',
          );
        }

        return RefreshIndicator(
          onRefresh: () async => onRetry(),
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
            itemCount: purchases.length,
            itemBuilder: (context, index) {
              final purchase = purchases[index];
              final date = purchase.purchasedAt as DateTime;
              final due = (purchase.dueAmount as num).toDouble();

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _panel,
                  borderRadius: BorderRadius.circular(19),
                  border: Border.all(
                      color: Colors.white.withValues(alpha: .06)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: _blue.withValues(alpha: .12),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: const Icon(Icons.receipt_long_rounded,
                              color: _blue),
                        ),
                        const SizedBox(width: 11),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(purchase.supplierName.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900)),
                              const SizedBox(height: 4),
                              Text(
                                'Invoice: ${purchase.invoiceNumber}',
                                style: const TextStyle(
                                    color: _muted, fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                        Text('₹${(purchase.totalAmount as num).toStringAsFixed(2)}',
                            style: const TextStyle(
                                color: _green,
                                fontWeight: FontWeight.w900)),
                      ],
                    ),
                    const Divider(height: 23, color: Color(0xFF263C50)),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${date.day.toString().padLeft(2, '0')}/'
                            '${date.month.toString().padLeft(2, '0')}/'
                            '${date.year}',
                            style: const TextStyle(
                                color: _muted, fontSize: 12),
                          ),
                        ),
                        _statusChip(due),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _miniAmount(
                            'Paid',
                            (purchase.paidAmount as num).toDouble(),
                            _green,
                          ),
                        ),
                        Expanded(
                          child: _miniAmount('Due', due, Colors.orangeAccent),
                        ),
                        IconButton(
                          tooltip: 'View purchase items',
                          onPressed: () async {
                            try {
                              final items = await client.purchase
                                  .getPurchaseItems(purchase.id as int);
                              if (!context.mounted) return;
                              showModalBottomSheet<void>(
                                context: context,
                                backgroundColor: _panel,
                                showDragHandle: true,
                                builder: (_) => SafeArea(
                                  child: ListView(
                                    padding: const EdgeInsets.all(18),
                                    children: [
                                      const Text('Purchase Items',
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w900)),
                                      const SizedBox(height: 14),
                                      ...items.map((item) => ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            title: Text(item.productName),
                                            subtitle: Text(
                                                '${item.quantity} × ₹${(item.unitPurchasePrice as num).toStringAsFixed(2)}'),
                                            trailing: Text(
                                              '₹${(item.lineTotal as num).toStringAsFixed(2)}',
                                              style: const TextStyle(
                                                  color: _green,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Items load failed: $e')),
                                );
                              }
                            }
                          },
                          icon: const Icon(Icons.chevron_right_rounded,
                              color: _blue),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _StockOverview extends StatelessWidget {
  final Future<List<dynamic>> future;
  final VoidCallback onRetry;

  const _StockOverview({required this.future, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(color: _blue));
        }
        if (snapshot.hasError) {
          return _errorView(snapshot.error.toString(), onRetry);
        }

        final products = snapshot.data ?? [];
        if (products.isEmpty) {
          return _emptyView(Icons.inventory_2_outlined,
              'Inventory empty', 'Pehle products add karo.');
        }

        return RefreshIndicator(
          onRefresh: () async => onRetry(),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
            children: [
              Row(
                children: [
                  Expanded(
                    child: _overviewCard(
                      'Products',
                      '${products.length}',
                      Icons.category_rounded,
                      _blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _overviewCard(
                      'Total Units',
                      '${products.fold<int>(0, (sum, p) => sum + (p.stockQuantity as int))}',
                      Icons.inventory_2_rounded,
                      _green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Text('Current Stock',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w900)),
              const SizedBox(height: 12),
              ...products.map((p) {
                final low = (p.stockQuantity as int) <=
                    (p.lowStockAlert as int);
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: _panel,
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 43,
                        height: 43,
                        decoration: BoxDecoration(
                          color: (low ? Colors.orangeAccent : _green)
                              .withValues(alpha: .12),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Icon(Icons.inventory_2_outlined,
                            color: low ? Colors.orangeAccent : _green),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p.name.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800)),
                            const SizedBox(height: 4),
                            Text('Purchase ₹${p.purchasePrice} • Sale ₹${p.sellingPrice}',
                                style: const TextStyle(
                                    color: _muted, fontSize: 11)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('${p.stockQuantity}',
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w900)),
                          Text(low ? 'LOW STOCK' : p.unit.toString(),
                              style: TextStyle(
                                  fontSize: 9,
                                  color: low ? Colors.orangeAccent : _muted)),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

Widget _section(String title, IconData icon) {
  return Row(
    children: [
      Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: _blue.withValues(alpha: .12),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Icon(icon, color: _blue, size: 19),
      ),
      const SizedBox(width: 10),
      Text(title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
    ],
  );
}

Widget _field(
  TextEditingController controller,
  String label, {
  IconData? icon,
  TextInputType? keyboard,
  bool requiredField = false,
  int maxLines = 1,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboard,
    maxLines: maxLines,
    validator: requiredField
        ? (value) => value == null || value.trim().isEmpty
            ? '$label required hai.'
            : null
        : null,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: icon == null ? null : Icon(icon, color: _blue),
      filled: true,
      fillColor: _panel,
      contentPadding: const EdgeInsets.all(15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
            color: Colors.white.withValues(alpha: .06)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: _blue),
      ),
    ),
  );
}

Widget _totalLine(
  String label,
  String value, {
  Color color = Colors.white,
  bool bold = false,
}) {
  return Row(
    children: [
      Expanded(
        child: Text(label,
            style: const TextStyle(color: _muted, fontSize: 13)),
      ),
      Text(value,
          style: TextStyle(
              color: color,
              fontSize: bold ? 17 : 14,
              fontWeight: bold ? FontWeight.w900 : FontWeight.w700)),
    ],
  );
}

Widget _miniAmount(String label, double amount, Color color) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: const TextStyle(color: _muted, fontSize: 11)),
      const SizedBox(height: 4),
      Text('₹${amount.toStringAsFixed(2)}',
          style: TextStyle(color: color, fontWeight: FontWeight.w900)),
    ],
  );
}

Widget _statusChip(double due) {
  final paid = due <= 0;
  final color = paid ? _green : Colors.orangeAccent;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: .12),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Text(
      paid ? 'PAID' : 'PAYMENT DUE',
      style: TextStyle(
          color: color, fontSize: 9, fontWeight: FontWeight.w900),
    ),
  );
}

Widget _overviewCard(
    String title, String value, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(17),
    decoration: BoxDecoration(
      color: _panel,
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: color.withValues(alpha: .18)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 23),
        const SizedBox(height: 14),
        Text(value,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.w900)),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(color: _muted, fontSize: 12)),
      ],
    ),
  );
}

Widget _emptyView(IconData icon, String title, String subtitle) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              color: _blue.withValues(alpha: .10),
              borderRadius: BorderRadius.circular(26),
            ),
            child: Icon(icon, color: _blue, size: 42),
          ),
          const SizedBox(height: 18),
          Text(title,
              style: const TextStyle(
                  fontSize: 19, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          Text(subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: _muted)),
        ],
      ),
    ),
  );
}

Widget _errorView(String error, VoidCallback onRetry) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.cloud_off_rounded,
              color: Colors.orangeAccent, size: 42),
          const SizedBox(height: 12),
          const Text('Data load nahi ho paya.',
              style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Text(error,
              textAlign: TextAlign.center,
              style: const TextStyle(color: _muted, fontSize: 11)),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Retry'),
          ),
        ],
      ),
    ),
  );
}
