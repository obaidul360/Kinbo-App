import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kinbo/src/google/phone.dart';
import 'package:kinbo/src/home/home_ui.dart';

class OtpSender extends StatefulWidget {
  final String verificationId;
  OtpSender({super.key, required this.verificationId});

  @override
  State<OtpSender> createState() => _OtpSenderState();
}

class _OtpSenderState extends State<OtpSender> {
  final TextEditingController otpController = TextEditingController();
  Future verifyOtp() async {
    try {
      PhoneAuthCredential credential = await PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otpController.text.trim(),
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeUiScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Invalid OTP")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            TextField(
              controller: otpController,
              decoration: InputDecoration(
                labelText: "Enter OTP",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(onPressed: verifyOtp, child: Text("Verify OTP")),
          ],
        ),
      ),
    );
  }
}
