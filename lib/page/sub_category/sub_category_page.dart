import 'dart:math';

import 'package:Sarh/page/search/search_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SubCategoryPage extends StatefulWidget {
  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text('Category Name'),
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.chevronLeft),
          onPressed: () {},
        ),
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
      title: Text('Sub category title'),
      trailing: Text('(${Random().nextInt(100)})'),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SearchResultScreen()));
      },
    );
  }
}
