import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_pattern/AppUtils/app_themes.dart';
import 'package:flutter_bloc_pattern/Presentation/Screens/home_page_screen.dart';
import 'package:flutter_bloc_pattern/Repositories/doctor_repository.dart';
import 'package:flutter_bloc_pattern/States/Home/home_bloc.dart';

/*
Title: Entry Point of  App
Purpose:Entry Point of  App
Created On: 2/04/2024
Edited On:2/04/2024
Author: Kalpesh Khandla
*/

void main() {
  final doctorRepository = DoctorRepository();
  runApp(MyApp(doctorRepository: doctorRepository));
}

class MyApp extends StatelessWidget {
  final DoctorRepository doctorRepository;

  const MyApp({
    super.key,
    required this.doctorRepository,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: doctorRepository),
        // Create other instances of repositories to make available to the app
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBloc(doctorRepository: doctorRepository)
              ..add(LoadHomeEvent()),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: const AppTheme().themeData,
          home: const HomePageScreen(),
        ),
      ),
    );
  }
}
