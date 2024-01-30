class ExclusiveModel{

  dynamic name;
  dynamic details;
  dynamic images;
  dynamic price;
  dynamic category;
  dynamic review;
  dynamic weight;
  dynamic quantity;
  ExclusiveModel(
      this.name,
      this.details,
      this.images,
      this.price,
      this.category,
      this.review,
      this.weight,
      this.quantity,
      );


  ExclusiveModel.fromJson(Map<String, dynamic>? json){
    name = json?['name'];
    details = json?['details'];
    images = json?['images'];
    price = json?['price'];
    category = json?['category'];
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
      'category':category,
      'review':review,
      'weight':weight,
      'quantity':quantity,
    };
}
}