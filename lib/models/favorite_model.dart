class FavoriteModel{

  dynamic name;
  dynamic exclusiveOffers;
  dynamic bestSelling;
  dynamic card;
  dynamic details;
  dynamic favorite;
  dynamic images;
  dynamic price;
  dynamic review;
  dynamic weight;
  FavoriteModel(
      this.name,
      this.exclusiveOffers,
      this.bestSelling,
      this.card,
      this.details,
      this.favorite,
      this.images,
      this.price,
      this.review,
      this.weight,
      );


  FavoriteModel.fromJson(Map<String, dynamic>? json){
    name = json?['name'];
    exclusiveOffers = json?['exclusiveOffers'];
    bestSelling = json?['bestSelling'];
    card = json?['card'];
    details = json?['details'];
    favorite = json?['favorite'];
    images = json?['images'];
    price = json?['price'];
    review = json?['review'];
    weight = json?['weight'];
  }

  Map<String, dynamic> toMap(){
    return{
      'name':name,
      'exclusiveOffers':exclusiveOffers,
      'bestSelling':bestSelling,
      'card':card,
      'details':details,
      'favorite':favorite,
      'images':images,
      'price':price,
      'review':review,
      'weight':weight,
    };
}
}