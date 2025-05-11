import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/bloc_observer.dart';
import 'features/cats/presentation/cubit/breed_cubit.dart';
import 'features/cats/presentation/pages/landing_ios_page.dart';
import 'features/cats/presentation/pages/landing_page.dart';
import 'dependency_injection.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  Bloc.observer = AppBlocObserver();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => getIt<BreedCubit>())],
      child:
          Platform.isIOS
              ? CupertinoApp(
                theme: CupertinoThemeData(brightness: Brightness.light),
                home: const LandingIOSPage(),
              )
              : MaterialApp(
                theme: ThemeData(
                  useMaterial3: true,
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.deepPurple,
                  ),
                  scaffoldBackgroundColor: Colors.white,
                ),

                home: HomePage(),
              ),
    );
  }
}
