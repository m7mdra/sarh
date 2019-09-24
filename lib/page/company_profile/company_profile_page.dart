import 'dart:math';

import 'package:Sarh/data/model/authorizer.dart';
import 'package:Sarh/dependency_provider.dart';
import 'package:Sarh/i10n/app_localizations.dart';
import 'package:Sarh/page/company_profile/bloc/authorizer/authorizer_bloc.dart';
import 'package:Sarh/page/company_profile/bloc/authorizer/authorizer_event.dart';
import 'package:Sarh/page/company_profile/bloc/authorizer/authorizer_state.dart';
import 'package:Sarh/page/company_profile/bloc/profile/bloc.dart';
import 'package:Sarh/page/company_profile/bloc/profile/company_profile_event.dart';
import 'package:Sarh/page/edit_company_profile/edit_company_profile_page.dart';
import 'package:Sarh/page/profile_image_modify/modify_profile_image_page.dart';
import 'package:Sarh/size_config.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:Sarh/widget/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/profile/bloc.dart';

class CompanyProfilePage extends StatefulWidget {
  @override
  _CompanyProfilePageState createState() => _CompanyProfilePageState();
}

class _CompanyProfilePageState extends State<CompanyProfilePage>
    with TickerProviderStateMixin {
  CompanyProfileBloc _companyProfileBloc;
  AuthorizersBloc _authorizersBloc;

  @override
  void initState() {
    super.initState();
    _companyProfileBloc = CompanyProfileBloc(DependencyProvider.provide());
    _authorizersBloc = AuthorizersBloc(DependencyProvider.provide());
    _companyProfileBloc.dispatch(LoadProfile());
    _authorizersBloc.dispatch(LoadAuthroizers());
  }

  @override
  void dispose() {
    super.dispose();
    _companyProfileBloc.dispose();
    _authorizersBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder(
          bloc: _companyProfileBloc,
          // ignore: missing_return
          builder: (context, state) {
            if (state is ProfileLoaded)
              return Column(
                children: <Widget>[
                  _appbarAndHeader(context, state),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: <Widget>[
                        Text(
                          'About',
                          style: Theme.of(context).textTheme.title,
                        ),
                        Text(state.company.about),
                        _divider,
                        Text(
                          'Company activites',
                          style: Theme.of(context).textTheme.title,
                        ),
                        Wrap(
                          spacing: 1,
                          runSpacing: 0,
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          children: <Widget>[
                            Chip(label: Text('Construction')),
                            Chip(label: Text('Anything')),
                            Chip(label: Text('Anything')),
                            Chip(label: Text('Anything')),
                            Chip(label: Text('Anything')),
                            Chip(label: Text('Anything')),
                          ],
                        ),
                        _divider,
                        Text(
                          'Contact information',
                          style: Theme.of(context).textTheme.title,
                        ),
                        ListTile(
                          dense: true,
                          contentPadding: const EdgeInsets.all(0),
                          leading: Icon(
                            FontAwesomeIcons.mobile,
                            color: Theme.of(context).accentColor,
                          ),
                          title: Text(state.user.phone),
                        ),
                        ListTile(
                          dense: true,
                          contentPadding: const EdgeInsets.all(0),
                          leading: Icon(
                            FontAwesomeIcons.phone,
                            color: Theme.of(context).accentColor,
                          ),
                          title: Text(state.company.landPhone),
                        ),
                        ListTile(
                          dense: true,
                          contentPadding: const EdgeInsets.all(0),
                          leading: Icon(
                            FontAwesomeIcons.solidEnvelope,
                            color: Theme.of(context).accentColor,
                          ),
                          title: Text('info@takween.com'),
                        ),
                        ListTile(
                          dense: true,
                          contentPadding: const EdgeInsets.all(0),
                          leading: Icon(
                            FontAwesomeIcons.solidMap,
                            color: Theme.of(context).accentColor,
                          ),
                          title: Text(state.company.address),
                        ),
                        ListTile(
                          dense: true,
                          contentPadding: const EdgeInsets.all(0),
                          leading: Icon(
                            FontAwesomeIcons.globe,
                            color: Theme.of(context).accentColor,
                          ),
                          title: Text(state.company.website),
                        ),
                        _heightSizedBox(),
                        Row(
                          children: <Widget>[
                            SocialMediaTile(
                              backgroundColor: Color(0xff20b4f5),
                              iconData: FontAwesomeIcons.twitter,
                            ),
                            SocialMediaTile(
                              backgroundColor: Color(0xff4a90fa),
                              iconData: FontAwesomeIcons.facebook,
                            ),
                            SocialMediaTile(
                              backgroundColor: Color(0xffff9898),
                              iconData: FontAwesomeIcons.instagram,
                            ),
                            SocialMediaTile(
                              backgroundColor: Color(0xff0066ff),
                              iconData: FontAwesomeIcons.behance,
                            ),
                            SocialMediaTile(
                              backgroundColor: Color(0xff37c2ff),
                              iconData: FontAwesomeIcons.linkedin,
                            ),
                          ],
                        ),
                        _divider,
                        Text(
                          'Authorized from',
                          style: Theme.of(context).textTheme.title,
                        ),
                        BlocBuilder(
                          bloc: _authorizersBloc,
                          builder: (context, state) {
                            if (state is AuthorizersLoaded) {
                              return Container(
                                height: SizeConfig.blockSizeVertical * 22,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return new AuthorizerWidget(
                                      authorizer: state.authorizers[index],
                                    );
                                  },
                                  itemCount: state.authorizers.length,
                                ),
                              );
                            }
                            if (state is AuthorizersFailed) {
                             return Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Column(children: <Widget>[
                                 Text('Failed to load Authorizers'),
                                 OutlineButton(onPressed: (){
                                   _authorizersBloc.dispatch(LoadAuthroizers());

                                 },child: Text(AppLocalizations.of(context).retryButton),)
                               ],),
                             );
                            }
                            if (state is AuthorizerLoading) {
                              return Center(child: ProgressBar());
                            }
                            if (state is AuthorizersEmpty) {
                              return Column(
                                children: <Widget>[
                                  Text(
                                    'No Authorizers added',
                                    style: Theme.of(context).textTheme.title,
                                  ),
                                  FlatButton(onPressed: (){},child: Text('Add now'),)
                                ],
                              );
                            }
                            return Container();
                          },
                        ),
                        Divider(
                          height: 1,
                        ),
                        Text(
                          'Featured projects',
                          style: Theme.of(context).textTheme.title,
                        ),
                        _heightSizedBox(),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 4,
                          runSpacing: 4,
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Container(
                              width: 120,
                              height: 100,
                              color: Colors.red,
                            ),
                            Container(
                              width: 120,
                              height: 100,
                              color: Colors.red,
                            ),
                            Container(
                              width: 120,
                              height: 100,
                              color: Colors.red,
                            ),
                            Container(
                              width: 120,
                              height: 100,
                              color: Colors.red,
                            ),
                            Container(
                              width: 120,
                              height: 100,
                              color: Colors.red,
                            ),
                            Container(
                              width: 120,
                              height: 100,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        _divider,
                        Text(
                          'Customers Reviews',
                          style: Theme.of(context).textTheme.title,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('12 Reviews'),
                            RaisedButton.icon(
                              onPressed: () {},
                              label: Text('Add a review'),
                              icon: Icon(FontAwesomeIcons.paperPlane),
                            ),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (BuildContext context, int index) {
                            return ReviewTileWidget();
                          },
                          itemCount: 4,
                        ),
                        RaisedButton(
                          onPressed: () {},
                          child: Text('More & Add comments'),
                        )
                      ],
                    ),
                  ),
                ],
              );
          },
        ),
      ),
    );
  }

  Divider get _divider => const Divider(
        color: Colors.black38,
      );

  Card _appbarAndHeader(BuildContext context, ProfileLoaded state) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16))),
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background/background.jpg'),
                    fit: BoxFit.cover)),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    BackButtonWidget(),
                    FlatButton.icon(
                      icon: Icon(
                        FontAwesomeIcons.userCog,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditCompanyProfilePage()));
                      },
                      textColor: Colors.white,
                      label: Text('Profile settings'),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ModifyProfileImagePage();
                          }));
                        },
                        child: Hero(
                          tag: 'profile_image',
                          child: Container(
                            child: ClipOval(
                              child: Container(
                                color: Colors.white,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Image.network(
                                      state.user.image,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 30,
                                      height:
                                          SizeConfig.blockSizeHorizontal * 30,
                                      fit: BoxFit.cover,
                                    ),
                                    Icon(
                                      Icons.camera_alt,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      _widthSizedBox(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            state.user.fullName,
                            style: Theme.of(context)
                                .textTheme
                                .title
                                .copyWith(color: Colors.white),
                          ),
                          _heightSizedBox(),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                                text: 'Category',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(color: Colors.white)),
                            TextSpan(
                                text: ' / ',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: 'Subcategory',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(color: Colors.white)),
                          ])),
                          _heightSizedBox(),
                          Row(
                            children: <Widget>[
                              IgnorePointer(
                                child: RatingBar(
                                  itemSize: 15,
                                  itemCount: 5,
                                  initialRating: 3,
                                  glowColor: Colors.yellow,
                                  unratedColor: Colors.yellow,
                                  glow: true,
                                  ratingWidget: RatingWidget(
                                      full: Icon(
                                        FontAwesomeIcons.solidStar,
                                        color: Colors.yellow,
                                      ),
                                      half: Icon(
                                        FontAwesomeIcons.starHalf,
                                        color: Colors.yellow,
                                      ),
                                      empty: Icon(
                                        FontAwesomeIcons.star,
                                        color: Colors.yellow,
                                      )),
                                  itemPadding: const EdgeInsets.all(2),
                                  onRatingUpdate: (double rating) {},
                                ),
                              ),
                              _widthSizedBox(),
                              Text(
                                '+20',
                                style: Theme.of(context)
                                    .textTheme
                                    .body1
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _heightSizedBox() {
    return const SizedBox(
      height: 4,
    );
  }

  SizedBox _widthSizedBox() {
    return const SizedBox(
      width: 8,
    );
  }
}

class AuthorizerWidget extends StatelessWidget {
  final Authorizer authorizer;

  const AuthorizerWidget({
    Key key,
    this.authorizer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Image.network(
              authorizer.logo,
              width: 120,
              height: 100,
            ),
            Text(
              authorizer.name,
              maxLines: 1,
            )
          ],
        ),
      ),
    );
  }
}

class SocialMediaTile extends StatelessWidget {
  final Color backgroundColor;
  final IconData iconData;

  const SocialMediaTile({Key key, this.backgroundColor, this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 4, right: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: backgroundColor,
      ),
      padding: const EdgeInsets.all(8),
      child: Icon(
        iconData,
        color: Colors.white,
      ),
    );
  }
}

class ReviewTileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      isThreeLine: true,
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/logo/logo.png'),
      ),
      title: Text('Mohamed sed ahmed'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry'),
          Text(
            '${Random().nextInt(24)}hours ago',
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }
}
