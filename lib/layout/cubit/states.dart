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
class GetProductsLoadingState extends GroceriesStates{}

class GetProductsSuccessState extends GroceriesStates{}

class GetProductsErrorState extends GroceriesStates{
  final String error;
  GetProductsErrorState(this.error);
}

// Exclusive offers
class GetExclusiveOffersLoadingState extends GroceriesStates{}

class GetExclusiveOffersSuccessState extends GroceriesStates{}

class GetExclusiveOffersErrorState extends GroceriesStates{
  final String error;
  GetExclusiveOffersErrorState(this.error);
}
