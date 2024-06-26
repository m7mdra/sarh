/*
 * Copyright (c) 2019.
 *           ______             _
 *          |____  |           | |
 *  _ __ ___    / / __ ___   __| |_ __ __ _
 * | '_ ` _ \  / / '_ ` _ \ / _` | '__/ _` |
 * | | | | | |/ /| | | | | | (_| | | | (_| |
 * |_| |_| |_/_/ |_| |_| |_|\__,_|_|  \__,_|
 *
 *
 *
 *
 */

import 'package:Sarh/commons.dart';
import 'package:Sarh/dependency_provider.dart';
import 'package:Sarh/i10n/app_localizations.dart';
import 'package:Sarh/page/account_reset/account_reset_page.dart';
import 'package:Sarh/page/account_type/account_type_page.dart';
import 'package:Sarh/page/add_company_profile/add_company_info_page.dart';
import 'package:Sarh/page/home/main/main_page.dart';
import 'package:Sarh/page/login/bloc/login_event_state.dart';
import 'package:Sarh/page/verify_account/verify_account_page.dart';
import 'package:Sarh/widget/progress_dialog.dart';
import 'package:Sarh/widget/relative_align.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../validators.dart';
import 'bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Validators {
  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  FocusNode _passwordFocusNode;
  TextEditingController _idTextEditingController;
  TextEditingController _passwordTextEditingController;
  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _idTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _loginBloc =
        LoginBloc(DependencyProvider.provide(), DependencyProvider.provide());
  }

  @override
  void dispose() {
    super.dispose();
    _passwordFocusNode.dispose();
    _passwordTextEditingController.dispose();
    _idTextEditingController.dispose();
    _loginBloc.dispose();
  }

  ScaffoldState get scaffold => _scaffoldKey.currentState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'assets/logo/logo.png',
                        width: 200,
                      ),
                    ),
                  ),
                ),
                buildSizedBox(),
                buildSizedBox(),
                buildSizedBox(),
                buildSizedBox(),
                buildSizedBox(),
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: BlocListener(
                    bloc: _loginBloc,
                    listener: (context, state) {
                      if (state is LoadingState) {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => ProgressDialog(
                                  message: AppLocalizations.of(context)
                                      .loginLoadingDialogMessage,
                                ));
                      }
                      if (state is SuccessState) {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => MainPage()));
                      }
                      if (state is AccountNotVerified) {
                        Navigator.pop(context);

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyAccountPage()));
                      }
                      if (state is ProfileNotCompleted) {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    AddCompanyInfoPage()));
                      }
                      if (state is NetworkError) {
                        Navigator.pop(context);
                        scaffold
                          ..hideCurrentSnackBar(
                              reason: SnackBarClosedReason.dismiss)
                          ..showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                                AppLocalizations.of(context).noNetworkError),
                            action: SnackBarAction(
                                label: AppLocalizations.of(context).retryButton,
                                onPressed: () {
                                  attemptLogin();
                                }),
                          ));
                      }
                      if (state is InvalidUsernameOrPassword) {
                        Navigator.pop(context);

                        scaffold.showSnackBar(SnackBar(
                            backgroundColor: Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                            content: Text(AppLocalizations.of(context)
                                .invalidLoginCredentials)));
                      }
                      if (state is LoginError) {
                        Navigator.pop(context);
                        scaffold.showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            'Unable to login right now, try later.',
                          ),
                        ));
                      }
                    },
                    child: Form(
                      key: _formKey,
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
                                style:
                                    Theme.of(context).textTheme.title.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                              ),
                            ),
                          ),
                          buildSizedBox(),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _idTextEditingController,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocusNode);
                            },
                            validator: (value) {
                              if (value.contains('@') &&
                                  !isValidEmailAddress(value))
                                return AppLocalizations.of(context)
                                    .invalidEmailValidationError;
                              else if (value.isEmpty)
                                return AppLocalizations.of(context)
                                    .emptyEmailValidationError;
                              return null;
                            },
                            decoration: buildInputDecoration(
                                AppLocalizations.of(context)
                                    .userIdentifierFieldHint,
                                FontAwesomeIcons.user),
                          ),
                          buildSizedBox(),
                          TextFormField(
                            focusNode: _passwordFocusNode,
                            controller: _passwordTextEditingController,
                            obscureText: true,
                            onEditingComplete: () {
                              isFormValid();
                              _hideKeyboard(context);
                            },
                            validator: (value) {
                              if (value.isEmpty)
                                return AppLocalizations.of(context)
                                    .emptyPasswordValidationError;
                              else
                                return null;
                            },
                            decoration: buildInputDecoration(
                                AppLocalizations.of(context).passwordFieldName,
                                FontAwesomeIcons.lock),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Hero(
                            tag: 'button',
                            child: SizedBox(
                              child: RaisedButton(
                                onPressed: () {
                                  if (isFormValid()) attemptLogin();
                                },
                                child: Text(
                                    AppLocalizations.of(context).signInButton),
                              ),
                              width: double.infinity,
                              height: 40,
                            ),
                          ),
                          buildSizedBox(),
                          RelativeAlign(
                            
                            alignment: ALIGN.Start,
                            child: FlatButton(
                            padding: const EdgeInsets.all(0),
                                onPressed: () =>
                                    _navigatedToResetAccountPage(context),
                                child: Text(AppLocalizations.of(context)
                                    .forgetMyPasswordButton)),
                          ),
                          buildSizedBox(),
                          RelativeAlign(
                            alignment: ALIGN.Start,
                            child: Text.rich(
                              TextSpan(
                                text: AppLocalizations.of(context)
                                    .iDontHaveAnAccount,
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
        ),
      ),
    );
  }

  void attemptLogin() {
    _loginBloc.dispatch(AttemptLogin(_idTextEditingController.text.trim(),
        _passwordTextEditingController.text.trim()));
  }

  SizedBox buildSizedBox() {
    return SizedBox(
      height: 8,
    );
  }

  void _hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  bool isFormValid() => _formKey.currentState.validate();

  _navigatedToResetAccountPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ResetAccountPage()));
  }
}
