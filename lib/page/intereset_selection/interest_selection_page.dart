import 'dart:math';

import 'package:Sarh/page/home/main/main_page.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:flutter/material.dart';

class InterestSelectionPage extends StatefulWidget {
  InterestSelectionPage({Key key}) : super(key: key);

  _InterestSelectionPageState createState() => _InterestSelectionPageState();
}

class _InterestSelectionPageState extends State<InterestSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButtonNoLabel(Colors.white),
        centerTitle: true,
        title: Text(
          'Choose your interests',
          style:
              Theme.of(context).textTheme.title.copyWith(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: SingleSelectionCategory(),
            height: 180,
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
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MainPage()));
                    },
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
  var _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      controller: ScrollController(),
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
            elevation: isSelected != null && isSelected ? 8 : 2,
            child: Image.asset(
              'assets/logo/logo.png',
              height: isSelected ? 110 : 90,
              width: isSelected ? 110 : 90,
            ),
          ),
          Text('Category')
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
      'Abated',
      'Active solar',
      'Architectural metals',
      'Banksman',
      'Barn raising',
      'Barra system',
      'Basement waterproofing',
      'Batter board',
      'Bill of quantities',
      'Borrow pit',
      'BREEAM',
      'Brick clamp',
      'Brick hod',
      'Brickwork',
      'Bridge management system',
      'Building control body',
      'Building envelope',
      'Scabbling',
      'Screed',
      'Sediment basin',
      'Sediment control',
      'Seismic retrofit',
      'Set-off (architecture)',
      'Shear wall',
      'Silt fence',
      'Site manager',
      'Slip forming',
      'Slipform stonemasonry',
      'Snow knife',
      'Sod Solutions',
      'Soft infrastructure',
      'Soft story building',
      'Solid ground floor',
      'Stabilization',
      'Staff (building material)',
      'Staggered truss system',
      'Steel building',
      'Steel frame',
      'Straw-bale construction',
      'Strongback (girder)',
      'Structural repairs',
    ];

    return SingleChildScrollView(
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        alignment: WrapAlignment.spaceAround,
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
      borderRadius: BorderRadius.circular(8),
      onTap: () {},
      highlightColor: Theme.of(context).primaryColorLight,
      child: Container(
        foregroundDecoration: _notSelectedBoxDecoration,
        child: Text(
          name,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
        padding: const EdgeInsets.all(8),
        decoration: isSelected
            ? _selectedBoxDecoration(context)
            : _notSelectedBoxDecoration,
      ),
    );
  }

  BoxDecoration _selectedBoxDecoration(BuildContext context) => BoxDecoration(
      color: Theme.of(context).accentColor,
      borderRadius: BorderRadius.circular(8));

  BoxDecoration get _notSelectedBoxDecoration => BoxDecoration(
      border: Border.all(color: Colors.black.withAlpha(40)),
      borderRadius: BorderRadius.circular(8));
}
