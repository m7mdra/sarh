import 'dart:math';

import 'package:Sarh/page/sub_category/sub_category_page.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 1),
        children: <Widget>[
          CategoryWidget(),
          CategoryWidget(),
          CategoryWidget(),
          CategoryWidget(),
          CategoryWidget(),
          CategoryWidget(),
          CategoryWidget(),
          CategoryWidget(),
          CategoryWidget(),
        ],
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SubCategoryPage()));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withAlpha(80), width: 0.2)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo/logo.png',
              width: 150,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              height: 8,
            ),
            Text('Category name'),
            SizedBox(
              height: 2,
            ),
            Text('(${Random().nextInt(500)})'),
          ],
        ),
      ),
    );
  }
}
