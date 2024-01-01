import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries/screens/category_screen/category_screen.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/icon_broken.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroceriesCubit, GroceriesStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var searchController = TextEditingController();
        return getExplore(context, searchController);
      },
    );
  }

  Widget getExplore(context, searchController){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        children: [
          getSearch(searchController),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1 / 1.1,
                children: List.generate(
                  8,
                      (index) => GestureDetector(
                    onTap: () {
                      navigateTo(context, const CategoryScreen());
                    },
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors
                              .redAccent, // Set the border color
                          width: 0.5, // Set the border width
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Image(
                              image:
                              AssetImage('assets/images/otp.jpg'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                'Red Apple',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getSearch(searchController) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15)
      ),
      child: Center(
        child: TextField(
          autofocus: true,
          controller: searchController,
          onChanged: (value) {},
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none
            ),
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
}
