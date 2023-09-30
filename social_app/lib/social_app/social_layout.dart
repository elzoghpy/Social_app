// ignore_for_file: unnecessary_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, unused_import, import_of_legacy_library_into_null_safe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social_app/post/newpost_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/social_app/cubit/cubit.dart';
import 'package:social_app/social_app/cubit/states.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          NavigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currntindex]),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications_active_outlined)),
              IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded))
            ],
          ),
          body: cubit.screens[cubit.currntindex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currntindex,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_rounded), label: 'Chats'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.upload_file_outlined), label: 'post'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.location_history), label: 'Users'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings_outlined), label: 'Settings')
              ]),
        );
      },
    );
  }
}
