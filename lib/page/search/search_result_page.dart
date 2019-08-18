import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchResultPage extends StatefulWidget {
  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Color(0xf9ac0e3),
                    child: IconButton(
                      icon: Icon(FontAwesomeIcons.chevronLeft),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                      child: Text(
                    'All Resutls 52',
                    textAlign: TextAlign.center,
                  ))
                ],
              ),
            ),
            Container(
              color: Theme.of(context).accentColor,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton.icon(
                      splashColor: Colors.white.withAlpha(60),

                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.filter,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Filter',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ), Expanded(
                    child: FlatButton.icon(
                      splashColor: Colors.white.withAlpha(60),

                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.th,
                        color: Colors.white,
                      ),
                      label: Text(
                        'View',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ), Expanded(
                    child: FlatButton.icon(
                      splashColor: Colors.white.withAlpha(60),
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.sort,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Sort',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Expanded(
              child: ListView(children: <Widget>[
                CompanyWidget(),
                Divider(),
                CompanyWidget(),
                Divider(),

                CompanyWidget(),
              ],padding: const EdgeInsets.all(16),),
            )
          ],
        ),
      ),
    );
  }
}

class CompanyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          child: Image.asset(
            'assets/logo/logo.png',
            width: 120,
            height: 120,
          ),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withAlpha(80))),
        ),
        SizedBox(
          width: 16,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Sentinel Constructions Sentinel Constructions',
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.th,
                    color: Colors.grey,
                    size: 13,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text('Build and constriction'),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.solidStar, size: 15),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    FontAwesomeIcons.solidStar,
                    size: 15,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    FontAwesomeIcons.solidStar,
                    size: 15,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    FontAwesomeIcons.solidStar,
                    size: 15,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Icon(
                    FontAwesomeIcons.solidStar,
                    size: 15,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    '+3',
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: <Widget>[
                  RaisedButton(
                      onPressed: () {},
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.image,
                            size: 15,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text('View Profile'),
                        ],
                      )),
                  SizedBox(
                    width: 4,
                  ),
                  RaisedButton(
                      onPressed: () {},
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.phoneAlt,
                            size: 15,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text('Contact'),
                        ],
                      )),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
class CompanyGridWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Column(
        children: <Widget>[
          Container(

            child: Image.asset(
              'assets/logo/logo.png',
              width: 200,
              height: 120,
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withAlpha(80))),
          ),
          SizedBox(
            width: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  'Sentinel Constructions Sentinel Constructions',
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.th,
                    color: Colors.grey,
                    size: 13,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text('Build and constriction'),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.solidStar, size: 15),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    FontAwesomeIcons.solidStar,
                    size: 15,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    FontAwesomeIcons.solidStar,
                    size: 15,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    FontAwesomeIcons.solidStar,
                    size: 15,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Icon(
                    FontAwesomeIcons.solidStar,
                    size: 15,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    '+3',
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
              SizedBox(
                height: 4,
              ),
            ],
          )
        ],
      ),
    );
  }
}
