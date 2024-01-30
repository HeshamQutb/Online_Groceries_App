class GroceriesModel{

  dynamic name;
  dynamic details;
  dynamic images;
  dynamic price;
  dynamic category;
  dynamic review;
  dynamic weight;
  dynamic quantity;
  GroceriesModel(
      this.name,
      this.details,
      this.images,
      this.price,
      this.review,
      this.weight,
      this.quantity,
      );


  GroceriesModel.fromJson(Map<String, dynamic>? json){
    name = json?['name'];
    details = json?['details'];
    images = json?['images'];
    price = json?['price'];
    review = json?['review'];
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
      'weight':weight,
      'quantity':quantity,
    };
}
}