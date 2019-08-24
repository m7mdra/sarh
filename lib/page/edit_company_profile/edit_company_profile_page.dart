import 'package:Sarh/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditCompanyProfilePage extends StatefulWidget {
  @override
  _EditCompanyProfilePageState createState() => _EditCompanyProfilePageState();
}

class _EditCompanyProfilePageState extends State<EditCompanyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: BackButtonNoLabel(Colors.grey),
        title: Text(
          'Profile settings',
          style: TextStyle(inherit: true, color: Colors.grey),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            onTap: () {},
            leading: Icon(FontAwesomeIcons.solidIdCard,
                color: Theme.of(context).accentColor),
            title: Text('Company information'),
          ),
          _divder,
          ListTile(
            onTap: () {},
            leading: Icon(
              FontAwesomeIcons.phoneAlt,
              color: Theme.of(context).accentColor,
            ),
            title: Text('Contact information'),
          ),
          _divder,
          ListTile(
            onTap: () {},
            leading: Icon(FontAwesomeIcons.userShield,
                color: Theme.of(context).accentColor),
            title: Text('Authorizated From'),
          ),
          _divder,
          ListTile(
            onTap: () {},
            leading: Icon(FontAwesomeIcons.solidStar,
                color: Theme.of(context).accentColor),
            title: Text('Featured clients'),
          ),
          _divder,
          ListTile(
            onTap: () {},
            leading: Icon(FontAwesomeIcons.solidImages,
                color: Theme.of(context).accentColor),
            title: Text('Gallery'),
          ),
          _divder,
          ListTile(
            onTap: () {},
            leading: Icon(FontAwesomeIcons.userCog,
                color: Theme.of(context).accentColor),
            title: Text('Account'),
          ),
          _divder,
          ListTile(
            onTap: () {},
            leading: Icon(FontAwesomeIcons.hashtag,
                color: Theme
                    .of(context)
                    .accentColor),
            title: Text('Social media'),
          ),
          _divder,
          ListTile(
            onTap: () {},
            leading: Icon(FontAwesomeIcons.infoCircle,
                color: Theme.of(context).accentColor),
            title: Text('About Sarh'),
          ),
          _divder,
          ListTile(
            leading: Icon(FontAwesomeIcons.code,
                color: Theme.of(context).accentColor),
            title: Text('Sarh'),
            subtitle: Text('Version 1.0'),
          ),
          _divder,
        ],
      ),
    );
  }

  Divider get _divder => Divider(
        height: 1,
      );
}
