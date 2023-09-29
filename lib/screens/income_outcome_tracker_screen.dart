import 'package:finplan/constant/finance_type_constants.dart';
import 'package:finplan/helper/dbhelper.dart';
import 'package:finplan/models/finance.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeOutcomeTrackerScreen extends StatefulWidget {
  @override
  _IncomeOutcomeTrackerScreenState createState() =>
      _IncomeOutcomeTrackerScreenState();
}

class _IncomeOutcomeTrackerScreenState
    extends State<IncomeOutcomeTrackerScreen> {
  List<Finance> cashFlowData = [];

  @override
  void initState() {
    super.initState();
    _fetchCashFlowData();
  }

  Future<void> _fetchCashFlowData() async {
    DbHelper dbHelper = DbHelper();
    await dbHelper.initDb(); // Initialize the database
    List<Finance> data = await dbHelper.getFinance();

    setState(() {
      cashFlowData = data;
    });
  }

  Future<void> _deleteItem(int index) async {
    DbHelper dbHelper = DbHelper();
    await dbHelper.initDb(); // Initialize the database

    // Delete the item from the database
    await dbHelper.deleteDataFinance(cashFlowData[index].id!);

    // Remove the item from the list
    setState(() {
      cashFlowData.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Cash Flow"),
      ),
      body: ListView.builder(
        itemCount: cashFlowData.length,
        itemBuilder: (context, index) {
          final item = cashFlowData[index];
          final isIncome = item.type == incomeType;

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: ListTile(
              leading: Image.asset(
                isIncome
                    ? 'assets/images/income_arrow.png'
                    : 'assets/images/expense_arrow.png',
                color: isIncome ? Colors.green : Colors.red,
                width: 24,
                height: 24,
              ),
              title: Text(item.date!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${isIncome ? 'Pemasukan' : 'Pengeluaran'}: ${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(int.parse(item.amount!))}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Deskripsi: ${item.description}",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              trailing: GestureDetector(
                onTap: () async {
                  _deleteItem(index);
                },
                child: const Icon(Icons.delete, color: Colors.red),
              ),
            ),
          );
        },
      ),
    );
  }
}
