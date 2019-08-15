import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RequestQuoteScreen extends StatefulWidget {
  @override
  _RequestQuoteScreenState createState() => _RequestQuoteScreenState();
}

class _RequestQuoteScreenState extends State<RequestQuoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Request qoutations',
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
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                'Choose request method',
              ),
              _sizedBox(),
              Container(
                child: ExpansionTile(
                  title: Text('Choose request method'),
                  children: <Widget>[
                    CheckboxListTile(
                      value: true,
                      onChanged: (newValue) {},
                      title: Text('Favorite'),
                      dense: true,
                    ),
                    CheckboxListTile(
                      value: false,
                      onChanged: (newValue) {},
                      title: Text('Random'),
                      dense: true,
                    ),
                    CheckboxListTile(
                      value: false,
                      onChanged: (newValue) {},
                      title: Text('Favorite'),
                      dense: true,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(4)),
              ),
              _sizedBox(),
              Text(
                'Quotation subject',
              ),
              _sizedBox(),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Enter the Quotation subject',
                    border: OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(12)),
              ),
              Text(
                'Quotation Details',
              ),
              _sizedBox(),
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                    hintText:
                        'Explain what you need the need from the service provider',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton.icon(
                      onPressed: () {},
                      icon: Icon(FontAwesomeIcons.paperPlane),
                      label: Text('Submit')),
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
                      icon: Icon(Icons.attach_file),
                      label: Text('Attatch file'))
                ],
              )
            ],
          ))
        ],
      )),
    );
  }

  SizedBox _sizedBox() {
    return const SizedBox(
      height: 4,
    );
  }
}
