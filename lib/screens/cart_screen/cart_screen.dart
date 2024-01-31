import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries/shared/styles/colors.dart';
import 'package:shimmer/shimmer.dart';
import '../../components/components.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../item_screen/item_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    GroceriesCubit.get(context).getCart();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroceriesCubit, GroceriesStates>(
      listener: (context, state) {
        if (state is RemoveFromCartSuccessState) {
          GroceriesCubit.get(context).getCart();
          showToast(
              message: 'Successfully Remove from Cart',
              state: ToastState.warning);
        }
      },
      builder: (context, state) {
        var cubit = GroceriesCubit.get(context);
        var cart = cubit.cart;
        return ConditionalBuilder(
            condition: state is! GetCartLoadingState,
            builder: (context) => cart.isNotEmpty
                ? getCart(context, cart, cubit)
                : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You Don\'t any Products In Cart',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Add To Cart To See here',
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
            fallback: (context) => getShimmerLoading(),
        );
      },
    );
  }

  Widget getCart(context, cart, cubit) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                final cartItem = cart[index];
                return InkWell(
                  onTap: () {
                    navigateTo(
                        context,
                        ItemScreen(
                          category: cartItem.category,
                          details: cartItem.details,
                          images: cartItem.images,
                          price: cartItem.price,
                          name: cartItem.name,
                          quantity: cartItem.quantity,
                          review: cartItem.review,
                          weight: cartItem.weight,
                          onPop: () {
                            GroceriesCubit.get(context).getCart();
                          },
                        ));
                  },
                  child: getCartProduct(context, cartItem, cubit),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                indent: 20,
                endIndent: 20,
                thickness: 1,
              ),
              itemCount: cart.length,
            ),
          ),
          defaultButton(
            function: () {},
            text: 'Go to Checkout',
          ),
        ],
      ),
    );
  }

  Widget getCartProduct(context, cartItem, cubit) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            width: 80,
            height: 80,
            child: CachedNetworkImage(imageUrl: cartItem.images),
          ),
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
                  Text(
                    cartItem.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      height: 0.1,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      cubit.addToCart(
                        name: cartItem.name,
                        details: cartItem.details,
                        images: cartItem.images,
                        price: cartItem.price,
                        review: cartItem.review,
                        category: cartItem.category,
                        weight: cartItem.weight,
                        quantity: cartItem.quantity,
                      );
                      setState(() {
                        cubit.getCart();
                      });
                    },
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
              Text(
                '${cartItem.weight}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
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
                    onPressed: () {
                      // Implement logic to decrease quantity
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  Text(
                    '${cartItem.quantity}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Implement logic to increase quantity
                    },
                    icon: const Icon(
                      Icons.add,
                      color: defaultColor,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '\$ ${cartItem.price}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
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

  Widget getShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return shimmerFavoriteProduct();
            },
            separatorBuilder: (context, index) => const Divider(
              indent: 20,
              endIndent: 20,
              thickness: 1,
            ),
            itemCount: 5, // Adjust the number of shimmer items as needed
          )),
    );
  }

  Widget shimmerFavoriteProduct() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 130,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: 100,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(
          indent: 20,
          endIndent: 20,
          thickness: 1,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
