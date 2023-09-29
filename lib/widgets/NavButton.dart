import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;
  final Color color;

  const NavButton(
      {super.key,
      required this.imagePath,
      required this.label,
      required this.onTap,
      required this.color});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.4;

    return Column(
      children: [
        Container(
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
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: onTap,
            child: Column(
              children: [
                Image.asset(
                  imagePath,
                  width: 70,
                  height: 70,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }
}
