import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({required this.onPressed, required this.text, this.icon, super.key});

  final VoidCallback onPressed;
  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Padding(padding: const EdgeInsets.only(right: 8), child: Icon(icon, size: 20)),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
