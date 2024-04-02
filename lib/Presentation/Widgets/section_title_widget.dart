import 'package:flutter/material.dart';


/*
Title: SectionTitleWidget
Purpose:SectionTitleWidget
Created On: 02/04/2024
Edited On:02/04/2024
Author: Kalpesh Khandla
*/


class SectionTitleWidget extends StatelessWidget {
  const SectionTitleWidget({
    super.key,
    required this.title,
    this.action,
    this.onPressed,
  });

  final String title;
  final String? action;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        if (action != null)
          TextButton(
            onPressed: onPressed,
            child: Text(
              action!,
              style: textTheme.bodyMedium!.copyWith(
                decoration: TextDecoration.underline,
                color: colorScheme.secondary,
              ),
            ),
          ),
      ],
    );
  }
}
