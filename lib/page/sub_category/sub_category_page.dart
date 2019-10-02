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
import 'package:Sarh/page/activity/activity_page.dart';
import 'package:Sarh/page/home/category/category_page.dart';
import 'package:Sarh/page/sub_category/bloc/bloc.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:Sarh/widget/ui_state.dart';
import 'package:Sarh/widget/ui_state/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubCategoryPage extends StatefulWidget {
  final Category parentCategory;

  const SubCategoryPage({Key key, this.parentCategory}) : super(key: key);

  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  SubCategoryBloc _subCategoryBloc;

  @override
  void initState() {
    super.initState();
    _subCategoryBloc = SubCategoryBloc(DependencyProvider.provide());
    _loadData();
  }

  void _loadData() =>
      _subCategoryBloc.dispatch(LoadSubCategories(widget.parentCategory.id));

  @override
  void dispose() {
    super.dispose();
    _subCategoryBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var category = widget.parentCategory;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButtonNoLabel(Colors.white),
        title: Text(Localizations.localeOf(context).languageCode == 'ar'
            ? category.nameAr
            : category.nameEn),
      ),
      body: BlocBuilder(
        bloc: _subCategoryBloc,
        builder: (context, state) {
          if (state is SubCategoryLoading) {
            return Center(
              child: ProgressBar(),
            );
          }
          if (state is SubCategoryNetworkError) {
            return Center(
              child: NetworkErrorWidget(onRetry: () => _loadData()),
            );
          }
          if (state is SubCategoryEmpty) {
            return Center(child: EmptyWidget());
          }
          if (state is SubCategorySuccess) {
            return RefreshIndicator(
              onRefresh: () {
                _loadData();
                return Future.value(null);
              },
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    childAspectRatio: 1),
                itemBuilder: (BuildContext context, int index) {
                  return CategoryWidget(
                    state.categoryList[index],
                    onCategoryTap: (category) {
                      if (category.hasDescendant) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SubCategoryPage(parentCategory: category);
                        }));
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ActivityPage(parentCategory: category);
                        }));
                      }
                    },
                  );
                },
                itemCount: state.categoryList.length,
              ),
            );
          }
          if (state is SubCategoryError || state is SubCategoryTimeout) {
            return Center(
              child: GeneralErrorWidget(onRetry: () => _loadData()),
            );
          }
          return Container();
        },
      ),
    );
  }
}
