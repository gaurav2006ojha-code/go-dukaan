import 'dart:async';



import 'package:flutter/material.dart';

import '../receipt_service.dart';







import '../client.dart';







const _bg = Color(0xFF07111F);



const _panel = Color(0xFF101D30);



const _panel2 = Color(0xFF16263B);



const _blue = Color(0xFF19B5FE);



const _green = Color(0xFF35D39A);



const _muted = Color(0xFF91A4BD);







class BillingScreen extends StatefulWidget {



  const BillingScreen({super.key});







  @override



  State<BillingScreen> createState() => _BillingScreenState();



}







class _CartLine {



  final dynamic product;



  int quantity = 1;



  _CartLine({

    required this.product,

  });







  int get id => product.id as int;



  String get name => product.name.toString();



  String get category => product.category.toString();



  double get price => (product.sellingPrice as num).toDouble();



  double get purchasePrice =>



      (product.purchasePrice as num).toDouble();



  int get stock => product.stockQuantity as int;



  double get total => price * quantity;



}







class _BillingScreenState extends State<BillingScreen>



    with SingleTickerProviderStateMixin {



  final _searchController = TextEditingController();



  final _discountController = TextEditingController(text: '0');



  final _taxController = TextEditingController(text: '0');



  final _notesController = TextEditingController();







  late final AnimationController _animationController;



  late final Animation<double> _fadeAnimation;







  List<dynamic> _products = [];



  List<dynamic> _customers = [];



  final List<_CartLine> _cart = [];







  int? _customerId;



  String _paymentMethod = 'Cash';



  bool _loading = true;



  bool _saving = false;



  String? _error;



  String _search = '';







  @override



  void initState() {



    super.initState();







    _animationController = AnimationController(



      vsync: this,



      duration: const Duration(milliseconds: 650),



    );







    _fadeAnimation = CurvedAnimation(



      parent: _animationController,



      curve: Curves.easeOutCubic,



    );







    _searchController.addListener(() {



      if (mounted) {



        setState(() => _search = _searchController.text.trim());



      }



    });







    _discountController.addListener(_refreshTotals);



    _taxController.addListener(_refreshTotals);







    _loadData();



  }







  @override



  void dispose() {



    _animationController.dispose();



    _searchController.dispose();



    _discountController.dispose();



    _taxController.dispose();



    _notesController.dispose();



    super.dispose();



  }







  void _refreshTotals() {



    if (mounted) setState(() {});



  }







  Future<void> _loadData() async {



    setState(() {



      _loading = true;



      _error = null;



    });







    try {



      final results = await Future.wait([



        client.product.getProducts(),



        client.customer.getCustomers(),



      ]);







      if (!mounted) return;







      setState(() {



        _products = results[0] as List<dynamic>;



        _customers = results[1] as List<dynamic>;



        _loading = false;



      });







      _animationController.forward();



    } catch (e) {



      if (!mounted) return;







      setState(() {



        _loading = false;



        _error = e.toString();



      });



    }



  }







  double get _subtotal =>



      _cart.fold(0.0, (sum, item) => sum + item.total);







  double get _discount {



    final value = double.tryParse(_discountController.text) ?? 0;



    return value.clamp(0.0, _subtotal);



  }







  double get _taxPercent {



    final value = double.tryParse(_taxController.text) ?? 0;



    return value.clamp(0.0, 100.0);



  }







  double get _tax =>



      (_subtotal - _discount) * _taxPercent / 100;







  double get _total => _subtotal - _discount + _tax;







  double get _paid {



    if (_paymentMethod == 'Credit') return 0;



    if (_paymentMethod == 'Partial') return 0;



    return _total;



  }







  double _partialAmount = 0;







  double get _effectivePaid =>



      _paymentMethod == 'Partial'



          ? _partialAmount.clamp(0.0, _total)



          : _paid;







  double get _due =>



      (_total - _effectivePaid).clamp(0.0, double.infinity);







  List<dynamic> get _filteredProducts {



    final query = _search.toLowerCase();







    final matches = _products.where((product) {



      final name = product.name.toString().toLowerCase();



      final category = product.category.toString().toLowerCase();



      final sku = (product.sku ?? '').toString().toLowerCase();



      final barcode =



          (product.barcode ?? '').toString().toLowerCase();







      final matchesSearch = query.isEmpty ||



          name.contains(query) ||



          category.contains(query) ||



          sku.contains(query) ||



          barcode.contains(query);







      return matchesSearch && product.isActive == true;



    }).toList();







    return matches;



  }







  int _cartQuantity(int productId) {



    for (final line in _cart) {



      if (line.id == productId) return line.quantity;



    }



    return 0;



  }







  void _addProduct(dynamic product) {



    final id = product.id as int;



    final existing = _cart.where((line) => line.id == id);







    if (existing.isNotEmpty) {



      final line = existing.first;







      if (line.quantity >= line.stock) {



        _message('Available stock is only ${line.stock}.');



        return;



      }







      setState(() => line.quantity++);



    } else {



      if ((product.stockQuantity as int) <= 0) {



        _message('This product is out of stock.');



        return;



      }







      setState(() => _cart.add(_CartLine(product: product)));



    }







    _message('${product.name} added to bill');



  }







  void _changeQuantity(_CartLine line, int change) {



    final next = line.quantity + change;







    if (next <= 0) {



      setState(() => _cart.remove(line));



      return;



    }







    if (next > line.stock) {



      _message('Available stock is only ${line.stock}.');



      return;



    }







    setState(() => line.quantity = next);



  }







  void _message(String message) {



    if (!mounted) return;







    ScaffoldMessenger.of(context)



      ..hideCurrentSnackBar()



      ..showSnackBar(



        SnackBar(



          content: Text(message),



          behavior: SnackBarBehavior.floating,



          backgroundColor: _panel2,



        ),



      );



  }








  ReceiptData _receiptDataForSale(dynamic sale) {
    return ReceiptData(
      shopName: 'GO Dukaan',
      ownerName: '',
      invoiceNumber: sale.invoiceNumber.toString(),
      createdAt: sale.createdAt as DateTime,
      items: _cart.map((line) => ReceiptLine(
        name: line.name,
        quantity: line.quantity,
        unitPrice: line.price,
        lineTotal: line.total,
      )).toList(),
      subtotal: (sale.subtotal as num).toDouble(),
      discount: (sale.discountAmount as num).toDouble(),
      tax: (sale.taxAmount as num).toDouble(),
      total: (sale.totalAmount as num).toDouble(),
      paid: (sale.paidAmount as num).toDouble(),
      due: (sale.dueAmount as num).toDouble(),
      paymentMethod: sale.paymentMethod.toString(),
    );
  }

  Future<void> _saveReceiptPdf(dynamic sale) async {
    try {
      final path = await ReceiptService.saveAndSharePdf(
        _receiptDataForSale(sale),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF saved in app documents: $path'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      _message('PDF save failed: $e');
    }
  }

  Future<void> _openThermalPrinter(ReceiptData receipt) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ThermalPrinterScreen(receipt: receipt),
      ),
    );
  }

  Future<void> _checkout() async {



    if (_cart.isEmpty) {



      _message('Add at least one product first.');



      return;



    }







    if (_total <= 0) {



      _message('Bill total must be greater than zero.');



      return;



    }







    if (_paymentMethod == 'Partial') {



      final controller = TextEditingController(



        text: _partialAmount.toStringAsFixed(2),



      );







      final result = await showDialog<double>(



        context: context,



        builder: (dialogContext) {



          return AlertDialog(



            backgroundColor: _panel,



            title: const Text('Partial payment'),



            content: TextField(



              controller: controller,



              keyboardType:



                  const TextInputType.numberWithOptions(decimal: true),



              decoration: const InputDecoration(



                labelText: 'Amount received (₹)',



              ),



            ),



            actions: [



              TextButton(



                onPressed: () => Navigator.pop(dialogContext),



                child: const Text('Cancel'),



              ),



              FilledButton(



                onPressed: () {



                  final amount = double.tryParse(controller.text);



                  if (amount == null ||



                      amount < 0 ||



                      amount >= _total) {



                    return;



                  }



                  Navigator.pop(dialogContext, amount);



                },



                child: const Text('Confirm'),



              ),



            ],



          );



        },



      );







      controller.dispose();







      if (result == null) return;







      setState(() => _partialAmount = result);



    }







    if (_due > 0 && _customerId == null) {



      _message('Select a customer to record the outstanding amount.');



      return;



    }







    if (!mounted) return;

final confirmed = await showModalBottomSheet<bool>(
  context: context,


      backgroundColor: _panel,



      isScrollControlled: true,



      shape: const RoundedRectangleBorder(



        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),



      ),



      builder: (context) {



        return SafeArea(



          child: Padding(



            padding: const EdgeInsets.all(24),



            child: Column(



              mainAxisSize: MainAxisSize.min,



              crossAxisAlignment: CrossAxisAlignment.start,



              children: [



                const Text(



                  'Confirm checkout',



                  style: TextStyle(



                    fontSize: 23,



                    fontWeight: FontWeight.w800,



                  ),



                ),



                const SizedBox(height: 18),



                _summaryRow('Items', '${_cart.length}'),



                _summaryRow('Subtotal', _money(_subtotal)),



                _summaryRow('Discount', '-${_money(_discount)}'),



                _summaryRow('Tax', _money(_tax)),



                _summaryRow('Total payable', _money(_total),



                    bold: true),



                _summaryRow('Received', _money(_effectivePaid)),



                _summaryRow('Remaining due', _money(_due),



                    bold: true),



                const SizedBox(height: 20),



                SizedBox(



                  width: double.infinity,



                  height: 52,



                  child: FilledButton.icon(



                    onPressed: () => Navigator.pop(context, true),



                    icon: const Icon(Icons.lock_rounded),



                    label: const Text('Create bill'),



                  ),



                ),



              ],



            ),



          ),



        );



      },



    );







    if (confirmed != true) return;







    setState(() => _saving = true);







    try {



      final sale = await client.sale.createSale(



        customerId: _customerId,



        productIds: _cart.map((line) => line.id).toList(),



        quantities: _cart.map((line) => line.quantity).toList(),



        discountAmount: _discount,



        taxPercent: _taxPercent,



        paymentMethod: _paymentMethod,



        paidAmount: _effectivePaid,



        notes: _notesController.text.trim().isEmpty



            ? null



            : _notesController.text.trim(),



      );







      if (!mounted) return;







      await showDialog<void>(



        context: context,



        barrierDismissible: false,



        builder: (dialogContext) {



          return AlertDialog(



            backgroundColor: _panel,



            icon: const Icon(



              Icons.check_circle_rounded,



              color: _green,



              size: 62,



            ),



            title: const Text('Bill created successfully!'),



            content: Column(



              mainAxisSize: MainAxisSize.min,



              children: [



                Text('Invoice: ${sale.invoiceNumber}'),



                const SizedBox(height: 8),



                Text(



                  _money(sale.totalAmount),



                  style: const TextStyle(



                    fontSize: 28,



                    fontWeight: FontWeight.w900,



                  ),



                ),



                Text('Due: ${_money(sale.dueAmount)}'),



              ],



            ),



            actions: [
              TextButton.icon(
                onPressed: () async {
                  Navigator.pop(dialogContext);
                  await _saveReceiptPdf(sale);
                },
                icon: const Icon(Icons.picture_as_pdf_rounded),
                label: const Text('Save PDF'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  final receipt = _receiptDataForSale(sale);
                  Navigator.pop(dialogContext);
                  _openThermalPrinter(receipt);
                },
                icon: const Icon(Icons.print_rounded),
                label: const Text('Print'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Done'),
              ),
            ],



          );



        },



      );







      if (!mounted) return;







      setState(() {



        _cart.clear();



        _customerId = null;



        _discountController.text = '0';



        _taxController.text = '0';



        _notesController.clear();



        _partialAmount = 0;



      });







      await _loadData();



    } catch (e) {



      if (mounted) {



        _message('Bill creation failed: $e');



      }



    } finally {



      if (mounted) setState(() => _saving = false);



    }



  }







  String _money(num value) => '₹${value.toStringAsFixed(2)}';







  Widget _summaryRow(



    String label,



    String value, {



    bool bold = false,



  }) {



    return Padding(



      padding: const EdgeInsets.symmetric(vertical: 6),



      child: Row(



        children: [



          Expanded(



            child: Text(



              label,



              style: TextStyle(



                color: bold ? Colors.white : _muted,



                fontWeight: bold ? FontWeight.w800 : FontWeight.w500,



              ),



            ),



          ),



          Text(



            value,



            style: TextStyle(



              fontWeight: bold ? FontWeight.w900 : FontWeight.w600,



              fontSize: bold ? 17 : 14,



            ),



          ),



        ],



      ),



    );



  }







  InputDecoration _inputDecoration(



    String label, {



    IconData? icon,



    String? hint,



  }) {



    return InputDecoration(



      labelText: label,



      hintText: hint,



      prefixIcon: icon == null ? null : Icon(icon),



      filled: true,



      fillColor: _panel2,



      border: OutlineInputBorder(



        borderRadius: BorderRadius.circular(15),



        borderSide: BorderSide.none,



      ),



      enabledBorder: OutlineInputBorder(



        borderRadius: BorderRadius.circular(15),



        borderSide: BorderSide(



          color: Colors.white.withValues(alpha: 0.06),



        ),



      ),



      focusedBorder: OutlineInputBorder(



        borderRadius: BorderRadius.circular(15),



        borderSide: const BorderSide(color: _blue),



      ),



    );



  }







  @override



  Widget build(BuildContext context) {



    return Scaffold(



      backgroundColor: _bg,



      appBar: AppBar(



        backgroundColor: _bg,



        foregroundColor: Colors.white,



        title: const Column(



          crossAxisAlignment: CrossAxisAlignment.start,



          children: [



            Text(



              'New Bill',



              style: TextStyle(fontWeight: FontWeight.w900),



            ),



            Text(



              'GO Dukaan POS',



              style: TextStyle(fontSize: 12, color: _muted),



            ),



          ],



        ),



        actions: [



          IconButton(



            tooltip: 'Refresh products',



            onPressed: _loading ? null : _loadData,



            icon: const Icon(Icons.refresh_rounded),



          ),



        ],



      ),



      body: _loading



          ? const Center(



              child: CircularProgressIndicator(color: _blue),



            )



          : _error != null



              ? _buildError()



              : FadeTransition(



                  opacity: _fadeAnimation,



                  child: LayoutBuilder(



                    builder: (context, constraints) {



                      final wide = constraints.maxWidth >= 900;







                      if (wide) {



                        return Row(



                          crossAxisAlignment: CrossAxisAlignment.stretch,



                          children: [



                            Expanded(flex: 6, child: _buildProducts()),



                            Container(



                              width: 1,



                              color: Colors.white.withValues(alpha: 0.08),



                            ),



                            Expanded(flex: 5, child: _buildCart()),



                          ],



                        );



                      }







                      return Column(



                        children: [



                          Expanded(flex: 5, child: _buildProducts()),



                          Container(



                            height: 1,



                            color: Colors.white.withValues(alpha: 0.08),



                          ),



                          Expanded(flex: 6, child: _buildCart()),



                        ],



                      );



                    },



                  ),



                ),



    );



  }







  Widget _buildError() {



    return Center(



      child: Padding(



        padding: const EdgeInsets.all(28),



        child: Column(



          mainAxisSize: MainAxisSize.min,



          children: [



            const Icon(



              Icons.cloud_off_rounded,



              color: Colors.orangeAccent,



              size: 54,



            ),



            const SizedBox(height: 16),



            const Text(



              'Could not load billing data',



              style: TextStyle(



                fontSize: 20,



                fontWeight: FontWeight.w800,



              ),



            ),



            const SizedBox(height: 8),



            Text(



              _error!,



              textAlign: TextAlign.center,



              style: const TextStyle(color: _muted),



            ),



            const SizedBox(height: 18),



            FilledButton.icon(



              onPressed: _loadData,



              icon: const Icon(Icons.refresh_rounded),



              label: const Text('Try again'),



            ),



          ],



        ),



      ),



    );



  }







  Widget _buildProducts() {



    return Padding(



      padding: const EdgeInsets.all(16),



      child: Column(



        crossAxisAlignment: CrossAxisAlignment.start,



        children: [



          const Row(



            children: [



              Icon(Icons.inventory_2_rounded, color: _blue),



              SizedBox(width: 9),



              Text(



                'Select products',



                style: TextStyle(



                  fontSize: 19,



                  fontWeight: FontWeight.w900,



                ),



              ),



            ],



          ),



          const SizedBox(height: 14),



          TextField(



            controller: _searchController,



            decoration: _inputDecoration(



              'Search product / SKU / barcode',



              icon: Icons.search_rounded,



            ),



          ),



          const SizedBox(height: 12),



          Expanded(



            child: _filteredProducts.isEmpty



                ? const Center(



                    child: Text(



                      'No matching products found',



                      style: TextStyle(color: _muted),



                    ),



                  )



                : ListView.separated(



                    physics: const BouncingScrollPhysics(),



                    itemCount: _filteredProducts.length,



                    separatorBuilder: (_, _) =>



                        const SizedBox(height: 9),



                    itemBuilder: (context, index) {



                      final product = _filteredProducts[index];



                      final quantity = _cartQuantity(product.id as int);



                      final stock = product.stockQuantity as int;







                      return _ProductTile(



                        name: product.name.toString(),



                        category: product.category.toString(),



                        price: _money(



                          (product.sellingPrice as num).toDouble(),



                        ),



                        stock: stock,



                        inCart: quantity,



                        onTap: () => _addProduct(product),



                      );



                    },



                  ),



          ),



        ],



      ),



    );



  }







  Widget _buildCart() {



    return SingleChildScrollView(

  padding: const EdgeInsets.all(16),

  child: Column(

    mainAxisSize: MainAxisSize.min,

    crossAxisAlignment: CrossAxisAlignment.start,

    children: [



          Row(



            children: [



              const Icon(Icons.shopping_bag_rounded, color: _green),



              const SizedBox(width: 9),



              const Expanded(



                child: Text(



                  'Current bill',



                  style: TextStyle(



                    fontSize: 19,



                    fontWeight: FontWeight.w900,



                  ),



                ),



              ),



              Container(



                padding: const EdgeInsets.symmetric(



                  horizontal: 10,



                  vertical: 6,



                ),



                decoration: BoxDecoration(



                  color: _green.withValues(alpha: 0.12),



                  borderRadius: BorderRadius.circular(20),



                ),



                child: Text(



                  '${_cart.length} items',



                  style: const TextStyle(



                    color: _green,



                    fontWeight: FontWeight.w800,



                  ),



                ),



              ),



            ],



          ),



          const SizedBox(height: 12),



          SizedBox(
            height: _cart.isEmpty ? 145 : 190,
            child: _cart.isEmpty
                ? const _EmptyCart()
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _cart.length,
                    separatorBuilder: (_, index) =>
                        const SizedBox(height: 9),
                    itemBuilder: (context, index) {
                      final line = _cart[index];
                      return _CartTile(
                        line: line,
                        money: _money,
                        onMinus: () => _changeQuantity(line, -1),
                        onPlus: () => _changeQuantity(line, 1),
                        onRemove: () {
                          setState(() => _cart.remove(line));
                        },
                      );
                    },
                  ),
          ),
          const SizedBox(height: 12),



          DropdownButtonFormField<int?>(



            initialValue: _customerId,



            isExpanded: true,



            dropdownColor: _panel2,



            decoration: _inputDecoration(



              'Customer (optional for paid bills)',



              icon: Icons.person_outline_rounded,



            ),



            items: [



              const DropdownMenuItem<int?>(



                value: null,



                child: Text('Walk-in customer'),



              ),



              ..._customers.map(



                (customer) => DropdownMenuItem<int?>(



                  value: customer.id as int,



                  child: Text(



                    '${customer.name} · ${customer.mobile ?? 'No mobile'}',



                    overflow: TextOverflow.ellipsis,



                  ),



                ),



              ),



            ],



            onChanged: (value) => setState(() => _customerId = value),



          ),



          const SizedBox(height: 10),



          Row(



            children: [



              Expanded(



                child: TextField(



                  controller: _discountController,



                  keyboardType:



                      const TextInputType.numberWithOptions(decimal: true),



                  decoration: _inputDecoration('Discount ₹'),



                ),



              ),



              const SizedBox(width: 10),



              Expanded(



                child: TextField(



                  controller: _taxController,



                  keyboardType:



                      const TextInputType.numberWithOptions(decimal: true),



                  decoration: _inputDecoration('Tax %'),



                ),



              ),



            ],



          ),



          const SizedBox(height: 10),



          DropdownButtonFormField<String>(



            initialValue: _paymentMethod,



            dropdownColor: _panel2,



            decoration: _inputDecoration(



              'Payment method',



              icon: Icons.payments_outlined,



            ),



            items: const [



              DropdownMenuItem(value: 'Cash', child: Text('Cash · Full payment')),



              DropdownMenuItem(value: 'UPI', child: Text('UPI · Full payment')),



              DropdownMenuItem(value: 'Card', child: Text('Card · Full payment')),



              DropdownMenuItem(value: 'Credit', child: Text('Credit · Khata')),



              DropdownMenuItem(



                value: 'Partial',



                child: Text('Partial · Part paid'),



              ),



            ],



            onChanged: (value) {



              if (value != null) {



                setState(() {



                  _paymentMethod = value;



                  if (value != 'Partial') _partialAmount = 0;



                });



              }



            },



          ),



          const SizedBox(height: 10),



          TextField(



            controller: _notesController,



            maxLines: 1,



            decoration: _inputDecoration(



              'Notes (optional)',



              icon: Icons.notes_rounded,



            ),



          ),



          const SizedBox(height: 14),



          Container(



            padding: const EdgeInsets.all(15),



            decoration: BoxDecoration(



              color: _panel,



              borderRadius: BorderRadius.circular(20),



              border: Border.all(



                color: _blue.withValues(alpha: 0.20),



              ),



            ),



            child: Column(



              children: [



                _summaryRow('Subtotal', _money(_subtotal)),



                _summaryRow('Discount', '-${_money(_discount)}'),



                _summaryRow('Tax', _money(_tax)),



                const Divider(color: Colors.white12, height: 20),



                _summaryRow('Grand total', _money(_total), bold: true),



                _summaryRow('Due', _money(_due)),



              ],



            ),



          ),



          const SizedBox(height: 12),



          SizedBox(



            width: double.infinity,



            height: 52,



            child: FilledButton.icon(



              onPressed: _saving ? null : _checkout,



              icon: _saving



                  ? const SizedBox(



                      width: 20,



                      height: 20,



                      child: CircularProgressIndicator(strokeWidth: 2),



                    )



                  : const Icon(Icons.receipt_long_rounded),



              label: Text(



                _saving ? 'Creating bill...' : 'Checkout · ${_money(_total)}',



                style: const TextStyle(fontWeight: FontWeight.w900),



              ),



              style: FilledButton.styleFrom(



                backgroundColor: _blue,



                foregroundColor: _bg,



                shape: RoundedRectangleBorder(



                  borderRadius: BorderRadius.circular(15),



                ),



              ),



            ),



          ),



        ],



      ),



    );



  }



}







