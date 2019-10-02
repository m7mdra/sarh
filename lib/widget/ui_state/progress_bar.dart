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

import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final bool circular;

  const ProgressBar({Key key, this.circular = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: circular
            ? CircularProgressIndicator(backgroundColor: Color(0xff21eae3))
            : Padding(
                padding: const EdgeInsets.all(16),
                child:
                    LinearProgressIndicator(backgroundColor: Color(0xff21eae3)),
              ),
      ),
    );
  }
}
