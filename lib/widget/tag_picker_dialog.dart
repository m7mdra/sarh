
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
import 'package:Sarh/page/add_community_post/bloc/tags/bloc.dart';
import 'package:Sarh/page/add_community_post/bloc/tags/tags_bloc.dart';
import 'package:Sarh/widget/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../dependency_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagSelectorDialog extends StatefulWidget {
  @override
  _TagSelectorDialogState createState() => _TagSelectorDialogState();
}

class _TagSelectorDialogState extends State<TagSelectorDialog> {
  TagsBloc _tagsBloc;
  Map<int, Tag> _selectedTags = {};
  TextEditingController _tagsTextEditingController;

  @override
  void initState() {
    super.initState();
    _tagsTextEditingController = TextEditingController();
    _tagsBloc = TagsBloc(DependencyProvider.provide());
  }

  @override
  void dispose() {
    super.dispose();
    _tagsBloc.dispose();
    _tagsTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
                controller: _tagsTextEditingController,
                onChanged: (tag) {
                  _tagsBloc.dispatch(FindTagWithName(tag));
                },
                decoration: InputDecoration.collapsed(hintText: '').copyWith(
                    labelText: 'Search for tags',
                    prefixIcon: Icon(FontAwesomeIcons.search),
                    filled: false,
                    border: UnderlineInputBorder())),
            Expanded(
              child: BlocBuilder(
                builder: (context, state) {
                  if (state is TagsLoading) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: ProgressBar(),
                      ),
                    );
                  }
                  if (state is TagsEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          Text('Tag not found',style: Theme.of(context).textTheme.title,),
                          Text("Tap on button below to add as a tag"),
                          RaisedButton(
                            onPressed: () {
                              Navigator.pop(context, <Tag>[
                                Tag.name(_tagsTextEditingController.text)
                              ]);
                            },
                            child: Text('Add tag'),
                          )
                        ],
                      ),
                    );
                  }
                  if (state is TagsLoaded) {
                    var tags = state.tags;
                    return Wrap(
                      spacing: 4,
                      children: tags
                          .map((tag) => ChoiceChip(
                                label: Text(tag.name),
                                selected: _selectedTags.containsKey(tag.id),
                                onSelected: (selected) {
                                  if (selected) {
                                    _selectedTags[tag.id] = tag;
                                  } else {
                                    _selectedTags.remove(tag.id);
                                  }
                                  setState(() {});
                                },
                              ))
                          .toList(),
                    );
                  }
                  if (state is TagsError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GeneralErrorWidget(
                        onRetry: () {
                          _tagsBloc.dispatch(
                              FindTagWithName(_tagsTextEditingController.text));
                        },
                      ),
                    );
                  }
                  if (state is TagsTimeout || state is TagsNetworkError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NetworkErrorWidget(
                        onRetry: () {
                          _tagsBloc.dispatch(
                              FindTagWithName(_tagsTextEditingController.text));
                        },
                      ),
                    );
                  }
                  return Container();
                },
                bloc: _tagsBloc,
              ),
            ),
            Row(
              children: <Widget>[
                FlatButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel')),
                FlatButton(
                  onPressed: _selectedTags.isEmpty
                      ? null
                      : () {
                          Navigator.pop(context, _selectedTags.values.toList());
                        },
                  child: Text('Select'),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
