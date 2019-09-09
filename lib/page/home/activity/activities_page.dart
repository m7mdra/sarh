
import 'package:Sarh/data/model/activity.dart';
import 'package:Sarh/page/home/activity/bloc/activity_bloc.dart';
import 'package:Sarh/page/home/activity/bloc/activity_event.dart';
import 'package:Sarh/page/home/activity/bloc/activity_state.dart';
import 'package:Sarh/page/login/login_page.dart';
import 'package:Sarh/page/sub_activity/sub_activity_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Sarh/widget/ui_state.dart';
import 'package:Sarh/locale.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with AutomaticKeepAliveClientMixin {
  ActivityBloc _activityBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _activityBloc = BlocProvider.of(context);
  }

  @override
  void dispose() {
    super.dispose();
    _activityBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: BlocListener(
        listener: (context, state) {
          if (state is ActivitySessionExpired)
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return LoginPage();
            }));
        },
        bloc: _activityBloc,
        child: BlocBuilder(
          bloc: _activityBloc,
          builder: (BuildContext context, state) {
            if (state is ActivityLoading) {
              return ProgressBar();
            }
            if (state is ActivityNetworkError) {
              return Center(
                child: NetworkErrorWidget(
                  onRetry: () {
                    _dispatchLoadEvent();
                  },
                ),
              );
            }
            if (state is ActivityError) {
              return Center(child: GeneralErrorWidget(
                onRetry: () {
                  _dispatchLoadEvent();
                },
              ));
            }
            if (state is ActivityEmpty) {
              return Center(child: EmptyWidget());
            }
            if (state is ActivitySuccess) {
              return RefreshIndicator(
                onRefresh: () {
                  _dispatchLoadEvent();
                  return Future.value(null);
                },
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      childAspectRatio: 1),
                  itemBuilder: (BuildContext context, int index) {
                    return ActivityWidget(
                      state.activityList[index],
                      onActivityTap: (activity) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubActivityPage(
                                      parentActivity: state.activityList[index],
                                    )));
                      },
                    );
                  },
                  itemCount: state.activityList.length,
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _dispatchLoadEvent() => _activityBloc.dispatch(LoadActivities());

  @override
  bool get wantKeepAlive => true;
}

class ActivityWidget extends StatelessWidget {
  final Activity activity;
  final ValueSetter<Activity> onActivityTap;

  const ActivityWidget(this.activity, {Key key, this.onActivityTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onActivityTap(activity),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withAlpha(80), width: 0.4)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo/logo.png',
              width: 120,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
                currentLanguage(context) == 'ar'
                    ? activity.nameAr
                    : activity.nameEn,
                maxLines: 2),
            SizedBox(
              height: 2,
            ),
          ],
        ),
      ),
    );
  }
}
