// ignore_for_file: unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../components/components.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({
    super.key,
    required this.weight,
    required this.name,
    required this.price,
    required this.details,
    required this.images,
  });
  final String weight;
  final String name;
  final String price;
  final String details;
  final String images;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroceriesCubit, GroceriesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(IconBroken.Arrow___Left_2),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCarouselSlider(images),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            weight,
                            style: const TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {},
                          child: const Icon(Icons.favorite_border))
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.remove),
                        color: Colors.grey,
                      ),
                      const Text(
                        '1',
                        style: TextStyle(fontSize: 20),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        color: defaultColor,
                      ),
                      const Spacer(),
                      Text(
                        '\$ $price',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Product Details',
                        style: TextStyle(fontSize: 15),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(Icons.keyboard_arrow_down_outlined),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    details,
                    style: const TextStyle(color: Colors.grey),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Nutrition\'s',
                        style: TextStyle(fontSize: 15),
                      ),
                      const Spacer(),
                      const Text(
                        '100gr',
                        style: TextStyle(fontSize: 8, color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(Icons.keyboard_arrow_right_outlined),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Review',
                        style: TextStyle(fontSize: 15),
                      ),
                      const Spacer(),
                      RatingBar.builder(
                        itemSize: 15,
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.redAccent,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(Icons.keyboard_arrow_right_outlined),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  defaultButton(function: () {}, text: 'Add To Card')
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCarouselSlider(images) {
    return CarouselSlider(
      items: [
        _buildImage(images),
        _buildImage(images),
        _buildImage(images),
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
}