class _ProductTile extends StatelessWidget {



  final String name;



  final String category;



  final String price;



  final int stock;



  final int inCart;



  final VoidCallback onTap;







  const _ProductTile({



    required this.name,



    required this.category,



    required this.price,



    required this.stock,



    required this.inCart,



    required this.onTap,



  });







  @override



  Widget build(BuildContext context) {



    final outOfStock = stock <= 0;







    return Material(



      color: _panel,



      borderRadius: BorderRadius.circular(16),



      child: InkWell(



        onTap: outOfStock ? null : onTap,



        borderRadius: BorderRadius.circular(16),



        child: Padding(



          padding: const EdgeInsets.all(12),



          child: Row(



            children: [



              Container(



                width: 45,



                height: 45,



                decoration: BoxDecoration(



                  color: _blue.withValues(alpha: 0.12),



                  borderRadius: BorderRadius.circular(13),



                ),



                child: const Icon(



                  Icons.inventory_2_outlined,



                  color: _blue,



                ),



              ),



              const SizedBox(width: 12),



              Expanded(



                child: Column(



                  crossAxisAlignment: CrossAxisAlignment.start,



                  children: [



                    Text(



                      name,



                      maxLines: 1,



                      overflow: TextOverflow.ellipsis,



                      style: const TextStyle(



                        fontWeight: FontWeight.w800,



                      ),



                    ),



                    const SizedBox(height: 4),



                    Text(



                      '$category · Stock $stock',



                      style: const TextStyle(



                        fontSize: 11,



                        color: _muted,



                      ),



                    ),



                    const SizedBox(height: 5),



                    Text(



                      price,



                      style: const TextStyle(



                        color: _green,



                        fontWeight: FontWeight.w900,



                      ),



                    ),



                  ],



                ),



              ),



              if (inCart > 0)



                Padding(



                  padding: const EdgeInsets.only(right: 7),



                  child: Text(



                    '×$inCart',



                    style: const TextStyle(



                      color: _green,



                      fontWeight: FontWeight.w900,



                    ),



                  ),



                ),



              Icon(



                outOfStock ? Icons.block_rounded : Icons.add_circle_rounded,



                color: outOfStock ? Colors.redAccent : _blue,



                size: 27,



              ),



            ],



          ),



        ),



      ),



    );



  }



}







