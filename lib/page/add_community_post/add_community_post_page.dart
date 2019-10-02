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
import 'package:Sarh/page/add_community_post/bloc/tags/tags_bloc.dart';
import 'package:Sarh/widget/attachment_widget.dart';
import 'package:Sarh/widget/auto_complete_text_field.dart';

import 'package:Sarh/widget/file_picker_sheet_modal.dart';
import 'package:Sarh/widget/tag_picker_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';


class AdCommunityPostPage extends StatefulWidget {
  @override
  _AdCommunityPostPageState createState() => _AdCommunityPostPageState();
}

class _AdCommunityPostPageState extends State<AdCommunityPostPage> {
  List<AttachmentFile> attachments = []..addAll([null, null, null]);

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  var _tags = <Tag>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).newPost),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _sizedBox(),
              Text(
                'Post Body',
              ),
              _sizedBox(),
              TextFormField(
                maxLines: 5,
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
                      onPressed: () {},
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
    );
  }

  SizedBox _sizedBox() {
    return const SizedBox(
      height: 8,
    );
  }
}
