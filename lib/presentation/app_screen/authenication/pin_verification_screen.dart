import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:untitled/presentation/app_screen/authenication/set_password_screen.dart';
import 'package:untitled/presentation/utiles/background_screen.dart';
import 'package:pinput/pinput.dart';
import '../../utiles/submit_button_widget.dart';
import 'log_in_screen.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundedScreen(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .2),
            const Text(
              'PIn Verification',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text(
                'A 6 digits verification pin will send to your email address',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Pinput(
                length: 6,
                autofocus: true,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                defaultPinTheme: PinTheme(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.green)),
                    textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                focusedPinTheme: PinTheme(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.green, width: 2)),
                    textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
            ),
            const SizedBox(height: 32),

            ///submit button
            GestureDetector(
              onTap: () {
                log('login Next');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SetPasswordScreen()));
              },
              child: const SubmitButtonWidget(
                HIcon: Icons.keyboard_arrow_right_outlined,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Have account?',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    log('SignIn');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LogInScreen()));
                  },
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
