import 'package:flutter/material.dart';

class HomeUiScreen extends StatefulWidget {
  const HomeUiScreen({super.key});

  @override
  State<HomeUiScreen> createState() => _HomeUiScreenState();
}

class _HomeUiScreenState extends State<HomeUiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen")),
      body: Center(child: Column(children: [Text("SuccesFull OTP")])),
    );
  }
}
