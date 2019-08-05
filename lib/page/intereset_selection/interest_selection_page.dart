import 'dart:math';

import 'package:flutter/material.dart';

class InterestPickSelectionPage extends StatefulWidget {
  InterestPickSelectionPage({Key key}) : super(key: key);

  _InterestPickSelectionPageState createState() =>
      _InterestPickSelectionPageState();
}

class _InterestPickSelectionPageState extends State<InterestPickSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choose your interests',
          style:
              Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: SingleSelectionCategory(),
            height: 170,
          ),
          Divider(
            height: 1,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: MultiSelectSubCategory(),
            ),
          ),
          Divider(
            height: 1,
          ),
          Flexible(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    child: Text('Skip for later'),
                    onPressed: () {},
                  ),
                  RaisedButton(
                    child: Text('Save'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SingleSelectionCategory extends StatefulWidget {
  @override
  _SingleSelectionCategoryState createState() =>
      _SingleSelectionCategoryState();
}

class _SingleSelectionCategoryState extends State<SingleSelectionCategory> {
  var _selectIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      itemBuilder: (BuildContext context, int index) {
        return CategoryWidget(
          onTap: () async {
            _selectIndex = index;
            setState(() {});
          },
          isSelected: index == _selectIndex,
        );
      },
      itemCount: 10,
      scrollDirection: Axis.horizontal,
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  const CategoryWidget({Key key, this.isSelected, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Card(
            elevation: isSelected != null && isSelected ? 16 : 0,
            child: Image.asset(
              'assets/logo/logo.png',
              height: isSelected ? 110 : 90,
              width: isSelected ? 110 : 90,
            ),
          ),
          Text('Category name')
        ],
      ),
    );
  }
}

class MultiSelectSubCategory extends StatefulWidget {
  MultiSelectSubCategory({Key key}) : super(key: key);

  _MultiSelectSubCategoryState createState() => _MultiSelectSubCategoryState();
}

class _MultiSelectSubCategoryState extends State<MultiSelectSubCategory> {
  @override
  Widget build(BuildContext context) {
    List subCategories = [
      'Electerical Electerical',
      'Painting',
      'Plumbing',
      'Anything',
      'Electerical',
      'Painting',
      'Plumbing',
      'Anything',
      'Electerical',
      'Painting',
      'Plumbing',
      'Anything',
      'Electerical',
      'Painting',
      'Plumbing',
      'Anything',
    ];

    return SingleChildScrollView(
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        children: subCategories
            .map((sub) => SubCategoryWidget(
                  isSelected: Random().nextInt(100) % 2 == 0,
                  name: sub,
                ))
            .toList(),
        direction: Axis.horizontal,
      ),
    );
  }
}

class SubCategoryWidget extends StatelessWidget {
  final bool isSelected;
  final String name;
  const SubCategoryWidget({Key key, this.isSelected, this.name})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        child: Text(
          name,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
        padding: const EdgeInsets.all(8),
        decoration:
            isSelected ? _selectedBoxDecoration : _notSelectedBoxDecoration,
      ),
    );
  }

  BoxDecoration get _selectedBoxDecoration => BoxDecoration(
      color: Colors.black54, borderRadius: BorderRadius.circular(4));
  BoxDecoration get _notSelectedBoxDecoration => BoxDecoration(
      border: Border.all(color: Colors.black.withAlpha(40)),
      borderRadius: BorderRadius.circular(4));
}
