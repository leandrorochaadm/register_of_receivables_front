import 'package:flutter/material.dart';

class BasePageWidget extends StatefulWidget {
  final Widget body;
  final Widget? footer;
  final String title;
  final FloatingActionButton? floatingActionButton;
  final List<Widget>? header;

  const BasePageWidget({
    Key? key,
    required this.title,
    required this.body,
    this.floatingActionButton,
    this.header,
    this.footer,
  }) : super(key: key);

  @override
  State<BasePageWidget> createState() => _BasePageWidgetState();
}

class _BasePageWidgetState extends State<BasePageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      floatingActionButton: widget.floatingActionButton,
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Row(
                  children: [...?widget.header],
                )
              ],
            ),
            const SizedBox(height: 22),
            Expanded(
              child: Container(
                // margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: widget.body,
                ),
              ),
            ),
            const SizedBox(height: 22),
            widget.footer ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
