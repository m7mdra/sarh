import 'package:Sarh/page/chat/chat_list_page.dart';
import 'package:Sarh/page/quote/request_quote_screen.dart';
import 'package:Sarh/page/search/search_page.dart';
import 'package:Sarh/widget/category_ship_widget.dart';
import 'package:Sarh/widget/fab_bottom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'categories_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GlobalKey<FABBottomAppBarState> _bottomBarKey = GlobalKey();
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: new UserDrawer(scaffoldKey: _scaffoldKey),
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
                              return ChatListPage();
                            }));
                          },
                        ))
                  ],
                ),
                Container(
                  height: 40,
                  child: ListView(
                    children: <Widget>[
                      CategoryShip(
                        category: 'Your favorite',
                      ),
                      CategoryShip(
                        category: 'Interior Design',
                      ),
                      CategoryShip(
                        category: 'Plumbing',
                      ),
                      CategoryShip(
                        category: 'Carpentry',
                      ),
                      CategoryShip(
                        category: 'Others',
                      ),
                    ],
                    scrollDirection: Axis.horizontal,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: <Widget>[
                HomePage(),
                CategoriesPage(),
              ],
            ),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab',
        onPressed: () {
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
    );
  }
}

class UserDrawer extends StatelessWidget {
  const UserDrawer({
    Key key,
    @required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).accentColor,
        child: ListView(
          padding:
              const EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 16),
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.user,
                      size: 30,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
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
                      'Username',
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(color: Colors.white),
                    ),
                    Text('Mail@Domain.com',
                        style: Theme.of(context).textTheme.body1.copyWith(
                              color: Colors.white,
                            )),
                    Text('Tap to view your profile',
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: Colors.white,
                            )),
                  ],
                ),
              ],
            ),
            Divider(
              color: Colors.white,
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.solidFileAlt,
                color: Colors.white,
              ),
              title: Text('Quotations',
                  style: Theme.of(context).textTheme.title.copyWith(
                      color: Colors.white, fontWeight: FontWeight.normal)),
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.users,
                color: Colors.white,
              ),
              title: Text('Community',
                  style: Theme.of(context).textTheme.title.copyWith(
                      color: Colors.white, fontWeight: FontWeight.normal)),
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.solidHeart,
                color: Colors.white,
              ),
              title: Text('Favorites',
                  style: Theme.of(context).textTheme.title.copyWith(
                      color: Colors.white, fontWeight: FontWeight.normal)),
            ),
            ListTile(
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
                      left: 64, right: 64, top: 16, bottom: 16),
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
