class GroceriesModel{

  dynamic name;
  dynamic details;
  dynamic images;
  dynamic price;
  dynamic review;
  dynamic weight;
  GroceriesModel(
      this.name,
      this.details,
      this.images,
      this.price,
      this.review,
      this.weight,
      );


  GroceriesModel.fromJson(Map<String, dynamic>? json){
    name = json?['name'];
    details = json?['details'];
    images = json?['images'];
    price = json?['price'];
    review = json?['review'];
    weight = json?['weight'];
  }

  Map<String, dynamic> toMap(){
    return{
      'name':name,
      'details':details,
      'images':images,
      'price':price,
      'review':review,
      'weight':weight,
    };
}
}