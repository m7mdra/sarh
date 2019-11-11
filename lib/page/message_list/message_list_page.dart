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

import 'package:Sarh/data/model/openchat.dart';
import 'package:Sarh/dependency_provider.dart';
import 'package:Sarh/page/company_message/company_message_page.dart';
import 'package:Sarh/page/message_list/bloc/message_list_state.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:Sarh/widget/ui_state/empty_widget.dart';
import 'package:Sarh/widget/ui_state/general_error_widget.dart';
import 'package:Sarh/widget/ui_state/network_error_widget.dart';
import 'package:Sarh/widget/ui_state/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'bloc/message_list_bloc.dart';
import 'bloc/message_list_event.dart';
import 'package:time_formatter/time_formatter.dart';


class MessageListPage extends StatefulWidget {

 final MessageList messagelist;

  MessageListPage({Key key,this.messagelist}) : super(key: key);

  _MessageListPageState createState() => _MessageListPageState();
}

class _MessageListPageState extends State<MessageListPage> {
  MessageList messageList;
  MessageListBloc _messageListBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messageList = widget.messagelist;
    _messageListBloc = MessageListBloc(DependencyProvider.provide());
    _dispatch();
  }

  void _dispatch() => _messageListBloc.dispatch(MessageListLoaded());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Messages',
          style: TextStyle(),
        ),
        leading: BackButtonNoLabel(Colors.white),
      ),
      body: BlocBuilder(
        bloc: _messageListBloc,
        builder: (context, state) {
          print(state);
            if (state is ListLoading) {
            return Center(child: ProgressBar());
            }
            if (state is ListNetworkError) {
            return Center(
            child:
            NetworkErrorWidget(onRetry: () => _dispatch()));
            }
            if (state is ListError) {
            return Center(
            child:
            GeneralErrorWidget(onRetry: () => _dispatch()));
            }
            if (state is ListEmpty) {
            return Center(
            child: EmptyWidget(),
            );
            }
            if (state is ListLoaded) {
            List listMessages = state.chats;
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: TextField(
                      decoration: InputDecoration.collapsed(
                          hintText: 'Search ...',
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none))
                          .copyWith(
                        contentPadding: const EdgeInsets.all(9),
                      )),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: false,
                    itemBuilder: (BuildContext context, int index) {
                      return MessageListItem(
                        messageListItem: listMessages[index],
                      );
                    },
                    itemCount: listMessages.length,
                  ),
                )
              ],
            );
          }
          return Container();
        }),
      /*

      */
    );
  }
}

class MessageListItem extends StatelessWidget {

  final MessageList messageListItem;

  const MessageListItem({Key key, this.messageListItem}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {

    bool newMessage = messageListItem.newMessagesCount > 0 ? true : false;

    var time = readTimestamp(messageListItem.createdAt);

    return ListTile(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return CompanyMessagePage(messageListItem:messageListItem);
            }));
      },
      selected: newMessage,
      leading: CircleAvatar(
        radius: 25,

        backgroundImage: NetworkImage(messageListItem.image),
      ),
      dense: true,
      title: Text(messageListItem.fullName,style: TextStyle(fontSize: 15),),
      contentPadding: const EdgeInsets.only(left: 4, right: 4),
      subtitle: Text(
        messageListItem.lastMessage,
        style: TextStyle(
            fontWeight: newMessage ? FontWeight.bold : FontWeight.normal),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            time.toString(),
            style: Theme.of(context).textTheme.caption,
          ),
          SizedBox(
            height: 4,
          ),
        ],
      ),
    );
  }
}
