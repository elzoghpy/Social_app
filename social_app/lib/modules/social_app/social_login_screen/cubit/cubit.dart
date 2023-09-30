// ignore_for_file: non_constant_identifier_names, avoid_print, unused_local_variable, unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social_app/social_login_screen/cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginIntialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);
  void UserLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoodingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool ispassword = true;
  void changePasswordVisibility() {
    ispassword = !ispassword;

    suffix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialloginChangePasswordVisibilityState());
  }
}
