import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/data/controller/auth/auth_controller.dart';
import 'package:untitled/data/model/user_data.dart';
import 'package:untitled/data/services/network_caller.dart';
import 'package:untitled/data/utility/app_url.dart';
import 'package:untitled/presentation/app_screen/authenication/profile_screen.dart';

class ProfileUpdateController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool updateProfileInProgress = false.obs;
  Rx<XFile?> pickedImage = Rx<XFile?>(null);

  @override
  void onInit() {
    super.onInit();
    emailController.text = AuthController.userData?.email ?? '';
    firstNameController.text = AuthController.userData?.firstName ?? '';
    lastNameController.text = AuthController.userData?.lastName ?? '';
    mobileController.text = AuthController.userData?.mobile ?? '';
  }

  Future<void> pickImageFromGallery() async {
    final ImagePicker imagePicker = ImagePicker();
    pickedImage.value = await imagePicker.pickImage(source: ImageSource.gallery);
  }

  Future<void> updateProfile() async {
    String? photo;

    updateProfileInProgress.value = true;
    update();
    final Map<String, dynamic> inputParams = {
      "email": emailController.text,
      "firstName": firstNameController.text.trim(),
      "lastName": lastNameController.text.trim(),
      "mobile": mobileController.text.trim(),
    };

    if (passwordController.text.isNotEmpty) {
      inputParams['password'] = passwordController.text;
    }

    if (pickedImage.value != null) {
      final bytes = await pickedImage.value!.readAsBytes();
      photo = base64Encode(bytes);
      inputParams['photo'] = photo;
    }

    final response = await NetworkCaller.postRequest(Urls.updateProfile, inputParams);
    updateProfileInProgress.value = false;

    if (response.isSuccess) {
      if (response.responseBody['status'] == 'success') {
        final UserData userData = UserData(
          email: emailController.text,
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          mobile: mobileController.text.trim(),
          photo: photo,
        );
        await AuthController.saveUserData(userData);
      }

      Get.offAll(() => const ProfileScreen());
      update();
    } else {
      Get.snackbar('Error', 'Update profile failed! Try again.');
      update();
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
