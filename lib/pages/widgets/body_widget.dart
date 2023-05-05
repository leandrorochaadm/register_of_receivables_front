import 'package:flutter/material.dart';

class BodyWidget extends StatelessWidget {
  final double width;
  final String label;
  final FontWeight fontWeight;

  const BodyWidget({
    Key? key,
    this.width = 200,
    required this.label,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        label,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
