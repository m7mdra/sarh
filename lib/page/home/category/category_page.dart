import 'package:Sarh/data/model/category.dart';
import 'package:Sarh/dependency_provider.dart';
import 'package:Sarh/locale.dart';
import 'package:Sarh/page/activity/activity_page.dart';
import 'package:Sarh/page/home/Category/bloc/category_bloc.dart';
import 'package:Sarh/page/home/category/bloc/category_event.dart';
import 'package:Sarh/page/home/category/bloc/category_state.dart';
import 'package:Sarh/page/login/login_page.dart';
import 'package:Sarh/page/sub_category/sub_category_page.dart';
import 'package:Sarh/widget/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  CategoryBloc _categoryBloc;

  @override
  void initState() {
    super.initState();
    _categoryBloc = CategoryBloc(DependencyProvider.provide());
    _categoryBloc.dispatch(LoadCategories());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _categoryBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: BlocListener(
        listener: (context, state) {
          if (state is CategorySessionExpired)
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return LoginPage();
            }));
        },
        bloc: _categoryBloc,
        child: BlocBuilder(
          bloc: _categoryBloc,
          builder: (BuildContext context, state) {
            if (state is CategoryLoading) {
              return ProgressBar();
            }
            if (state is CategoryNetworkError) {
              return Center(
                child: NetworkErrorWidget(
                  onRetry: () {
                    _dispatchLoadEvent();
                  },
                ),
              );
            }
            if (state is CategoryError) {
              return Center(child: GeneralErrorWidget(
                onRetry: () {
                  _dispatchLoadEvent();
                },
              ));
            }

            if (state is CategoryEmpty) {
              return Center(child: EmptyWidget());
            }
            if (state is CategorySuccess) {
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
                    return CategoryWidget(
                      state.categoryList[index],
                      onCategoryTap: (category) {
                        if (category.hasDescendant) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SubCategoryPage(parentCategory: category);
                          }));
                        } else {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ActivityPage(parentCategory: category);
                          }));
                        }
                      },
                    );
                  },
                  itemCount: state.categoryList.length,
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _dispatchLoadEvent() => _categoryBloc.dispatch(LoadCategories());

  @override
  bool get wantKeepAlive => true;
}

class CategoryWidget extends StatelessWidget {
  final Category category;
  final ValueSetter<Category> onCategoryTap;

  const CategoryWidget(this.category, {Key key, this.onCategoryTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onCategoryTap(category),
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
                    ? category.nameAr
                    : category.nameEn,
                maxLines: 2),
            Text('(${category.companyCount})'),
            SizedBox(
              height: 2,
            ),
          ],
        ),
      ),
    );
  }
}
