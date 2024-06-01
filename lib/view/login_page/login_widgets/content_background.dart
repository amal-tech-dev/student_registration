import 'package:flutter/material.dart';

class ContentBackground extends StatelessWidget {
  Widget content;
  ContentBackground({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey, width: 1.5),
      ),
      child: Center(child: content),
    );
  }
}
