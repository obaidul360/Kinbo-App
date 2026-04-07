import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Home"),
          SizedBox(height: 50),
          Text("Product"),
          SizedBox(height: 200),
          Text("Screen"),
        ],
      ),
    );
  }
}
