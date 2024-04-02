import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../presentation/app_screen/bottom_navigation_screen.dart';
import '../../model/login_response.dart';
import '../../model/response_object.dart';
import '../../services/network_caller.dart';
import '../../utility/app_url.dart';
import 'auth_controller.dart';

class LoginController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage ?? " ";

  Future<bool> login(String email, String password) async {
    _inProgress = true;

    Map<String, dynamic> inputParam = {
      "email": email.trim(),
      "password": password,
    };

    final ResponseObject response = await NetworkCaller.postRequest(
        Urls.login, inputParam,
        fromSignIn: true);

    _inProgress = false;

    if (response.isSuccess) {
      LoginResponse loginResponse =
      LoginResponse.fromJson(response.responseBody);

      ///Save Data
      await AuthController.saveUserData(loginResponse.userData!);
      await AuthController.saveUserToken(loginResponse.token!);

      Get.offAll( BottomNavigationScreen());
      update();
      return true; // Return true indicating successful login
    } else {
      Get.snackbar(
        "Error",
        response.errorMessage ?? "Login failed! Try again.",
      );
      update();
      return false; // Return false indicating failed login
    }
  }

}
