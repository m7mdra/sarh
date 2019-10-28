
import 'package:Sarh/data/model/openchat.dart';

class MessageListState {}

class ListLoading extends MessageListState {}

class ListLoaded extends MessageListState {
  final List<MessageList> chats;

  ListLoaded(this.chats);
}

class ListEmpty extends MessageListState {}

class ListNetworkError extends MessageListState {}

class ListTimeout extends MessageListState {}

class ListSessionExpired extends MessageListState {}

class ListError extends MessageListState {}
