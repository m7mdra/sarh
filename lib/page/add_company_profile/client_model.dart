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

import 'dart:io';
import 'package:meta/meta.dart';

class FeaturedClient {
  final String name;
  final File logo;
  final String website;

  FeaturedClient({@Required() this.name, @Required() this.logo, this.website});

  @override
  String toString() {
    return 'FeaturedClient{name: $name, logo: $logo, website: $website}';
  }
}
