import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unicorndial/unicorndial.dart';

class ChatListPage extends StatefulWidget {
  ChatListPage({Key key}) : super(key: key);

  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  
  @override
  Widget build(BuildContext context) {
      var childButtons = List<UnicornButton>();

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelHasShadow: true,
        labelText: "New Message",
        currentButton: FloatingActionButton(
          mini: true,
          heroTag: '"',
          child: Icon(FontAwesomeIcons.envelope),
          onPressed: () {},
        )));

    childButtons.add(UnicornButton(
        currentButton: FloatingActionButton(
            child: Icon(FontAwesomeIcons.fileInvoiceDollar),
            heroTag: '',
            mini: true, onPressed: () {},
           ),labelText: 'New Quote',
           hasLabel: true,
           labelHasShadow: true,));


    return Scaffold(
      floatingActionButton: UnicornDialer(
        childButtons: childButtons,
        orientation: UnicornOrientation.VERTICAL,
        parentButton: Icon(Icons.add),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Messages',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        leading: IconButton(
          color: Colors.black54,
          icon: Icon(
            FontAwesomeIcons.chevronLeft,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
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
              itemBuilder: (BuildContext context, int index) {
                return ChatListItem();
              },
              itemCount: 10,
              shrinkWrap: false,
            ),
          )
        ],
      ),
    );
  }
}

class ChatListItem extends StatelessWidget {
  const ChatListItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/logo/logo.png'),
      ),
      dense: true,
      title: Text('Proivder name'),
      contentPadding: const EdgeInsets.only(left: 16, right: 16),
      subtitle: Text(
        'Message message message messageMessage message message message',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Today 8:25 am',
            style: Theme.of(context).textTheme.caption,
          ),
          SizedBox(
            height: 4,
          ),
          CircleAvatar(
            radius: 10,
            child: Text('${math.Random().nextInt(10)}'),
          ),
        ],
      ),
    );
  }
}
