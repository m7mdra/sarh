/*
 * Copyright (c) 2019.
 *           ______             _
 *          |____  |           | |
 *  _ __ ___    / / __ ___   __| |_ __ __ _
 * | '_ ` _ \  / / '_ ` _ \ / _` | '__/ _` |
 * | | | | | |/ /| | | | | | (_| | | | (_| |
 * |_| |_| |_/_/ |_| |_| |_|\__,_|_|  \__,_|
 *
 *
 *
 *
 */

import 'package:Sarh/data/model/user.dart';
import 'package:Sarh/dependency_provider.dart';
import 'package:Sarh/page/community/community_page.dart';
import 'package:Sarh/page/profile_image_modify/modify_profile_image_page.dart';
import 'package:Sarh/size_config.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  UserProfileBloc _userProfileBloc =
      UserProfileBloc(DependencyProvider.provide());

  @override
  Widget build(BuildContext context) {
    _userProfileBloc.dispatch(LoadProfile());
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder(
          bloc: _userProfileBloc,
          builder: (BuildContext context, state) {
            print(state);
            if (state is ProfileLoaded) {
              var user = state.user;
              return _buildUserDetails(context, user);
            }

            return Container();
          },
        ),
      ),
    );
  }

  Column _buildUserDetails(BuildContext context, User user) {
    return Column(
      children: <Widget>[
        _appbarAndHeader(context, user),
        Expanded(
            child: ListView(
          children: <Widget>[
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
              title: Text(user.phone),
            ),
            ListTile(
              dense: true,
              contentPadding: const EdgeInsets.all(0),
              leading: Icon(
                FontAwesomeIcons.solidEnvelope,
                color: Theme.of(context).accentColor,
              ),
              title: Text(user.username),
            ),
            ListTile(
              dense: true,
              contentPadding: const EdgeInsets.all(0),
              leading: Icon(
                FontAwesomeIcons.solidMap,
                color: Theme.of(context).accentColor,
              ),
              title: Text(user.city.name),
            ),
            Text(
              'Last posts',
              style: Theme.of(context).textTheme.title,
            ),
/*            ListView(
              children: <Widget>[
                CommunityPostWidget(
                  showBottomActionButtons: false,
                ),
                CommunityPostWidget(
                  showBottomActionButtons: false,
                ),
              ],
              shrinkWrap: true,
              primary: false,
            )*/
          ],
          padding: const EdgeInsets.all(16),
        )),
      ],
    );
  }

  Card _appbarAndHeader(BuildContext context, User user) {
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
/*                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditCompanyProfilePage()));*/
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
                            return BlocProvider(
                              child: ModifyProfileImagePage(),
                              builder: (BuildContext context) {
                                return _userProfileBloc;
                              },
                            );
                          }));
                        },
                        child: Hero(
                          tag: 'profile_image',
                          child: Container(
                            child: ClipOval(
                              child: Container(
                                color: Colors.white,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Image.network(
                                      user.image,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 30,
                                      height:
                                          SizeConfig.blockSizeHorizontal * 30,
                                      fit: BoxFit.cover,
                                    ),
                                    Icon(
                                      Icons.camera_alt,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
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
                            user.fullName,
                            style: Theme.of(context)
                                .textTheme
                                .title
                                .copyWith(color: Colors.white),
                          ),
                          _heightSizedBox(),
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
