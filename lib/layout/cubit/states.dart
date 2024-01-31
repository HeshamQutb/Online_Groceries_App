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

class SearchSuccessState extends GroceriesStates {}

class SearchErrorState extends GroceriesStates {
  final String error;
  SearchErrorState(this.error);
}

class GroceriesLoadedState extends GroceriesStates {
  GroceriesLoadedState(List<GroceriesModel> groceries);
}


// Add to Favourites
class AddFavouritesLoadingState extends GroceriesStates{}

class AddFavouritesSuccessState extends GroceriesStates{}

class AddFavouritesErrorState extends GroceriesStates{
  final String error;
  AddFavouritesErrorState(this.error);
}

// get Favourites
class GetFavouritesLoadingState extends GroceriesStates{}

class GetFavouritesSuccessState extends GroceriesStates{}

class GetFavouritesErrorState extends GroceriesStates{
  final String error;
  GetFavouritesErrorState(this.error);
}

// Remove Favourites
class RemoveFromFavoritesSuccessState extends GroceriesStates{}




// Add to Cart
class AddCartLoadingState extends GroceriesStates{}

class AddCartSuccessState extends GroceriesStates{}

class AddCartErrorState extends GroceriesStates{
  final String error;
  AddCartErrorState(this.error);
}

// get Cart
class GetCartLoadingState extends GroceriesStates{}

class GetCartSuccessState extends GroceriesStates{}

class GetCartErrorState extends GroceriesStates{
  final String error;
  GetCartErrorState(this.error);
}

// Remove Cart

class RemoveFromCartSuccessState extends GroceriesStates{}


