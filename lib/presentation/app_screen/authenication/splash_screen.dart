import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constant/image_constants.dart';
import '../../utiles/background_screen.dart';
import 'log_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _moveToSignIn();
    super.initState();
  }

  Future<void> _moveToSignIn() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LogInScreen()));
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
