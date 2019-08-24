
import 'package:Sarh/page/company_message/company_message_page.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:flutter/material.dart';

class MessageListPage extends StatefulWidget {
  MessageListPage({Key key}) : super(key: key);

  _MessageListPageState createState() => _MessageListPageState();
}

class _MessageListPageState extends State<MessageListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Messages',
          style: TextStyle(
          ),
        ),
        leading: BackButtonNoLabel(Colors.white),
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
                return MessageListItem(
                  newMessage: index == 0,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CompanyMessagePage();
                    }));
                  },
                );
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

class MessageListItem extends StatelessWidget {
  final bool newMessage;
  final VoidCallback onTap;

  const MessageListItem({Key key, this.newMessage, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      selected: newMessage,
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage('assets/background/stock_person.jpg'),
      ),
      dense: true,
      title: Text('Proivder name'),
      contentPadding: const EdgeInsets.only(left: 16, right: 16),
      subtitle: Text(
        'Message message message messageMessage message message message',
        style: TextStyle(
            fontWeight: newMessage ? FontWeight.bold : FontWeight.normal),
        maxLines: 2,
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
        ],
      ),
    );
  }
}
