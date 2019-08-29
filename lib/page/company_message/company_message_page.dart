import 'dart:math';

import 'package:Sarh/page/create_quote/create_quote_page.dart';
import 'package:Sarh/size_config.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CompanyMessagePage extends StatefulWidget {
  @override
  _CompanyMessagePageState createState() => _CompanyMessagePageState();
}

class Message {
  final String message;
  final bool isYou;
  final String date;

  Message(this.message, this.isYou, this.date);

  @override
  String toString() {
    return "$date: $message";
  }
}

class _CompanyMessagePageState extends State<CompanyMessagePage> {
  TextEditingController _chatController;
  List<Message> messages;

  @override
  void initState() {
    super.initState();

    _chatController = TextEditingController();
    messages = List.generate(4, (index) {
      return index % 2 == 0
          ? Message(
              '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem industry's standard dummy text ever since the 1500stext ever since the''',
              true,
              '${Random().nextInt(60)} min ago')
          : Message(
              '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. ''',
              false,
              '${Random().nextInt(60)} min ago');
    });
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
          'Mohamed Sed',
          style: TextStyle(),
        ),
        leading: BackButtonNoLabel(Colors.white),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              reverse: false,
              itemBuilder: (context, index) {
                var message = messages[index];
                return message.isYou
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
                        setState(() {
                          messages.add(Message(
                              _chatController.value.text, true, 'Just now'));
                          _chatController.clear();

                        });
                      }),
                )
              ],
            ),
          ),
        ],
      )),
    );
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
              backgroundImage: AssetImage('assets/background/stock_person.jpg'),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 64),
          child: Text(
            message.date,
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
              backgroundImage: AssetImage('assets/background/stock_woman.jpg'),
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
          padding: const EdgeInsetsDirectional.only(end: 64),
          child: Text(
            message.date,
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
