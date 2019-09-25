import 'package:Sarh/data/model/category.dart';
import 'package:Sarh/dependency_provider.dart';
import 'package:Sarh/page/activity/bloc/bloc.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:Sarh/widget/ui_state.dart';
import 'package:Sarh/widget/ui_state/network_error_widget.dart';
import 'package:Sarh/widget/ui_state/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityPage extends StatefulWidget {
  final Category parentCategory;

  const ActivityPage({Key key, this.parentCategory}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  ActivityBloc _activityBloc;

  @override
  void initState() {
    super.initState();
    _activityBloc = ActivityBloc(DependencyProvider.provide());
    _loadData();
  }

  void _loadData() {
    _activityBloc
        .dispatch(LoadActivitiesFromCategory(1));
  }

  @override
  void dispose() {
    super.dispose();
    _activityBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var category = widget.parentCategory;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder(
        bloc: _activityBloc,
        builder: (context, state) {
          if (state is ActivityLoadingState) {
            return Center(
              child: ProgressBar(),
            );
          }
          if (state is ActivityNetworkErrorState || state is ActivityTimeoutState) {
            return Center(
              child: NetworkErrorWidget(onRetry: () => _loadData()),
            );
          }
          if (state is ActivitiesLoadedState) {
            return Center(child: Text(state.activities.join()));
          }
          if (state is ActivityEmptyState) {
            return Center(child: EmptyWidget());
          }
          if (state is ActivityErrorState) {
            return Center(child: GeneralErrorWidget(onRetry: () => _loadData()));
          }

          return Container();
        },
      ),
      appBar: AppBar(
        leading: BackButtonNoLabel(Colors.white),
/*        title: Text(Localizations.localeOf(context).languageCode == 'ar'
            ? category.nameAr
            : category.nameEn),*/
      ),
    );
  }
}
