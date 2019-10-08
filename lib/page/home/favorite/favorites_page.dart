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

import 'package:Sarh/page/community/community_page.dart';
import 'package:Sarh/page/search/search_result_page.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Theme.of(context).primaryColor,
          tabs: [
            Tab(
              text: 'Service Providers',
            ),
            Tab(
              text: 'Community posts',
            ),
          ],
          controller: _tabController,
        ),
        Expanded(
          child: TabBarView(
            children: [
              ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (BuildContext context, int index) {
                  return CompanyWidget();
                },
                itemCount: 10,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ),

              /*** Bloc Listener ****/



              /*** Bloc Listener ****/

              ListView.builder(
                padding: const EdgeInsets.all(16),
                itemBuilder: (BuildContext context, int index) {
                  return CommunityPostWidget();
                },
                itemCount: 10,
              ),
            ],
            controller: _tabController,
          ),
        )
      ],
    ));
  }
}
