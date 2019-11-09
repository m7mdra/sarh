

import 'package:Sarh/data/model/chat_responses/messages.dart';
import 'package:Sarh/data/model/chat_responses/quotations.dart';

class CompanyMessagesState{}

class OnLoading extends CompanyMessagesState {}

class OnLoaded extends CompanyMessagesState {
  final List<Message> messages;
  final List<Quotations> quotations;

  OnLoaded(this.messages,this.quotations);

}

class CompanyMessagesNetworkError extends CompanyMessagesState {}

class CompanyMessagesError extends CompanyMessagesState {}

class CompanyMessagesEmpty extends CompanyMessagesState {}

class CompanyMessagesSessionExpired extends CompanyMessagesState {}

class CompanyMessagesTimeout extends CompanyMessagesState {}