import 'dart:math';

import 'package:Sarh/widget/back_button_widget.dart';
import 'package:Sarh/widget/relative_align.dart';
import 'package:Sarh/widget/sliver_header_delegate.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
class CompanyGalleryPage extends StatefulWidget {
  final List<String> images;

  const CompanyGalleryPage({Key key, this.images}) : super(key: key);

  @override
  _CompanyGalleryPageState createState() => _CompanyGalleryPageState();
}

class _CompanyGalleryPageState extends State<CompanyGalleryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              centerTitle: true,
              leading: BackButtonNoLabel(Colors.white),
              automaticallyImplyLeading: true,
              title: Text(
                'Company\'s gallery',
              ),
            ),
            SliverPersistentHeader(
                pinned: true,
                delegate: SliverHeaderDelegate(
                    maxHeight: 90,
                    minHeight: 75,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        color: Colors.white70,
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              child: Image.asset(
                                'assets/logo/logo-light.png',
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('Company name here'),
                                Text(
                                  'tap to view profile',
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ))),
            SliverList(
                delegate: SliverChildListDelegate(widget.images
                    .map((image) => CompanyGalleryItem(
                          imageUrl: image,
                        ))
                    .toList()))
          ],
        ),
      ),
    );
  }
}


class CompanyGalleryItem extends StatelessWidget {
  final String imageUrl;

  const CompanyGalleryItem({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RelativeAlign(
          alignment: ALIGN.End,
          child: IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: (context),
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Card(
                              margin: const EdgeInsets.all(0),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(
                                      FontAwesomeIcons.envelope,
                                      color: Colors.blue,
                                    ),
                                    title: Text('Send a message'),
                                  ),
                                  const Divider(
                                    height: 1,
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      FontAwesomeIcons.share,
                                      color: Colors.green,
                                    ),
                                    title: Text('Share the photo'),
                                  ),
                                  const Divider(
                                    height: 1,
                                  ),
                                  ListTile(
                                    leading: Icon(FontAwesomeIcons.star,
                                        color: Colors.yellow),
                                    title: Text('Add company to favorites'),
                                  ),
                                  const Divider(
                                    height: 1,
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      FontAwesomeIcons.flag,
                                      color: Colors.red,
                                    ),
                                    title: Text('Report the content'),
                                  ),
                                ],
                              )),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)));
            },
            icon: Icon(FontAwesomeIcons.ellipsisH),
            padding: const EdgeInsets.all(0),
          ),
        ),
        CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.fitWidth,
          width: MediaQuery.of(context).size.width,
          height: 250,
          placeholderFadeInDuration: Duration(milliseconds: 200),
        ),
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16,right: 16,top: 4),
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
            ' Curabitur augue lectus, egestas quis commodo a, auctor in eros.'
            ' Curabitur facilisis egestas erat, mattis sagittis turpis sodales vitae.',
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16,right: 16,top: 4),
          child: Text(
            '${Random().nextInt(24)} hour ago',
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }
}
