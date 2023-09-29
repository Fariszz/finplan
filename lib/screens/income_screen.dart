import 'package:finplan/helper/dbhelper.dart';
import 'package:finplan/screens/base_financial_screen.dart';
import 'package:flutter/material.dart';

class IncomeScreen extends BaseFinancialScreen {
  IncomeScreen({Key? key})
      : super(
          key: key,
          title: "Tambah Pemasukan",
          actionText: "Simpan",
          onSave: (String date, String amount, String description) async {
            final DbHelper dbHelper = DbHelper();
            return dbHelper.insertIncome(date, amount, description);
          },
        );
}