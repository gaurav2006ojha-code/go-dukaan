import 'package:flutter/material.dart';
import 'package:go_dukaan_client/go_dukaan_client.dart';

class ReportsScreen extends StatefulWidget {
  final Client client;

  const ReportsScreen({
    super.key,
    required this.client,
  });

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  late DateTime selectedMonth;
  Future<MonthlyReport>? reportFuture;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedMonth = DateTime(now.year, now.month);
    loadReport();
  }

  void loadReport() {
    setState(() {
      reportFuture =
          widget.client.report.getMonthlyReport(selectedMonth);
    });
  }

  void changeMonth(int offset) {
    selectedMonth = DateTime(
      selectedMonth.year,
      selectedMonth.month + offset,
    );
    loadReport();
  }

  String money(double amount) =>
      '₹${amount.toStringAsFixed(2)}';

  Widget reportCard(
    String title,
    double amount,
    IconData icon, {
    Color color = Colors.blue,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.12),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              money(amount),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Reports'),
        actions: [
          IconButton(
            onPressed: loadReport,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh report',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => changeMonth(-1),
                  icon: const Icon(Icons.chevron_left),
                ),
                Expanded(
                  child: Text(
                    '${_monthName(selectedMonth.month)} '
                    '${selectedMonth.year}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => changeMonth(1),
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<MonthlyReport>(
              future: reportFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Report load nahi ho payi.',
                            style: TextStyle(fontSize: 17),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${snapshot.error}',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton.icon(
                            onPressed: loadReport,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Try Again'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final report = snapshot.data;
                if (report == null) {
                  return const Center(
                    child: Text('Report available nahi hai.'),
                  );
                }

                return ListView(
                  padding: const EdgeInsets.fromLTRB(
                    12, 0, 12, 20,
                  ),
                  children: [
                    reportCard(
                      'Total Sales',
                      report.totalSales,
                      Icons.point_of_sale,
                    ),
                    reportCard(
                      'Payment Received',
                      report.totalReceived,
                      Icons.payments,
                      color: Colors.green,
                    ),
                    reportCard(
                      'Sales Due',
                      report.totalSalesDue,
                      Icons.pending_actions,
                      color: Colors.orange,
                    ),
                    reportCard(
                      'Discount',
                      report.totalDiscount,
                      Icons.discount,
                      color: Colors.deepOrange,
                    ),
                    reportCard(
                      'Tax Collected',
                      report.totalTax,
                      Icons.receipt_long,
                    ),
                    const Divider(height: 28),
                    reportCard(
                      'Total Purchases',
                      report.totalPurchases,
                      Icons.shopping_cart,
                      color: Colors.deepPurple,
                    ),
                    reportCard(
                      'Purchase Paid',
                      report.totalPurchasePaid,
                      Icons.check_circle_outline,
                      color: Colors.green,
                    ),
                    reportCard(
                      'Purchase Due',
                      report.totalPurchaseDue,
                      Icons.money_off,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    Card(
                      color: report.grossProfit >= 0
                          ? Colors.green.withValues(alpha: 0.10)
                          : Colors.red.withValues(alpha: 0.10),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          children: [
                            const Text(
                              'Gross Profit / Loss',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              money(report.grossProfit),
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: report.grossProfit >= 0
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Estimated profit before shop expenses',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.receipt),
                        title: const Text('Bills Created'),
                        trailing: Text('${report.billCount}'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.inventory_2),
                        title: const Text('Purchases Recorded'),
                        trailing: Text('${report.purchaseCount}'),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      'January', 'February', 'March', 'April',
      'May', 'June', 'July', 'August',
      'September', 'October', 'November', 'December',
    ];
    return months[month - 1];
  }
}