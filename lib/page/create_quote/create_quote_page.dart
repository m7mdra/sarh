import 'package:Sarh/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateQuotePage extends StatefulWidget {
  @override
  _CreateQuotePageState createState() => _CreateQuotePageState();
}

class _CreateQuotePageState extends State<CreateQuotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Create qoutation',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            Text(
              'for Mohamed sed',
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
        leading: BackButtonNoLabel(Colors.grey),
      ),
      body: SafeArea(
          child: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Create new quotation',
                style: Theme.of(context).textTheme.title,
              ),
              _sizedBox(),
              _sizedBox(),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(12)),
              ),
              _sizedBox(),
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                    hintText:
                        'Details/description',
                    border: OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(12)),
              ),
              _sizedBox(),
              Container(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(4),
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        Container(
                          child: Icon(
                            FontAwesomeIcons.solidTimesCircle,
                          ),
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                        ),
                      ],
                    );
                  },
                  shrinkWrap: true,
                  itemCount: 5,
                ),
              ),
              _sizedBox(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton.icon(
                        icon: Icon(FontAwesomeIcons.paperPlane),
                        label: Text('Submit'), onPressed: () {},),
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
                                        width:
                                            MediaQuery.of(context).size.width,
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
        ),
      )),
    );
  }

  SizedBox _sizedBox() {
    return const SizedBox(
      height: 8,
    );
  }
}
