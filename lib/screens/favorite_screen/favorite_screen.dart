import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroceriesCubit, GroceriesStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return getFavorite();
      },
    );
  }

  Widget getFavorite() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => getFavoriteProduct(),
              separatorBuilder: (context, index) => const Divider(
                indent: 20,
                endIndent: 20,
                thickness: 1,
              ),
              itemCount: 8,
            ),
          ),
          defaultButton(
            function: () {},
            text: 'Add ALl To Cart',
          ),
        ],
      ),
    );
  }

  Widget getFavoriteProduct() {
    return Row(
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: Image.asset('assets/images/otp.jpg'),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sprite Can',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    '325ml, Price',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    '\$1.50',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ))
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
