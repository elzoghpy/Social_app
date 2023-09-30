abstract class SocialStates {}

class SocialIntialState extends SocialStates {}

class SocialGetuserLoadingState extends SocialStates {}

class SocialGetuserSuccessState extends SocialStates {}

class SocialGetuserErrorState extends SocialStates {
  final String error;

  SocialGetuserErrorState(this.error);
}

class SocialGetAlluserLoadingState extends SocialStates {}

class SocialGetAlluserSuccessState extends SocialStates {}

class SocialGetAlluserErrorState extends SocialStates {
  final String error;

  SocialGetAlluserErrorState(this.error);
}

//get post

class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  final String error;

  SocialGetPostsErrorState(this.error);
}

//like post
class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final String error;

  SocialLikePostErrorState(this.error);
}

//comment post

class SocialCommentPostSuccessState extends SocialStates {}

class SocialCommentPostErrorState extends SocialStates {
  final String error;

  SocialCommentPostErrorState(this.error);
}

//get user

class SocialGetuserChangePasswordVisibilityState extends SocialStates {}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

// upload profile state &cover
class SocialProfileImagePickedSucsessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialCoverImagePickedSucsessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

class SocialUploadProfileImageSucsessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageSucsessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUpdateUserErrorState extends SocialStates {}

class SocialUpdateUserLoadingState extends SocialStates {}
//
//
// create post

class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuscessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialPostImagePickedSucsessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

//chats

class SocialCreatechatLoadingState extends SocialStates {}

class SocialSendMessageSuscessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {}

class SocialGetMessagesSuscessState extends SocialStates {}

class SocialGetMessagesErrorState extends SocialStates {}

class SocialchatImagePickedSucsessState extends SocialStates {}

class SocialchatImagePickedErrorState extends SocialStates {}

class SocialUploadchatImageSucsessState extends SocialStates {}

class SocialUploadchatImageErrorState extends SocialStates {}
