/*
 * Copyright (c) 2019.
 *           ______             _
 *          |____  |           | |
 *  _ __ ___    / / __ ___   __| |_ __ __ _
 * | '_ ` _ \  / / '_ ` _ \ / _` | '__/ _` |
 * | | | | | |/ /| | | | | | (_| | | | (_| |
 * |_| |_| |_/_/ |_| |_| |_|\__,_|_|  \__,_|
 *
 *
 *
 *
 */
import 'bloc.dart';
import 'package:Sarh/data/community/post_repository.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:bloc/bloc.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  final PostRepository _postRepository;

  AddPostBloc(this._postRepository);

  @override
  AddPostState get initialState => AddPostState();

  @override
  Stream<AddPostState> mapEventToState(AddPostEvent event) async* {
    if (event is SubmitPost) {
      yield LoadingState();
      try {
        var response = await _postRepository.addPost(body: event.body,
            attachments: event.attachments,
            tags: event.tags,
            title: event.title);
        if(response.success){
          yield SuccessState(response.post);
        }else{
          yield ErrorState();
        }
      }
      on UnableToConnectException {
        yield NetworkErrorState();
      } on SessionExpiredException {
        yield SessionExpiredState();
      } on TimeoutException {
        yield TimeoutState();
      }
      catch (error) {
        yield ErrorState();
      }
    }
  }
}
