import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:untitled/data/controller/auth/login_controller.dart';
import 'package:untitled/presentation/app_screen/authenication/sign_up_screen.dart';
import '../../utiles/background_screen.dart';
import '../../utiles/custom_snackbar.dart';
import '../../utiles/submit_button_widget.dart';
import '../bottom_navigation_screen.dart';
import 'email_for_varification_screen.dart';
import 'package:get/get.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  final LoginController _loginController = Get.find<LoginController>();

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
              _buildEmailForm(),
              const SizedBox(height: 16),
              _buildPasswordForm(),
              const SizedBox(height: 32),
              _buildSubmitButton(),
              _buildBottomSide(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailForm() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      decoration: const InputDecoration(hintText: 'Email'),
      validator: (String? value) {
        if (value?.trim().isEmpty ?? true) {
          return "Enter Your Email";
        }
        return null;
      },
    );
  }

  Widget _buildPasswordForm() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        hintText: 'Password',
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: _obscurePassword ? Colors.grey : Colors.blue,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
      validator: (String? value) {
        if (value?.trim().isEmpty ?? true) {
          return "Enter Your Password";
        }
        return null;
      },
    );
  }

  Widget _buildSubmitButton() {
    return GestureDetector(
      onTap: () {
        log('login Next');

        if (_globalKey.currentState!.validate()) {
          _login();
        }
      },
      child: GetBuilder<LoginController>(
        builder: (logInController) {
          return Visibility(
            visible: logInController.inProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            ),
            child: const SubmitButtonWidget(
              HIcon: Icons.keyboard_arrow_right_outlined,
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomSide() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EmailVerification(),
                ),
              );
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
                    builder: (context) => const SignUpScreen(),
                  ),
                );
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
    );
  }

  Future<void> _login() async {
    final result = await _loginController.login(
        _emailController.text.trim(), _passwordController.text);

    if (result == true) {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  BottomNavigationScreen(),
          ),
        );
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, _loginController.errorMessage);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
