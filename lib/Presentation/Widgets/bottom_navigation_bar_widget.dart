import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/AppUtils/app_strings.dart';

/*
Title: BottomNavigationBarWidget
Purpose:BottomNavigationBarWidget
Created On: 02/04/2024
Edited On:02/04/2024
Author: Kalpesh Khandla
*/

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  onItemTap(int index) {
    switch (index) {
      case 0:
        print(index);

        break;
      case 1:
        print(index);

        break;

      case 2:
        print(index);

        break;

      case 3:
        print(index);

        break;

      case 4:
        print(index);

        break;
      // ... other index
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BottomNavigationBar(
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: colorScheme.onBackground.withOpacity(0.5),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedFontSize: 14,
      selectedLabelStyle: textTheme.bodySmall,
      unselectedLabelStyle: textTheme.bodySmall,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        onItemTap(index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: AppStrings.discover,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore_outlined),
          label: AppStrings.explore,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          label:AppStrings.booking,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_outlined),
          label: AppStrings.chat,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: AppStrings.profile,
        ),
      ],
    );
  }
}
