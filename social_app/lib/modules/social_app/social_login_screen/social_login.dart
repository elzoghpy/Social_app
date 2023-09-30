// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, import_of_legacy_library_into_null_safe, prefer_const_constructors, duplicate_ignore

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social_app/social_login_screen/cubit/cubit.dart';
import 'package:social_app/modules/social_app/social_login_screen/cubit/states.dart';
import 'package:social_app/modules/social_app/socil_register_screen/social_register.dart';
import 'package:social_app/shared/network/local/cashe_helper.dart';
import 'package:social_app/social_app/social_layout.dart';

import '../../../shared/components/components.dart';

class SocialLoginScreen extends StatelessWidget {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool ispassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            ShowToast(text: state.error, state: ToastStates.ERROR);
          }
          if (state is SocialLoginSuccessState) {
            CasheHelper.saveData(key: 'uid', value: state.uid).then((value) {
              NavigateAndFinsh(context, SocialLayout());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text('login now to communicate with other frindes',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: Colors.grey)),
                          SizedBox(
                            height: 30.0,
                          ),
                          defaultFormFaild(
                            controller: emailcontroller,
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Email address must be not empty';
                              }
                              return null;
                            },
                            Label: 'Email Adress',
                            prefix: Icons.email_outlined,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultFormFaild(
                            controller: passwordcontroller,
                            type: TextInputType.visiblePassword,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'password must be not empty';
                              }
                              return null;
                            },
                            Label: 'Password',
                            prefix: Icons.lock,
                            onsubmet: (value) {
                              if (formkey.currentState!.validate()) {
                                SocialLoginCubit.get(context).UserLogin(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text);
                              }
                            },
                            suffix: SocialLoginCubit.get(context).suffix,
                            isPassword:
                                SocialLoginCubit.get(context).ispassword,
                            sufixpressed: () {
                              SocialLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! SocialLoginLoodingState,
                            builder: (context) => defaultButton(
                              text: 'LOGIN',
                              isUpperCase: true,
                              //   background:   Colors.blueGrey,
                              function: () {
                                if (formkey.currentState!.validate()) {
                                  SocialLoginCubit.get(context).UserLogin(
                                      email: emailcontroller.text,
                                      password: passwordcontroller.text);
                                }
                              },
                            ),
                            fallback: (context) =>
                                // ignore: prefer_const_constructors
                                Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an acount?',
                              ),
                              defaultTextButton(
                                  function: (() {
                                    NavigateTo(context, SocialRegisterScreen());
                                  }),
                                  text: 'Regisster')
                            ],
                          )
                        ]),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
