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

import 'package:Sarh/data/model/gallery_item.dart';
import 'package:Sarh/dependency_provider.dart';
import 'package:Sarh/page/company_gallery/bloc/bloc.dart';
import 'package:Sarh/page/company_gallery/bloc/company_gallery_bloc.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:Sarh/widget/relative_align.dart';
import 'package:Sarh/widget/sliver_header_delegate.dart';
import 'package:Sarh/widget/ui_state.dart';
import 'package:Sarh/widget/ui_state/progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CompanyGalleryPage extends StatefulWidget {
  final GalleryItem galleryItem;

  const CompanyGalleryPage({Key key, this.galleryItem}) : super(key: key);

  @override
  _CompanyGalleryPageState createState() => _CompanyGalleryPageState();
}

class _CompanyGalleryPageState extends State<CompanyGalleryPage> {
  GalleryItem galleryItem;
  CompanyGalleryBloc _galleryBloc;

  @override
  void initState() {
    super.initState();
    galleryItem = widget.galleryItem;
    _galleryBloc = CompanyGalleryBloc(DependencyProvider.provide());
    _dispatch();
  }

  @override
  void dispose() {
    super.dispose();
    _galleryBloc.dispose();
  }

  void _dispatch() => _galleryBloc.dispatch(LoadCompanyGallery(galleryItem.id));

  ///TODO: The getter 'visible' was called on null.
  ///Receiver: null
  ///Tried calling: visible
  @override
  Widget build(BuildContext context) {
    var company = galleryItem.company;
    return Scaffold(
      backgroundColor: Colors.white,
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
                                child: company.companyImage != null &&
                                    company.companyImage.isNotEmpty
                                    ? Image.network(company.companyImage)
                                    : Image.asset(
                                  'assets/logo/logo-light.png',
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('${company.companyName}'),
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
            SliverToBoxAdapter(
              child: BlocBuilder(
                  bloc: _galleryBloc,
                  builder: (context, state) {
                    print(state);
                    if (state is CompanyGalleryLoading) {
                      return Center(child: ProgressBar());
                    }
                    if (state is CompanyGalleryNetworkError) {
                      return Center(
                          child:
                          NetworkErrorWidget(onRetry: () => _dispatch()));
                    }
                    if (state is CompanyGalleryError) {
                      return Center(
                          child:
                          GeneralErrorWidget(onRetry: () => _dispatch()));
                    }
                    if (state is CompanyGalleryEmpty) {
                      return Center(
                        child: EmptyWidget(),
                      );
                    }
                    if (state is CompanyGalleryLoaded) {
                      List galleryItems = state.galleryItems;
                      return ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            return CompanyGalleryItemWidget(
                                galleryItem: galleryItems[index]);
                          },
                          itemCount: galleryItems.length);
                    }
                    return Container();
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class CompanyGalleryItemWidget extends StatelessWidget {
  final GalleryItem galleryItem;

  const CompanyGalleryItemWidget({Key key, this.galleryItem}) : super(key: key);

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
          imageUrl: galleryItem.img,
          fit: BoxFit.fitWidth,
          width: MediaQuery.of(context).size.width,
          placeholderFadeInDuration: Duration(milliseconds: 200),
        ),
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 4),
          child: Text(
            galleryItem.title,
            style: Theme
                .of(context)
                .textTheme
                .subhead,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 4),
          child: Text(
            galleryItem.description,

          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 4),
          child: Text(
            DateFormat.ms().format(
                DateTime.fromMillisecondsSinceEpoch(galleryItem.createdAt)),
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
