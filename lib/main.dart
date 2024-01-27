// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries/screens/splash_screen/splash_screen.dart';
import 'package:online_groceries/shared/bloc_observer.dart';
import 'package:online_groceries/shared/cubit/App/cubit.dart';
import 'package:online_groceries/shared/cubit/App/states.dart';
import 'package:online_groceries/shared/network/local/cache_helper.dart';
import 'package:online_groceries/shared/styles/theme.dart';

import 'components/constants.dart';
import 'firebase_options.dart';
import 'layout/cubit/cubit.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  uId = CacheHelper.getData(key: 'uId');
  print('uId = $uId');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  print('onBoarding = $onBoarding');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  const MyApp({super.key, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppCubit(),),
          BlocProvider(create: (context) => GroceriesCubit(),),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {

          },
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.light,
              home: const SplashScreen(),
            );
          },
        )
    );
  }
}


