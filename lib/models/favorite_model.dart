class FavoriteModel{

  dynamic name;
  dynamic details;
  dynamic images;
  dynamic price;
  dynamic review;
  dynamic category;
  dynamic weight;
  dynamic quantity;
  FavoriteModel(
      this.name,
      this.details,
      this.images,
      this.price,
      this.review,
      this.category,
      this.weight,
      this.quantity,
      );


  FavoriteModel.fromJson(Map<String, dynamic>? json){
    name = json?['name'];
    details = json?['details'];
    images = json?['images'];
    price = json?['price'];
    review = json?['review'];
    category = json?['category'];
    weight = json?['weight'];
    quantity = json?['quantity'];
  }

  Map<String, dynamic> toMap(){
    return{
      'name':name,
      'details':details,
      'images':images,
      'price':price,
      'review':review,
      'category':category,
      'weight':weight,
      'quantity':quantity,
    };
}
}