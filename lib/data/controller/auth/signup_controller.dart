import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/response_object.dart';
import '../../services/network_caller.dart';
import '../../utility/app_url.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  Future<bool> signup(GlobalKey<FormState> globalKey, String email, String firstName, String lastName, String mobile, String password) async {
    if (globalKey.currentState!.validate()) {
      _inProgress = true;

      Map<String, dynamic> inputParams = {
        "email": email.trim(),
        "firstName": firstName.trim(),
        "lastName": lastName.trim(),
        "mobile": mobile.trim(),
        "password": password,
      };

      final ResponseObject response = await NetworkCaller.postRequest(
          Urls.registration, inputParams);

      _inProgress = false;

      if (response.isSuccess) {
        Get.snackbar(
          "Success",
          "Registration Successful",
        );
        return true; // Return true indicating successful registration
      } else {
        Get.snackbar(
          "Error",
          response.errorMessage ?? "Registration Failed, try again.",
        );
        return false; // Return false indicating failed registration
      }
    } else {
      return false; // Form validation failed
    }
  }
}
