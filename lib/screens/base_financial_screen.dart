import 'package:finplan/helper/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BaseFinancialScreen extends StatefulWidget {
  final String title;
  final String actionText;
  final Future<int> Function(String date, String amount, String description)
      onSave;

  BaseFinancialScreen({
    Key? key,
    required this.title,
    required this.actionText,
    required this.onSave,
  }) : super(key: key);

  @override
  _BaseFinancialScreenState createState() => _BaseFinancialScreenState();
}

class _BaseFinancialScreenState extends State<BaseFinancialScreen> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final DbHelper dbHelper = DbHelper();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  void resetForm() {
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    amountController.clear();
    descriptionController.clear();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: dateController,
              readOnly: true,
              onTap: () {
                _selectDate(context);
              },
              decoration: const InputDecoration(labelText: "Tanggal"),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Jumlah (Nominal)"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Keterangan"),
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.amber),
                    ),
                    onPressed: () {
                      resetForm();
                    },
                    child: const Text("Reset"),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green.shade200),
                    ),
                    onPressed: () async {
                      String date = dateController.text;
                      String amount = amountController.text;
                      String description = descriptionController.text;

                      if (date.isNotEmpty && amount.isNotEmpty) {
                        int rowCount = await widget.onSave(date, amount, description);
                        if (rowCount > 0) {
                          // Successfully added data
                          resetForm(); // Reset the form
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Data berhasil disimpan."),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Gagal menyimpan data."),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Tanggal dan Jumlah harus diisi."),
                          ),
                        );
                      }
                    },
                    child: Text(widget.actionText),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Kembali ke halaman Beranda
                    },
                    child: const Text("<< Kembali"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
