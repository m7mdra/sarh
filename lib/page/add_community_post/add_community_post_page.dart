import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdCommunityPostPage extends StatefulWidget {
  @override
  _AdCommunityPostPageState createState() => _AdCommunityPostPageState();
}

class _AdCommunityPostPageState extends State<AdCommunityPostPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Text(
            'Choose the category',
          ),
          _sizedBox(),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Choose category',
                border: OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(12)),
          ),
          _sizedBox(),
          Text(
            'Post Title',
          ),
          _sizedBox(),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Enter the Post title',
                border: OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(12)),
          ),
          _sizedBox(),
          Text(
            'Post Body',
          ),
          _sizedBox(),
          TextFormField(
            maxLines: 3,
            decoration: InputDecoration(
                hintText: 'Explain what you want to quary about...',
                border: OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(12)),
          ),
          _sizedBox(),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton.icon(
                  icon: Icon(FontAwesomeIcons.paperPlane),
                  label: Text('Submit'),
                  onPressed: () {},
                ),
                FlatButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                          context: (context),
                          builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Card(
                                      margin: const EdgeInsets.all(0),
                                      child: Column(
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(
                                              FontAwesomeIcons.image,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            title: Text('Attach photo'),
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              FontAwesomeIcons.video,
                                              color: Colors.green,
                                            ),
                                            title: Text('Attach Video'),
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              FontAwesomeIcons.image,
                                              color: Colors.redAccent,
                                            ),
                                            title: Text('Attach document'),
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: RaisedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancel'),
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)));
                    },
                    icon: Icon(FontAwesomeIcons.paperclip),
                    label: Text('Attatch file'))
              ],
            ),
          )
        ],
      ),
    );
  }

  SizedBox _sizedBox() {
    return const SizedBox(
      height: 8,
    );
  }
}