class _CartTile extends StatelessWidget {



  final _CartLine line;



  final String Function(num) money;



  final VoidCallback onMinus;



  final VoidCallback onPlus;



  final VoidCallback onRemove;







  const _CartTile({



    required this.line,



    required this.money,



    required this.onMinus,



    required this.onPlus,



    required this.onRemove,



  });







  @override



  Widget build(BuildContext context) {



    return Container(



      padding: const EdgeInsets.all(12),



      decoration: BoxDecoration(



        color: _panel,



        borderRadius: BorderRadius.circular(16),



      ),



      child: Column(



        children: [



          Row(



            children: [



              Expanded(



                child: Text(



                  line.name,



                  maxLines: 1,



                  overflow: TextOverflow.ellipsis,



                  style: const TextStyle(fontWeight: FontWeight.w800),



                ),



              ),



              IconButton(



                onPressed: onRemove,



                visualDensity: VisualDensity.compact,



                icon: const Icon(



                  Icons.delete_outline_rounded,



                  color: Colors.redAccent,



                ),



              ),



            ],



          ),



          Row(



            children: [



              Text(



                '${money(line.price)} each',



                style: const TextStyle(color: _muted, fontSize: 12),



              ),



              const Spacer(),



              IconButton(



                onPressed: onMinus,



                visualDensity: VisualDensity.compact,



                icon: const Icon(Icons.remove_circle_outline_rounded),



              ),



              Text(



                '${line.quantity}',



                style: const TextStyle(fontWeight: FontWeight.w900),



              ),



              IconButton(



                onPressed: onPlus,



                visualDensity: VisualDensity.compact,



                icon: const Icon(



                  Icons.add_circle_outline_rounded,



                  color: _blue,



                ),



              ),



              const SizedBox(width: 6),



              Text(



                money(line.total),



                style: const TextStyle(



                  color: _green,



                  fontWeight: FontWeight.w900,



                ),



              ),



            ],



          ),



        ],



      ),



    );



  }



}







class _EmptyCart extends StatelessWidget {



  const _EmptyCart();







  @override



  Widget build(BuildContext context) {



    return Center(



      child: Column(



        mainAxisSize: MainAxisSize.min,



        children: [



          Container(



            width: 76,



            height: 76,



            decoration: BoxDecoration(



              color: _blue.withValues(alpha: 0.10),



              shape: BoxShape.circle,



            ),



            child: const Icon(



              Icons.shopping_cart_outlined,



              size: 36,



              color: _blue,



            ),



          ),



          const SizedBox(height: 14),



          const Text(



            'Your bill is empty',



            style: TextStyle(



              fontSize: 18,



              fontWeight: FontWeight.w800,



            ),



          ),



          const SizedBox(height: 6),



          const Text(



            'Tap a product to add it here.',



            style: TextStyle(color: _muted),



          ),



        ],



      ),



    );



  }



}
