// ignore_for_file: use_key_in_widget_constructors, unnecessary_import, prefer_const_constructors, sort_child_properties_last, must_be_immutable, sized_box_for_whitespace, body_might_complete_normally_nullable, unused_local_variable, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/social_app/cubit/cubit.dart';
import 'package:social_app/social_app/cubit/states.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;

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
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
              ),
            ),
            title: Text(
              'Edit Profile',
              style: TextStyle(fontSize: 20.0),
            ),
            actions: [
              defaultTextButton(
                  text: 'Update',
                  function: () {
                    SocialCubit.get(context).UpdateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                    );
                  })
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(children: [
                if (state is SocialUpdateUserLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialUpdateUserLoadingState)
                  SizedBox(
                    height: 10.0,
                  ),
                Container(
                  height: 190.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 140.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4),
                                ),
                                image: DecorationImage(
                                  image: coverImage == null
                                      ? NetworkImage('${userModel.image}')
                                      : FileImage(coverImage) as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getcoverImage();
                              },
                              icon: CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 20.0,
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  size: 20.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        alignment: AlignmentDirectional.topCenter,
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 64.0,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: profileImage == null
                                  ? NetworkImage('${userModel.image}')
                                  : FileImage(profileImage) as ImageProvider,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              SocialCubit.get(context).getprofileImage();
                            },
                            icon: CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 20.0,
                              child: Icon(
                                Icons.camera_alt_rounded,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                if (SocialCubit.get(context).profileImage != null ||
                    SocialCubit.get(context).coverImage != null)
                  Row(
                    children: [
                      if (SocialCubit.get(context).profileImage != null)
                        Expanded(
                          child: defaultButton(
                              function: () {
                                SocialCubit.get(context).UploadprofileImage(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  bio: bioController.text,
                                );
                              },
                              text: 'Upload Profile'),
                        ),
                      if (state is SocialUpdateUserLoadingState)
                        SizedBox(
                          height: 5.0,
                        ),
                      if (state is SocialUpdateUserLoadingState)
                        LinearProgressIndicator(),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (SocialCubit.get(context).coverImage != null)
                        Expanded(
                          child: defaultButton(
                              function: () {
                                SocialCubit.get(context).UploadCoverImage(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  bio: bioController.text,
                                );
                              },
                              text: 'Upload Cover'),
                        ),
                      if (state is SocialUpdateUserLoadingState)
                        SizedBox(
                          height: 5.0,
                        ),
                      if (state is SocialUpdateUserLoadingState)
                        LinearProgressIndicator(),
                    ],
                  ),
                if (SocialCubit.get(context).profileImage != null ||
                    SocialCubit.get(context).coverImage != null)
                  SizedBox(
                    height: 10,
                  ),
                defaultFormFaild(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    Label: 'Name',
                    prefix: Icons.person_outline_rounded),
                SizedBox(
                  height: 10.0,
                ),
                defaultFormFaild(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'bio must not be empty';
                      }
                      return null;
                    },
                    Label: 'Bio',
                    prefix: Icons.info_outlined),
                SizedBox(
                  height: 10.0,
                ),
                defaultFormFaild(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'phone number must not be empty';
                      }
                      return null;
                    },
                    Label: 'phone',
                    prefix: Icons.call_rounded)
              ]),
            ),
          ),
        );
      },
    );
  }
}
