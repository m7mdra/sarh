import 'dart:async';

import 'package:Sarh/page/account_type/account_type_page.dart';
import 'package:Sarh/widget/verification_widget.dart';
import 'package:flutter/material.dart';
import 'package:Sarh/i10n/app_localizations.dart';
import 'bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/ticker.dart';

class VerifyAccountPage extends StatefulWidget {
  final Account accountType;

  const VerifyAccountPage({Key key, this.accountType}) : super(key: key);

  @override
  _VerifyAccountPageState createState() => _VerifyAccountPageState();
}

class _VerifyAccountPageState extends State<VerifyAccountPage> {
  TimerBloc _timerBloc;
  GlobalKey<VerificationCodeWidgetState> _codeWidgetKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _timerBloc = TimerBloc(ticker: Ticker());
    _timerBloc.dispatch((Start()));
  }

  @override
  void dispose() {
    super.dispose();
    _timerBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).accountVerificationPageTitle,
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)
                      .accountVerificationMessage('0512345678'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.grey),
                ),
                SizedBox(height: 16),
                BlocBuilder(
                  bloc: _timerBloc,
                  builder: (BuildContext context, state) {
                    if (state is Tick)
                      return buildCounterWidget(state.duration, context);

                    if (state is Ready)
                      return buildCounterWidget(state.duration, context);

                    if (state is Finished)
                      return buildCounterWidget(state.duration, context);

                    if (state is Running)
                      return buildCounterWidget(state.duration, context);
                    return buildCounterWidget(0, context);
                  },
                ),
                SizedBox(height: 8),
                Directionality(
                  child: VerificationCodeWidget(
                    6,
                    key: _codeWidgetKey,
                    // ignore: missing_return
                    onCodeChange: (code) {},
                    // ignore: missing_return
                    onComplete: (bool) {},
                  ),
                  textDirection: TextDirection.ltr,
                ),
                SizedBox(height: 8),
                ButtonBar(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Hero(
                      tag: 'button',
                      child: RaisedButton(
                        onPressed: () {
                          if (codeWidget.codes == null ||
                              codeWidget.codes.length < 6) {
                            scaffold.hideCurrentSnackBar(
                                reason: SnackBarClosedReason.hide);
                            scaffold.showSnackBar(SnackBar(
                              content: Text(AppLocalizations.of(context)
                                  .pleaseFillAllTheFields),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ));
                          } else {}
                        },
                        child: Text(AppLocalizations.of(context).verifyButton),
                      ),
                    ),
                    BlocBuilder(
                      bloc: _timerBloc,
                      builder: (BuildContext context, state) {
                        return OutlineButton(
                          onPressed: state is Finished
                              ? () {
                                  _timerBloc.dispatch(Start());
                                  scaffold.hideCurrentSnackBar();
                                  scaffold.showSnackBar(SnackBar(
                                    backgroundColor: Colors.green,
                                    content:
                                        Text('Request was sent successfully'),
                                    behavior: SnackBarBehavior.floating,
                                  ));
                                }
                              : null,
                          child: Text(
                              AppLocalizations.of(context).sendAgainButton),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ScaffoldState get scaffold => _scaffoldKey.currentState;

  VerificationCodeWidgetState get codeWidget => _codeWidgetKey.currentState;

  Text buildCounterWidget(int duration, BuildContext context) {
    return Text(
      '${duration.toString()} ${duration <= 1 ? 'second' : 'seconds'}',
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .title
          .copyWith(color: Theme.of(context).primaryColor),
    );
  }
}
