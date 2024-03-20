import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/data/controller/auth_controller.dart';
import 'package:untitled/localization/Language/languages.dart';
import 'package:untitled/presentation/app_screen/authenication/profile_update_screen.dart';
import 'package:untitled/presentation/utiles/background_screen.dart';
import '../../../data/provider/language_provider.dart';
import '../../../data/provider/theme_provider.dart';
import '../../../localization/Language/language_bn.dart';
import '../../../localization/Language/language_en.dart';
import 'log_in_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {

    var languageProvider = Provider.of<LanguageProvider>(context);
    var currentLanguage = languageProvider.currentLanguage;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return BackgroundedScreen(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),

            ///profile info
            _profileInfo(context),
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),

            Card(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    _buildPersonalInfo(currentLanguage),
                    _buildLanguage(currentLanguage, languageProvider),
                    _buildTheme(currentLanguage, themeProvider),
                    _version(currentLanguage),
                    _logout(currentLanguage),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return Card(
      child: Container(
        height: MediaQuery.of(context).size.width * .5,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(
              height: 90,
              width: 105,
              child: Stack(
                children: [
                  ///profile photo
                  Container(
                    height: 120,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Theme.of(context).colorScheme.onSecondary,
                          width: 2),
                      // image: DecorationImage(
                      //   image: MemoryImage(base64Decode(AuthController.userData!.photo!))
                      // ),
                    ),
                    child: CircleAvatar(
                      backgroundImage: AuthController.userData?.photo != null
                          ? MemoryImage(base64Decode(AuthController.userData!.photo!))
                          : null,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const ProfileUpdateScreen()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.onPrimary,
                            border: Border.all(
                                color: Theme.of(context).colorScheme.onSecondary,
                                width: 1)),
                        child: Icon(
                          Icons.edit,
                          color: Theme.of(context).colorScheme.onSecondary,
                          size: 15,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Text(
              AuthController.userData!.fullName,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary),
            ),
            Text(
              AuthController.userData!.email ?? ' ',
              style: TextStyle(
                  fontSize: 12, color: Theme.of(context).colorScheme.secondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguage(currentLanguage, languageProvider){
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 16.0, horizontal: 8.0),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              currentLanguage.language,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary),
            ),
            SizedBox(
              height: 30,
              child: Switch(
                value: languageProvider.currentLanguage is LanguageBn,
                activeColor: Colors.white,
                activeTrackColor: Colors.green,
                inactiveTrackColor: Colors.white,
                inactiveThumbColor: Colors.transparent,
                // activeThumbImage: AssetImage(AssetsPath.sun),
                // inactiveThumbImage: AssetImage(AssetsPath.moon),
                onChanged: (bool newValue) {
                  if (newValue) {
                    languageProvider.changeLanguage(LanguageBn(), 'LanguageBn');
                  } else {
                    languageProvider.changeLanguage(LanguageEn(), 'LanguageEn');
                  }
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildTheme(currentLanguage,themeProvider){
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 16.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            currentLanguage.theme,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary),
          ),
          Switch(
            activeColor: Colors.white,
            activeTrackColor: Colors.green,
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfo(Languages currentLanguage){
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 16.0, horizontal: 8.0),
      child: GestureDetector(
        onTap: () {},
        child: Text(
          currentLanguage.personal_info,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary),
        ),
      ),
    );
  }

  Widget _version(Languages currentLanguage){
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 16.0, horizontal: 8.0),
      child: GestureDetector(
        onTap: () {},
        child: Text(
          currentLanguage.version,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary),
        ),
      ),
    );
  }

  Widget _logout(Languages currentLanguage){
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 16.0, horizontal: 8.0),

      child: GestureDetector(
        onTap: () async {
          await AuthController.clearUserData();
          if(mounted){
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LogInScreen()),
                (route) => false);
          }
        },


        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              currentLanguage.logout,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary),
            ),
            const Icon(Icons.exit_to_app, color: Colors.red)
          ],
        ),
      ),
    );
  }

}
