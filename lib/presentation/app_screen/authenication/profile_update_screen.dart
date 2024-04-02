import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled/presentation/utiles/background_screen.dart';
import '../../../data/controller/auth/profile_update_controller.dart';
import '../../constant/image_constants.dart';
import '../../utiles/submit_button_widget.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({super.key});

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  final ProfileUpdateController controller = Get.put(ProfileUpdateController());

  @override
  Widget build(BuildContext context) {
    return BackgroundedScreen(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Form(
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
                          image: const DecorationImage(
                              image: AssetImage(AssetsPath.Professional),
                              fit: BoxFit.cover),
                          border: Border.all(
                              color: Theme.of(context).colorScheme.onPrimary,
                              width: 2),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            print('upload Image');
                            controller.pickImageFromGallery();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).colorScheme.onPrimary,
                                border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    width: 2)),
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
                enabled: false,
                keyboardType: TextInputType.emailAddress,
                controller: controller.emailController,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              const SizedBox(height: 16),

              ///First Name
              TextFormField(
                keyboardType: TextInputType.text,
                controller: controller.firstNameController,
                decoration: const InputDecoration(hintText: 'First Name'),
              ),
              const SizedBox(height: 16),

              ///Last Name
              TextFormField(
                keyboardType: TextInputType.text,
                controller: controller.lastNameController,
                decoration: const InputDecoration(hintText: 'Last Name'),
              ),
              const SizedBox(height: 16),

              ///Mobile
              TextFormField(
                keyboardType: TextInputType.number,
                controller: controller.mobileController,
                decoration: const InputDecoration(hintText: 'Mobile'),
              ),
              const SizedBox(height: 16),

              ///password
              TextFormField(
                controller: controller.passwordController,
                decoration: const InputDecoration(hintText: 'Password'),
              ),

              const SizedBox(height: 32),

              ///submit button
              GetBuilder<ProfileUpdateController>(
                builder: (controller) {
                  if (controller == null) {
                    return SizedBox.shrink(); // or return null;
                  }

                  return Visibility(
                    visible: controller.updateProfileInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        log('login Next');
                        controller.updateProfile();
                      },
                      child: const SubmitButtonWidget(
                        HIcon: Icons.keyboard_arrow_right_outlined,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
