import 'package:flutter/material.dart';
import '../app_screen/authenication/profile_screen.dart';
import '../constant/image_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(

      ///user photo
      leading: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfileScreen(toggleTheme: () {  },)));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage(
                    AssetsPath.Professional,
                  ),
                  fit: BoxFit.cover),
              shape: BoxShape.circle,
              border: Border.all(color: Theme.of(context).colorScheme.onSecondary, width: 2),
            ),
          ),
        ),
      ),

      ///User Name
      title: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  ProfileScreen(toggleTheme: () { },)));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Daniella Amato',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondary)),
            Text('App Developer',
                style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSecondary)),
          ],
        ),
      ),
      elevation: 0,
      centerTitle: false,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
    );
  }
}