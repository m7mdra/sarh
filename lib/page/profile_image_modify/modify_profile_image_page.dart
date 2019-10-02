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

import 'package:Sarh/dependency_provider.dart';
import 'package:Sarh/page/profile_image_modify/bloc/modify_profile_image_event.dart';
import 'package:Sarh/page/profile_image_modify/bloc/modify_profile_image_state.dart';
import 'package:Sarh/size_config.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:Sarh/widget/media_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/modify_profile_image_bloc.dart';

class ModifyProfileImagePage extends StatefulWidget {
  @override
  _ModifyProfileImagePageState createState() => _ModifyProfileImagePageState();
}

class _ModifyProfileImagePageState extends State<ModifyProfileImagePage> {
  ModifyProfileImageBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = ModifyProfileImageBloc(
        DependencyProvider.provide(), DependencyProvider.provide());
    _bloc.dispatch(Load());
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                child: BlocBuilder(
                  bloc: _bloc,
                  builder: (context, state) {
                    print(state);
                    if (state is Loading) {
                      return CircularProgressIndicator();
                    }
                    if (state is ImageLoaded) {
                      return _buildProfileImage(state.imageUrl);
                    }
                    if (state is Idle) {
                      return _buildProfileImage(state.url);
                    }
                    if (state is Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container();
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              RaisedButton.icon(
                onPressed: () async {
                  var file = await showDialog(
                      context: context,
                      builder: (context) => MediaPickDialog());
                  if (file != null) _bloc.dispatch(Modify(file));
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

  Hero _buildProfileImage(String url) {
    return Hero(
      tag: 'profile_image',
      child: Container(
        child: ClipOval(
          child: Container(
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.network(
                  url,
                  width: SizeConfig.blockSizeHorizontal * 50,
                  height: SizeConfig.blockSizeHorizontal * 50,
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
    );
  }
}
