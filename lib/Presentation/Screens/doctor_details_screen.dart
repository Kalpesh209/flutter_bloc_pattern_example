import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_pattern/AppUtils/time_of_day_extensions.dart';
import 'package:flutter_bloc_pattern/Presentation/Widgets/app_icon_widget.dart';
import 'package:flutter_bloc_pattern/Presentation/Widgets/doctor_card_widget.dart';
import 'package:flutter_bloc_pattern/Repositories/doctor_repository.dart';
import 'package:flutter_bloc_pattern/States/DoctorDetails/doctor_details_bloc.dart';
import 'package:models/models.dart';

/*
Title: DoctorDetailsScreen
Purpose:DoctorDetailsScreen
Created On: 02/04/2024
Edited On:02/04/2024
Author: Kalpesh Khandla
*/

class DoctorDetailsScreen extends StatelessWidget {
  final String doctorId;

  const DoctorDetailsScreen({
    super.key,
    required this.doctorId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorDetailsBloc(
        doctorRepository: context.read<DoctorRepository>(),
      )..add(
          LoadDoctorDetailsEvent(doctorId: doctorId),
        ),
      child: const DoctorDetailsView(),
    );
  }
}

class DoctorDetailsView extends StatelessWidget {
  const DoctorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // Create the UI here
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: AppIconWidget(
          icon: Icons.arrow_back,
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          'Doctor Details',
          style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          AppIconWidget(
            icon: Icons.favorite_outline,
            onTap: () {},
          )
        ],
      ),
      body: BlocBuilder<DoctorDetailsBloc, DoctorDetailsState>(
        builder: (context, state) {
          if (state.status == DoctorDetailsStatus.initial ||
              state.status == DoctorDetailsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == DoctorDetailsStatus.loaded) {
            final doctor = state.doctor;

            if (doctor == null) {
              return const Center(child: Text('Doctor not found.'));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DoctorCardWidget(
                    doctor: state.doctor!,
                  ),
                  Divider(
                    height: 32.0,
                    color: colorScheme.surfaceVariant,
                  ),
                  _DoctorWorkingHours(
                    workingHours: doctor.workingHours,
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}

class _DoctorWorkingHours extends StatelessWidget {
  const _DoctorWorkingHours({
    required this.workingHours,
  });

  final List<DoctorWorkingHours> workingHours;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Working Hours',
          style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        ListView.separated(
          padding: const EdgeInsets.all(8.0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: workingHours.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8.0),
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: Text(workingHours[index].dayOfWeek),
                ),
                const SizedBox(width: 16.0),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: colorScheme.surfaceVariant),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    workingHours[index].startTime.toCustomString(),
                    style: textTheme.bodySmall!.copyWith(
                      color: colorScheme.onBackground.withOpacity(.5),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                const Text("-"),
                const SizedBox(width: 16.0),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: colorScheme.surfaceVariant),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    workingHours[index].endTime.toCustomString(),
                    style: textTheme.bodySmall!.copyWith(
                      color: colorScheme.onBackground.withOpacity(.5),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
