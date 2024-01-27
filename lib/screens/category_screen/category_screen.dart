// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries/models/groceries_model.dart';
import 'package:shimmer/shimmer.dart';
import '../../components/components.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';
import '../item_screen/item_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
    required this.AppBarName,
    required this.filteredGroceries,
  });

  final String AppBarName;
  final List<GroceriesModel> filteredGroceries;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroceriesCubit, GroceriesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: getAppBar(context, AppBarName),
          ),
          body: ConditionalBuilder(
              condition: state is! GetFilteredGroceriesSuccessState,
              builder: (context)=> getBody(context, filteredGroceries),
              fallback: (context)=> getShimmerLoading(),
          )
        );
      },
    );
  }

  Widget getAppBar(context, AppBarName) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(IconBroken.Arrow___Left_2),
      ),
      title: Text(
        AppBarName,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  Widget getBody(context, filteredGroceries) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 1 / 1.27,
          children: List.generate(
            filteredGroceries.length,
            (index) {
              final filteredGrocery = filteredGroceries[index];
              return GestureDetector(
                onTap: () {
                  navigateTo(
                    context,
                    ItemScreen(
                      weight: filteredGrocery.weight.toString(),
                      name: filteredGrocery.name,
                      price: filteredGrocery.price.toString(),
                      details: filteredGrocery.details,
                      images: filteredGrocery.images,
                    ),
                  ); // Pass model to screen
                },
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 88,
                          child: CachedNetworkImage(
                            imageUrl: filteredGrocery.images,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          filteredGrocery.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          filteredGrocery.weight.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 80,
                              height: 30,
                              child: Text(
                                '\$ ${filteredGrocery.price.toString()}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: defaultColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.add,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget getShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ListTile(
                leading: Icon(
                  IconBroken.Search,
                  color: Colors.black54,
                ),
                title: Text(
                  'Search Store',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 120,
                    height: 20,
                    color: Colors.grey,
                  ),
                  Container(
                    width: 40,
                    height: 20,
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [

                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 120,
                    height: 20,
                    color: Colors.grey,
                  ),
                  Container(
                    width: 40,
                    height: 20,
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [

                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 120,
                    height: 20,
                    color: Colors.grey,
                  ),
                  Container(
                    width: 40,
                    height: 20,
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
