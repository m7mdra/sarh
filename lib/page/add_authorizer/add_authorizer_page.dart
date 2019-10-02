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

import 'dart:io';
import 'dart:math';

import 'package:Sarh/i10n/app_localizations.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:Sarh/widget/media_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddAuthorizerPage extends StatefulWidget {
  @override
  _AddAuthorizerPageState createState() => _AddAuthorizerPageState();
}

class _AddAuthorizerPageState extends State<AddAuthorizerPage> {
  File _logoImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButtonNoLabel(Colors.white),
        title: Text('Add Authorizers'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Authorizers Logo',
              style: Theme.of(context).textTheme.subhead,
            ),
            _sizedBox,
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () async {
                var pickedFile = await showDialog(
                    context: context, builder: (context) => MediaPickDialog());
                if (pickedFile != null)
                  setState(() {
                    _logoImage = pickedFile;
                  });
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8)),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.camera),
                    if (_logoImage != null)
                      ClipRRect(
                        child: Image.file(
                          _logoImage,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      )
                  ],
                ),
              ),
            ),
            _sizedBox,
            Text(
              'Authorizer Name',
              style: Theme.of(context).textTheme.subhead,
            ),
            _sizedBox,
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.all(12)),
            ),
            _sizedBox,
            RaisedButton(onPressed: (){},child: Text(AppLocalizations.of(context).submitButton),)
          ],
        ),
      ),
    );
  }

  SizedBox get _sizedBox {
    return SizedBox(
      height: 8,
    );
  }
}
