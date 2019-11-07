

import 'package:Sarh/data/chat/chat_repository.dart';
import 'package:Sarh/page/message_list/bloc/message_list_event.dart';
import 'package:Sarh/page/message_list/bloc/message_list_state.dart';
import 'package:bloc/bloc.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';


class MessageListBloc extends Bloc<MessageListEvent,MessageListState>{

  final ChatRepository _chatRepository;

  MessageListBloc(this._chatRepository);

  @override
  // TODO: implement initialState
  MessageListState get initialState => MessageListState();

  @override
  Stream<MessageListState> mapEventToState(MessageListEvent event) async*{
    if (event is MessageListLoaded) {
      yield ListLoading();
      try {
        var messageListResponse =
            await _chatRepository.getChats();
        if (messageListResponse.success) {
          print("Loaded Chats");
          var messageListCounts = messageListResponse.data;
          print(messageListResponse.data);
          if (messageListCounts.isNotEmpty) {
            print("Loaded Not Empty");
            yield ListLoaded(messageListCounts);
          } else {
            print("Loaded Empty");

            yield ListEmpty();
          }
        } else {
          yield ListError();
        }
      } on UnableToConnectException {
        yield ListNetworkError();
      } on TimeoutException {
        yield ListNetworkError();
      } on SessionExpiredException {
        yield ListSessionExpired();
      } catch (error) {
        print(error);
        yield ListError();
      }
    }
  }

}