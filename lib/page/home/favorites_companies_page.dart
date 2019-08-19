import 'package:Sarh/page/community/community_page.dart';
import 'package:Sarh/page/search/search_result_page.dart';
import 'package:flutter/material.dart';

class FavoriteCompaniesPage extends StatefulWidget {
  @override
  _FavoriteCompaniesPageState createState() => _FavoriteCompaniesPageState();
}

class _FavoriteCompaniesPageState extends State<FavoriteCompaniesPage>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
