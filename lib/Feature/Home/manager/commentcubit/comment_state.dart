part of 'comment_cubit.dart';

abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentSuccess extends CommentState {
 final List<CommentItem> comments;

 CommentSuccess({required this.comments});
}

class AddCommentSuccess extends CommentState {
 final List<CommentItem> comments;

 AddCommentSuccess({required this.comments});
}

class CommentFailure extends CommentState {
 final String errorMessage;

 CommentFailure(this.errorMessage);
}

class CommentEmpty extends CommentState {}
