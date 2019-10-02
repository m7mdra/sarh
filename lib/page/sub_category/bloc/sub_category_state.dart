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

import 'package:Sarh/data/model/category.dart';

class SubCategoryState {}

class SubCategoryLoading extends SubCategoryState {}

class SubCategoryNetworkError extends SubCategoryState {}

class SubCategoryEmpty extends SubCategoryState {}

class SubCategorySuccess extends SubCategoryState {
  final List<Category> categoryList;

  SubCategorySuccess(this.categoryList);
}

class SubCategoryError extends SubCategoryState {}

class SubCategoryIdle extends SubCategoryState {}

class SubCategoryTimeout extends SubCategoryState {}

class SubCategorySessionExpired extends SubCategoryState {}
class HideSubCategoryState extends SubCategoryState{}

