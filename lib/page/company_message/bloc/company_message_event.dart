

class CompanyMessagesEvent{}

class LoadCompanyMessages extends CompanyMessagesEvent{
  int userId;
  LoadCompanyMessages(this.userId);
}

class AddNewMessage extends CompanyMessagesEvent{
  String message;
  int to;
  List<dynamic> attachments;

  AddNewMessage(this.message,this.to,this.attachments);
}
