import 'package:Sarh/i10n/app_localizations.dart';
import 'package:Sarh/page/register/register_page.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Sarh/i10n/app_localizations.dart';

class AccountTypePage extends StatefulWidget {
  @override
  _AccountTypePageState createState() => _AccountTypePageState();
}

class _AccountTypePageState extends State<AccountTypePage> {
  Color _appbarColor = Colors.white;
  Color _fontColor = Colors.grey;
  Account _selectedAccount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        centerTitle: true,
        leading: BackButtonNoLabel(_fontColor),
        backgroundColor: _appbarColor,
        title: Text(
          AppLocalizations.of(context).selectAccountType,
          style: TextStyle(inherit: true, color: _fontColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AccountTypeSelectionWidget(
              onSelectChanged: (account) {
                setState(() {
                  _selectedAccount = account;
                  if (account == Account.personal)
                    _appbarColor = Colors.blue;
                  else
                    _appbarColor = Colors.lightBlueAccent;
                  _fontColor = Colors.white;
                });
              },
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '- ${AppLocalizations.of(context).personalAccountType}',
              textAlign: TextAlign.start,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur augue lectus, egestas quis commodo a, auctor in eros. Curabitur facilisis egestas erat, mattis sagittis turpis sodales vitae.',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            Divider(),
            Text(
              '- ${AppLocalizations.of(context).serviceProviderAccountType}',
              textAlign: TextAlign.start,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur augue lectus, egestas quis commodo a, auctor in eros. Curabitur facilisis egestas erat, mattis sagittis turpis sodales vitae.',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              child: RaisedButton(
                onPressed: _selectedAccount == null
                    ? null
                    : () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => RegisterPage(
                                      accountType: _selectedAccount,
                                    )));
                      },
                child: Text(AppLocalizations.of(context).nextButton),
              ),
              width: double.infinity,
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}

enum Account { personal, service_provider }

class AccountTypeSelectionWidget extends StatefulWidget {
  final ValueChanged<Account> onSelectChanged;

  const AccountTypeSelectionWidget({Key key, this.onSelectChanged})
      : super(key: key);

  @override
  _AccountTypeSelectionWidgetState createState() =>
      _AccountTypeSelectionWidgetState();
}

class _AccountTypeSelectionWidgetState extends State<AccountTypeSelectionWidget>
    with SingleTickerProviderStateMixin {
  Account _selectedAccount;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Card(
                      elevation: isPersonal ? 16 : 0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: IconButton(
                          icon: Icon(FontAwesomeIcons.user),
                          iconSize: 100,
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              _selectedAccount = Account.personal;
                              widget.onSelectChanged(Account.personal);
                            });
                          },
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.blue,
                    ),
                    Text(AppLocalizations.of(context).personalAccountType,
                        style: Theme.of(context).textTheme.subhead.copyWith(
                            fontWeight: isPersonal
                                ? FontWeight.bold
                                : FontWeight.normal))
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Card(
                      elevation: isServiceProvider ? 16 : 0,
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: IconButton(
                            icon: Icon(FontAwesomeIcons.solidBuilding),
                            iconSize: 100,
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                _selectedAccount = Account.service_provider;
                                widget
                                    .onSelectChanged(Account.service_provider);
                              });
                            },
                          )),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.lightBlueAccent,
                    ),
                    Text(
                      AppLocalizations.of(context).serviceProviderAccountType,
                      style: Theme.of(context).textTheme.subhead.copyWith(
                          fontWeight: isServiceProvider
                              ? FontWeight.bold
                              : FontWeight.normal),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  bool get isServiceProvider => _selectedAccount == Account.service_provider;

  bool get isPersonal => _selectedAccount == Account.personal;
}
