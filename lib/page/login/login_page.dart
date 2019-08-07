import 'package:Sarh/page/account_type/account_type_page.dart';
import 'package:Sarh/page/home/main_page.dart';
import 'package:Sarh/page/register/register_page.dart';
import 'package:Sarh/widget/relative_align.dart';
import 'package:Sarh/widget/sarh_text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Sarh/i10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Align(
              child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.angleLeft,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              alignment: Alignment.topLeft,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'assets/logo/logo.png',
                    width: 170,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RelativeAlign(
                        alignment: ALIGN.Start,
                        child: Hero(
                          tag: 'screenName',
                          child: Text(
                            '${AppLocalizations.of(context).login}   ',
                            style: Theme.of(context).textTheme.title.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SrahTextFormField(
                        labelText: AppLocalizations.of(context).userNameOrEmail,
                        icon: FontAwesomeIcons.user,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SrahTextFormField(
                        labelText:
                            AppLocalizations.of(context).passwordFieldName,
                        icon: FontAwesomeIcons.lock,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Hero(
                        tag: 'button',
                        child: SizedBox(
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage()));
                            },
                            child:
                                Text(AppLocalizations.of(context).signInButton),
                          ),
                          width: double.infinity,
                          height: 40,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      RelativeAlign(
                        alignment: ALIGN.Start,
                        child: Text.rich(
                          TextSpan(
                              text: AppLocalizations.of(context)
                                  .forgetMyPasswordButton,
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () => print('Tap Here onTap'),
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              )),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      RelativeAlign(
                        alignment: ALIGN.Start,
                        child: Text.rich(
                          TextSpan(
                            text:
                                AppLocalizations.of(context).iDontHaveAnAccount,
                            children: [
                              TextSpan(
                                  text:
                                      ' ${AppLocalizations.of(context).createNew}',
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AccountTypePage())),
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ))
                            ],
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
