import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_pattern/AppUtils/app_strings.dart';
import 'package:flutter_bloc_pattern/Presentation/Widgets/appointment_preview_card_widget.dart';
import 'package:flutter_bloc_pattern/Presentation/Widgets/bottom_navigation_bar_widget.dart';
import 'package:flutter_bloc_pattern/Presentation/Widgets/circle_avatar_with_text_widget.dart';
import 'package:flutter_bloc_pattern/Presentation/Widgets/doctor_list_item_widget.dart';
import 'package:flutter_bloc_pattern/Presentation/Widgets/section_title_widget.dart';
import 'package:flutter_bloc_pattern/States/Home/home_bloc.dart';
import 'package:models/models.dart';

/*
Title: HomePageScreen
Purpose:HomePageScreen
Created On: 02/04/2024
Edited On:02/04/2024
Author: Kalpesh Khandla
*/

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Create the HomeView UI
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.welcome,
              style: textTheme.bodyMedium,
            ),
            SizedBox(height: 4.0),
            Text(
              AppStrings.massimo,
              style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: colorScheme.secondary,
                ),
                const SizedBox(width: 4.0),
                Text(
                  'Dubai, UAE',
                  style: textTheme.bodySmall!.copyWith(
                    color: colorScheme.secondary,
                  ),
                ),
                const SizedBox(width: 4.0),
                Icon(
                  Icons.expand_more,
                  color: colorScheme.secondary,
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
          const SizedBox(width: 8.0),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Search for doctors...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: Container(
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: colorScheme.onSurfaceVariant,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(
                    Icons.filter_alt_outlined,
                    color: colorScheme.surfaceVariant,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.loading ||
              state.status == HomeStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == HomeStatus.loaded) {
            return const SingleChildScrollView(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _DoctorCategories(),
                  SizedBox(height: 24.0),
                  _MySchedule(),
                  SizedBox(height: 24.0),
                  _NearbyDoctors(),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Error loading data'));
          }
        },
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}

class _DoctorCategories extends StatelessWidget {
  const _DoctorCategories();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            SectionTitleWidget(
              title: AppStrings.categories,
              action:AppStrings.seeAll,
              onPressed: () {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: state.doctorCategories
                  // Take 5 could be added in the bloc calculation
                  .take(5)
                  .map(
                    (category) => Expanded(
                      child: CircleAvatarWithTextWidget(
                        icon: category.icon,
                        label: category.name,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}

class _MySchedule extends StatelessWidget {
  const _MySchedule();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            SectionTitleWidget(
              title: 'My Schedule',
              action: 'See all',
              onPressed: () {},
            ),
            AppointmentPreviewCardWidget(
              appointment: state.myAppointments.firstOrNull,
            ),
          ],
        );
      },
    );
  }
}

class _NearbyDoctors extends StatelessWidget {
  const _NearbyDoctors();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            SectionTitleWidget(
              title:AppStrings.nearByDoctor,
              action:AppStrings.seeAll,
              onPressed: () {},
            ),
            const SizedBox(height: 8.0),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return Divider(
                  height: 24.0,
                  color: colorScheme.surfaceVariant,
                );
              },
              itemCount: state.nearbyDoctors.length,
              itemBuilder: (context, index) {
                final doctor = state.nearbyDoctors[index];
                return DoctorListItemWidget(doctor: doctor);
              },
            ),
          ],
        );
      },
    );
  }
}
