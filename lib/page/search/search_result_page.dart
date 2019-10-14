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

import 'package:Sarh/data/community/model/favorite_company_response.dart';
import 'package:Sarh/size_config.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:Sarh/widget/sliver_header_delegate.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchResultPage extends StatefulWidget {
  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  bool _showGrid = false;
  var _selectedSort = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              centerTitle: true,
              leading: BackButtonNoLabel(Colors.white),
              automaticallyImplyLeading: true,
              title: Text(
                'Results for M',
              ),
            ),
            SliverPersistentHeader(
                floating: true,
                pinned: true,
                delegate: SliverHeaderDelegate(
                  maxHeight: 50,
                  minHeight: 50,
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: FlatButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              FontAwesomeIcons.filter,
                            ),
                            label: Text(
                              'Filter',
                            ),
                          ),
                        ),
                        Expanded(
                          child: FlatButton.icon(
                            onPressed: () {
                              setState(() {
                                _showGrid = !_showGrid;
                              });
                            },
                            icon: Icon(
                              _showGrid
                                  ? FontAwesomeIcons.list
                                  : FontAwesomeIcons.th,
                            ),
                            label: Text(
                              'View',
                            ),
                          ),
                        ),
                        Expanded(
                          child: FlatButton.icon(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        contentPadding: const EdgeInsets.all(0),
                                        actions: <Widget>[
                                          FlatButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                  MaterialLocalizations.of(
                                                          context)
                                                      .cancelButtonLabel))
                                        ],
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        title: Text('Sort Service providers'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            ListTile(
                                              selected: _selectedSort == 1,
                                              leading: Icon(FontAwesomeIcons
                                                  .sortAlphaDown),
                                              title: Text(
                                                  'Alphabetically Asending'),
                                              onTap: () {
                                                _selectedSort = 1;
                                                Navigator.pop(context);
                                              },
                                            ),
                                            Divider(
                                              height: 1,
                                            ),
                                            ListTile(
                                              selected: _selectedSort == 2,
                                              leading: Icon(
                                                  FontAwesomeIcons.sortAlphaUp),
                                              title: Text(
                                                  'Alphabetically Descending'),
                                              onTap: () {
                                                _selectedSort = 2;
                                                Navigator.pop(context);
                                              },
                                            ),
                                            Divider(
                                              height: 1,
                                            ),
                                            ListTile(
                                              selected: _selectedSort == 3,
                                              leading: Icon(FontAwesomeIcons
                                                  .sortAmountDown),
                                              title: Text('Rating Asending'),
                                              onTap: () {
                                                _selectedSort = 3;
                                                Navigator.pop(context);
                                              },
                                            ),
                                            Divider(
                                              height: 1,
                                            ),
                                            ListTile(
                                              selected: _selectedSort == 4,
                                              leading: Icon(FontAwesomeIcons
                                                  .sortAmountUp),
                                              title: Text('Rating Descending'),
                                              onTap: () {
                                                _selectedSort = 4;
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      ));
                            },
                            icon: Icon(
                              FontAwesomeIcons.sort,
                            ),
                            label: Text(
                              'Sort',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            SliverToBoxAdapter(
              child: Divider(
                height: 1,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: _showGrid
                  ? SliverGrid(
                      delegate: SliverChildListDelegate([
                        CompanyGridWidget(),
                        CompanyGridWidget(),
                        CompanyGridWidget(),
                        CompanyGridWidget(),
                      ]),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:
                              MediaQuery.of(context).size.width / 2,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          childAspectRatio: 0.6))
                  : SliverList(
                      delegate: SliverChildListDelegate([
                      CompanyWidget(),
                      Divider(),
                      CompanyWidget(),
                      Divider(),
                      CompanyWidget(),
                      Divider(),
                      CompanyWidget(),
                      Divider(),
                      CompanyWidget(),
                      Divider(),
                      CompanyWidget(),
                    ])),
            )
          ],
        ),
      ),
    );
  }
}

class CompanyWidget extends StatelessWidget {
  final bool showBottomActionButtons;
  final ResponseData company;
  final ValueChanged<ResponseData> onLike;
  final ValueChanged<ResponseData> onComment;
  final ValueChanged<ResponseData> onShare;

