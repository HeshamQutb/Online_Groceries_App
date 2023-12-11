import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';


class RootLayout extends StatelessWidget {
  const RootLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroceriesCubit(),
      child: BlocConsumer<GroceriesCubit, GroceriesStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = GroceriesCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                cubit.title[cubit.currentIndex],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25
                ),),
            ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeNavBar(index);
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.store_outlined),
                      label: 'Shop'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.manage_search),
                      label: 'Explore'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart_outlined),
                      label: 'Cart'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_border),
                      label: 'Favorite'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_2_outlined),
                      label: 'Account'),
                ]),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
