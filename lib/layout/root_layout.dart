import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/styles/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RootLayout extends StatelessWidget {
  const RootLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroceriesCubit()..getExclusiveOffers()..getBestSelling()..getGroceries(),
      child: BlocConsumer<GroceriesCubit, GroceriesStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = GroceriesCubit.get(context);
          return Scaffold(
            appBar: cubit.currentIndex == 4
                ? AppBar(
                    title: getAccountAppBar(),
                  )
                : AppBar(
                    centerTitle: true,
                    title: Text(
                      cubit.title[cubit.currentIndex],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeNavBar(index);
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.store_outlined), label: 'Shop'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.manage_search), label: 'Explore'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_border), label: 'Favorite'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_2_outlined), label: 'Account'),
                ]),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }

  Widget getAccountAppBar() {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('assets/images/otp.jpg'),
          radius: 30,
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Hesham Qutb',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.edit_outlined,
                      size: 20,
                      color: defaultColor,
                    )),
              ],
            ),
            const Text(
              'heshsaker9@gmail.com',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ],
        )
      ],
    );
  }
}
