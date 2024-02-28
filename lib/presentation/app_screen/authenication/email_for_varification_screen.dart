import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:untitled/presentation/app_screen/authenication/pin_verification_screen.dart';
import 'package:untitled/presentation/utiles/background_screen.dart';
import '../../utiles/submit_button_widget.dart';
import 'log_in_screen.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BackgroundedScreen(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .2,
              ),
              const Text(
                'Your Email Address',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  'A 6 digits verification pin will send to your email address',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 16),

              ///Email
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: const InputDecoration(hintText: 'Email'),
              ),

              const SizedBox(height: 32),

              ///submit button
              GestureDetector(
                onTap: () {
                  log('login Next');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PinVerificationScreen()));
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
                    '''Have account?''',
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
                      ' Sign in',
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
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
