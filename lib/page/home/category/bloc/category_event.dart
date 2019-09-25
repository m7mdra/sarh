
import 'package:Sarh/data/model/category.dart';

class CategoryEvent {}

class LoadCategories extends CategoryEvent {}
class OnCategorySelectedEvent extends CategoryEvent{
  final Category category;

  OnCategorySelectedEvent(this.category);
}
