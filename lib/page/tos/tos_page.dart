import 'package:Sarh/widget/back_button_widget.dart';
import 'package:flutter/material.dart';

class TosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms of coniditons'),
        centerTitle: true,
        leading: BackButtonNoLabel(Colors.white),
      ),
    );
  }

  static navigate(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return TosPage();
    }));
  }
}
