import '../../models/groceries_model.dart';

abstract class GroceriesStates{}

class GroceriesInitState extends GroceriesStates{}

class GroceriesChangeNavBarState extends GroceriesStates{}

class GroceriesSplashState extends GroceriesStates{}


// Banners
class GetBannersSuccessState extends GroceriesStates{}

class GetBannersErrorState extends GroceriesStates{
  final String error;
  GetBannersErrorState(this.error);
}


// Products
class GetGroceriesLoadingState extends GroceriesStates{}

class GetGroceriesSuccessState extends GroceriesStates{}

class GetGroceriesErrorState extends GroceriesStates{
  final String error;
  GetGroceriesErrorState(this.error);
}

// Exclusive offers
class GetExclusiveOffersLoadingState extends GroceriesStates{}

class GetExclusiveOffersSuccessState extends GroceriesStates{}

class GetExclusiveOffersErrorState extends GroceriesStates{
  final String error;
  GetExclusiveOffersErrorState(this.error);
}

// Best Selling
class GetBestSellingLoadingState extends GroceriesStates{}

class GetBestSellingSuccessState extends GroceriesStates{}

class GetBestSellingErrorState extends GroceriesStates{
  final String error;
  GetBestSellingErrorState(this.error);
}


// Category
class GetFilteredGroceriesLoadingState extends GroceriesStates{}

class GetFilteredGroceriesSuccessState extends GroceriesStates{}

class GetFilteredGroceriesErrorState extends GroceriesStates{
  final String error;
  GetFilteredGroceriesErrorState(this.error);
}


// Search
class GetSearchGroceriesSuccessState extends GroceriesStates {
  final List<GroceriesModel> groceries;

  GetSearchGroceriesSuccessState(this.groceries);
}

class SearchSuccessState extends GroceriesStates {}


class GroceriesErrorState extends GroceriesStates {
  final String error;
  GroceriesErrorState(this.error);
}

class GroceriesLoadedState extends GroceriesStates {
  GroceriesLoadedState(List<GroceriesModel> groceries);
}
