// ignore_for_file: camel_case_types, override_on_non_overriding_member, prefer_typing_uninitialized_variables, overridden_fields, annotate_overrides

abstract class SocialLoginStates {}

class SocialLoginIntialState extends SocialLoginStates {}

class SocialLoginLoodingState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates {
  final String uid;

  SocialLoginSuccessState(this.uid);
}

class SocialLoginErrorState extends SocialLoginStates {
  final String error;

  SocialLoginErrorState(this.error);
}

class SocialloginChangePasswordVisibilityState extends SocialLoginStates {}
