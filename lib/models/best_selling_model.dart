class BestSellingModel{

  dynamic name;
  dynamic details;
  dynamic images;
  dynamic price;
  dynamic category;
  dynamic weight;
  BestSellingModel(
      this.name,
      this.details,
      this.images,
      this.price,
      this.category,
      this.weight,
      );


  BestSellingModel.fromJson(Map<String, dynamic>? json){
    name = json?['name'];
    details = json?['details'];
    images = json?['images'];
    price = json?['price'];
    category = json?['category'];
    weight = json?['weight'];
  }

  Map<String, dynamic> toMap(){
    return{
      'name':name,
      'details':details,
      'images':images,
      'price':price,
      'category':category,
      'weight':weight,
    };
  }
}