import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../data/provider/auth_provider.dart';
import '../../../data/shared preferance/auth_shared_preferance.dart';
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
  late String token;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    token = await AuthenticationProvider().getTokenFromSharedPreferences() ?? '';

    if (token.isEmpty) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LogInScreen()),
              (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigationScreen()),
              (route) => false);
    }

    print("Token from splash: $token");
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
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .45),
                child: SvgPicture.asset(AssetsPath.Logo),
              ),
            ],
          ),
        ));
  }
}
