import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/data/controller/auth_controller.dart';
import 'package:untitled/presentation/app_screen/authenication/profile_screen.dart';
import 'package:untitled/presentation/utiles/background_screen.dart';
import '../../../data/model/user_data.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utility/app_url.dart';
import '../../constant/image_constants.dart';
import '../../utiles/custom_snackbar.dart';
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
  XFile? _pickedImage;
  bool _updateProfileInProgress = false;

  @override
  void initState() {
    super.initState();
    _emailController.text = AuthController.userData?.email ?? '';
    _firstNameController.text = AuthController.userData?.firstName ?? '';
    _lastNameController.text = AuthController.userData?.lastName ?? '';
    _mobileController.text = AuthController.userData?.mobile ?? '';
  }

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
                            pickImageFromGallery();
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
              Visibility(
                visible: _updateProfileInProgress = true,
                replacement: const Center(
                  child: CircularProgressIndicator( color: Colors.green,),
                ),
                child: GestureDetector(
                  onTap: () {
                    log('login Next');
                    _updateProfile();
                  },
                  child: const SubmitButtonWidget(
                    HIcon: Icons.keyboard_arrow_right_outlined,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickImageFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    _pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  // Future<void> _updateProfile() async {
  //   String? photo;
  //
  //   _updateProfileInProgress = true;
  //   setState(() {});
  //
  //   Map<String, dynamic> inputParams = {
  //     "email": _emailController.text,
  //     "firstName": _firstNameController.text.trim(),
  //     "lastName": _lastNameController.text.trim(),
  //     "mobile": _mobileController.text.trim(),
  //   };
  //
  //   if (_passwordController.text.isNotEmpty) {
  //     inputParams['password'] = _passwordController.text;
  //   }
  //
  //   if (_pickedImage != null) {
  //     List<int> bytes = await _pickedImage!.readAsBytes();
  //     String photo = base64Encode(bytes);
  //     inputParams['photo'] = photo;
  //   }
  //
  //   final response =
  //       await NetworkCaller.postRequest(Urls.updateProfile, inputParams);
  //   _updateProfileInProgress = false;
  //   if (response.isSuccess) {
  //     if (response.responseBody['status'] == 'success') {
  //       UserData userData = UserData(
  //         email: _emailController.text,
  //         firstName: _firstNameController.text.trim(),
  //         lastName: _lastNameController.text.trim(),
  //         mobile: _mobileController.text.trim(),
  //         photo: photo,
  //       );
  //       await AuthController.saveUserData(userData);
  //     }
  //     setState(() {});
  //
  //     if (mounted) {
  //       Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (context) => const ProfileScreen()),
  //           (route) => false);
  //     }
  //   } else {
  //     if (!mounted) {
  //       return;
  //     }
  //     setState(() {});
  //     showSnackBarMessage(context, 'Update profile failed! Try again.');
  //   }
  // }
  Future<void> _updateProfile() async {
    String? photo; // Declare photo variable at the beginning of the function

    _updateProfileInProgress = true;
    setState(() {});

    Map<String, dynamic> inputParams = {
      "email": _emailController.text,
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mobileController.text.trim(),
    };

    if (_passwordController.text.isNotEmpty) {
      inputParams['password'] = _passwordController.text;
    }

    if (_pickedImage != null) {
      List<int> bytes = await _pickedImage!.readAsBytes();
      photo = base64Encode(bytes); // Remove String declaration here
      inputParams['photo'] = photo;
    }

    final response = await NetworkCaller.postRequest(Urls.updateProfile, inputParams);
    _updateProfileInProgress = false;
    if (response.isSuccess) {
      if (response.responseBody['status'] == 'success') {
        UserData userData = UserData(
          email: _emailController.text,
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          mobile: _mobileController.text.trim(),
          photo: photo, // Use the outer photo variable here
        );
        await AuthController.saveUserData(userData);
      }
      setState(() {});

      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
                (route) => false);
      }
    } else {
      if (!mounted) {
        return;
      }
      setState(() {});
      showSnackBarMessage(context, 'Update profile failed! Try again.');
    }
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
