import 'package:flutter/material.dart';

class SettingCardButton extends StatelessWidget {
  final String text;

  final Icon? icon;

  final VoidCallback? onPressed;

  const SettingCardButton(
      {super.key, required this.text, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: const Color.fromARGB(255, 135, 182, 221),
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
