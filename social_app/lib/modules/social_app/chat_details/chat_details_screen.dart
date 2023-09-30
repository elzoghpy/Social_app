// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, non_constant_identifier_names, prefer_is_empty, curly_braces_in_flow_control_structures, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_app/chat_model/chat_model.dart';
import 'package:social_app/models/social_app/user_model/user_model.dart';
import 'package:social_app/social_app/cubit/cubit.dart';
import 'package:social_app/social_app/cubit/states.dart';

// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel? userModel;

  ChatDetailsScreen({this.userModel});

  var MessagetextController = TextEditingController();
  var MessageimageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
            ),
            titleSpacing: 0.0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage('${userModel!.image}'),
                ),
                SizedBox(
                  width: 14.0,
                ),
                Text('${userModel!.name}')
              ],
            ),
          ),
          body:
              //  ConditionalBuilder(
              //   condition: SocialCubit.get(context).messages.length > 0,
              //   builder: (context) =>
              BlocSelector<SocialCubit, SocialStates,
                  SocialGetMessagesSuscessState>(
            selector: (state) => SocialGetMessagesSuscessState(),
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message =
                                SocialCubit.get(context).messages[index];
                            if (SocialCubit.get(context).userModel!.uid ==
                                message.senderid)
                              return buildMyMessage(message);
                            return buildMessage(message);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                height: 14.0,
                              ),
                          itemCount: SocialCubit.get(context).messages.length),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1.0),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: TextFormField(
                                  controller: MessagetextController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'type your message here ....'),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getchatImage();
                                  },
                                  icon: Icon(
                                    Icons.photo_camera,
                                    color: Colors.grey[300],
                                  )),
                            ),
                            Container(
                              height: 50,
                              color: Colors.blue,
                              child: MaterialButton(
                                onPressed: () {
                                  SocialCubit.get(context).sendMessage(
                                      receiverid: userModel!.uid!,
                                      datetime: DateTime.now().toString(),
                                      text: MessagetextController.text,
                                      chatImage: MessageimageController.text);
                                },
                                minWidth: 1.0,
                                child: Icon(
                                  Icons.send_rounded,
                                  size: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // fallback: (context) => Center(child: CircularProgressIndicator()),
          // ),
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(.9),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(
            model.text!,
            style: TextStyle(fontSize: 15.0),
          ),
        ),
      );

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(
            model.text!,
            style: TextStyle(fontSize: 15.0),
          ),
        ),
      );
}
