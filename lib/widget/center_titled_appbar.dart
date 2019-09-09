import 'package:Sarh/widget/back_button_widget.dart';
import 'package:flutter/material.dart';

class CenteredTitleAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  const CenteredTitleAppbar({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      leading: BackButtonNoLabel(Colors.white),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
