import 'package:flutter/material.dart';

typedef CallbackSetting = void Function(String, int);

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;
  final double? size;
  final VoidCallback onPressed;

  const ProductivityButton(
      {super.key,
      required this.color,
      required this.text,
      this.size = 150,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      minWidth: size,
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  final Color color;
  final String text;
  final int value;
  final String setting;
  final CallbackSetting callBack;

  const SettingsButton(
      {super.key,
      required this.color,
      required this.text,
      required this.value,
      required this.setting,
      required this.callBack});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => callBack(setting, value),
      color: color,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
