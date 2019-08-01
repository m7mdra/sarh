import 'package:Sarh/page/login/login_page.dart';
import 'package:Sarh/widget/sarh_text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:clippy_flutter/arc.dart';

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
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'assets/logo/logo.png',
                    width: 150,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Align(
                        //TODO: HANDLE WHEN Layout orientation changes
                        alignment: Alignment.centerLeft,
                        child: Hero(
                          tag: 'screenName',
                          child: Text(
                            'Register',
                            style: Theme.of(context).textTheme.title.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Hero(
                        tag: 'field',
                        child: SrahTextFormField(
                          labelText: 'User',
                          icon: FontAwesomeIcons.envelope,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SrahTextFormField(
                        labelText: 'Email Address',
                        icon: FontAwesomeIcons.envelope,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SrahTextFormField(
                        labelText: 'Full name',
                        icon: FontAwesomeIcons.user,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SrahTextFormField(
                        labelText: 'Passwrod',
                        icon: FontAwesomeIcons.lock,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SrahTextFormField(
                        labelText: 'Confirm Password',
                        icon: FontAwesomeIcons.lock,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      DropdownButtonFormField<String>(
                        hint: Text('Account type'),
                        items: [
                          DropdownMenuItem(child: Text('User')),
                          DropdownMenuItem(child: Text('Company')),
                          DropdownMenuItem(child: Text('Supervisor')),
                          DropdownMenuItem(child: Text('Manager')),
                        ],
                        decoration: InputDecoration.collapsed(hintText: null)
                            .copyWith(
                                prefixIcon: Icon(FontAwesomeIcons.userTag),
                                filled: true,
                                fillColor: Color(0xf9ac0e3)),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Hero(
                        tag: 'button',
                        child: SizedBox(
                          child: RaisedButton(
                            onPressed: () {},
                            child: Text('Sign up'),
                          ),
                          width: double.infinity,
                          height: 40,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text.rich(
                          TextSpan(
                            text: 'I already have an account',
                            children: [
                              TextSpan(
                                  text: ' Login',
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginPage())),
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
