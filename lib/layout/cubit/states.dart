abstract class GroceriesStates{}

class GroceriesInitState extends GroceriesStates{}

class GroceriesChangeNavBarState extends GroceriesStates{}

class GroceriesSplashState extends GroceriesStates{}

class GetBannersSuccessState extends GroceriesStates{}

class GetBannersErrorState extends GroceriesStates{
  final String error;
  GetBannersErrorState(this.error);
}


