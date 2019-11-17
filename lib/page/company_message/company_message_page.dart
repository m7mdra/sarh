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

import 'dart:async';
import 'dart:convert';
import 'dart:core' as prefix0;
import 'dart:core';
import 'dart:math';

import 'package:Sarh/data/chat/chat_repository.dart';
import 'package:Sarh/data/exceptions/exceptions.dart' as prefix1;
import 'package:Sarh/data/model/chat_responses/messages.dart';
import 'package:Sarh/data/model/openchat.dart';
import 'package:Sarh/data/session.dart';
import 'package:Sarh/page/company_message/bloc/bloc.dart';
import 'package:Sarh/page/create_quote/create_quote_page.dart';
import 'package:Sarh/page/login/login_page.dart';
import 'package:Sarh/page/message_list/message_list_page.dart';
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
import 'package:Sarh/data/exceptions/exceptions.dart';
import '../../dependency_provider.dart';

//PUSHER IMPORT
import 'package:flutter/services.dart';
import 'package:pusher_websocket_flutter/pusher.dart';

class CompanyMessagePage extends StatefulWidget {
  MessageList messageListItem;

  CompanyMessagePage({this.messageListItem});

  @override
  _CompanyMessagePageState createState() =>
      _CompanyMessagePageState(messageListItem);
}

class _CompanyMessagePageState extends State<CompanyMessagePage> {
  TextEditingController _chatController;
  Session session;
  ChatRepository _chatRepository;

  MessageList messageListItem;
  List messages, quotations;
  SharedPreferences sharedPreferences;
  var userId;
  ScrollController _controller = ScrollController();

  var _mLoaded = 'load';
  var _addMessage = 'add';

  _CompanyMessagePageState(this.messageListItem);

  getUserInfo() async {
    sharedPreferences = await SharedPreferences.getInstance();
    session = new Session(sharedPreferences);
    setState(() {
      userId = sharedPreferences.get('user_id');
      firePusher('channel-' + userId.toString(), 'event');
      _dispatch();
    });
  }

  loadMessages(var userId) async {
    prefix0.print("STARTING");
    try {
      var _messagesResponse = await _chatRepository.getMessagesWith(userId);
      prefix0.print('SUCCESS');
      print(_messagesResponse.success);
      if (_messagesResponse.success) {
        prefix0.print('MESSAGES');
        print(_messagesResponse.data.messages.length);
        prefix0.print('QUOTATIONS');
        print(_messagesResponse.data.quotations.length);
        messages = _messagesResponse.data.messages;
        quotations = _messagesResponse.data.quotations;

        setState(() {
          _mLoaded = 'loaded';
        });

      } else {
        setState(() {
          prefix0.print("GENERAL ERROR");
          _mLoaded = 'companyMessageError';
        });
      }
    } on UnableToConnectException {
      setState(() {
        _mLoaded = 'companyMessageNetworkError';
      });
    } on TimeoutException {
      setState(() {
        _mLoaded = 'companyMessageNetworkError';
      });
    } on SessionExpiredException {
      setState(() {
        _sessionExpired();
      });
    } catch (error) {
      setState(() {
        _mLoaded = 'companyMessageError';
      });
    }
  }

  addMessageToList(Message message) {
    setState(() {
      messages.add(message);

      Timer(Duration(milliseconds: 300),
          () => _controller.jumpTo(_controller.position.minScrollExtent));
      addMessage(message);
    });
  }

  addMessage(Message message) async {
    try {
      var _addMessageResponse = await _chatRepository.addNewMessage(message);
      prefix0.print('RESPONSE');
      print(_addMessageResponse);
      if (_addMessageResponse['success']) {
        prefix0.print('MESSAGES');
        setState(() {
          _addMessage = 'added';

           message = Message.fromJson(_addMessageResponse['data']);
           updateSentMessage(message);
        });
      } else {
        setState(() {
          _addMessage = 'error';
        });
      }
    } on UnableToConnectException {
      setState(() {
        _addMessage = 'error';
      });
    } on TimeoutException {
      setState(() {
        _addMessage = 'error';
      });
    } on SessionExpiredException {
      _sessionExpired();
    } catch (error) {
      setState(() {
        _addMessage = 'error';
      });
    }
  }

  updateSentMessage(Message message){
    final tile = messages.firstWhere((item) => item.message == message.message, orElse: null);
    if (tile != null) {
      setState(() {
        tile.createdAt = message.createdAt;
          prefix0.print(tile);
      });
    }
    else {
      prefix0.print('Not FOUND');
    }

  }

