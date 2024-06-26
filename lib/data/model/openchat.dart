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

class MessageList {
  int id;
  String fullName;
  String image;
  String lastMessage;
  int createdAt;
  int newMessagesCount;

  MessageList({
    this.id,
    this.fullName,
    this.image,
    this.lastMessage,
    this.createdAt,
    this.newMessagesCount,
  });

  MessageList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    image = json['image'];
    lastMessage = json['lastMessage']['message'];
    createdAt = json['lastMessage']['created_at'];
    newMessagesCount = json['newMessagesCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['image'] = this.image;
    data['lastMessage'] = this.lastMessage;
    data['created_at'] = this.createdAt;
    data['newMessagesCount'] = this.newMessagesCount;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class LastMessage {
  int id;
  String message;
  int createdAt;

  LastMessage({
    this.id,
    this.message,
    this.createdAt
  });

  LastMessage.fromJson(Map<String, dynamic> json){
    id = json['id'];
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['createdAt'] = this.createdAt;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
