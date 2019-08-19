import 'package:Sarh/widget/back_button_widget.dart';
import 'package:Sarh/widget/media_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ModifyProfileImagePage extends StatefulWidget {
  @override
  _ModifyProfileImagePageState createState() => _ModifyProfileImagePageState();
}

class _ModifyProfileImagePageState extends State<ModifyProfileImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          BackButtonWidget(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Hero(
                  tag: 'profile_image',
                  child: Container(
                    width: 180,
                    height: 180,
                    child: Icon(
                      Icons.camera_alt,
                      size: 50,
                      color: Colors.grey,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              RaisedButton.icon(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => MediaPickDialog());
                },
                label: Text('Update image'),
                icon: Icon(FontAwesomeIcons.image),
              )
            ],
          ),
        ],
      )),
    );
  }
}
