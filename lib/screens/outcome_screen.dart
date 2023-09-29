import 'package:finplan/screens/base_financial_screen.dart';
import 'package:flutter/material.dart';
import 'package:finplan/helper/dbhelper.dart';

class OutcomeScreen extends BaseFinancialScreen {
  OutcomeScreen({Key? key})
      : super(
          key: key,
          title: "Tambah Pengeluaran",
          actionText: "Simpan",
          onSave: (String date, String amount, String description) async {
            final DbHelper dbHelper = DbHelper();
            return dbHelper.insertOutcome(date, amount, description);
          },
        );
}