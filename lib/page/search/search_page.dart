import 'package:Sarh/page/search/search_result_page.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  BackButtonNoLabel(Theme.of(context).accentColor),
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        suffixIcon: Icon(
                          FontAwesomeIcons.search,
                          size: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        hintText: 'Search...',
                        contentPadding: const EdgeInsets.all(12)),
                  )),
                ],
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    SearchSuggestionListTile(
                      categoryName: 'Interrial Desgin',
                    ),
                    buildDivider(),
                    SearchSuggestionListTile(
                      categoryName: 'Construction',
                    ),
                    buildDivider(),
                    SearchSuggestionListTile(
                      categoryName: 'Contracting',
                    ),
                    buildDivider(),
                    SearchSuggestionListTile(
                      categoryName: 'Plumbing',
                    ),
                    buildDivider(),
                    SearchSuggestionListTile(
                      categoryName: 'Electrotechnical',
                    ),
                    buildDivider(),
                    SearchSuggestionListTile(
                      categoryName: 'Building material',
                    ),
                    buildDivider(),
                    SearchSuggestionListTile(
                      categoryName: 'Painting',
                    ),
                    buildDivider(),
                    SearchSuggestionListTile(
                      categoryName: 'HAVC',
                    ),
                    buildDivider(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Divider buildDivider() => const Divider(
        height: 1,
      );
}

class SearchSuggestionListTile extends StatelessWidget {
  final String categoryName;

  const SearchSuggestionListTile({Key key, this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //TODO: Delegate onTap to construction
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SearchResultPage()));
      },
      title: Text.rich(TextSpan(text: 'Search in ', children: [
        TextSpan(
            text: categoryName,
            style: Theme.of(context)
                .textTheme
                .body1
                .copyWith(fontWeight: FontWeight.bold, color: Colors.black))
      ])),
    );
  }
}
