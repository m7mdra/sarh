import 'package:Sarh/i10n/app_localizations.dart';
import 'package:Sarh/page/new_password/new_password_page.dart';
import 'package:Sarh/page/verify_account/bloc/timer/ticker.dart';
import 'package:Sarh/page/verify_account/bloc/timer/timer_event.dart';
import 'package:Sarh/page/verify_account/bloc/timer/timer_state.dart';
import 'package:Sarh/page/verify_account/bloc/timer/verifiy_timer_bloc.dart';
import 'package:Sarh/widget/verification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountResetVerificationPage extends StatefulWidget {
  final String phoneNumber;

  const AccountResetVerificationPage({Key key, this.phoneNumber})
      : super(key: key);

  @override
  _AccountResetVerificationPageState createState() =>
      _AccountResetVerificationPageState();
}

class _AccountResetVerificationPageState
    extends State<AccountResetVerificationPage> {
  TimerBloc _timerBloc;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GlobalKey<VerificationCodeWidgetState> _codeWidgetKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _timerBloc = TimerBloc(ticker: Ticker());
    _timerBloc.dispatch(Start());
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
        body: Padding(
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
                      .accountVerificationMessage(widget.phoneNumber),
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
                          /*  if (codeWidget.codes == null ||
                              codeWidget.codes.length < 6) {
                            scaffold.hideCurrentSnackBar(
                                reason: SnackBarClosedReason.hide);
                            scaffold.showSnackBar(SnackBar(
                              content: Text(AppLocalizations.of(context)
                                  .pleaseFillAllTheFields),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ));
                          } else {}*/
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewPasswordPage()));
                        },
                        child: Text(AppLocalizations.of(context).verifyButton),
                      ),
                    ),
                    BlocBuilder(
                      bloc: _timerBloc,
                      builder: (BuildContext context, state) {
                        return OutlineButton(
                          onPressed: state is Finished ? () {} : null,
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
        ));
  }

  Text buildCounterWidget(int duration, BuildContext context) {
    return Text(
      AppLocalizations.of(context).seconds(duration),
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .title
          .copyWith(color: Theme.of(context).primaryColor),
    );
  }

  ScaffoldState get scaffold => _scaffoldKey.currentState;

  VerificationCodeWidgetState get codeWidget => _codeWidgetKey.currentState;
}
