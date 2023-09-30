// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_app/user_model/user_model.dart';
import 'package:social_app/modules/social_app/socil_register_screen/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterIntialState());
  static SocialRegisterCubit get(context) => BlocProvider.of(context);
//  SocialLoginModel? loginModel;
  void UserRegister({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) {
    emit(SocialRegisterLoodingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(
        uid: value.user!.uid,
        email: email,
        name: name,
        phone: phone,
        image:
            "https://img.freepik.com/free-photo/glad-dark-haired-young-woman-says-sounds-good-confirms-something-everything-control-going-great-approves-promo-has-glad-expression-agrees-with-person-wears-yellow-sweatshirt_273609-42865.jpg?w=1060&t=st=1681032189~exp=1681032789~hmac=880191f6cdbe6dfdb047667f89597671342064df2ac626cfa8a0dd50407c60ac",
        cover:
            "https://i.pinimg.com/564x/2b/78/35/2b7835870bfcc3f1f82e13c9ce037324.jpg",
        bio: "write your bio ...",
      );
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uid,
    required String image,
    required String cover,
    required String bio,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uid: uid,
      image:
          "https://img.freepik.com/free-photo/glad-dark-haired-young-woman-says-sounds-good-confirms-something-everything-control-going-great-approves-promo-has-glad-expression-agrees-with-person-wears-yellow-sweatshirt_273609-42865.jpg?w=1060&t=st=1681032189~exp=1681032789~hmac=880191f6cdbe6dfdb047667f89597671342064df2ac626cfa8a0dd50407c60ac",
      cover:
          "https://i.pinimg.com/564x/2b/78/35/2b7835870bfcc3f1f82e13c9ce037324.jpg",
      bio: "write your bio ...",
      isEmailVerifired: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool ispassword = true;
  void changePasswordVisibility() {
    ispassword = !ispassword;

    suffix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
