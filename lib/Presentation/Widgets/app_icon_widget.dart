import 'package:flutter/material.dart';

/*
Title: AppIconWidget
Purpose:AppIconWidget
Created On: 02/04/2024
Edited On:02/04/2024
Author: Kalpesh Khandla
*/

class AppIconWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const AppIconWidget({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: colorScheme.onBackground.withOpacity(0.05),
          ),
        ),
        child: Icon(icon, size: 24),
      ),
    );
  }
}
