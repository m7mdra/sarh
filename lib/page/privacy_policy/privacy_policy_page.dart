import 'package:Sarh/widget/back_button_widget.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy policy'),
        centerTitle: true,
        leading: BackButtonNoLabel(Colors.white),
      ),
    );
  }

  static navigate(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => PrivacyPolicyPage()));
  }
}
