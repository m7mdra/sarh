import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new StaggeredGridView.countBuilder(
      padding: const EdgeInsets.only(bottom: 80),
      crossAxisCount: 4,
      itemCount: 100,
      itemBuilder: (BuildContext context, int index) => Image.network(
        'https://loremflickr.com/${Random().nextInt(1000)}/${Random().nextInt(1000)}/house,construction',
        fit: BoxFit.cover,
        key: UniqueKey(),
      ),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 2 : 1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}
