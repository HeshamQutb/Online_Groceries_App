import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return BlocProvider(
      create: (context) => GroceriesCubit()..splashScreen(context),
      child: BlocConsumer<GroceriesCubit, GroceriesStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color(0xFF53b175), Colors.lightGreen],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              )),
              child: Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  SizedBox(
                      height: 250,
                      width: 250,
                      child: Image.asset(
                        'assets/images/shopping.png',
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    children: [
                      const Text(
                        'GROC',
                        style: TextStyle(
                          color: (Colors.white),
                          fontSize: 70,
                          height: 0.5,
                        ),
                      ),
                      Text(
                        'online groceries',
                        style: TextStyle(
                          color: (Colors.grey[200]),
                          fontSize: 25,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
