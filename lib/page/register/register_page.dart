import 'package:Sarh/page/login/login_page.dart';
import 'package:Sarh/page/verify_account/verify_account_page.dart';
import 'package:Sarh/widget/relative_align.dart';
import 'package:Sarh/widget/sarh_text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:clippy_flutter/arc.dart';
import 'package:Sarh/i10n/app_localizations.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
            Align(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/logo/logo.png',
                  width: 150,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RelativeAlign(
                      alignment: ALIGN.Start,
                      child: Hero(
                        tag: 'screenName',
                        child: Text(
                          AppLocalizations.of(context).register,
                          style: Theme.of(context).textTheme.title.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),

                    SizedBox(
                      height: 4,
                    ),
                    SrahTextFormField(
                      labelText: AppLocalizations.of(context).emailAddress,
                      icon: FontAwesomeIcons.envelope,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    SrahTextFormField(
                      labelText: AppLocalizations.of(context).fullName,
                      icon: FontAwesomeIcons.user,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    SrahTextFormField(
                      labelText:
                          AppLocalizations.of(context).passwordFieldName,
                      icon: FontAwesomeIcons.lock,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    SrahTextFormField(
                      labelText: AppLocalizations.of(context).confirmPassword,
                      icon: FontAwesomeIcons.lock,
                    ),
                    SizedBox(
                      height: 4,
                    ),

                    SizedBox(
                      height: 16,
                    ),
                    Hero(
                      tag: 'button',
                      child: SizedBox(
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        VerifyAccountPage()));
                          },
                          child:
                              Text(AppLocalizations.of(context).nextButton),
                        ),
                        width: double.infinity,
                        height: 40,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    RelativeAlign(
                      alignment: ALIGN.Start,
                      child: Text.rich(
                        TextSpan(
                          text: AppLocalizations.of(context)
                              .iAlreadyHaveAccount,
                          children: [
                            TextSpan(
                                text:
                                    ' ${AppLocalizations.of(context).login}',
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage())),
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
          ],
        ),
      ),
    );
  }
}
