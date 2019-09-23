import 'package:Sarh/dependency_provider.dart';
import 'package:Sarh/page/community/community_page.dart';
import 'package:Sarh/page/company_profile/company_profile_page.dart';
import 'package:Sarh/page/home/category/bloc/category_bloc.dart';
import 'package:Sarh/page/home/category/bloc/category_event.dart';
import 'package:Sarh/page/home/category/category_page.dart';
import 'package:Sarh/page/home/favorite/favorites_page.dart';
import 'package:Sarh/page/home/main/bloc/bloc.dart';
import 'package:Sarh/page/home/main/bloc/home_page_bloc.dart';
import 'package:Sarh/page/home/updates_page.dart';
import 'package:Sarh/page/message_list/message_list_page.dart';
import 'package:Sarh/page/profile/bloc/user_profile_bloc.dart';
import 'package:Sarh/page/profile/bloc/user_profile_event.dart';
import 'package:Sarh/page/profile/bloc/user_profile_state.dart';
import 'package:Sarh/page/profile/user_profile_page.dart';
import 'package:Sarh/page/quotes_list/quotes_list_page.dart';
import 'package:Sarh/page/request_quote/request_quote_screen.dart';
import 'package:Sarh/page/search/search_page.dart';
import 'package:Sarh/page/settings/settings_page.dart';
import 'package:Sarh/widget/fab_bottom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../home_page.dart';
import 'package:preload_page_view/preload_page_view.dart';
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GlobalKey<UserDrawerState> _drawerKey = GlobalKey();
  GlobalKey<FABBottomAppBarState> _bottomBarKey = GlobalKey();
  PreloadPageController _pageController = PreloadPageController();
  HomePageBloc _homePageBloc;

  @override
  void initState() {
    super.initState();

    _homePageBloc = HomePageBloc(DependencyProvider.provide());
  }

  @override
  void dispose() {
    super.dispose();
  }

  UserDrawerState get drawer => _drawerKey.currentState;

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _homePageBloc,
      listener: (context, state) {
        if (state is NavigateToCompanyProfile) {
          drawer.navigateToCompanyProfile();
        }
        if (state is NavigateToUserProfile) {
          drawer.navigateToUserProfile();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: BlocProvider.value(
          child: new UserDrawer(
            scaffoldKey: _scaffoldKey,
            key: _drawerKey,
          ),
          value: _homePageBloc,
        ),
        body: SafeArea(
            child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              color: Color(0xff1f1f1),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Color(0xf9ac0e3),
                        child: IconButton(
                          icon: Icon(FontAwesomeIcons.user),
                          onPressed: () {
                            _scaffoldKey.currentState.openDrawer();
                          },
                        ),
                      ),
                      Expanded(
                          child: TextField(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchPage()));
                        },
                        readOnly: true,
                        decoration:
                            InputDecoration.collapsed(hintText: 'Search...')
                                .copyWith(
                                    fillColor: Colors.white,
                                    filled: true,
                                    suffixIcon: Icon(
                                      FontAwesomeIcons.search,
                                      size: 15,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(32),
                                        gapPadding: 0),
                                    hintText: 'Search...',
                                    contentPadding: const EdgeInsets.all(8)),
                      )),
                      CircleAvatar(
                          backgroundColor: Color(0xf9ac0e3),
                          child: IconButton(
                            icon: Icon(FontAwesomeIcons.commentAlt),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return MessageListPage();
                              }));
                            },
                          ))
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: PreloadPageView(
                preloadPagesCount: 4,
                controller: _pageController,
                children: <Widget>[
                  HomePage(),
                  CategoryPage(),
                  UpdatesPage(),
                  FavoritePage()
                ],
              ),
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          heroTag: 'fab',
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return RequestQuoteScreen();
            }));
          },
          child: Icon(FontAwesomeIcons.plus),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: FABBottomAppBar(
          onTabSelected: (index) {
            setState(() {
              _bottomBarKey.currentState.selectedIndex = index;
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 200), curve: Curves.easeIn);
            });
          },
          key: _bottomBarKey,
          items: [
            FABBottomAppBarItem(iconData: FontAwesomeIcons.home, text: 'Home'),
            FABBottomAppBarItem(
                iconData: FontAwesomeIcons.th, text: 'Category'),
            FABBottomAppBarItem(
                iconData: FontAwesomeIcons.solidBell, text: 'Updates'),
            FABBottomAppBarItem(
                iconData: FontAwesomeIcons.solidStar, text: 'Favorite'),
          ],
          centerItemText: 'Quote',
          notchedShape: CircularNotchedRectangle(),
          selectedColor: Theme.of(context).primaryColor,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class UserDrawer extends StatefulWidget {
  const UserDrawer({
    Key key,
    @required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  UserDrawerState createState() => UserDrawerState();
}

class UserDrawerState extends State<UserDrawer> {
  UserProfileBloc _userProfileBloc;

  @override
  void initState() {
    super.initState();
    _userProfileBloc = UserProfileBloc(DependencyProvider.provide());
    _userProfileBloc.dispatch(LoadProfile());
  }
@override
  void dispose() {
    super.dispose();
    _userProfileBloc.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).accentColor,
        child: ListView(
          children: <Widget>[
            BlocBuilder(
              bloc: _userProfileBloc,
              builder: (context, state) {
                if (state is ProfileLoaded) {
                  var user = state.user;

                  return Padding(
                    padding: EdgeInsets.only(
                        top: 32, left: 16, right: 16, bottom: 16),
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () => BlocProvider.of<HomePageBloc>(context)
                              .dispatch(NavigateToProfile()),
                          child: Row(
                            children: <Widget>[
                              Hero(
                                tag: 'profile_image',
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                      child: user.image != null &&
                                              user.image.isNotEmpty
                                          ? Image.network(user.image)
                                          : Icon(FontAwesomeIcons.user,
                                              size: 50)),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    user.username,
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(color: Colors.white),
                                  ),
                                  Text('Mail@Domain.com',
                                      style: Theme.of(context)
                                          .textTheme
                                          .body1
                                          .copyWith(
                                            color: Colors.white,
                                          )),
                                  Text('Tap to view your profile',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                            color: Colors.white,
                                          )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
            ListTile(
              onTap: _navigateToQuotesPage,
              leading: Icon(
                FontAwesomeIcons.solidFileAlt,
                color: Colors.white,
              ),
              title: Text('Quotations',
                  style: Theme.of(context).textTheme.title.copyWith(
                      color: Colors.white, fontWeight: FontWeight.normal)),
            ),
            ListTile(
              dense: true,
              leading: Icon(
                FontAwesomeIcons.users,
                color: Colors.white,
              ),
              onTap: _navigateToCommunityPage,
              title: Text('Community',
                  style: Theme.of(context).textTheme.title.copyWith(
                      color: Colors.white, fontWeight: FontWeight.normal)),
            ),
            ListTile(
              onTap: _navigatedToSettings,
              leading: Icon(
                FontAwesomeIcons.cog,
                color: Colors.white,
              ),
              title: Text('Settings',
                  style: Theme.of(context).textTheme.title.copyWith(
                      color: Colors.white, fontWeight: FontWeight.normal)),
            ),
            Divider(
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  padding: const EdgeInsets.only(
                      left: 32, right: 32, top: 8, bottom: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  child: Text('Logout',
                      style: Theme.of(context).textTheme.title.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.normal)),
                  onPressed: () {},
                  color: Colors.white,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _navigateToQuotesPage() {
    Navigator.pop(context);
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => QuoteListPage()));
  }

  void _navigatedToSettings() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsPage()));
  }

  void navigateToUserProfile() {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return UserProfilePage();
    }));
  }

  void navigateToCompanyProfile() {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CompanyProfilePage();
    }));
  }

  void _navigateToCommunityPage() {
    Navigator.pop(context);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CommunityPage();
    }));
  }
}

class GlobalSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [Container()];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Container();
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
