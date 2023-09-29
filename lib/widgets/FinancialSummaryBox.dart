import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FinancialSummaryBox extends StatelessWidget {
  final int total;
  final String label;
  final Color color;
  final String imagePath;

  const FinancialSummaryBox(
      {super.key,
      required this.total,
      required this.label,
      required this.color,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 1;

    return Container(
      height: 80,
      width: buttonWidth,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                NumberFormat.currency(locale: 'id', symbol: 'Rp. ')
                    .format(total),
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
          // Image.asset(
          //   imagePath,
          //   width: 70,
          //   height: 70,
          // ),
        ]),
      ),
    );
  }
}
