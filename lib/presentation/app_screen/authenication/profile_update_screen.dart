import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/presentation/utiles/background_screen.dart';
import '../../utiles/submit_button_widget.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({super.key});

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .09,
              ),
              const Text(
                'Update Profile',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Center(
                child: SizedBox(
                  height: 90,
                  width: 100,
                  child: Stack(
                    children: [
                      Container(
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Theme.of(context).colorScheme.onSecondary),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: (){
                            print('upload Image');
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).colorScheme.onPrimary,
                                border: Border.all(color: Theme.of(context).colorScheme.onSecondary)
                            ),
                            child: Icon(
                              Icons.add_a_photo_outlined,
                              color: Theme.of(context).colorScheme.onSecondary,
                              size: 15,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ///Email
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              const SizedBox(height: 16),

              ///First Name
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _firstNameController,
                decoration: const InputDecoration(hintText: 'First Name'),
              ),
              const SizedBox(height: 16),

              ///Last Name
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _lastNameController,
                decoration: const InputDecoration(hintText: 'Last Name'),
              ),
              const SizedBox(height: 16),

              ///Mobile
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _mobileController,
                decoration: const InputDecoration(hintText: 'Mobile'),
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
