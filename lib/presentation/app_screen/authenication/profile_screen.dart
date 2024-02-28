import 'package:flutter/material.dart';
import 'package:untitled/presentation/app_screen/authenication/profile_update_screen.dart';
import 'package:untitled/presentation/constant/image_constants.dart';
import 'package:untitled/presentation/utiles/background_screen.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const ProfileScreen({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

   bool _isSelected = false;
   bool _isSelectedLanguage = false;

  @override
  Widget build(BuildContext context) {
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Personal Information',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Language',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary),
                          ),

                          GestureDetector(
                            onTap: (){
                              setState(() {
                                _isSelectedLanguage =! _isSelectedLanguage;
                              });
                            },
                            child: Container(
                              child: _isSelectedLanguage? Text('বাংলা'): Text('English'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Theme',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              _isSelected =! _isSelected;
                              widget.toggleTheme();
                            });
                          },
                          child: Container(
                            child: _isSelected? Icon(Icons.nightlight_outlined, color: Colors.white,): Icon(Icons.sunny, color: Colors.orange,),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Version',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Logout',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          const Icon(Icons.exit_to_app, color: Colors.red)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return Container(
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
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Theme.of(context).colorScheme.onSecondary,
                        width: 2),
                    image: const DecorationImage(
                      image: AssetImage(AssetsPath.Professional),
                      fit: BoxFit.cover,
                    ),
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
            'Daniella Amato',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary),
          ),
          Text(
            'example@gmail.com',
            style: TextStyle(
                fontSize: 12, color: Theme.of(context).colorScheme.secondary),
          ),
        ],
      ),
    );
  }
}
