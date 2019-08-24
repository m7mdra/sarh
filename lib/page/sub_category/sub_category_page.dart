import 'dart:math';

import 'package:Sarh/page/search/search_result_page.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:flutter/material.dart';

class SubActivitypage extends StatefulWidget {
  @override
  _SubActivitypageState createState() => _SubActivitypageState();
}

class _SubActivitypageState extends State<SubActivitypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text('Activity Name'),
        leading: BackButtonNoLabel(Colors.white),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return SubCategoryItem();
        },
        itemCount: 10,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 1,
          );
        },
      ),
    );
  }
}

class SubCategoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Sub Activity title'),
      trailing: Text('(${Random().nextInt(100)})'),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SearchResultPage()));
      },
    );
  }
}
