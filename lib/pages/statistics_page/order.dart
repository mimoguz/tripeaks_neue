import 'package:flutter/material.dart';

final class Order extends StatelessWidget {
  const Order(this.value, {super.key});

  final int value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24.0,
      child: Text(value.toString(), style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600)),
    );
  }
}
