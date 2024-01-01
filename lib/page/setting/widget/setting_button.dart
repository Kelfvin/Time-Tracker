import 'package:flutter/material.dart';

class SettingCardButton extends StatelessWidget {
  String text = "";

  Icon? icon;

  VoidCallback? onPressed = () {};

  SettingCardButton({super.key, required this.text, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: Colors.white,
        child: Ink(
          width: 100,
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Text(text),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      icon ?? Container()
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
