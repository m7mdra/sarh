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

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UpdatesPage extends StatefulWidget {
  const UpdatesPage({Key key}) : super(key: key);

  @override
  _UpdatesPageState createState() => _UpdatesPageState();
}

class _UpdatesPageState extends State<UpdatesPage> {
  var days = [
    'Today',
    'Yesterday',
    '2 Days ago',
    '3 Days ago',
    '4 Days ago',
    '5 Days ago',
    '1 Week ago',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                days[index],
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                primary: false,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Color(0xffF3F4F5),
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      onTap: () {},
                      dense: true,
                      trailing: Icon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.grey,
                      ),
                      title: Text('Notification title'),
                      subtitle: Text('${Random().nextInt(12)} am'),
                    ),
                  );
                },
                itemCount: Random().nextInt(10),
                shrinkWrap: true,
              )
            ],
          );
        },
        itemCount: days.length,
      )),
    );
  }
}
