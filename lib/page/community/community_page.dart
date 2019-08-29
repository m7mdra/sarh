import 'package:Sarh/page/message_list/message_list_page.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:Sarh/widget/sliver_header_delegate.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:Sarh/page/add_community_post/add_community_post_page.dart';

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'fabAdd',
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AdCommunityPostPage();
          }));
        },
        child: Icon(FontAwesomeIcons.plus),
      ),
      body: SafeArea(
          child: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
              floating: true,
              pinned: true,
              delegate: SliverHeaderDelegate(
                  maxHeight: 70,
                  minHeight: 70,
                  child: Material(
                    elevation: 2,
                    color: Theme.of(context).primaryColor,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: <Widget>[
                          BackButtonNoLabel(Colors.white),
                          Expanded(
                              child: TextField(
                            onTap: () {},
                            decoration: InputDecoration.collapsed(
                                    hintText: 'Search...')
                                .copyWith(
                                    fillColor: Colors.white,
                                    filled: true,
                                    suffixIcon: Icon(
                                      FontAwesomeIcons.search,
                                      size: 15,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(32),
                                        gapPadding: 0),
                                    hintText: 'Search...',
                                    contentPadding: const EdgeInsets.all(8)),
                          )),
                        ],
                      ),
                    ),
                  ))),
          SliverPadding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Latest Posts',
                style: Theme.of(context).textTheme.title,
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Container(
            height: 50,
            child: ListView.builder(
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
          )),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 64),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return CommunityPostWidget(
                key: ValueKey(index),
              );
            }, childCount: 10)),
          )
        ],
      )),
    );
  }
}

class CommunityPostWidget extends StatelessWidget {
  const CommunityPostWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(),
                SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Mohamed Sed'),
                    Text(
                      'Construction/supply materials',
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                )
              ],
            ),
            DescriptionTextWidget(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
                " Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of "
                "type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,"
                " remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages,"
                " and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
            Row(
              children: <Widget>[
                Text(
                  '690 likes',
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  '2k comments',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconText(
                  icon: FontAwesomeIcons.thumbsUp,
                  text: 'Like',
                  onTap: () {},
                ),
                IconText(
                  icon: FontAwesomeIcons.commentAlt,
                  text: 'Comment',
                  onTap: () {},
                ),
                IconText(
                  icon: FontAwesomeIcons.shareAlt,
                  text: 'Share',
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class IconText extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const IconText({
    Key key,
    this.text,
    this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.black,
            ),
            SizedBox(
              width: 4,
            ),
            Text(text)
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
      padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
