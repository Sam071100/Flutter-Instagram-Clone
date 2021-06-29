import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/blocs/auth/auth_bloc.dart';
import 'package:instagram_clone/models/models.dart';
import 'package:instagram_clone/repositories/post/post_repository.dart';
import 'package:meta/meta.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final PostRepository _postRepository;
  final AuthBloc _authBloc;

  StreamSubscription<List<Future<Comment>>> _commentSubscription;

  CommentsBloc({
    @required PostRepository postRepository,
    @required AuthBloc authBloc,
  })  : _postRepository = postRepository,
        _authBloc = authBloc,
        super(CommentsState.initial());

  @override
  Future<void> close() {
    _commentSubscription.cancel();
    return super.close();
  }

  @override
  Stream<CommentsState> mapEventToState(
    CommentsEvent event,
  ) async* {
    if (event is CommentsFetchComments) {
      yield* _mapCommentsFetchCommentsToState(event);
    } else if (event is CommentsUpdateComments) {
      yield* _mapCommentsUpdateCommentsToState(event);
    } else if (event is CommentsPostComment) {
      yield* _mapCommentsPostCommentToState(event);
    }
  }

  Stream<CommentsState> _mapCommentsFetchCommentsToState(
      CommentsFetchComments event) async* {
    yield state.copyWith(status: CommentsStatus.loading);
    try {
      _commentSubscription?.cancel();
      _commentSubscription = _postRepository
          .getPostComments(postId: event.post.id)
          .listen((comments) async {
        final allComments = await Future.wait(comments);
        add(CommentsUpdateComments(comments: allComments));
      });

      yield state.copyWith(post: event.post, status: CommentsStatus.loaded);
    } catch (err) {
      yield state.copyWith(
          status: CommentsStatus.error,
          failure: const Failure(
              message: 'We were unable to load the post\'s comments.'));
    }
  }

  Stream<CommentsState> _mapCommentsUpdateCommentsToState(
      CommentsUpdateComments event) async* {
    yield state.copyWith(comments: event.comments);
  }

  Stream<CommentsState> _mapCommentsPostCommentToState(
      CommentsPostComment event) async* {
    yield state.copyWith(status: CommentsStatus.submitting);
    try {
      final author = User.empty.copyWith(id: _authBloc.state.user.uid);
      final comment = Comment(
        postId: state.post.id,
        author: author,
        content: event.content,
        date: DateTime.now(),
      );

      await _postRepository.createComment(comment: comment);
      yield state.copyWith(status: CommentsStatus.loaded);
    } catch (err) {
      yield state.copyWith(
          status: CommentsStatus.error,
          failure: const Failure(message: 'Comment failed to Post'));
    }
  }
}
