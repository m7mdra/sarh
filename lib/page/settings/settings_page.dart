import 'package:Sarh/widget/center_titled_appbar.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CenteredTitleAppbar(
      title: 'Settings',
    ));
  }
}
