import 'package:flutter/material.dart';

class BodyWidget extends StatelessWidget {
  final double width;
  final String label;
  final String data;

  const BodyWidget({
    Key? key,
    this.width = 200,
    this.label = '',
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        children: [
          Text(
            label + ':',
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            data,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
