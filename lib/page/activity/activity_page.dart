import 'package:Sarh/data/model/category.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:flutter/material.dart';

class ActivityPage extends StatefulWidget {
  final Category parentCategory;

  const ActivityPage({Key key, this.parentCategory}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
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
