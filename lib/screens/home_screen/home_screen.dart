import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries/models/best_selling_model.dart';
import 'package:online_groceries/models/exclusive_offers_model.dart';
import 'package:online_groceries/screens/exclusive_offer_screen/exclusive_offers_screen.dart';
import 'package:shimmer/shimmer.dart';
import '../../components/components.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/groceries_model.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';
import '../item_screen/item_screen.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroceriesCubit, GroceriesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = GroceriesCubit.get(context);
        return ConditionalBuilder(
          condition: state is! GetExclusiveOffersLoadingState,
          builder: (BuildContext context) => getHomePage(context, cubit),
          fallback: (BuildContext context) => getShimmerLoading(),
        );
      },
    );
  }

  Widget getHomePage(context, GroceriesCubit cubit) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                cubit.changeNavBar(1);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const ListTile(
                  leading: Icon(
                    IconBroken.Search,
                    color: Colors.black54,
                  ),
                  title: Text(
                    'Search Store',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            getBanners(),
            const SizedBox(
              height: 15,
            ),
            getExclusiveOffersSection(context, cubit.offers),
            const SizedBox(
              height: 15,
            ),
            getBestSellingSection(context, cubit.bestSelling),
            const SizedBox(
              height: 15,
            ),
            getGroceriesSection(context, cubit.groceries)
          ],
        ),
      ),
    );
  }

  Widget getBanners() {
    return CarouselSlider(
      items: [
        _buildImage(
            'https://as2.ftcdn.net/v2/jpg/03/20/46/13/1000_F_320461388_5Snqf6f2tRIqiWlaIzNWrCUm1Ocaqhfm.jpg'),
        _buildImage(
            'https://as1.ftcdn.net/v2/jpg/04/14/51/80/1000_F_414518045_jxAaMA75UWWwHyTvMkS0GVMtqF56mFmM.jpg'),
        _buildImage(
            'https://as1.ftcdn.net/v2/jpg/02/62/18/46/1000_F_262184611_bXhmboL9oE6k2ILu4qXxNWFhNJCEbTn2.jpg'),
      ],
      options: CarouselOptions(
        height: 150,
        initialPage: 0,
        enableInfiniteScroll: true,
        viewportFraction: 1,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget getExclusiveOffersSection(
      BuildContext context, List<ExclusiveModel> exclusiveModels) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Exclusive Offer',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                navigateTo(context, const ExclusiveOffersScreen());
              },
              child: const Text(
                'See all',
                style: TextStyle(color: defaultColor),
              ),
            ),
          ],
        ),
        Container(
          color: Colors.white,
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final exclusiveModel = exclusiveModels[index];
              return GestureDetector(
                onTap: () {
                  navigateTo(
                      context,
                      ItemScreen(
                        category: exclusiveModel.category,
                        details: exclusiveModel.details,
                        images: exclusiveModel.images,
                        name: exclusiveModel.name,
                        price: exclusiveModel.price.toString(),
                        quantity: exclusiveModel.quantity,
                        review: exclusiveModel.review,
                        weight: exclusiveModel.weight.toString(),
                      )); // Pass model to screen
                },
                child: Container(
                  height: 200,
                  width: 150,
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
                          height: 92,
                          child: CachedNetworkImage(
                            imageUrl: exclusiveModel.images,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(exclusiveModel.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2),
                        Text(exclusiveModel.weight.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.grey)),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 80,
                              height: 30,
                              child: Text(
                                  '\$ ${exclusiveModel.price.toString()}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
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
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemCount: exclusiveModels.length,
          ),
        ),
      ],
    );
  }

  Widget getBestSellingSection(
      BuildContext context, List<BestSellingModel> bestSellingModels) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Best Selling',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                navigateTo(context, const ExclusiveOffersScreen());
              },
              child: const Text(
                'See all',
                style: TextStyle(color: defaultColor),
              ),
            ),
          ],
        ),
        Container(
          color: Colors.white,
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final bestSelling = bestSellingModels[index];
              return GestureDetector(
                onTap: () {
                  navigateTo(
                      context,
                      ItemScreen(
                        category: bestSelling.category,
                        details: bestSelling.details,
                        images: bestSelling.images,
                        name: bestSelling.name,
                        price: bestSelling.price.toString(),
                        quantity: bestSelling.quantity,
                        review: bestSelling.review,
                        weight: bestSelling.weight.toString(),
                      )); // Pass model to screen
                },
                child: Container(
                  height: 200,
                  width: 150,
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
                          height: 92,
                          child: CachedNetworkImage(
                            imageUrl: bestSelling.images,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(bestSelling.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2),
                        Text(bestSelling.weight.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.grey)),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 80,
                              height: 30,
                              child: Text('\$ ${bestSelling.price.toString()}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
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
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemCount: bestSellingModels.length,
          ),
        ),
      ],
    );
  }

  Widget getGroceriesSection(
      BuildContext context, List<GroceriesModel> groceriesModels) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Groceries',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                navigateTo(context, const ExclusiveOffersScreen());
              },
              child: const Text(
                'See all',
                style: TextStyle(color: defaultColor),
              ),
            ),
          ],
        ),
        Container(
          color: Colors.white,
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final groceriesModel = groceriesModels[index];
              return GestureDetector(
                onTap: () {
                  navigateTo(
                      context,
                      ItemScreen(
                        weight: groceriesModel.weight.toString(),
                        name: groceriesModel.name,
                        price: groceriesModel.price.toString(),
                        details: groceriesModel.details,
                        images: groceriesModel.images,
                        review: groceriesModel.review,
                        quantity: groceriesModel.quantity,
                        category: groceriesModel.category,
                      )); // Pass model to screen
                },
                child: Container(
                  height: 200,
                  width: 150,
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
                          height: 92,
                          child: CachedNetworkImage(
                            imageUrl: groceriesModel.images,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(groceriesModel.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2),
                        Text(groceriesModel.weight.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.grey)),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 80,
                              height: 30,
                              child: Text(
                                  '\$ ${groceriesModel.price.toString()}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
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
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemCount: groceriesModels.length,
          ),
        ),
      ],
    );
  }

  Widget productBuilder() => Container(
        height: 200,
        width: 150,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey, // Set the border color
            width: 0.2, // Set the border width
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CachedNetworkImage(
              //   imageUrl: productModel.images,
              //   fit: BoxFit.fill,
              // ),
              Center(
                child: SizedBox(
                    height: 90,
                    width: 90,
                    child: Image.asset('assets/images/otp.jpg')),
              ),
              const SizedBox(
                height: 2,
              ),
              const Text(
                'product_name',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              const Text(
                'product_weight',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 80,
                    height: 30,
                    child: Text(
                      '\$ product_price',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: defaultColor,
                        borderRadius: BorderRadius.circular(15)),
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
      );

  Widget _buildImage(String imageUrl) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.fill,
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    productBuilder(),
                    productBuilder(),
                    productBuilder(),
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    productBuilder(),
                    productBuilder(),
                    productBuilder(),
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    productBuilder(),
                    productBuilder(),
                    productBuilder(),
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
