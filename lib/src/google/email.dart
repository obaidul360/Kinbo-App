import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kinbo/src/home/home_ui.dart';

class EmailAuthenticationScreen extends StatefulWidget {
  const EmailAuthenticationScreen({super.key});

  @override
  State<EmailAuthenticationScreen> createState() =>
      _EmailAuthenticationScreenState();
}

class _EmailAuthenticationScreenState extends State<EmailAuthenticationScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool loading = false;
  Future emailLogin() async {
    setState(() => loading = true);

    try {
      await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeUiScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "Error")));
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Email")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: passController,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: loading ? null : emailLogin,
              child: loading
                  ? CircularProgressIndicator()
                  : Text("verify mail"),
            ),
          ],
        ),
      ),
    );
  }
}
