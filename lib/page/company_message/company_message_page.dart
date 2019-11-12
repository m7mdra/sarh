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

import 'dart:core' as prefix0;
import 'dart:core';
import 'dart:math';

import 'package:Sarh/data/model/chat_responses/messages.dart';
import 'package:Sarh/data/model/openchat.dart';
import 'package:Sarh/data/session.dart';
import 'package:Sarh/page/company_message/bloc/bloc.dart';
import 'package:Sarh/page/create_quote/create_quote_page.dart';
import 'package:Sarh/page/message_list/message_list_page.dart';
import 'package:Sarh/pusher_service.dart';
import 'package:Sarh/size_config.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:Sarh/widget/ui_state/empty_widget.dart';
import 'package:Sarh/widget/ui_state/general_error_widget.dart';
import 'package:Sarh/widget/ui_state/network_error_widget.dart';
import 'package:Sarh/widget/ui_state/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dependency_provider.dart';


class CompanyMessagePage extends StatefulWidget {
  MessageList messageListItem;

  CompanyMessagePage({this.messageListItem});

  @override
  _CompanyMessagePageState createState() => _CompanyMessagePageState(messageListItem);
}


class _CompanyMessagePageState extends State<CompanyMessagePage> {
  TextEditingController _chatController;
  CompanyMessagesBloc _messageListBloc;
  Session session;

  MessageList messageListItem;
  List messages;
  SharedPreferences sharedPreferences;
  var userId;

  PusherService pusherService;


  _CompanyMessagePageState(this.messageListItem);

