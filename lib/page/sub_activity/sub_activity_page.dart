import 'package:Sarh/data/model/activity.dart';
import 'package:Sarh/dependency_provider.dart';
import 'package:Sarh/page/search/search_result_page.dart';
import 'package:Sarh/page/sub_activity/bloc/sub_activity_event.dart';
import 'package:Sarh/page/sub_activity/bloc/sub_activity_state.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:Sarh/widget/ui_state.dart';
import 'package:Sarh/widget/ui_state/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:Sarh/locale.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/sub_activity_bloc.dart';

class SubActivityPage extends StatefulWidget {
  final Activity parentActivity;

  const SubActivityPage({Key key, this.parentActivity}) : super(key: key);

  @override
  _SubActivityPageState createState() => _SubActivityPageState();
}

class _SubActivityPageState extends State<SubActivityPage> {
  Activity parentActivity;

  SubActivityBloc _subActivityBloc;

  @override
  void initState() {
    super.initState();
    parentActivity = widget.parentActivity;
    _subActivityBloc = SubActivityBloc(DependencyProvider.provide());
    _dispatchLoadSubActivitiesEvent();
  }

  void _dispatchLoadSubActivitiesEvent() =>
      _subActivityBloc.dispatch(LoadSubActivities(parentActivity.id));

  @override
  void dispose() {
    super.dispose();
    _subActivityBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(currentLanguage(context) == 'ar'
            ? parentActivity.nameAr
            : parentActivity.nameEn),
        leading: BackButtonNoLabel(Colors.white),
      ),
      body: BlocBuilder(
        bloc: _subActivityBloc,
        builder: (BuildContext context, state) {
          if (state is Loading) {
            return ProgressBar();
          }
          if (state is NetworkError) {
            return Center(
              child: NetworkErrorWidget(
                onRetry: () {
                  _dispatchLoadSubActivitiesEvent();
                },
              ),
            );
          }
          if (state is Error) {
            return Center(child: GeneralErrorWidget());
          }
          if (state is Empty) {
            return Center(child: EmptyWidget());
          }
          if (state is Success) {
            return RefreshIndicator(
              onRefresh: () {
                _dispatchLoadSubActivitiesEvent();
                return Future.value(null);
              },
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return SubActivityItem(
                    activity: state.activityList[index],
                  );
                },
                itemCount: state.activityList.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: 1,
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class SubActivityItem extends StatelessWidget {
  final Activity activity;

  const SubActivityItem({Key key, this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          currentLanguage(context) == 'ar' ? activity.nameAr : activity.nameEn),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SearchResultPage()));
      },
    );
  }
}
