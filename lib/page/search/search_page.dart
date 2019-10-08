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

import 'package:Sarh/data/model/category.dart';
import 'package:Sarh/dependency_provider.dart';
import 'package:Sarh/page/home/category/bloc/category_bloc.dart';
import 'package:Sarh/page/home/category/bloc/category_event.dart';
import 'package:Sarh/page/home/category/bloc/category_state.dart';
import 'package:Sarh/page/search/search_result_page.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:Sarh/widget/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  CategoryBloc _categoryBloc;

  @override
  void initState() {
    super.initState();
    _categoryBloc = CategoryBloc(DependencyProvider.provide());
    _categoryBloc.dispatch(LoadCategories());
  }

  @override
  void dispose() {
    super.dispose();
    _categoryBloc.dispose();
  }

  void _dispatchLoadEvent() => _categoryBloc.dispatch(LoadCategories());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  BackButtonNoLabel(Theme.of(context).accentColor),
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        suffixIcon: Icon(
                          FontAwesomeIcons.search,
                          size: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        hintText: 'Search...',
                        contentPadding: const EdgeInsets.all(12)),
                  )),
                ],
              ),
              BlocBuilder(
                bloc: _categoryBloc,
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: ProgressBar(),
                    );
                  }
                  if (state is CategoryNetworkError) {
                    return Center(
                      child: NetworkErrorWidget(
                        onRetry: () {
                          _dispatchLoadEvent();
                        },
                      ),
                    );
                  }
                  if (state is CategoryError) {
                    return Center(child: GeneralErrorWidget(
                      onRetry: () {
                        _dispatchLoadEvent();
                      },
                    ));
                  }
                  if (state is CategorySuccess) {
                    var categoryList = state.categoryList;
                    return Expanded(
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return buildDivider();
                        },
                        itemCount: categoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SearchSuggestionListTile(
                            category: categoryList[index],
                            onSuggestionClicked: (category) {
                              print(category.toJson());
                            },
                          );
                        },
                      ),
                    );
                  }
                  if (state is CategoryEmpty) {
                    return Center(child: EmptyWidget());
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Divider buildDivider() => const Divider(
        height: 1,
      );
}

class SearchSuggestionListTile extends StatelessWidget {
  final Category category;
  final ValueChanged<Category> onSuggestionClicked;

  const SearchSuggestionListTile(
      {Key key, this.category, this.onSuggestionClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onSuggestionClicked(category),
      title: Text.rich(TextSpan(text: 'Search in ', children: [
        TextSpan(
            text: Localizations.localeOf(context).languageCode == 'ar'
                ? category.nameAr
                : category.nameEn,
            style: Theme.of(context)
                .textTheme
                .body1
                .copyWith(fontWeight: FontWeight.bold, color: Colors.black))
      ])),
    );
  }
}
