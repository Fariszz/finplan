import 'package:finplan/constant/route_constants.dart';
import 'package:finplan/helper/dbhelper.dart';
import 'package:finplan/widgets/FinanceChartData.dart';
import 'package:finplan/widgets/FinancialSummaryBox.dart';
import 'package:finplan/widgets/NavButton.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalIncome = 0;
  int totalExpense = 0;

  @override
  void initState() {
    super.initState();
    _fetchTotalIncomeAndExpense();
  }

  Future<void> _fetchTotalIncomeAndExpense() async {
    // Initialize your DBHelper
    final dbHelper = DbHelper();

    // Fetch the total income and total expense
    final income = await dbHelper.getTotalIncome();
    final expense = await dbHelper.getTotalOutcome();

    setState(() {
      totalIncome = income;
      totalExpense = expense;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchTotalIncomeAndExpense(); // Refresh data when navigating back
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
          child: Center(
              child: Column(
            children: [
              const FinanceChartData(),
              const SizedBox(
                height: 20,
              ),
              FinancialSummaryBox(
                  total: totalIncome,
                  label: "Total pendapatan bulan ini",
                  color: Colors.blue.shade700,
                  imagePath: "assets/images/income_arrow.png"),
              const SizedBox(
                height: 20,
              ),
              FinancialSummaryBox(
                  total: totalExpense,
                  label: "Total pengeluaran bulan ini",
                  color: Colors.red.shade700,
                  imagePath: "assets/images/expense_arrow.png"),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ]),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          NavButton(
                            imagePath: 'assets/images/income.png',
                            label: "Tambah Pemasukan",
                            onTap: () {
                              Navigator.pushNamed(context, addIncomeRoute);
                            },
                            color: Colors.green.shade300,
                          ),
                          NavButton(
                            imagePath: 'assets/images/expense.png',
                            label: "Tambah Pengeluaran",
                            onTap: () {
                              Navigator.pushNamed(context, addExpenseRoute);
                            },
                            color: Colors.red.shade300,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          NavButton(
                            imagePath: 'assets/images/lists.png',
                            label: "Detail Cash Flow",
                            onTap: () async {
                              await Navigator.pushNamed(
                                  context, detailCashFlowRoute);

                              _fetchTotalIncomeAndExpense();
                            },
                            color: Colors.blue.shade300,
                          ),
                          NavButton(
                            imagePath: 'assets/images/settings.png',
                            label: "Pengaturan",
                            onTap: () {
                              Navigator.pushNamed(context, '/settings');
                            },
                            color: Colors.orange.shade300,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