  addReceiveMessage(Message message){
    setState(() {
      messages.add(message);
      _receivedMessage(message);

      Timer(Duration(milliseconds: 300),
              () => _controller.jumpTo(_controller.position.minScrollExtent));
    });
  }

  //************* PUSHER SERVICES ****************//

  var lastEvent;
  String lastConnectionState;
  var channel;
  dynamic message;

  StreamController<dynamic> _eventData = StreamController<dynamic>();
  Sink get _inEventData => _eventData.sink;
  Stream get eventStream => _eventData.stream;

  Future<void> initPusher() async {
    try {
      await Pusher.init('5ae81a1f2be1bd8dd275', PusherOptions(cluster: 'mt1'));
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  void connectPusher() {
    Pusher.connect(
        onConnectionStateChange: (ConnectionStateChange connectionState) async {
          lastConnectionState = connectionState.currentState.toString();
          prefix0.print("PUSHER CONNECT STATE In");
          print(lastConnectionState);
        }, onError: (ConnectionError e) {
      print("Error: ${e.message}");
    });

  }

  Future<void> subscribePusher(String channelName) async {
    prefix0.print('BEFORE SUBSCRIBE STATE');
    channel = await Pusher.subscribe(channelName);
    prefix0.print('SUBSCRIBE STATE');
    print(channel.toString());
  }

  void unSubscribePusher(String channelName) {
    Pusher.unsubscribe(channelName);
  }

  void bindEvent(String eventName) {
    channel.bind(eventName, (last) {
      prefix0.print('PUSHER BIND LAST DATA');
      var data = json.decode(last.data);
      print(data);

      Message message = new Message.fromJson(data);
      print(message.message);

      addReceiveMessage(message);

    });
  }

  void unbindEvent(String eventName) {
    channel.unbind(eventName);
    _eventData.close();
  }

  Future<void> firePusher(String channelName, String eventName) async {
    await initPusher();
    connectPusher();
    await subscribePusher(channelName);
    bindEvent(eventName);
  }

  //************* PUSHER SERVICES ****************//

  @override
  void initState() {
    _chatRepository = DependencyProvider.provide();
      getUserInfo();
    _chatController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    unbindEvent('event');
    super.dispose();
  }

  void _dispatch() => loadMessages(messageListItem.id);

  void _sessionExpired() async {
    sharedPreferences = await SharedPreferences.getInstance();
    session = new Session(sharedPreferences);
    sharedPreferences.clear();
    session.clear();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

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
          child: _mLoaded == 'load'
              ? Center(child: ProgressBar())
              : _mLoaded == 'loaded'
                  ? Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            reverse: true,
                            controller: _controller,
                            itemBuilder: (context, index) {
                              Message message = messages[messages.length - 1 - index];
                              return _addMessageToView(message,userId);
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
                                        contentPadding:
                                            const EdgeInsets.all(10)),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black12),
                                child: IconButton(
                                    icon:
                                        Icon(FontAwesomeIcons.solidPaperPlane),
                                    onPressed: () {
                                      Message message = new Message(
                                        id: 1,
                                        message: _chatController.text,
                                        messageAttachments: [],
                                        accountReceiver: new AccountReceiver(
                                            id: messageListItem.id,
                                            image: messageListItem.image,
                                            fullName: messageListItem.fullName),
                                        accountSender: new AccountSender(
                                            id: userId,
                                            image: messageListItem.image,
                                            fullName: messageListItem.fullName),
                                        quotatioRequest: null,
                                        quotationReply: null,
                                        seenAt: null,
                                        createdAt: 00,
                                      );
                                      addMessageToList(message);
                                      _chatController.clear();
                                    }),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  : _mLoaded == 'companyMessageError'
                      ? Center(
                          child: NetworkErrorWidget(onRetry: () => _dispatch))
                      : _mLoaded == 'companyMessageNetworkError'
                          ? Center(
                              child: NetworkErrorWidget(
                                  onRetry: () => _dispatch()))
                          : Center(
                              child: NetworkErrorWidget(
                                  onRetry: () => _dispatch))),
    );
  }

  String readTimestamp(int timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat('HH:mm a');
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';
    if (timestamp == 0) {
      return time = 'Pending';
    }
    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
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

  Widget _addMessageToView(Message message,var userId){
    prefix0.print("USER ID");
    print(userId.toString());
    prefix0.print("MESSAGE ACCOUNT ID");
    print(message.accountSender.id.toString());

    if(message.accountSender.id == userId){
      return _sentMessage(message);
    }
    else{
      return _receivedMessage(message);
    }
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
          padding: const EdgeInsetsDirectional.only(start: 54, top: 5),
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


/*BlocBuilder(
              bloc: _messageListBloc,
              builder: (context, state) {
                print(state);
                if (state is OnLoading) {
                  return Center(child: ProgressBar());
                }
                if (state is CompanyMessagesNetworkError) {
                  return Center(
                      child: NetworkErrorWidget(onRetry: () => _dispatch()));
                }
                if (state is CompanyMessagesError) {
                  return Center(
                      child: GeneralErrorWidget(onRetry: () => _dispatch()));
                }
                if (state is CompanyMessagesEmpty) {
                  return Center(
                    child: EmptyWidget(),
                  );
                }
                if (state is MessageAddedToList) {
                  print('MessageAddedToList MessageAddedToList');
                  print('MessageAddedToList2 MessageAddedToList2');
                  return Container(
                    child: BlocListener(
                      bloc: _messageListBloc,
                      listener: (BuildContext context, state) {
                        print('NEW MESSAGE ADDED 1');
                        print(state);

                        if (state is MessageAddedToList) {
                          setState(() {

                            print('NEW MESSAGE ADDED 2');
                            print('BEFORE');
                            messages.add(state.message);
                            Timer(
                                Duration(milliseconds: 300),
                                    () => _controller
                                    .jumpTo(_controller.position.maxScrollExtent));
                            print('AFTER ADDED');
                            _messageListBloc
                                .dispatch(AddNewMessage(state.message));
                          });
                        }
                      },
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.all(8),
                              reverse: true,
                              controller: _controller,
                              itemBuilder: (context, index) {
                                Message message = messages[messages.length - 1 -index];
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
                                          contentPadding:
                                              const EdgeInsets.all(10)),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black12),
                                  child: IconButton(
                                      icon: Icon(
                                          FontAwesomeIcons.solidPaperPlane),
                                      onPressed: () {
                                        Message message = new Message(
                                          id: 1,
                                          message: _chatController.text,
                                          messageAttachments: [],
                                          accountReceiver: new AccountReceiver(
                                              id: messageListItem.id,
                                              image: messageListItem.image,
                                              fullName:
                                                  messageListItem.fullName),
                                          accountSender: new AccountSender(
                                              id: 1,
                                              image: messageListItem.image,
                                              fullName:
                                                  messageListItem.fullName),
                                          quotatioRequest: null,
                                          quotationReply: null,
                                          seenAt: null,
                                          createdAt: 00,
                                        );
                                        _messageListBloc.dispatch(
                                            MessageAddToList(message));
                                        _chatController.clear();
                                      }),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  /*return Container(
                    child: BlocListener(
                      bloc: _messageListBloc,
                      listener: (BuildContext context , state){
                        prefix0.print('STATE BEFORE');
                        print(state);
                        if(state is MessageAddedToList){
                          print("!11111111111111111111");
                          setState(() {
                            messages.add(state.message);
                          });
                          print("!22222222222222222");
                          _messageListBloc.dispatch(AddNewMessage(state.message));
                        }
                      },
                      child: Column(
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
                                        print("FIRSTTT Add MEssage To List");
                                        Message message = new Message(
                                          id: 0,
                                          message: _chatController.text,
                                          messageAttachments: [],
                                          accountReceiver: new AccountReceiver(
                                              id: messageListItem.id,
                                              image: messageListItem.image,
                                              fullName: messageListItem.fullName
                                          ),
                                          accountSender: null,
                                          quotatioRequest: null,
                                          quotationReply: null,
                                          seenAt: null,
                                          createdAt: 00,
                                        );
                                        print("FIRSTTT MESSAGE");
                                        _messageListBloc.dispatch(MessageAddToList(message));
                                        print("FIRSTTT DISPATCH");
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
                  );*/
                }
                if (state is OnLoaded) {
                  messages = state.messages;
                  List quotation = state.quotations;
                  return Container(
                      child: BlocListener(
                          bloc: _messageListBloc,
                          listener: (BuildContext context, state) {
                            print('NEW MESSAGE ADDED 1');
                            print(state);

                            if (state is MessageAddedToList) {
                              setState(() {
                                print('NEW MESSAGE ADDED 2');
                                print('BEFORE');
                                messages.add(state.message);
                                Timer(
                                    Duration(milliseconds: 300),
                                        () => _controller
                                        .jumpTo(_controller.position.maxScrollExtent));
                                print('AFTER ADDED');
                                _messageListBloc
                                    .dispatch(AddNewMessage(state.message));
                              });
                            }
                          },
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  reverse: true,
                                  controller: _controller,
                                  itemBuilder: (context, index) {
                                    Message message = messages[messages.length - 1 -index];
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
                                          shape: BoxShape.circle,
                                          color: Colors.black12),
                                      child: IconButton(
                                          icon: Icon(FontAwesomeIcons.solidPaperPlane),
                                          onPressed: () {
                                            Message message = new Message(
                                              id: 1,
                                              message: _chatController.text,
                                              messageAttachments: [],
                                              accountReceiver: new AccountReceiver(
                                                  id: messageListItem.id,
                                                  image: messageListItem.image,
                                                  fullName: messageListItem.fullName),
                                              accountSender: new AccountSender(
                                                  id: 1,
                                                  image: messageListItem.image,
                                                  fullName: messageListItem.fullName),
                                              quotatioRequest: null,
                                              quotationReply: null,
                                              seenAt: null,
                                              createdAt: 00,
                                            );
                                            _messageListBloc
                                                .dispatch(MessageAddToList(message));
                                            _chatController.clear();
                                          }
                                          ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                      ),
                  );
                }
                if(state is CompanyMessagesState){
                  Timer(
                      Duration(milliseconds: 300),
                          () => _controller
                          .jumpTo(_controller.position.maxScrollExtent));
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          reverse: true,
                          controller: _controller,
                          itemBuilder: (context, index) {
                            Message message = messages[messages.length - 1 -index];
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
                                      contentPadding:
                                      const EdgeInsets.all(10)),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black12),
                              child: IconButton(
                                  icon: Icon(
                                      FontAwesomeIcons.solidPaperPlane),
                                  onPressed: () {
                                    Message message = new Message(
                                      id: 1,
                                      message: _chatController.text,
                                      messageAttachments: [],
                                      accountReceiver: new AccountReceiver(
                                          id: messageListItem.id,
                                          image: messageListItem.image,
                                          fullName:
                                          messageListItem.fullName),
                                      accountSender: new AccountSender(
                                          id: 1,
                                          image: messageListItem.image,
                                          fullName:
                                          messageListItem.fullName),
                                      quotatioRequest: null,
                                      quotationReply: null,
                                      seenAt: null,
                                      createdAt: 00,
                                    );
                                    _messageListBloc.dispatch(
                                        MessageAddToList(message));
                                    _chatController.clear();
                                  }),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }
               /* else if (state is NewMessageAdded) {
                  print(state.message.message);
                  print('AFTER2312');
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
//                  )
                  return Container(
                    child: BlocListener(
                      bloc: _messageListBloc,
                      listener: (BuildContext context, state) {
                        print('BAHSA1');
                        if (state is NewMessageAdded) {
                          print('BAHSA2');
                          setState(() {
//                            print('NEW MESSAGE ADDED 2');
//                            print('BEFORE');
//                            messages.add(state.message);
//                            print('AFTER ADDED');
//                            _messageListBloc.dispatch(AddNewMessage(state.message));
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
                                          contentPadding:
                                              const EdgeInsets.all(10)),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black12),
                                  child: IconButton(
                                      icon: Icon(
                                          FontAwesomeIcons.solidPaperPlane),
                                      onPressed: () {
                                        Message message = new Message(
                                          id: 1,
                                          message: _chatController.text,
                                          messageAttachments: [],
                                          accountReceiver: new AccountReceiver(
                                              id: messageListItem.id,
                                              image: messageListItem.image,
                                              fullName: messageListItem.fullName),
                                          accountSender: new AccountSender(
                                              id: 1,
                                              image: messageListItem.image,
                                              fullName: messageListItem.fullName),
                                          quotatioRequest: null,
                                          quotationReply: null,
                                          seenAt: null,
                                          createdAt: 00,
                                        );
                                        _messageListBloc
                                            .dispatch(MessageAddToList(message));
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
                }*/
                return Container();
              })*/
