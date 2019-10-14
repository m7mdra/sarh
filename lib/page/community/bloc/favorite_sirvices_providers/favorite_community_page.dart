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

import 'package:Sarh/page/search/search_result_page.dart';

import './bloc.dart';
import 'package:Sarh/page/community/community_page.dart';
import 'package:Sarh/widget/ui_state/empty_widget.dart';
import 'package:Sarh/widget/ui_state/network_error_widget.dart';
import 'package:Sarh/widget/ui_state/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../dependency_provider.dart';

class FavoriteCommunityCompaniesPage extends StatefulWidget {
  @override
  _FavoriteCommunityPageState createState() => _FavoriteCommunityPageState();
}

class _FavoriteCommunityPageState extends State<FavoriteCommunityCompaniesPage> {
  FavoritePostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _postBloc = FavoritePostBloc(DependencyProvider.provide());
    _loadPosts();
  }

  void _loadPosts() => _postBloc.dispatch(OnLoadingFavoritePost());

  @override
  void dispose() {
    super.dispose();
    _postBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _postBloc,
      builder: (context, state) {
        print("init22");

        print(state);

        if (state is OnLoading) {
          return Center(
            child: ProgressBar(),
          );
        }
        if (state is FavoritePostsNetworkError) {
          return Center(
            child: NetworkErrorWidget(onRetry: () => _loadPosts()),
          );
        }
        if (state is FavoritePostsEmpty) {
          return Center(child: EmptyWidget());
        }
        if (state is OnLoaded) {
          var favoritePosts = state.posts;
          print(favoritePosts);
          return RefreshIndicator(
            onRefresh: (){
              _loadPosts();
              return Future.value(null);
            },
            child: ListView.builder(
              itemBuilder: (context, index) {          
               return CompanyWidget(company:favoritePosts[index] ,);
              },
              itemCount: favoritePosts.length,
            ),
          );
        }


        return Container();
      },
    );
  }
}
