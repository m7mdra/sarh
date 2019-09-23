import 'package:Sarh/data/model/category.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:flutter/material.dart';

class SubCategoryPage extends StatefulWidget {
  final Category parentCategory;

  const SubCategoryPage({Key key, this.parentCategory}) : super(key: key);

  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  @override
  Widget build(BuildContext context) {
    var category = widget.parentCategory;
    return Scaffold(
      appBar: AppBar(
        leading: BackButtonNoLabel(Colors.white),
        title: Text(Localizations.localeOf(context).languageCode == 'ar'
            ? category.nameAr
            : category.nameEn),
      ),
    );
  }
}
