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
import 'package:Sarh/page/community/bloc/like/bloc.dart';
import 'package:Sarh/page/login/login_page.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:Sarh/widget/ui_state.dart';
import 'package:Sarh/widget/ui_state/progress_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Sarh/page/add_community_post/add_community_post_page.dart';

import 'bloc/post/bloc.dart';

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  PostBloc _postBloc;
  bool _showFab = false;
  LikeBloc _likeBloc;

  @override
  void initState() {
    super.initState();
    _postBloc = PostBloc(DependencyProvider.provide());
    _likeBloc = LikeBloc(DependencyProvider.provide(), _postBloc);
    _loadPosts();
  }

  void _loadPosts() => _postBloc.dispatch(LoadPosts());

  @override
  void dispose() {
    super.dispose();
    _postBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Community'),
        centerTitle: true,
        leading: BackButtonNoLabel(Colors.white),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (_showFab)
            FloatingActionButton(
              heroTag: 'fabAdd',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BlocProvider(
                    child: AdCommunityPostPage(),
                    builder: (context) {
                      return _postBloc;
                    },
                  );
                }));
              },
              child: Icon(FontAwesomeIcons.plus),
            ),
        ],
      ),
      body: SafeArea(
          child: BlocListener(
        bloc: _postBloc,
        listener: (context, state) {
          if (state is PostsLoaded) {
            setState(() {
              _showFab = true;
            });
          }
        },
        child: ListView(
          primary: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
              child: TextField(
                  decoration: InputDecoration.collapsed(
                          hintText: 'Search ...',
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none))
                      .copyWith(
                contentPadding: const EdgeInsets.all(9),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                'Latest Posts',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Container(
              height: 50,
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsetsDirectional.only(start: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsetsDirectional.only(end: 4),
                    child: Chip(label: Text('Category${index + 1}')),
                  );
                },
                itemCount: 10,
              ),
            ),
            BlocListener(
              bloc: _postBloc,
              listener: (context, state) {
                if (state is PostsSessionExpired) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                }
              },
              child: BlocBuilder(
                builder: (context, state) {
                  if (state is PostsLoaded) {
                    _showFab = true;
                    var posts = state.posts;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return CommunityPostWidget(
                          onShare: (post) {},
                          onComment: (post) {},
                          onLike: (post) {
                            _likeBloc.dispatch(ToggleLikePostById(post));
                          },
                          key: ValueKey(posts[index].id),
                          post: posts[index],
                        );
                      },
                      itemCount: posts.length,
                      shrinkWrap: true,
                      primary: false,
                      addAutomaticKeepAlives: false,
                      padding: const EdgeInsets.only(bottom: 64),
                    );
                  }
                  if (state is PostsLoading) {
                    return Center(
                      child: ProgressBar(),
                    );
                  }
                  if (state is PostsNetworkError || state is PostsTimeout) {
                    return Center(
                      child: NetworkErrorWidget(onRetry: () => _loadPosts()),
                    );
                  }
                  if (state is PostsError) {
                    return Center(
                      child: GeneralErrorWidget(onRetry: () => _loadPosts()),
                    );
                  }
                  if (state is PostsEmpty) {
                    return Center(
                      child: EmptyWidget(),
                    );
                  }
                  return Container();
                },
                bloc: _postBloc,
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class CommunityPostWidget extends StatelessWidget {
  final bool showBottomActionButtons;
  final Post post;
  final ValueChanged<Post> onLike;
  final ValueChanged<Post> onComment;
  final ValueChanged<Post> onShare;

  const CommunityPostWidget(
      {Key key,
      this.showBottomActionButtons = true,
      this.post,
      this.onLike,
      this.onComment,
      this.onShare})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var author = post.author;
    var tags = post.tags;
    return InkWell(
      onTap: () {
        print(post.toJson());
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  author.image != null && author.image.isNotEmpty
                      ? Image.network(author.image)
                      : CircleAvatar(
                          child: Text(author.fullName.substring(0, 1)),
                        ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(author.fullName),
                    ],
                  )
                ],
              ),
              Padding(
                padding: new EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  post.title,
                  style: Theme.of(context).textTheme.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              DescriptionTextWidget(post.post),
              Container(
                height: tags.isEmpty ? 0 : 30,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 4, right: 4),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 2, right: 2),
                      child: Chip(label: Text("#${tags[index].name}")),
                    );
                  },
                  itemCount: tags.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Row(
                children: <Widget>[
                  Text(
                    '${post.postLikes.length} likes',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    '${post.allCommentsCount} comments',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
              Visibility(
                child: Divider(
                  height: 1,
                ),
                visible: showBottomActionButtons,
              ),
              Visibility(
                visible: showBottomActionButtons,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconText(
                      icon: FontAwesomeIcons.thumbsUp,
                      text: 'Like',
                      onTap: () => onLike(post),
                      color: post.isLiked
                          ? Theme.of(context).primaryColor
                          : Colors.black,
                    ),
                    IconText(
                      icon: FontAwesomeIcons.commentAlt,
                      text: 'Comment',
                      onTap: () => onComment(post),
                    ),
                    IconText(
                      icon: FontAwesomeIcons.shareAlt,
                      text: 'Share',
                      onTap: () => onShare(post),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class IconText extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const IconText({
    Key key,
    this.text,
    this.icon,
    this.onTap,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              text,
              style: TextStyle(color: color),
            )
          ],
        ),
      ),
    );
  }
}

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget(this.text);

  @override
  _DescriptionTextWidgetState createState() =>
      new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget>
    with SingleTickerProviderStateMixin {
  String firstHalf;
  String secondHalf;
  AnimationController expandController;
  bool flag = true;

  @override
  void initState() {
    super.initState();
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    if (widget.text.length > 150) {
      firstHalf = widget.text.substring(0, 150);
      secondHalf = widget.text.substring(150, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.symmetric(horizontal: 10.0),
      child: secondHalf.isEmpty
          ? new Text(firstHalf)
          : new Text.rich(TextSpan(children: [
              TextSpan(
                  text: flag ? (firstHalf + "...") : (firstHalf + secondHalf)),
              TextSpan(
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        flag = !flag;
                      });
                    },
                  text: flag ? " show more" : " show less",
                  style: TextStyle(color: Colors.blue))
            ])),
    );
  }
}
