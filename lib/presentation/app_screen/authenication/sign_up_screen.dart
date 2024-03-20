import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:untitled/data/services/network_caller.dart';
import 'package:untitled/data/utility/app_url.dart';
import 'package:untitled/presentation/utiles/background_screen.dart';
import '../../../data/model/response_object.dart';
import '../../utiles/custom_snackbar.dart';
import '../../utiles/submit_button_widget.dart';
import 'log_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _isRegistrationInProgress = false;

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
                'Join With Us',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              ///Email
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: const InputDecoration(hintText: 'Email'),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Enter Your Email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              ///First Name
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _firstNameController,
                decoration: const InputDecoration(hintText: 'First Name'),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Enter Your First Name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              ///Last Name
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _lastNameController,
                decoration: const InputDecoration(hintText: 'Last Name'),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Enter Your Last Name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              ///Mobile
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _mobileController,
                decoration: const InputDecoration(hintText: 'Mobile'),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Enter Your Mobile Number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              ///password
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(hintText: 'Password'),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Enter Your Password";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 32),

              ///submit button
              GestureDetector(
                onTap: () async {
                  log('login Next');
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const LogInScreen()),
                  // );

                  if (_globalKey.currentState!.validate()) {
                    _isRegistrationInProgress = true;
                    setState(() {});
                    Map<String, dynamic> inputParams = {
                      "email": _emailController.text.trim(),
                      "firstName": _firstNameController.text.trim(),
                      "lastName": _lastNameController.text.trim(),
                      "mobile": _mobileController.text.trim(),
                      "password": _passwordController.text,
                    };

                    final ResponseObject response = await NetworkCaller.postRequest(Urls.registration, inputParams);

                    _isRegistrationInProgress = false;
                    setState(() {});

                    if (response.isSuccess) {
                      if (mounted) {
                        showSnackBarMessage(context,'Registration Successful');
                        Navigator.pop(context);
                      }
                    } else {
                      if (mounted) {
                        showSnackBarMessage(context, 'Registration Failed, try again.');
                      }
                    }
                  }
                },
                child: Visibility(
                  visible: _isRegistrationInProgress == false,
                  replacement:  const Center(
                    child: CircularProgressIndicator(color: Colors.grey,),
                  ),
                  child: const SubmitButtonWidget(
                    HIcon: Icons.keyboard_arrow_right_outlined,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: GestureDetector(
                  onTap: () {
                    log('forget password');
                  },
                  child: Text(
                    'forget Password?',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '''Don't have account''',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
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
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
