import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:untitled/presentation/app_screen/authenication/sign_up_screen.dart';
import '../../utiles/background_screen.dart';
import '../../utiles/submit_button_widget.dart';
import 'email_for_varification_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                'Get Started With',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              ///Email
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              const SizedBox(height: 16),

              ///password
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(hintText: 'Password'),
              ),

              const SizedBox(height: 32),

              ///submit button
              GestureDetector(
                onTap: () {
                  log('login Next');
                },
                child: const SubmitButtonWidget(
                  HIcon: Icons.keyboard_arrow_right_outlined,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EmailVerification()));
                  },
                  child: Text(
                    'forget Password?',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '''Don't have account?''',
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
                              builder: (context) => const SignUpScreen()));
                    },
                    child: const Text(
                      ' Sign Up',
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
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
