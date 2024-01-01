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

class ItemScreen extends StatelessWidget {

  const ItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroceriesCubit, GroceriesStates>(
      listener: (context, state) {
      },
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
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCarouselSlider(),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Naturel Red Apple',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            '1kg, Price',
                            style: TextStyle(color: Colors.grey),
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
                      const Text(
                        '\$4.99',
                        style: TextStyle(
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
                        child: const Icon(
                            Icons.keyboard_arrow_down_outlined),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Red Delicious apples are one of the most well known commercially '
                        'grown apples in the United States. The Botanically, they are '
                        'classified as Malus domestica. Red Delicious apples look a lot'
                        ' different today than when they were first discovered. Over a '
                        'perof nearly 100 years, improvements were made, altering the f'
                        'ruit’s shape, firmness, juiciness and even its color. '
                        'Red Delicious is the parent apple of several popular varieties '
                        'like the Starkrimson, Empire and Fuji apples.',
                    style: TextStyle(color: Colors.grey),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Nutritions',
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
                        child: const Icon(
                            Icons.keyboard_arrow_right_outlined),
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
                        onRatingUpdate: (rating) {

                        },
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                            Icons.keyboard_arrow_right_outlined),
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
          )
          // ConditionalBuilder(
          //     condition: model != null,
          //     builder: (context) => SingleChildScrollView(
          //       physics: const BouncingScrollPhysics(),
          //       child: Padding(
          //             padding: const EdgeInsets.symmetric(
          //                 horizontal: 20.0, vertical: 10),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 _buildCarouselSlider(model, boardController),
          //                 const SizedBox(
          //                   height: 40,
          //                 ),
          //                 Row(
          //                   children: [
          //                     const Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Text(
          //                           'Naturel Red Apple',
          //                           style: TextStyle(
          //                               fontWeight: FontWeight.bold,
          //                               fontSize: 20),
          //                         ),
          //                         Text(
          //                           '1kg, Price',
          //                           style: TextStyle(color: Colors.grey),
          //                         )
          //                       ],
          //                     ),
          //                     const Spacer(),
          //                     GestureDetector(
          //                         onTap: () {},
          //                         child: const Icon(Icons.favorite_border))
          //                   ],
          //                 ),
          //                 const SizedBox(
          //                   height: 30,
          //                 ),
          //                 Row(
          //                   children: [
          //                     IconButton(
          //                       onPressed: () {},
          //                       icon: const Icon(Icons.remove),
          //                       color: Colors.grey,
          //                     ),
          //                     const Text(
          //                       '1',
          //                       style: TextStyle(fontSize: 20),
          //                     ),
          //                     IconButton(
          //                       onPressed: () {},
          //                       icon: const Icon(Icons.add),
          //                       color: defaultColor,
          //                     ),
          //                     const Spacer(),
          //                     const Text(
          //                       '\$4.99',
          //                       style: TextStyle(
          //                           fontWeight: FontWeight.bold, fontSize: 20),
          //                     )
          //                   ],
          //                 ),
          //                 const SizedBox(
          //                   height: 30,
          //                 ),
          //                 Row(
          //                   children: [
          //                     const Text(
          //                       'Product Details',
          //                       style: TextStyle(fontSize: 15),
          //                     ),
          //                     const Spacer(),
          //                     GestureDetector(
          //                       onTap: () {},
          //                       child: const Icon(
          //                           Icons.keyboard_arrow_down_outlined),
          //                     )
          //                   ],
          //                 ),
          //                 const SizedBox(
          //                   height: 5,
          //                 ),
          //                 const Text(
          //                   'Red Delicious apples are one of the most well known commercially '
          //                   'grown apples in the United States. The Botanically, they are '
          //                   'classified as Malus domestica. Red Delicious apples look a lot'
          //                   ' different today than when they were first discovered. Over a '
          //                   'perof nearly 100 years, improvements were made, altering the f'
          //                   'ruit’s shape, firmness, juiciness and even its color. '
          //                   'Red Delicious is the parent apple of several popular varieties '
          //                   'like the Starkrimson, Empire and Fuji apples.',
          //                   style: TextStyle(color: Colors.grey),
          //                   maxLines: 3,
          //                   overflow: TextOverflow.ellipsis,
          //                 ),
          //                 const SizedBox(
          //                   height: 30,
          //                 ),
          //                 Row(
          //                   children: [
          //                     const Text(
          //                       'Nutritions',
          //                       style: TextStyle(fontSize: 15),
          //                     ),
          //                     const Spacer(),
          //                     const Text(
          //                       '100gr',
          //                       style: TextStyle(fontSize: 8, color: Colors.grey),
          //                     ),
          //                     const SizedBox(
          //                       width: 5,
          //                     ),
          //                     GestureDetector(
          //                       onTap: () {},
          //                       child: const Icon(
          //                           Icons.keyboard_arrow_right_outlined),
          //                     )
          //                   ],
          //                 ),
          //                 const SizedBox(
          //                   height: 30,
          //                 ),
          //                 Row(
          //                   children: [
          //                     const Text(
          //                       'Review',
          //                       style: TextStyle(fontSize: 15),
          //                     ),
          //                     const Spacer(),
          //                     RatingBar.builder(
          //                       itemSize: 15,
          //                       initialRating: 3,
          //                       minRating: 1,
          //                       direction: Axis.horizontal,
          //                       allowHalfRating: true,
          //                       itemCount: 5,
          //                       itemPadding:
          //                           const EdgeInsets.symmetric(horizontal: 1.0),
          //                       itemBuilder: (context, _) => const Icon(
          //                         Icons.star,
          //                         color: Colors.redAccent,
          //                       ),
          //                       onRatingUpdate: (rating) {
          //
          //                       },
          //                     ),
          //                     const SizedBox(
          //                       width: 5,
          //                     ),
          //                     GestureDetector(
          //                       onTap: () {},
          //                       child: const Icon(
          //                           Icons.keyboard_arrow_right_outlined),
          //                     )
          //                   ],
          //                 ),
          //                 const SizedBox(
          //                   height: 30,
          //                 ),
          //                 defaultButton(function: () {}, text: 'Add To Card')
          //               ],
          //             ),
          //           ),
          //     ),
          //     fallback: (context) => const Center(
          //           child: CircularProgressIndicator(),
          //         )
          // ),
        );
      },
    );
  }

  Widget _buildCarouselSlider() {
    return CarouselSlider(
      items: [
        _buildImage('https://www.kapruka.com/shops/specialGifts/productImages/1215060818546_apples.jpg'),
        _buildImage('https://sinsoohup.com.my/cdn/shop/products/redapple.jpg?v=1587824331'),
        _buildImage('https://iranfreshfruit.net/wp-content/uploads/2020/01/red-apple-fruit.jpg'),
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
