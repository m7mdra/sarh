import 'dart:collection';

import 'bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:Sarh/data/community/post_repository.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;

  PostBloc(this._postRepository);

  @override
  PostState get initialState => PostState();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is LoadPosts) {
      yield PostsLoading();
      try {
        var response = await _postRepository.getPosts();
        if (response.success) {
          var posts = response.posts;
          if (posts.isNotEmpty) {
            yield PostsLoaded(UnmodifiableListView(posts));
          } else {
            yield PostsEmpty();
          }
        } else {
          yield PostsError();
        }
      } on SessionExpiredException {
        yield PostsSessionExpired();
      } on TimeoutException {
        yield PostsTimeout();
      } on UnableToConnectException {
        yield PostsNetworkError();
      } catch (error) {
        yield PostsError();
      }
    }
  }
}
