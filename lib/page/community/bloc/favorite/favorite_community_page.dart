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

import 'package:Sarh/page/community/bloc/favorite/bloc.dart';
import 'package:Sarh/page/community/bloc/post/bloc.dart';
import 'package:Sarh/widget/ui_state/empty_widget.dart';
import 'package:Sarh/widget/ui_state/network_error_widget.dart';
import 'package:Sarh/widget/ui_state/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../../dependency_provider.dart';

class FavoriteCommunityPage extends StatefulWidget {


  @override
  _FavoriteCommunityPageState createState() => _FavoriteCommunityPageState();
}

class _FavoriteCommunityPageState extends State<FavoriteCommunityPage> {

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
        if (state is OnLoadingFavoritePost) {
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
          var galleryItems = state.posts;
          return Expanded(
            child: new StaggeredGridView.countBuilder(
              addAutomaticKeepAlives: true,
              key: PageStorageKey(10),
              padding: const EdgeInsets.only(bottom: 80),
              crossAxisCount: 4,
              itemCount: galleryItems.length,
              itemBuilder: (BuildContext context, int index) => InkWell(
                onTap: () {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => CompanyGalleryPage(
//                          galleryItem: state.posts[index])));
                },
//                child: CachedNetworkImage(
//                  key: ObjectKey(galleryItems[index].id),
//                  imageUrl: galleryItems[index].img,
//                  fit: BoxFit.cover,
//                  placeholderFadeInDuration: Duration(milliseconds: 200),
//                ),
              ),
              staggeredTileBuilder: (int index) =>
              new StaggeredTile.fit(2),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
          );
        }
        return Container();
      },

    );
  }
}
