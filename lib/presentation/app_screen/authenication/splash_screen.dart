import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/data/controller/auth_controller.dart';
import '../../constant/image_constants.dart';
import '../../utiles/background_screen.dart';
import '../bottom_navigation_screen.dart';
import 'log_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _moveToNextScreen();
    super.initState();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    bool isLoggedIn = await AuthController.isUserLoggedIn();

    if (mounted) {
      if (isLoggedIn) {
        {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const BottomNavigationScreen()),
              (route) => false);
        }
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LogInScreen()),
            (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundedScreen(
        child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * .45),
            child: SvgPicture.asset(AssetsPath.Logo),
          ),
        ],
      ),
    ));
  }
}
