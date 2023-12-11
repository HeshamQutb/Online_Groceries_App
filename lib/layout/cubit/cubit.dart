// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries/layout/cubit/states.dart';
import 'package:online_groceries/models/products_model.dart';


import '../../models/banners_model.dart';
import '../../screens/account_screen/account_screen.dart';
import '../../screens/cart_screen/cart_screen.dart';
import '../../screens/explore_screen/explore_screen.dart';
import '../../screens/favorite_screen/favorite_screen.dart';
import '../../screens/home_screen/home_screen.dart';
import '../../screens/login_screen/login_screen.dart';
import '../../screens/onboarding_screen/on_boarding_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
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
    const ExploreScreen(),
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
    FirebaseFirestore.instance.collection('banners').doc('images').get().then((value) {
      print(value.data());
      bannersModel = BannersModel.fromJson(value.data());
      emit(GetBannersSuccessState());
    }).catchError((error) {
      emit(GetBannersErrorState(error.toString()));
    });
  }



  ProductModel? productModel;
  void getProducts() {
    emit(GetProductsLoadingState());
    FirebaseFirestore.instance.collection('products').doc().get().then((value) {
      print(value.data());
      productModel = ProductModel.fromJson(value.data());
      emit(GetProductsSuccessState());
    }).catchError((error) {
      emit(GetProductsErrorState(error.toString()));
    });
  }
}
