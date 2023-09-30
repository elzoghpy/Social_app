// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/social_app/cubit/cubit.dart';
import 'package:social_app/social_app/cubit/states.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          // appBar: defaultAppBar(
          //       context: context,
          //       titel: 'Add Post',
          //     ),
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
            ),
            title: Text(
              'Create Post',
              style: TextStyle(fontSize: 20.0),
            ),
            actions: [
              defaultTextButton(
                  text: 'Post',
                  function: () {
                    var now = DateTime.now();
                    if (SocialCubit.get(context).postimage == null) {
                      SocialCubit.get(context).CreatePost(
                          dateTime: now.toString(), text: textController.text);
                    } else {
                      SocialCubit.get(context).UploadPostImage(
                          dateTime: now.toString(), text: textController.text);
                    }
                  })
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(
                    color: defaultColor,
                  ),
                if (state is SocialCreatePostLoadingState)
                  SizedBox(
                    height: 10.0,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        'https://as1.ftcdn.net/v2/jpg/03/57/19/68/1000_F_357196891_ba0xXG6sZiEAL7fmDIEQJh3l5oY7Tctv.jpg',
                      ),
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mohamed Elzoghpy',
                            style: TextStyle(
                                height: .80,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          // TextButton(
                          //     onPressed: () {},
                          //     child: Row(
                          //       children: [
                          //         Text('public'),
                          //         SizedBox(
                          //           width: 5.0,
                          //         ),
                          //         Text('privet'),
                          //       ],
                          //     ))
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                          hintText: 'what is on your mind...',
                          border: InputBorder.none)),
                )),
                SizedBox(
                  height: 20.0,
                ),
                if (SocialCubit.get(context).postimage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                            image:
                                FileImage(SocialCubit.get(context).postimage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          SocialCubit.get(context).removePostImage();
                        },
                        icon: CircleAvatar(
                          backgroundColor: Colors.red[700],
                          radius: 20.0,
                          child: Icon(
                            Icons.close,
                            size: 18.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getpostimage();
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.photo),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('add photo'),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text('# tags'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
