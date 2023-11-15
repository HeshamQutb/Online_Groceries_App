class UserModel{

  dynamic name;
  dynamic phone;
  dynamic email;
  dynamic uId;
  dynamic bio;
  dynamic image;
  dynamic cover;
  UserModel(
      this.name,
      this.phone,
      this.email,
      this.uId,
      this.bio,
      this.image,
      this.cover,
      );


  UserModel.fromJson(Map<String, dynamic>? json){
    name = json?['name'];
    phone = json?['phone'];
    email = json?['email'];
    uId = json?['uId'];
    bio = json?['bio'];
    image = json?['image'];
    cover = json?['cover'];
  }

  Map<String, dynamic> toMap(){
    return{
      'name':name,
      'phone':phone,
      'email':email,
      'uId':uId,
      'bio':bio,
      'image':image,
      'cover':cover,
    };
}
}