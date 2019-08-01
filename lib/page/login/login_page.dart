import 'package:Sarh/page/register/register_page.dart';
import 'package:Sarh/widget/sarh_text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:clippy_flutter/arc.dart';
import 'package:Sarh/i10n/app_localizations.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                      Align(
                        //TODO: HANDLE WHEN Layout orientation changes
                        alignment: Alignment.centerLeft,
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
                        labelText: 'Username or Email',
                        icon: FontAwesomeIcons.user,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SrahTextFormField(
                        labelText: 'Password',
                        icon: FontAwesomeIcons.lock,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Hero(
                        tag: 'button',
                        child: SizedBox(
                          child: RaisedButton(
                            onPressed: () {},
                            child: Text('Sign in'),
                          ),
                          width: double.infinity,
                          height: 40,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text.rich(
                          TextSpan(
                              text: 'Forgot my password',
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text.rich(
                          TextSpan(
                            text: 'I dont have an account',
                            children: [
                              TextSpan(
                                  text: ' create new',
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterPage())),
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
