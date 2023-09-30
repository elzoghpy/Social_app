class SocialUserModel {
  String? name;
  String? email;
  String? phone;
  String? uid;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerifired;

  SocialUserModel({
    this.name,
    this.email,
    this.phone,
    this.uid,
    this.image,
    this.cover,
    this.bio,
    this.isEmailVerifired,
  });

  SocialUserModel.fromjason(Map<String, dynamic> jason) {
    email = jason['email'];
    name = jason['name'];
    phone = jason['phone'];
    uid = jason['uid'];
    image = jason['image'];
    cover = jason['cover'];
    bio = jason['bio'];
    isEmailVerifired = jason['isEmailVerifired'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uid': uid,
      'image': image,
      'bio': bio,
      'cover': cover,
      'isEmailVerifired': isEmailVerifired,
    };
  }
}
