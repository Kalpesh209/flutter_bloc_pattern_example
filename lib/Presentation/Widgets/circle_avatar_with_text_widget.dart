import 'package:flutter/material.dart';

/*
Title: CircleAvatarWithTextWidget
Purpose:CircleAvatarWithTextWidget
Created On: 02/04/2024
Edited On:02/04/2024
Author: Kalpesh Khandla
*/

class CircleAvatarWithTextWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const CircleAvatarWithTextWidget({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            child: Icon(icon),
          ),
          const SizedBox(height: 8.0),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
