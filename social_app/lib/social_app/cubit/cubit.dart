// ignore_for_file: avoid_print, prefer_const_constructors, curly_braces_in_flow_control_structures, non_constant_identifier_names, deprecated_member_use, unused_import, avoid_web_libraries_in_flutter, prefer_typing_uninitialized_variables, avoid_function_literals_in_foreach_calls, prefer_is_empty, unused_local_variable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_app/models/social_app/chat_model/chat_model.dart';
import 'package:social_app/models/social_app/user_model/postmodel/post_model.dart';
import 'package:social_app/models/social_app/user_model/user_model.dart';
import 'package:social_app/modules/social_app/chats/chats_screen.dart';
import 'package:social_app/modules/social_app/feeds/FeedsScreen.dart';
import 'package:social_app/modules/social_app/post/newpost_screen.dart';
import 'package:social_app/modules/social_app/settings/setting_screen.dart';
import 'package:social_app/modules/social_app/users/users_screen.dart';
import 'package:social_app/shared/components/conestants.dart';
import 'package:social_app/social_app/cubit/states.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialIntialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  // SocialUserModel? model;
  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialGetuserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      // print(value.data());
      userModel = SocialUserModel.fromjason(value.data()!);
      emit(SocialGetuserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetuserErrorState(error.toString()));
    });
  }

  int currntindex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen()
  ];
  List<String> titles = ['Home', 'Chats', 'post', 'Users', 'Settings'];
  void changeBottomNav(int index) {
    if (index == 1) getUsers();
    if (index == 2)
      emit(SocialNewPostState());
    else {
      currntindex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  var picker = ImagePicker();

  File? profileImage;
  Future<void> getprofileImage() async {
    final PickedFile = await picker.getImage(source: ImageSource.gallery);

    if (PickedFile != null) {
      profileImage = File(PickedFile.path);
      emit(SocialProfileImagePickedSucsessState());
    } else {
      print('No image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;
  Future<void> getcoverImage() async {
    final PickedFile = await picker.getImage(source: ImageSource.gallery);

    if (PickedFile != null) {
      coverImage = File(PickedFile.path);
      emit(SocialCoverImagePickedSucsessState());
    } else {
      print('No image selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void UploadprofileImage({
    required String name,
    required String phone,
    required String bio,
    String? image,
  }) {
    emit(SocialUpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadProfileImageSucsessState());
        print(value);
        UpdateUser(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void UploadCoverImage({
    required String name,
    required String phone,
    required String bio,
    String? cover,
  }) {
    emit(SocialUpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadCoverImageSucsessState());
        print(value);
        UpdateUser(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

// String basename = basename(_imageFile.path);

  void UpdateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    SocialUserModel model = SocialUserModel(
      uid: userModel!.uid,
      name: name,
      phone: phone,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      email: userModel!.email,
      bio: bio,
      isEmailVerifired: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUpdateUserErrorState());
    });
  }

  // void UpdateUserImage({
  //   required String name,
  //   required String phone,
  //   required String bio,
  //   String? email,
  //   String? image,
  //   String? cover,
  // }) {
  //   emit(SocialUpdateUserLoadingState());
  //   if (coverImage != null) {
  //     UploadCoverImage();
  //   } else if (profileImage != null) {
  //     UploadprofileImage();
  //   } else if (coverImage != null && profileImage != null) {
  //     UploadCoverImage();
  //     UploadprofileImage();
  //   } else {
  //     UpdateUser(
  //       bio: bio,
  //       name: name,
  //       phone: phone,
  //       email: email,
  //       image: image,
  //       cover: cover,
  //     );
  //   }
  // }

// String? name;
//   String? uid;
//   String? image;
//   String? dateTime;
//   String? text;
//   String? postImage;

  File? postimage;
  Future<void> getpostimage() async {
    final PickedFile = await picker.getImage(source: ImageSource.gallery);

    if (PickedFile != null) {
      postimage = File(PickedFile.path);
      emit(SocialPostImagePickedSucsessState());
    } else {
      print('No image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postimage = null;
    emit(SocialRemovePostImageState());
  }

  void UploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postimage!.path).pathSegments.last}')
        .putFile(postimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        CreatePost(
          dateTime: dateTime,
          text: text,
          postimage: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void CreatePost({
    required String dateTime,
    required String text,
    String? postimage,
  }) {
    postModel model = postModel(
      uid: userModel!.uid,
      name: userModel!.name,
      image: userModel!.image,
      dateTime: dateTime,
      text: text,
      postImage: postimage ?? '',
    );
    FirebaseFirestore.instance
        .collection('poste')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuscessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<postModel> Posts = [];
  List<String> PostsId = [];
  List<int> likes = [];
  List<int> comments = [];

  void getPosts() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('Posts').get().then((value) {
      print("$value");

      value.docs.forEach((element) {
        Posts.add(postModel.fromjason(element.data()));
        comments.add(value.docs.length);
        element.reference.collection('comments').get().then((value) {
          PostsId.add(element.id);
          Posts.add(postModel.fromjason(element.data()));
        }).catchError((error) {});

        element.reference.collection('likes').get().then((value) {
          PostsId.add(element.id);
          Posts.add(postModel.fromjason(element.data()));
        }).catchError((error) {});
      });
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void LikePost(String PostId) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(PostId)
        .collection('Likes')
        .doc(userModel!.uid)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  void CommentPost(String PostId) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(PostId)
        .collection('Comments')
        .doc(userModel!.uid)
        .set({'comment': true}).then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((error) {
      emit(SocialCommentPostErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];

  void getUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uid'] != userModel!.uid)
            users.add(SocialUserModel.fromjason(element.data()));
        });
        emit(SocialGetAlluserSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetAlluserErrorState(error.toString()));
      });
  }

  void sendMessage(
      {required String receiverid,
      required String datetime,
      required String text,
      required String chatImage}) {
    MessageModel model = MessageModel(
        text: text,
        chatImage: chatImage,
        senderid: userModel!.uid,
        receiverid: receiverid,
        datetime: datetime);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(receiverid)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuscessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverid)
        .collection('chats')
        .doc(userModel!.uid)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuscessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];
  List<MessageModel> getMessage({
    required String receiverid,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(receiverid)
        .collection('messages')
        .orderBy('datetime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromjason(element.data()));
      });
      emit(SocialGetMessagesSuscessState());
    });
    return messages;
  }

  File? chatImage;
  Future<void> getchatImage() async {
    final PickedFile = await picker.getImage(source: ImageSource.gallery);

    if (PickedFile != null) {
      chatImage = File(PickedFile.path);
      emit(SocialchatImagePickedSucsessState());
    } else {
      print('No image selected');
      emit(SocialchatImagePickedErrorState());
    }
  }
  // void UploadChatImage({

  // }) {
  //   emit(SocialUpdateUserLoadingState());
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('chats/${Uri.file(chatImage!.path).pathSegments.last}')
  //       .putFile(chatImage!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       print(value);
  //     }).catchError((error) {
  //       emit(SocialUploadchatImageSucsessState());
  //     });
  //   }).catchError((error) {
  //     emit(SocialUploadchatImageErrorState());
  //   });
  // }
}
