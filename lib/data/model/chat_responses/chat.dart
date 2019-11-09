
import 'package:Sarh/data/model/chat_responses/messages.dart';

import 'quotations.dart';

class MessagesResponse{
  bool success;
  Data data;
  String message;

  MessagesResponse({this.success, this.data, this.message});

  MessagesResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    print("MESSAGEREPONSEFOREACT");
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['Message'] = this.message;
    return data;
  }
}

class Data {
  List<Message> messages;
  List<Quotations> quotations;

  Data.fromJson(Map<String, dynamic> json) {

    if (json['messages'] != null) {
      messages = new List<Message>();
      json['messages'].forEach((v) {
        messages.add(new Message.fromJson(v));
      });
    }

    if (json['allQuotations'] != null) {
      quotations = new List<Quotations>();
      json['allQuotations'].forEach((v) {
        quotations.add(new Quotations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.messages != null) {
      data['messages'] =
          this.messages.map((v) => v.toJson()).toList();
    }

    if (this.quotations != null) {
      data['allQuotations'] =
          this.quotations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}