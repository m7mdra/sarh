

import 'package:Sarh/data/model/chat_responses/messages.dart';

class CompanyMessagesEvent{}

class LoadCompanyMessages extends CompanyMessagesEvent{
  int userId;
  LoadCompanyMessages(this.userId);
}

class AddNewMessage extends CompanyMessagesEvent{
  Message message;


  AddNewMessage(this.message);
}

class MessageAddToList extends CompanyMessagesEvent{
  Message message;

  MessageAddToList(this.message);
}
