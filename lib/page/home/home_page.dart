import 'package:Sarh/page/company_gallery/company_gallery_page.dart';
import 'package:Sarh/widget/category_ship_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math' show Random;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        Container(
          height: 40,
          child: ListView(
            children: <Widget>[
              CategoryShip(
                category: 'Your favorite',
              ),
              CategoryShip(
                category: 'Interior Design',
              ),
              CategoryShip(
                category: 'Plumbing',
              ),
              CategoryShip(
                category: 'Carpentry',
              ),
              CategoryShip(
                category: 'Others',
              ),
            ],
            scrollDirection: Axis.horizontal,
          ),
        ),
        Expanded(
          child: new StaggeredGridView.countBuilder(
            padding: const EdgeInsets.only(bottom: 80),
            crossAxisCount: 4,
            itemCount: 100,
            itemBuilder: (BuildContext context, int index) => InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CompanyGalleryPage(
                    image:
                        'https://loremflickr.com/${Random().nextInt(500)}/${Random().nextInt(500)}/house,construction,workers',
                  );
                }));
              },
              child: CachedNetworkImage(
                imageUrl:
                    'https://loremflickr.com/${Random().nextInt(500)}/${Random().nextInt(500)}/house,construction,workers',
                placeholderFadeInDuration: Duration(milliseconds: 200),
              ),
            ),
            staggeredTileBuilder: (int index) =>
                new StaggeredTile.count(2, index.isEven ? 2 : 1),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
