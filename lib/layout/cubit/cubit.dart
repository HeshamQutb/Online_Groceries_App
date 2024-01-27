// ignore_for_file: avoid_print

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries/layout/cubit/states.dart';
import 'package:online_groceries/models/best_selling_model.dart';
import 'package:online_groceries/models/exclusive_offers_model.dart';
import 'package:online_groceries/models/groceries_model.dart';

import '../../components/components.dart';
import '../../components/constants.dart';
import '../../models/banners_model.dart';
import '../../screens/account_screen/account_screen.dart';
import '../../screens/cart_screen/cart_screen.dart';
import '../../screens/explore_screen/explore_screen.dart';
import '../../screens/favorite_screen/favorite_screen.dart';
import '../../screens/home_screen/home_screen.dart';
import '../../screens/login_screen/login_screen.dart';
import '../../screens/onboarding_screen/on_boarding_screen.dart';
import '../../shared/network/local/cache_helper.dart';
import '../root_layout.dart';

class GroceriesCubit extends Cubit<GroceriesStates> {
  GroceriesCubit() : super(GroceriesInitState());

  static GroceriesCubit get(context) => BlocProvider.of(context);

  List<String> title = [
    'Groc Store',
    'Find Products',
    'My Cart',
    'Favorite',
    'Account'
  ];

  int currentIndex = 0;
  List<Widget> screens = [
    const ShopScreen(),
    ExploreScreen(),
    const CartScreen(),
    const FavoriteScreen(),
    const AccountScreen(),
  ];

  void changeNavBar(int index) {
    currentIndex = index;
    emit(GroceriesChangeNavBarState());
  }

  void splashScreen(context) {
    Future.delayed(const Duration(seconds: 2), () {
      if (CacheHelper.getData(key: 'onBoarding') != null) {
        if (uId != null) {
          navigateAndFinish(context, const RootLayout());
        } else {
          navigateAndFinish(context, const LoginScreen());
        }
      } else {
        navigateAndFinish(context, const OnBoardingScreen());
      }
    });
    emit(GroceriesSplashState());
  }

  BannersModel? bannersModel;
  void getBanners() {
    FirebaseFirestore.instance
        .collection('banners')
        .doc('images')
        .get()
        .then((value) {
      print(value.data());
      bannersModel = BannersModel.fromJson(value.data());
      emit(GetBannersSuccessState());
    }).catchError((error) {
      emit(GetBannersErrorState(error.toString()));
    });
  }

  // All Groceries
  List<GroceriesModel> groceries = [];
  Future<void> getGroceries() async {
    emit(GetGroceriesLoadingState());

    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('groceries').get();

      groceries = querySnapshot.docs.map((doc) {
        return GroceriesModel.fromJson(doc.data());
      }).toList();

      emit(GetGroceriesSuccessState());
    } catch (error) {
      print('Error fetching exclusive offers: $error');
      emit(GetGroceriesErrorState(error.toString()));
    }
  }

  // Exclusive offers
  List<ExclusiveModel> offers = [];
  Future<void> getExclusiveOffers() async {
    emit(GetExclusiveOffersLoadingState());

    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('exclusive_offers').get();

      offers = querySnapshot.docs.map((doc) {
        return ExclusiveModel.fromJson(doc.data());
      }).toList();

      emit(GetExclusiveOffersSuccessState());
    } catch (error) {
      print('Error fetching exclusive offers: $error');
      emit(GetExclusiveOffersErrorState(error.toString()));
    }
  }

  // Best Selling
  List<BestSellingModel> bestSelling = [];
  Future<void> getBestSelling() async {
    emit(GetBestSellingLoadingState());

    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('best_selling').get();

      bestSelling = querySnapshot.docs.map((doc) {
        return BestSellingModel.fromJson(doc.data());
      }).toList();

      emit(GetBestSellingSuccessState());
    } catch (error) {
      print('Error fetching Best Selling: $error');
      emit(GetBestSellingErrorState(error.toString()));
    }
  }

  // Category
  List<GroceriesModel> filteredGroceries = [];
  Future<List<GroceriesModel>> getFilteredGroceries(String category) async {
    emit(GetFilteredGroceriesLoadingState());

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('groceries')
          .where('category', isEqualTo: category)
          .get();

      final List<GroceriesModel> result = querySnapshot.docs.map((doc) {
        return GroceriesModel.fromJson(doc.data());
      }).toList();

      emit(GetFilteredGroceriesSuccessState());

      return result;
    } catch (error) {
      print('Error fetching filtered groceries: $error');
      emit(GetFilteredGroceriesErrorState(error.toString()));
      return []; // or throw an exception based on your error handling strategy
    }
  }


  // Search
  final StreamController<QuerySnapshot> _searchResultController =
  StreamController<QuerySnapshot>.broadcast();

  Stream<QuerySnapshot> get searchResultStream =>
      _searchResultController.stream;

  void disposeSearchResultStream() {
    _searchResultController.close();
  }

  void searchGroceries(String searchText) async {
    if (searchText.isEmpty) {
      emit(GroceriesInitState());
      return;
    }

    try {
      final formattedSearchText =
          searchText[0].toUpperCase() + searchText.substring(1).toLowerCase();

      final querySnapshot = await FirebaseFirestore.instance
          .collection('groceries')
          .orderBy('name')
          .where('name', isGreaterThanOrEqualTo: formattedSearchText)
          .where('name', isLessThan: '${formattedSearchText}z')
          .get();

      _searchResultController.add(querySnapshot); // Update the stream

      emit(GroceriesLoadedState(querySnapshot.docs
          .map((doc) => GroceriesModel.fromJson(doc.data()))
          .toList()));
    } catch (e) {
      print('Error during search: $e');
      emit(GroceriesErrorState('An error occurred during search.'));
    }
  }





}
