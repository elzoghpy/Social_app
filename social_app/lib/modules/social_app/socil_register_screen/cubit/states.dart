// ignore_for_file: camel_case_types, override_on_non_overriding_member, prefer_typing_uninitialized_variables, overridden_fields, annotate_overrides

abstract class SocialRegisterStates {}

class SocialRegisterIntialState extends SocialRegisterStates {}

class SocialRegisterLoodingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates {
  final String error;

  SocialRegisterErrorState(this.error);
}

class SocialRegisterChangePasswordVisibilityState extends SocialRegisterStates {
}

abstract class SocialCreateUserStates {}

class SocialCreateUserIntialState extends SocialRegisterStates {}

class SocialCreateUserLoodingState extends SocialRegisterStates {}

class SocialCreateUserSuccessState extends SocialRegisterStates {}

class SocialCreateUserErrorState extends SocialRegisterStates {
  final String error;

  SocialCreateUserErrorState(this.error);
}

class SocialCreateUserChangePasswordVisibilityState
    extends SocialRegisterStates {}
