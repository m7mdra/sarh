import 'dart:math';

import 'package:Sarh/page/company_gallery/company_gallery_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new StaggeredGridView.countBuilder(
      padding: const EdgeInsets.only(bottom: 80),
      crossAxisCount: 4,
      itemCount: 100,
      itemBuilder: (BuildContext context, int index) => InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CompanyGalleryPage(image: 'https://loremflickr.com/500/500/house,construction,workers',);
          }));
        },
        child: FadeInImage.assetNetwork(
            fadeInDuration: Duration(milliseconds: 200),
            placeholder: 'assets/logo/logo.png',
            fit: BoxFit.fitWidth,
            height: 200,
            image:
                'https://loremflickr.com/500/500/house,construction,workers'),
      ),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 2 : 1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
