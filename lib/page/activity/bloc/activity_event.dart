class ActivityEvent{}


class LoadActivitiesFromCategory extends ActivityEvent{
  final int categoryId;

  LoadActivitiesFromCategory(this.categoryId);
}