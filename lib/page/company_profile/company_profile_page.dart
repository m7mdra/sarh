import 'dart:math';

import 'package:Sarh/page/edit_company_profile/edit_company_profile_page.dart';
import 'package:Sarh/page/profile_image_modify/modify_profile_image_page.dart';
import 'package:Sarh/size_config.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CompanyProfilePage extends StatefulWidget {
  @override
  _CompanyProfilePageState createState() => _CompanyProfilePageState();
}

class _CompanyProfilePageState extends State<CompanyProfilePage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _appbarAndHeader(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: <Widget>[
                  Text(
                    'About',
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text(
                      '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem industry's standard dummy text ever since the 1500stext ever since the 1500stext.'''),
                  _divider,
                  Text(
                    'Company activites',
                    style: Theme.of(context).textTheme.title,
                  ),
                  Wrap(
                    spacing: 1,
                    runSpacing: 0,
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      Chip(label: Text('Construction')),
                      Chip(label: Text('Anything')),
                      Chip(label: Text('Anything')),
                      Chip(label: Text('Anything')),
                      Chip(label: Text('Anything')),
                      Chip(label: Text('Anything')),
                    ],
                  ),
                  _divider,
                  Text(
                    'Contact information',
                    style: Theme.of(context).textTheme.title,
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.all(0),
                    leading: Icon(
                      FontAwesomeIcons.mobile,
                      color: Theme.of(context).accentColor,
                    ),
                    title: Text('+971 56 887 8888'),
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.all(0),
                    leading: Icon(
                      FontAwesomeIcons.phone,
                      color: Theme.of(context).accentColor,
                    ),
                    title: Text('+971 21 887 8888'),
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.all(0),
                    leading: Icon(
                      FontAwesomeIcons.solidEnvelope,
                      color: Theme.of(context).accentColor,
                    ),
                    title: Text('info@takween.com'),
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.all(0),
                    leading: Icon(
                      FontAwesomeIcons.solidMap,
                      color: Theme.of(context).accentColor,
                    ),
                    title: Text('Hotel Sofitel, Abu Dhabi\n23100 Abu Dhabi '),
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.all(0),
                    leading: Icon(
                      FontAwesomeIcons.globe,
                      color: Theme.of(context).accentColor,
                    ),
                    title: Text('www.takweeneng.com'),
                  ),
                  _heightSizedBox(),
                  Row(
                    children: <Widget>[
                      SocialMediaTile(
                        backgroundColor: Color(0xff20b4f5),
                        iconData: FontAwesomeIcons.twitter,
                      ),
                      SocialMediaTile(
                        backgroundColor: Color(0xff4a90fa),
                        iconData: FontAwesomeIcons.facebook,
                      ),
                      SocialMediaTile(
                        backgroundColor: Color(0xffff9898),
                        iconData: FontAwesomeIcons.instagram,
                      ),
                      SocialMediaTile(
                        backgroundColor: Color(0xff0066ff),
                        iconData: FontAwesomeIcons.behance,
                      ),
                      SocialMediaTile(
                        backgroundColor: Color(0xff37c2ff),
                        iconData: FontAwesomeIcons.linkedin,
                      ),
                    ],
                  ),
                  _divider,
                  Text(
                    'Authorized from',
                    style: Theme.of(context).textTheme.title,
                  ),
                  Container(
                    height: 110,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/logo/logo.png',
                              width: 120,
                              height: 100,
                            ),
                          ),
                        );
                      },
                      itemCount: 5,
                    ),
                  ),
                  _divider,
                  Text(
                    'Featured projects',
                    style: Theme.of(context).textTheme.title,
                  ),
                  _heightSizedBox(),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 4,
                    runSpacing: 4,
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        width: 120,
                        height: 100,
                        color: Colors.red,
                      ),
                      Container(
                        width: 120,
                        height: 100,
                        color: Colors.red,
                      ),
                      Container(
                        width: 120,
                        height: 100,
                        color: Colors.red,
                      ),
                      Container(
                        width: 120,
                        height: 100,
                        color: Colors.red,
                      ),
                      Container(
                        width: 120,
                        height: 100,
                        color: Colors.red,
                      ),
                      Container(
                        width: 120,
                        height: 100,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  _divider,
                  Text(
                    'Customers Reviews',
                    style: Theme.of(context).textTheme.title,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('12 Reviews'),
                      RaisedButton.icon(
                        onPressed: () {},
                        label: Text('Add a review'),
                        icon: Icon(FontAwesomeIcons.paperPlane),
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (BuildContext context, int index) {
                      return ReviewTileWidget();
                    },
                    itemCount: 4,
                  ),
                  RaisedButton(
                    onPressed: () {},
                    child: Text('More & Add comments'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Divider get _divider => const Divider(
        color: Colors.black38,
      );

  Card _appbarAndHeader(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16))),
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background/background.jpg'),
                    fit: BoxFit.cover)),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    BackButtonWidget(),
                    FlatButton.icon(
                      icon: Icon(
                        FontAwesomeIcons.userCog,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditCompanyProfilePage()));
                      },
                      textColor: Colors.white,
                      label: Text('Profile settings'),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ModifyProfileImagePage();
                          }));
                        },
                        child: Hero(
                          tag: 'profile_image',
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 30,
                            height: SizeConfig.blockSizeVertical * 20,
                            child: Icon(
                              Icons.camera_alt,
                              size: 30,
                              color: Colors.grey,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      _widthSizedBox(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Takween Enginering',
                            style: Theme.of(context)
                                .textTheme
                                .title
                                .copyWith(color: Colors.white),
                          ),
                          _heightSizedBox(),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                                text: 'Category',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(color: Colors.white)),
                            TextSpan(
                                text: ' / ',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: 'Subcategory',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(color: Colors.white)),
                          ])),
                          _heightSizedBox(),
                          Row(
                            children: <Widget>[
                              IgnorePointer(
                                child: RatingBar(
                                  itemSize: 15,
                                  itemCount: 5,
                                  initialRating: 3,
                                  glowColor: Colors.yellow,
                                  unratedColor: Colors.yellow,
                                  glow: true,
                                  ratingWidget: RatingWidget(
                                      full: Icon(
                                        FontAwesomeIcons.solidStar,
                                        color: Colors.yellow,
                                      ),
                                      half: Icon(
                                        FontAwesomeIcons.starHalf,
                                        color: Colors.yellow,
                                      ),
                                      empty: Icon(
                                        FontAwesomeIcons.star,
                                        color: Colors.yellow,
                                      )),
                                  itemPadding: const EdgeInsets.all(2),
                                  onRatingUpdate: (double rating) {},
                                ),
                              ),
                              _widthSizedBox(),
                              Text(
                                '+20',
                                style: Theme.of(context)
                                    .textTheme
                                    .body1
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _heightSizedBox() {
    return const SizedBox(
      height: 4,
    );
  }

  SizedBox _widthSizedBox() {
    return const SizedBox(
      width: 8,
    );
  }
}

class SocialMediaTile extends StatelessWidget {
  final Color backgroundColor;
  final IconData iconData;

  const SocialMediaTile({Key key, this.backgroundColor, this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 4, right: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: backgroundColor,
      ),
      padding: const EdgeInsets.all(8),
      child: Icon(
        iconData,
        color: Colors.white,
      ),
    );
  }
}

class ReviewTileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      isThreeLine: true,
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/logo/logo.png'),
      ),
      title: Text('Mohamed sed ahmed'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry'),
          Text(
            '${Random().nextInt(24)}hours ago',
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }
}
