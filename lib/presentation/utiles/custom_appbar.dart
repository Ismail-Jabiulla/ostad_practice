import 'package:flutter/material.dart';
import 'package:untitled/data/controller/auth/auth_controller.dart';
import '../constant/image_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  Function callBack;
   CustomAppBar({required this.callBack, super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(

      ///user photo
      leading: GestureDetector(
        onTap: () {
         callBack();
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
          callBack();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AuthController.userData!.fullName,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondary)),
            Text(AuthController.userData!.email ?? '',
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