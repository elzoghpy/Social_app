// ignore_for_file: camel_case_types

class postModel {
  String? name;
  String? uid;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;

  postModel({
    this.name,
    this.uid,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,
  });

  postModel.fromjason(Map<String, dynamic> jason) {
    name = jason['name'];
    uid = jason['uid'];
    image = jason['image'];
    dateTime = jason['dateTime'];
    text = jason['text'];
    postImage = jason['postImage'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
    };
  }
}
