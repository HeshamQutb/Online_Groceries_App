class BannersModel{
  dynamic image;
  dynamic image1;
  dynamic image2;
    BannersModel(
      this.image,
      this.image1,
      this.image2,
      );
  BannersModel.fromJson(Map<String, dynamic>? json){
    image = json?['image'];
    image1 = json?['image1'];
    image2 = json?['image2'];
  }

  Map<String, dynamic> toMap(){
    return{
      'image':image,
      'image1':image1,
      'image2':image2,
    };
  }
}