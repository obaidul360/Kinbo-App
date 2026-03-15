import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'gmail_login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  bool loading = false;

  Future register() async {

    if (!formKey.currentState!.validate()) return;

    setState(() => loading = true);

    try {

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: pass.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration Success")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );

    } on FirebaseAuthException catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Error")),
      );

    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [

              TextFormField(
                controller: email,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (v) {
                  if (v!.isEmpty) return "Enter Email";
                  if (!v.contains("@")) return "Invalid Email";
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: pass,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
                validator: (v) {
                  if (v!.isEmpty) return "Enter Password";
                  if (v.length < 6) return "Min 6 char";
                  return null;
                },
              ),

              const SizedBox(height: 25),

              loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: register,
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}