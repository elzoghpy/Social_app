// ignore_for_file: use_key_in_widget_constructors, import_of_legacy_library_into_null_safe, prefer_const_constructors

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social_app/socil_register_screen/cubit/cubit.dart';
import 'package:social_app/modules/social_app/socil_register_screen/cubit/states.dart';
import 'package:social_app/social_app/social_layout.dart';

import '../../../shared/components/components.dart';
import '../social_login_screen/social_login.dart';

// ignore: must_be_immutable
class SocialRegisterScreen extends StatelessWidget {
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool ispassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            NavigateAndFinsh(context, SocialLayout());
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
                            'REGISTER',
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text('Register now to communicate with other frindes',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: Colors.grey)),
                          SizedBox(
                            height: 30.0,
                          ),
                          defaultFormFaild(
                            controller: namecontroller,
                            type: TextInputType.name,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'this name allready used';
                              }
                              return null;
                            },
                            Label: 'Name',
                            prefix: Icons.person,
                          ),
                          SizedBox(
                            height: 20,
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
                            controller: phonecontroller,
                            type: TextInputType.phone,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter your phone number';
                              }
                              return null;
                            },
                            Label: 'Phone',
                            prefix: Icons.phone,
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
                            onsubmet: (value) {},
                            suffix: SocialRegisterCubit.get(context).suffix,
                            isPassword:
                                SocialRegisterCubit.get(context).ispassword,
                            sufixpressed: () {
                              SocialRegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! SocialRegisterLoodingState,
                            builder: (context) => defaultButton(
                              text: 'REGISTER',
                              isUpperCase: true,
                              //   background:   Colors.blueGrey,
                              function: () {
                                if (formkey.currentState!.validate()) {
                                  SocialRegisterCubit.get(context).UserRegister(
                                    name: namecontroller.text,
                                    email: emailcontroller.text,
                                    phone: passwordcontroller.text,
                                    password: passwordcontroller.text,
                                  );
                                }
                              },
                            ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'If you have an acount?',
                              ),
                              defaultTextButton(
                                  function: (() {
                                    NavigateTo(context, SocialLoginScreen());
                                  }),
                                  text: 'Login')
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
