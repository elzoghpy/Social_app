// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import, prefer_is_empty, import_of_legacy_library_into_null_safe

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_app/user_model/user_model.dart';
import 'package:social_app/modules/social_app/chat_details/chat_details_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/social_app/cubit/cubit.dart';
import 'package:social_app/social_app/cubit/states.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.length > 0,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildChatItem(SocialCubit.get(context).users[index], context),
              separatorBuilder: (context, index) => MyDivider(),
              itemCount: SocialCubit.get(context).users.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel model, context) => InkWell(
        onTap: () {
          NavigateTo(
              context,
              ChatDetailsScreen(
                userModel: model,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(
                '${model.image}',
              ),
            ),
            SizedBox(
              width: 12.0,
            ),
            Text(
              '${model.name}',
              style: TextStyle(
                  height: .80, fontSize: 18.0, fontWeight: FontWeight.w700),
            ),
          ]),
        ),
      );
}
