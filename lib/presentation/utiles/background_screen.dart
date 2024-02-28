import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/presentation/constant/image_constants.dart';

class BackgroundedScreen extends StatelessWidget {
  final Widget child;

  const BackgroundedScreen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: SvgPicture.asset(
              AssetsPath.Background,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Theme.of(context).colorScheme.onSurface,
            child: Column(
              children: [
                const SizedBox(height: 40),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