  getUserInfo()async{
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userId = sharedPreferences.get('user_id');
      pusherService = PusherService();
      pusherService.firePusher('channel-'+userId.toString(), 'event');
    });
  }


  @override
  void initState() {
    getUserInfo();
    _messageListBloc = CompanyMessagesBloc(DependencyProvider.provide());
    _dispatch();
    _chatController = TextEditingController();

    super.initState();

  }

  @override
  void dispose() {
    pusherService.unbindEvent('event');
    super.dispose();
  }

  void _dispatch() => _messageListBloc.dispatch(LoadCompanyMessages(messageListItem.id));

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            tooltip: 'Create quote',
            icon: Icon(FontAwesomeIcons.fileInvoice),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CreateQuotePage();
              }));
            },
            color: Colors.white,
          )
        ],
        elevation: 2,
        centerTitle: true,
        title: Text(
          messageListItem.fullName,
          style: TextStyle(),
        ),
        leading: BackButtonNoLabel(Colors.white),
      ),
      body: SafeArea(
          child: BlocBuilder(
              bloc: _messageListBloc,
              builder: (context, state) {
                print(state);
                if (state is OnLoading) {
                  return Center(child: ProgressBar());
                }
                if (state is CompanyMessagesNetworkError) {
                  return Center(
                      child:
                      NetworkErrorWidget(onRetry: () => _dispatch()));
                }
                if (state is CompanyMessagesError) {
                  return Center(
                      child:
                      GeneralErrorWidget(onRetry: () => _dispatch()));
                }
                if (state is CompanyMessagesEmpty) {
                  return Center(
                    child: EmptyWidget(),
                  );
                }
                if (state is OnLoaded) {
                  messages = state.messages;
                  List quotation = state.quotations;
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          reverse: false,
                          itemBuilder: (context, index) {
                            Message message = messages[index];
                            return message.accountSender.id != userId
                                ? _sentMessage(message)
                                : _receivedMessage(message);
                          },
                          itemCount: messages.length,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Card(
                                child: TextField(
                                  controller: _chatController,
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.newline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      hintText: 'Type here...',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.zero,
                                          borderSide: BorderSide.none),
                                      contentPadding: const EdgeInsets.all(10)),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.black12),
                              child: IconButton(
                                  icon: Icon(FontAwesomeIcons.solidPaperPlane),
                                  onPressed: () {
//                                    setState(() {
//                                      messages.add(message);
//                                    });

                                    _messageListBloc.dispatch(AddNewMessage(_chatController.text.trim(), messageListItem.id, []));
                                    _chatController.clear();

                                  }
                                  ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }
                if(state is NewMessageAdded){
                  print(state.message);
                  prefix0.print("ERROR DATA FROM PUSHER");
                  print('BEFORE');
//                  return StreamBuilder(
//                    stream: pusherService.eventStream,
//                    builder: (BuildContext context, AsyncSnapshot snapshot) {
//                      if (!snapshot.hasData) {
//                        return CircularProgressIndicator();
//                      }
//                      return Container(
//                        child: Text(snapshot.data),
//                      );
//                    },
//                  );
                  return Container(
                    child: BlocListener(
                    bloc: _messageListBloc,
                    listener: (BuildContext context , state){
                      if(state is NewMessageAdded){
                        setState(() {
                          messages.add(state.message);
                        });
                      }
                    },
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.all(8),
                              reverse: false,
                              itemBuilder: (context, index) {
                                return state.message.accountSender.id != userId
                                    ? _sentMessage(state.message)
                                    : _receivedMessage(state.message);
                              },
                              itemCount: messages.length,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Card(
                                    child: TextField(
                                      controller: _chatController,
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.newline,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                          hintText: 'Type here...',
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide.none),
                                          contentPadding: const EdgeInsets.all(10)),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, color: Colors.black12),
                                  child: IconButton(
                                      icon: Icon(FontAwesomeIcons.solidPaperPlane),
                                      onPressed: () {
//                                    setState(() {
//                                      messages.add(message);
//                                    });

                                        _messageListBloc.dispatch(AddNewMessage(_chatController.text.trim(), messageListItem.id, []));
                                        _chatController.clear();

                                      }
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                  ),
                  );
                }
                return Container();
              }
              ),
      ),
    );
  }


  String readTimestamp(int timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat('HH:mm a');
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' Day Ago';
      } else {
        time = diff.inDays.toString() + ' Days Ago';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' Week Ago';
      } else {

        time = (diff.inDays / 7).floor().toString() + ' Weeks Ago';
      }
    }

    return time;
  }

  Widget _sentMessage(Message message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              margin:
                  const EdgeInsetsDirectional.only(end: 8, start: 16, top: 8),
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: SizeConfig.blockSizeHorizontal * 65,
                child: Text(
                  message.message,
                  textAlign: TextAlign.start,
                  style:
                      Theme.of(context).textTheme.body1.copyWith(fontSize: 14),
                ),
              ),
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.only(
                          bottomEnd: Radius.circular(8),
                          bottomStart: Radius.circular(8),
                          topStart: Radius.circular(8))),
                  color: Theme.of(context).splashColor),
            ),
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(message.accountSender.image),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 54,top: 5),
          child: Text(
            readTimestamp(message.createdAt),
            style: Theme.of(context).textTheme.caption,
          ),
        )
      ],
    );
  }

  Widget _receivedMessage(Message message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(message.accountReceiver.image),
            ),
            Container(
              margin:
                  const EdgeInsetsDirectional.only(start: 8, end: 16, top: 8),
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: SizeConfig.blockSizeHorizontal * 65,
                child: Text(
                  message.message,
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.white),
                  maxLines: null,
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
              ),
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.only(
                          bottomEnd: Radius.circular(8),
                          bottomStart: Radius.circular(8),
                          topEnd: Radius.circular(8))),
                  color: Theme.of(context).accentColor),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 54),
          child: Text(
            readTimestamp(message.createdAt),
            style: Theme.of(context).textTheme.caption,
          ),
        )
      ],
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isYour;

  const MessageBubble({Key key, this.message, this.isYour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 4),
      padding: const EdgeInsets.all(8),
      alignment: isYour ? Alignment.topRight : Alignment.topLeft,
      child: Text(
        message.message,
        style: Theme.of(context).textTheme.body1.copyWith(fontSize: 14),
        maxLines: null,
        overflow: TextOverflow.visible,
        softWrap: true,
      ),
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          color: Theme.of(context).accentColor),
    );
  }
}



