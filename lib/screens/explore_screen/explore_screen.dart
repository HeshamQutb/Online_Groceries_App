import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries/screens/category_screen/category_screen.dart';
import '../../components/components.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/groceries_model.dart';
import '../../shared/styles/icon_broken.dart';
import '../item_screen/item_screen.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroceriesCubit, GroceriesStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = GroceriesCubit.get(context);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            children: [
              getSearch(context, cubit),
              const SizedBox(height: 20),
              Expanded(
                child: state is! GroceriesLoadedState
                    ? getCategoriesGrid(context, cubit.filteredGroceries, cubit)
                    : displaySearchResults(context, cubit),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget getSearch(BuildContext context, cubit) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: TextField(
          autofocus: true,
          onChanged: (String searchText) {
            cubit.searchGroceries(searchText);
          },
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            prefixIcon: Icon(
              IconBroken.Search,
              size: 23,
              color: Colors.black54,
            ),
            hintText: 'Search store',
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget displaySearchResults(BuildContext context, cubit) {
    return StreamBuilder(
      stream: cubit.searchResultStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListView.builder(
            itemCount: snapshot.data?.docs.length ?? 0,
            itemBuilder: (context, index) {
              var selectedData = snapshot.data?.docs[index];
              return InkWell(
                onTap: () {
                  navigateTo(
                    context,
                    ItemScreen(
                      weight: selectedData?['weight'],
                      name: selectedData?['name'],
                      price: selectedData!['price'].toString(),
                      details: selectedData['details'],
                      images: selectedData['images'],
                      review: selectedData['review'],
                      quantity: selectedData['quantity'],
                      category: selectedData['category'],
                    ),
                  );
                },
                child: Card(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl: snapshot.data?.docs[index]['images'] ?? '',
                          width: 80,
                          height: 50,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          snapshot.data?.docs[index]['name'] ?? '',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget getCategoryCard(context, String appBarName, String filterType,
      String imagePath, Color borderColor, cubit) {
    return InkWell(
      onTap: () async {
        List<GroceriesModel> result =
            await cubit.getFilteredGroceries(filterType);

        if (result.isNotEmpty) {
          navigateTo(
            context,
            CategoryScreen(
              AppBarName: appBarName,
              filteredGroceries: result,
            ),
          );
        }
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: borderColor,
            width: 0.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Image(image: AssetImage(imagePath)),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  appBarName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCategoriesGrid(
      context, List<GroceriesModel> filteredGroceries, cubit) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      childAspectRatio: 1 / 1.1,
      children: [
        getCategoryCard(
            context,
            'Fresh Fruits &\n Vegetables',
            'fruits_vegetables',
            'assets/images/fruits.png',
            Colors.green,
            cubit),
        getCategoryCard(context, 'Cooking Oil & Ghee', 'oil',
            'assets/images/oil.png', Colors.orangeAccent, cubit),
        getCategoryCard(context, 'Meat & Fish', 'meat',
            'assets/images/meat.png', Colors.red, cubit),
        getCategoryCard(context, 'Bakery & Snakes', 'bakery',
            'assets/images/bakery.png', Colors.purple, cubit),
        getCategoryCard(context, 'Dairy & Eggs', 'eggs',
            'assets/images/eggs.png', Colors.grey, cubit),
        getCategoryCard(context, 'Beverages', 'beverages',
            'assets/images/beverages.png', Colors.blue, cubit),
      ],
    );
  }
}
