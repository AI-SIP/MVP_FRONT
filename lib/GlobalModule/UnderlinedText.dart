import 'package:flutter/material.dart';

class UnderlinedText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;

  const UnderlinedText({
    super.key,
    required this.text,
    this.fontSize = 20,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: TextStyle(fontSize: fontSize, fontFamily: 'font1', fontWeight: FontWeight.bold, color: color)),
          Container(
            margin: const EdgeInsets.only(top: 2),
            height: 2,
            color: Colors.red.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}