  const CompanyWidget(
      {Key key,
      this.showBottomActionButtons = true,
      this.company,
      this.onLike,
      this.onComment,
      this.onShare})
      : super(key: key);
      
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      children: <Widget>[
        Container(
          child:    CachedNetworkImage(
          imageUrl: company.company.userInfo.image.toString(),
          fit: BoxFit.fitWidth,
          width: MediaQuery.of(context).size.width,
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget:  (context, url, error) => Image.asset(
            'assets/logo/logo.png',
            width: SizeConfig.blockSizeHorizontal * 30,
            height: SizeConfig.blockSizeHorizontal * 30,
          ),
        ),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withAlpha(80))),
        ),
        SizedBox(
          width: 16,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
               company.company.userInfo.fullName,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 2,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.th,
                    color: Colors.grey,
                    size: 13,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(company.company.companyInfo.category.toString()),
                ],
              ),
              SizedBox(
                height: 4,
              ),
            Row(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.phone,
                    color: Colors.grey,
                    size: 13,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(company.company.userInfo.phone.toString()),
                ],
              ),
              // Row(
              //   children: <Widget>[
              //     Icon(FontAwesomeIcons.solidStar, size: 15),
              //     SizedBox(
              //       width: 4,
              //     ),
              //     Icon(
              //       FontAwesomeIcons.solidStar,
              //       size: 15,
              //     ),
              //     SizedBox(
              //       width: 4,
              //     ),
              //     Icon(
              //       FontAwesomeIcons.solidStar,
              //       size: 15  ,
              //     ),
              //     SizedBox(
              //       width: 4,
              //     ),
              //     Icon(
              //       FontAwesomeIcons.solidStar,
              //       size: 15,
              //       color: Colors.grey,
              //     ),
              //     SizedBox(
              //       width: 2,
              //     ),
              //     Icon(
              //       FontAwesomeIcons.solidStar,
              //       size: 15,
              //       color: Colors.grey,
              //     ),
              //     SizedBox(
              //       width: 4,
              //     ),
              //     Text(
              //       '+3',
              //       style: Theme.of(context).textTheme.caption,
              //     )
              //   ],
              // ),
              // SizedBox(
              //   height: 4,
              // ),
//              Row(
//                children: <Widget>[
//                  RaisedButton(
//                      onPressed: () {},
//                      padding: const EdgeInsets.all(8),
//                      child: Row(
//                        children: <Widget>[
//                          Icon(
//                            FontAwesomeIcons.image,
//                            size: 15,
//                          ),
//                          SizedBox(
//                            width: 4,
//                          ),
//                          Text('View Profile'),
//                        ],
//                      )),
//                  SizedBox(
//                    width: 4,
//                  ),
//                  RaisedButton(
//                      onPressed: () {},
//                      padding: const EdgeInsets.all(8),
//                      child: Row(
//                        children: <Widget>[
//                          Icon(
//                            FontAwesomeIcons.phoneAlt,
//                            size: 15,
//                          ),
//                          SizedBox(
//                            width: 4,
//                          ),
//                          Text('Contact'),
//                        ],
//                      )),
//                ],
//              )
            ],
          ),
        )
      ],
    );
  }
}

class CompanyGridWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Image.asset(
            'assets/logo/logo.png',
            height: SizeConfig.blockSizeVertical * 20,
          ),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withAlpha(80))),
        ),
        SizedBox(
          width: 16,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                'Sentinel Constructions',
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 2,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(fontWeight: FontWeight.normal),
              ),
            ),
            Text(
              'Build and constriction',
            ),
            Row(
              children: <Widget>[
                Icon(FontAwesomeIcons.solidStar, size: 15),
                SizedBox(
                  width: 4,
                ),
                Icon(
                  FontAwesomeIcons.solidStar,
                  size: 15,
                ),
                SizedBox(
                  width: 4,
                ),
                Icon(
                  FontAwesomeIcons.solidStar,
                  size: 15,
                ),
                SizedBox(
                  width: 4,
                ),
                Icon(
                  FontAwesomeIcons.solidStar,
                  size: 15,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 2,
                ),
                Icon(
                  FontAwesomeIcons.solidStar,
                  size: 15,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  '+3',
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
            SizedBox(
              height: 4,
            ),
          ],
        )
      ],
    );
  }
}
