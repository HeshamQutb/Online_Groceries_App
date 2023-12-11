// ignore_for_file: unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';

class CategoryScreen extends StatelessWidget {

  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroceriesCubit, GroceriesStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var size = MediaQuery.sizeOf(context);
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: getAppBar(context)),
          body: getBody(context),
        );
      },
    );
  }

  Widget getAppBar(context){
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(IconBroken.Arrow___Left_2),
      ),
      title: const Text(
        'Beverages',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      ),
      centerTitle: true,
    );
}

  Widget getBody(context){
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
              8,
              (index) => GestureDetector(
                onTap: () {
                  navigateTo(context, const CategoryScreen());
                },
                child: productBuilder(),
              )
          ),
        ),
      ),
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
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                        size: 28,
                        color: Colors.white,
                      )))
            ],
          )
        ],
      ),
    ),
  );

}
