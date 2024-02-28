import 'package:flutter/material.dart';

class SubmitButtonWidget extends StatelessWidget {
  const SubmitButtonWidget({Key? key, this.HText, this.HIcon}) : super(key: key);

  final String? HText;
  final IconData? HIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (HIcon != null) Icon(HIcon, size: 25, color: Colors.white,),
            if (HText != null) Text(HText!,),
          ],
        ),
      ),
    );
  }
}
