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

import 'package:Sarh/data/model/post.dart';
import 'package:Sarh/dependency_provider.dart';
import 'package:Sarh/i10n/app_localizations.dart';
import 'package:Sarh/page/community/bloc/post/bloc.dart';
import 'package:Sarh/page/login/login_page.dart';
import 'package:Sarh/widget/attachment_widget.dart';

import 'package:Sarh/widget/file_picker_sheet_modal.dart';
import 'package:Sarh/widget/progress_dialog.dart';
import 'package:Sarh/widget/tag_picker_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/add_post/bloc.dart';

class AdCommunityPostPage extends StatefulWidget {
  @override
  _AdCommunityPostPageState createState() => _AdCommunityPostPageState();
}

class _AdCommunityPostPageState extends State<AdCommunityPostPage> {
  List<AttachmentFile> attachments = []..addAll([null, null, null]);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey();
  var _tags = <Tag>{};
  AddPostBloc _addPostBloc;
  TextEditingController _titleTextEditingController;
  TextEditingController _bodyTextEditingController;

  @override
  void initState() {
    super.initState();
    _addPostBloc = AddPostBloc(DependencyProvider.provide());
    _titleTextEditingController = TextEditingController();
    _bodyTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _addPostBloc.dispose();
  }

  void _showSnackBar(SnackBar snackBar) {
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  SnackBarAction get _retrySnackBarAction => SnackBarAction(
        onPressed: () => _submitPost(),
        label: 'Retry',
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).newPost),
      ),
      body: BlocListener(
        bloc: _addPostBloc,
        listener: (context, state) {
          if (state is LoadingState) {
            showDialog(
                context: context,
                builder: (context) => ProgressDialog(
                      message: 'Wait while add post to community...',
                    ),
                barrierDismissible: false);
          }
          if (state is ErrorState) {
            pop(context);

            _showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text('Failed to add post. try again'),
              action: _retrySnackBarAction,
            ));
          }
          if (state is SessionExpiredState) {
            pop(context);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          }
          if (state is SuccessState) {
            pop(context);
            BlocProvider.of<PostBloc>(context)
                .dispatch(OnNewPostAdded(state.post));
            pop(context);
          }
          if (state is TimeoutState || state is NetworkErrorState) {
            pop(context);
            _showSnackBar(SnackBar(
              backgroundColor: Colors.grey,
              content: Text('No active connection found. try again'),
              action: _retrySnackBarAction,
            ));
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _sizedBox(),
                Text(
                  'Post Title',
                ),
                _sizedBox(),
                TextFormField(
                  controller: _titleTextEditingController,
                  maxLines: 1,
                  validator: (title) {
                    if (title.isEmpty) {
                      return 'Post title can not be empty';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(12)),
                ),
                _sizedBox(),
                Text(
                  'Post Body',
                ),
                _sizedBox(),
                TextFormField(
                  controller: _bodyTextEditingController,
                  maxLines: 5,
                  validator: (body) {
                    if (body.isEmpty) {
                      return 'Post body can not be empty';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Explain what you want to quary about...',
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(12)),
                ),
                _sizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Tags'),
                    FlatButton(
                        onPressed: () async {
                          var tags = await showDialog<List<Tag>>(
                              context: _scaffoldKey.currentContext,
                              builder: (context) => TagSelectorDialog());
                          if (tags != null && tags.isNotEmpty) {
                            setState(() {
                              _tags.addAll(tags);
                            });
                          }
                        },
                        child: Text('Add tag'))
                  ],
                ),
                Container(
                  height: _tags.isEmpty ? 0 : 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Chip(
                        label: Text(_tags.toSet().toList()[index].name),
                        onDeleted: () {
                          setState(() {
                            _tags.remove(_tags.toList()[index]);
                          });
                        },
                      );
                    },
                    itemCount: _tags.length,
                  ),
                ),
                _sizedBox(),
                Container(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return AttachmentWidget(
                        attachments[index],
                        key: ObjectKey('Media$index'),
                        onRemove: () {
                          setState(() {
                            attachments.removeAt(index);
                          });
                        },
                      );
                    },
                    shrinkWrap: true,
                    itemCount: attachments.length,
                  ),
                ),
                _sizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton.icon(
                        onPressed: () => _submitPost(),
                        icon: Icon(FontAwesomeIcons.paperPlane),
                        label: Text(AppLocalizations.of(context).submitButton)),
                    FlatButton.icon(
                        onPressed: () async {
                          var file = await showFilePickDialog<AttachmentFile>(
                              context: context);
                          if (file != null)
                            setState(() {
                              attachments.removeWhere(
                                  (attachment) => attachment == null);
                              attachments.add(file);
                            });
                        },
                        icon: Icon(Icons.attach_file),
                        label:
                            Text(AppLocalizations.of(context).attachFileButton))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitPost() {
    if (_formKey.currentState.validate()) {
      _addPostBloc.dispatch(SubmitPost(
          _titleTextEditingController.text,
          _bodyTextEditingController.text,
          attachments
              .where((attachment) => attachment != null)
              .map((attachment) => attachment.file)
              .toList(),
          _tags.map((tag) => tag.name).toList()));
    }
  }

  void pop(BuildContext context) {
    Navigator.pop(context);
  }

  SizedBox _sizedBox() {
    return const SizedBox(
      height: 8,
    );
  }
}
