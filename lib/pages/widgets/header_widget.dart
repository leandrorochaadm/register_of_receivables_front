import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final double width;
  final String label;

  const HeaderWidget({
    Key? key,
    required this.width,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
