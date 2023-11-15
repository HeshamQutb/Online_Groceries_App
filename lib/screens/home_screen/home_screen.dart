
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';
import '../item_screen/item_screen.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroceriesCubit, GroceriesStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = GroceriesCubit.get(context);
        var model = GroceriesCubit.get(context).bannersModel;
        return ConditionalBuilder(
          condition: model != null,
          builder: (BuildContext context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                      cubit.changeNavBar(1);
                    },
                    child: _buildSearchContainer(),
                  ),
                  const SizedBox(height: 10),
                  _buildCarouselSlider(model),
                  const SizedBox(height: 10),
                  _buildSectionTitle('Exclusive Offer', () {}),
                  const SizedBox(height: 10),
                  productBuilder(model),
                  _buildSectionTitle('Best Selling', () {}),
                  const SizedBox(height: 10),
                  productBuilder(model),
                  _buildSectionTitle('Groceries', () {}),
                  const SizedBox(height: 10),
                  productBuilder(model),
                ],
              ),
            ),
          ),
          fallback: (BuildContext context) => getShimmerLoading(context,model),
        );
      },
    );
  }

  Widget productBuilder(model) => SizedBox(
    height: 200,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => GestureDetector(
          onTap:(){
            navigateTo(context, ItemScreen(model: model,));
            },
          child: productItemBuilder()),
      separatorBuilder: (context, index) => const SizedBox(width: 10,),
      itemCount: 5,
    ),
  );

  Widget productItemBuilder() => Container(
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
          const Image(
            image: AssetImage('assets/images/otp.jpg'),
          ),
          const SizedBox(
            height: 2,
          ),
          const Text(
            'Red Apple',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 2,
          ),
          const Text(
            '1k, Price',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                '\$4.99',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                        size: 28,
                        color: Colors.white,
                      )
                  ))
            ],
          )
        ],
      ),
    ),
  );

  Widget _buildSearchContainer() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 0.2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.infinity,
      height: 50,
      child: const Row(
        children: [
          Icon(IconBroken.Search, size: 20),
          SizedBox(width: 10),
          Text('Search Store', style: TextStyle(color: Colors.grey, fontSize: 20)),
        ],
      ),
    );
  }

  Widget _buildCarouselSlider(bannersModel) {
    return CarouselSlider(
      items: [
        _buildImage(bannersModel.image),
        _buildImage(bannersModel.image1),
        _buildImage(bannersModel.image2),
      ],
      options: CarouselOptions(
        height: 200,
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

  Widget _buildSectionTitle(String title, VoidCallback onTap) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const Spacer(),
        TextButton(
          onPressed: onTap,
          child: const Text(
            'See All',
            style: TextStyle(color: defaultColor),
          ),
        )
      ],
    );
  }

  Widget getShimmerLoading(BuildContext context,model) {
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
              _buildSearchContainer(),
              const SizedBox(height: 10),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
              const SizedBox(height: 10),
              _buildSectionTitle('Exclusive Offer', () {}),
              const SizedBox(height: 10),
              productBuilder(model),
              _buildSectionTitle('Best Selling', () {}),
              const SizedBox(height: 10),
              productBuilder(model),
              _buildSectionTitle('Groceries', () {}),
              const SizedBox(height: 10),
              productBuilder(model),
            ],
          ),
        ),
      ),
    );
  }

}






