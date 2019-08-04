import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RequestQuoteScreen extends StatefulWidget {
  @override
  _RequestQuoteScreenState createState() => _RequestQuoteScreenState();
}

class _RequestQuoteScreenState extends State<RequestQuoteScreen> {
  var offset = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform.translate(
          offset: offset,
          child: Container(
            width: 200,
            height: 200,
            color: Colors.teal,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            offset = Offset(
                Random()
                    .nextInt(MediaQuery.of(context).size.width.round())
                    .toDouble(),
                Random()
                    .nextInt(MediaQuery.of(context).size.height.round())
                    .toDouble());
          });
        },
        heroTag: 'fab',
        label: Text('Submit'),
        icon: Icon(FontAwesomeIcons.plus),
      ),
    );
  }
}
