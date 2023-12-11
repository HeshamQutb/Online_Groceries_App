import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries/shared/components/components.dart';
import 'package:online_groceries/shared/styles/colors.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroceriesCubit, GroceriesStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return getMyCart();
      },
    );
  }

  Widget getMyCart() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => getProduct(),
              separatorBuilder: (context, index) => const Divider(
                indent: 20,
                endIndent: 20,
                thickness: 1,
              ),
              itemCount: 10,
            ),
          ),
          defaultButton(
              function: (){},
              text: 'Go to Checkout',
          ),
        ],
      ),
    );
  }

  Widget getProduct() {
    return Row(
      children: [
        Expanded(
          child: Image.asset('assets/images/otp.jpg'),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Bell Pepper Red',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      height: 0.1,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
              const Text(
                '1kg, price',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height: 0.1,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.remove),
                  ),
                  const Text(
                    '1',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                      color: defaultColor,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    '\$14.99',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
