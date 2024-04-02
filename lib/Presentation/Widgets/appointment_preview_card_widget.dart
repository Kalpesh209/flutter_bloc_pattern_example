import 'package:flutter/material.dart';


/*
Title: AppointmentPreviewCardWidget
Purpose:AppointmentPreviewCardWidget
Created On: 02/04/2024
Edited On:02/04/2024
Author: Kalpesh Khandla
*/

class AppointmentPreviewCardWidget extends StatelessWidget {
  final dynamic appointment;

  const AppointmentPreviewCardWidget({
    super.key,
    this.appointment,
  });



  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorScheme.primary,
                colorScheme.tertiary,
              ],
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    'No appointment yet',
                    style: textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.25),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(8.0),
            ),
          ),
        ),
        Container(
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 24.0),
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.15),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(8.0),
            ),
          ),
        ),
      ],
    );
  }
}
