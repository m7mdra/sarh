import 'package:Sarh/dependency_provider.dart';
import 'package:Sarh/page/account_type/account_type_page.dart';
import 'package:Sarh/page/add_company_profile/add_company_info_page.dart';
import 'package:Sarh/page/home/main/main_page.dart';
import 'package:Sarh/page/intereset_selection/interest_selection_page.dart';
import 'package:Sarh/page/login/login_page.dart';
import 'package:Sarh/page/verify_account/bloc/verification_bloc/verify_account_bloc_event.dart';
import 'package:Sarh/page/verify_account/bloc/verification_bloc/verify_account_bloc_state.dart';
import 'package:Sarh/widget/progress_dialog.dart';
import 'package:Sarh/widget/verification_widget.dart';
import 'package:flutter/material.dart';
import 'package:Sarh/i10n/app_localizations.dart';
import 'bloc/timer/timer_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/timer/ticker.dart';
import 'bloc/verification_bloc/verify_account_bloc.dart';

class VerifyAccountPage extends StatefulWidget {
  final AccountType accountType;

  const VerifyAccountPage({Key key, this.accountType}) : super(key: key);

  @override
  _VerifyAccountPageState createState() => _VerifyAccountPageState();
}

class _VerifyAccountPageState extends State<VerifyAccountPage> {
  TimerBloc _timerBloc;
  VerifyAccountBloc _verifyAccountBloc;
  GlobalKey<VerificationCodeWidgetState> _codeWidgetKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _timerBloc = TimerBloc(ticker: Ticker());
    _timerBloc.dispatch(Start());
    _verifyAccountBloc = VerifyAccountBloc(
        DependencyProvider.provide(), DependencyProvider.provide(), _timerBloc);
    _verifyAccountBloc.dispatch(LoadPhoneNumber());
  }

  @override
  void dispose() {
    super.dispose();
    _timerBloc.dispose();
    _verifyAccountBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: SafeArea(
        child: BlocListener(
          bloc: _verifyAccountBloc,
          listener: (context, state) {
            if (state is Loading) {
              showDialog(
                  context: context,
                  builder: (context) => ProgressDialog(
                        message: AppLocalizations.of(context)
                            .verifyAccountProgressDialogTitle,
                      ),
                  barrierDismissible: false);
            }
            if (state is ResendLoading) {
              showDialog(
                  context: context,
                  builder: (context) => ProgressDialog(
                        message: AppLocalizations.of(context)
                            .resendCodeProgressDialogTitle,
                      ),
                  barrierDismissible: false);
            }
            if (state is Failed) {
              _hideProgressDialog(context);
              scaffold.hideCurrentSnackBar();
              scaffold.showSnackBar(SnackBar(
                  content: Text(AppLocalizations.of(context).verifyFailed),
                  behavior: SnackBarBehavior.floating));
            }
            if (state is InvalidCode) {
              _hideProgressDialog(context);
              scaffold.hideCurrentSnackBar();
              scaffold.showSnackBar(SnackBar(
                content:
                    Text(AppLocalizations.of(context).invalidVerificationCode),
                behavior: SnackBarBehavior.floating,
              ));
            }
            if (state is Success) {
              _hideProgressDialog(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            }
            if (state is NavigateToCompleteProfilePage) {
              _hideProgressDialog(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddCompanyInfoPage()));
            }
            if (state is NavigateToInterestPickerPage) {
              _hideProgressDialog(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InterestSelectionPage()));
            }
            if (state is ResendRequested) {
              _hideProgressDialog(context);
              scaffold.showSnackBar(SnackBar(
                content:
                    Text(AppLocalizations.of(context).verificationCodeRequest),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
              ));
            }
            if (state is SessionExpired) {
              _hideProgressDialog(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            }
            if (state is Timeout) {
              _hideProgressDialog(context);
              scaffold.showSnackBar(SnackBar(
                content: Text(AppLocalizations.of(context).requestTimeout),
                behavior: SnackBarBehavior.floating,
              ));
            }
          },
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
                  BlocBuilder(
                    builder: (context, state) {
                      if (state is PhoneNumberLoaded)
                        return Text(
                          AppLocalizations.of(context)
                              .accountVerificationMessage(state.phoneNumber),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .body1
                              .copyWith(color: Colors.grey),
                        );
                      return Text(
                        AppLocalizations.of(context)
                            .accountVerificationMessage('    '),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .body1
                            .copyWith(color: Colors.grey),
                      );
                    },
                    bloc: _verifyAccountBloc,
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
                            } else {
                              _verifyAccountBloc
                                  .dispatch(VerifyAccount(codeWidget.codes));
                            }
                          },
                          child:
                              Text(AppLocalizations.of(context).verifyButton),
                        ),
                      ),
                      BlocBuilder(
                        bloc: _timerBloc,
                        builder: (BuildContext context, state) {
                          return OutlineButton(
                            onPressed: state is Finished
                                ? () {
                                    _verifyAccountBloc
                                        .dispatch(ResentVerificationCode());
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
      ),
    );
  }

  bool _hideProgressDialog(BuildContext context) => Navigator.pop(context);

  ScaffoldState get scaffold => _scaffoldKey.currentState;

  VerificationCodeWidgetState get codeWidget => _codeWidgetKey.currentState;

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
}
