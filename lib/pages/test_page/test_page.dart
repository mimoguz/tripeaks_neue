import 'package:flutter/material.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/cleared_card.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int _id = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ClearedCardAnimated(id: _id, score: 100, show: true),
            FilledButton(onPressed: () => setState(() => _id++), child: Text("Set id")),
          ],
        ),
      ),
    );
  }
}
