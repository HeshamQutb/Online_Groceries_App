import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries/models/favorite_model.dart';
import 'package:online_groceries/screens/item_screen/item_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../components/components.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    GroceriesCubit.get(context).getFavourites();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroceriesCubit, GroceriesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = GroceriesCubit.get(context);
        var favorites = cubit.favorites;
        return ConditionalBuilder(
          condition: state is! GetFavouritesLoadingState,
          builder: (context) => favorites.isNotEmpty
              ? getFavorite(context, favorites)
              : const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'You Don\'t any Favorite Products',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Add To Favorite To See here',
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

  Widget getFavorite(context, List<FavoriteModel> favorites) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                final favorite = favorites[index];
                return InkWell(
                  onTap: () {
                    navigateTo(
                        context,
                        ItemScreen(
                          category: favorite.category,
                          details: favorite.details,
                          images: favorite.images,
                          price: favorite.price,
                          name: favorite.name,
                          quantity: favorite.quantity,
                          review: favorite.review,
                          weight: favorite.weight,
                          onPop: () {
                            GroceriesCubit.get(context).getFavourites();
                          },
                        ));
                  },
                  child: getFavoriteProduct(context, favorite),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                indent: 20,
                endIndent: 20,
                thickness: 1,
              ),
              itemCount: favorites.length,
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

  Widget getFavoriteProduct(context, favorite) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: CachedNetworkImage(imageUrl: favorite.images),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    favorite.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    favorite.weight,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '\$ ${favorite.price}',
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                      onTap: () {
                        navigateTo(
                          context,
                          ItemScreen(
                              weight: favorite.weight,
                              name: favorite.name,
                              price: favorite.price,
                              details: favorite.details,
                              images: favorite.images,
                              review: favorite.review,
                              quantity: favorite.quantity,
                              category: favorite.category),
                        );
                      },
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
