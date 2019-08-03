import 'dart:async';

import 'package:Sarh/page/home/main_page.dart';
import 'package:Sarh/widget/sarh_progress_bar.dart';
import 'package:Sarh/widget/sarh_text_form_field.dart';
import 'package:Sarh/widget/verification_widget.dart';
import 'package:flutter/material.dart';

class VerifyAccountPage extends StatefulWidget {
  @override
  _VerifyAccountPageState createState() => _VerifyAccountPageState();
}

class _VerifyAccountPageState extends State<VerifyAccountPage> {
  bool isLoading = false;
  Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Account Verification',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(height: 8),
                Text(
                  'Please enter the verification code below\n that we have sent to your phone number +971589227074',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.grey),
                ),
                SizedBox(height: 16),
                Text(
                  '0:47',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                SizedBox(height: 8),
                VerificationCodeWidget(
                  4,
                  onCodeChange: (code) {},
                  onComplete: (bool) {
                    print("is completed? $bool");
                  },
                ),
                SizedBox(height: 8),
                Visibility(
                  visible: !isLoading,
                  child: ButtonBar(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Hero(
                        tag: 'button',
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              _timer = Timer(Duration(seconds: 1), () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainPage()));
                              });
                              isLoading = true;
                            });
                          },
                          child: Text('Verify'),
                        ),
                      ),
                      OutlineButton(
                        onPressed: () {},
                        child: Text('Send again'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Center(
                    child: Visibility(
                  child: SarhProgressBar(),
                  visible: isLoading,
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
