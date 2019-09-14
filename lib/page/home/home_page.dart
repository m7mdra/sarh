import 'package:Sarh/page/company_gallery/company_gallery_page.dart';
import 'package:Sarh/widget/category_ship_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math' show Random;
import 'package:Sarh/image.json.dart';

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
            primary: true,
            itemCount: imageList.length,
            itemBuilder: (BuildContext context, int index) => InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CompanyGalleryPage(
                    images: imageList.sublist(
                        0, Random().nextInt(imageList.length - 1)),
                  );
                }));
              },
              child: CachedNetworkImage(
                imageUrl: imageList[index],
                fit: BoxFit.cover,
                placeholderFadeInDuration: Duration(milliseconds: 200),
              ),
            ),
            staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
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
