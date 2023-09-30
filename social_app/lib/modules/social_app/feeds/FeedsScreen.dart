// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, dead_code, prefer_is_empty, import_of_legacy_library_into_null_safe, unused_label

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_app/user_model/postmodel/post_model.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/social_app/cubit/cubit.dart';
import 'package:social_app/social_app/cubit/states.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: true,
            //   condition: SocialCubit.get(context).Posts.length > 0
            // SocialCubit.get(context).userModel != null,
            builder: (context) => SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Card(
                        elevation: 5.0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        margin: EdgeInsets.all(7.0),
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Image(
                              image: NetworkImage(
                                  '${SocialCubit.get(context).userModel!.cover}'),
                              fit: BoxFit.cover,
                              height: 180.0,
                              width: double.infinity,
                            ),
                            Text(
                              'communicate with friends',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: ((context, index) => buildpostItem(
                            SocialCubit.get(context).Posts[index],
                            context,
                            index)),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 8.0,
                        ),
                        itemCount: SocialCubit.get(context).Posts.length,
                      ),
                      SizedBox(
                        height: 8.0,
                      )
                    ],
                  ),
                ));
        // fallback:
        // (context) => Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildpostItem(postModel model, context, index) => Card(
        elevation: 5.0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.symmetric(horizontal: 7.0),
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      '${model.image}',
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: TextStyle(
                                  height: .80,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: defaultColor,
                              size: 18,
                            )
                          ],
                        ),
                        Text('${model.dateTime}',
                            style: Theme.of(context).textTheme.caption)
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model.text}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 10.0, top: 5),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         // Padding(
              //         //   padding: const EdgeInsetsDirectional.only(end: 8.0),
              //         //   child: Container(
              //         //     height: 22.0,
              //         //     child: MaterialButton(
              //         //       onPressed: () {},
              //         //       minWidth: 1.0,
              //         //       padding: EdgeInsets.zero,
              //         //       child: Text(
              //         //         '#software',
              //         //         style: TextStyle(color: defaultColor),
              //         //       ),
              //         //     ),
              //         //   ),
              //         // ),
              //         // Padding(
              //         //   padding: const EdgeInsetsDirectional.only(end: 8.0),
              //         //   child: Container(
              //         //     height: 22.0,
              //         //     child: MaterialButton(
              //         //       onPressed: () {},
              //         //       minWidth: 1.0,
              //         //       padding: EdgeInsets.zero,
              //         //       child: Text(
              //         //         '#designer',
              //         //         style: TextStyle(color: defaultColor),
              //         //       ),
              //         //     ),
              //         //   ),
              //         // ),
              //         // Padding(
              //         //   padding: const EdgeInsetsDirectional.only(end: 8.0),
              //         //   child: Container(
              //         //     height: 22.0,
              //         //     child: MaterialButton(
              //         //       onPressed: () {},
              //         //       minWidth: 1.0,
              //         //       padding: EdgeInsets.zero,
              //         //       child: Text(
              //         //         '#software_frontend',
              //         //         style: TextStyle(color: defaultColor),
              //         //       ),
              //         //     ),
              //         //   ),
              //         // ),
              //         // Padding(
              //         //   padding: const EdgeInsetsDirectional.only(end: 8.0),
              //         //   child: Container(
              //         //     height: 22.0,
              //         //     child: MaterialButton(
              //         //       onPressed: () {},
              //         //       minWidth: 1.0,
              //         //       padding: EdgeInsets.zero,
              //         //       child: Text(
              //         //         '#software_evolopment',
              //         //         style: TextStyle(color: defaultColor),
              //         //       ),
              //         //     ),
              //         //   ),
              //         // ),
              //         // Padding(
              //         //   padding: const EdgeInsetsDirectional.only(end: 8.0),
              //         //   child: Container(
              //         //     height: 22.0,
              //         //     child: MaterialButton(
              //         //       onPressed: () {},
              //         //       minWidth: 1.0,
              //         //       padding: EdgeInsets.zero,
              //         //       child: Text(
              //         //         '#software_flutter',
              //         //         style: TextStyle(color: defaultColor),
              //         //       ),
              //         //     ),
              //         //   ),
              //         // ),
              //       ],
              //     ),
              //   ),
              // ),
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 5),
                  child: Container(
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      image: DecorationImage(
                        image: NetworkImage('${model.postImage}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite_outline_rounded,
                              size: 18,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${SocialCubit.get(context).likes[index]}',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.chat_bubble_rounded,
                              size: 18,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${SocialCubit.get(context).comments[index]}',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20.0,
                              backgroundImage: NetworkImage(
                                "${SocialCubit.get(context).userModel!.image}",
                              ),
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            Text('write a comment ...',
                                style: Theme.of(context).textTheme.caption),
                            SizedBox(
                              width: 12.0,
                            ),
                          ],
                        ),
                        onTap: () {
                          SocialCubit.get(context).CommentPost(
                              SocialCubit.get(context).PostsId[index]);
                        },
                      ),
                    ),
                    InkWell(
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite_outline_rounded,
                            size: 18,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'like',
                          ),
                        ],
                      ),
                      onTap: () {
                        SocialCubit.get(context)
                            .LikePost(SocialCubit.get(context).PostsId[index]);
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      child: Row(
                        children: [
                          Icon(
                            Icons.share,
                            size: 18,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'share',
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
