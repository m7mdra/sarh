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

import 'package:Sarh/dependency_provider.dart';
import 'package:Sarh/i10n/app_localizations.dart';
import 'package:Sarh/page/new_password/bloc/bloc.dart';
import 'package:Sarh/widget/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:Sarh/commons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login/login_page.dart';

class NewPasswordPage extends StatefulWidget {
  final String resetToken;
  final String phoneNumber;

  const NewPasswordPage({Key key, this.resetToken, this.phoneNumber})
      : super(key: key);

  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TextEditingController _newPasswordTextController;
  TextEditingController _confirmNewPasswordTextController;
  FocusNode _confirmNewPasswordFocusNode;
  NewPasswordBloc _newPasswordBloc;

  FormState get form => _formKey.currentState;

  ScaffoldState get scaffold => _scaffoldKey.currentState;

  @override
  void initState() {
    super.initState();
    _newPasswordBloc = NewPasswordBloc(DependencyProvider.provide());
    _newPasswordTextController = TextEditingController();
    _confirmNewPasswordTextController = TextEditingController();
    _confirmNewPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _newPasswordTextController.dispose();
    _confirmNewPasswordTextController.dispose();
    _confirmNewPasswordFocusNode.dispose();
    _newPasswordBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Center(
          child: BlocListener(
            bloc: _newPasswordBloc,
            listener: (context, state) async {
              if (state is Loading) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return ProgressDialog(
                        message: 'Assigning new password to your account...',
                      );
                    });
              }
              if (state is Success) {
                await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Account reset success.'),
                        content: Text(
                            'You can now use the new password to access your account.'),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(MaterialLocalizations.of(context)
                                  .okButtonLabel))
                        ],
                      );
                    },
                    barrierDismissible: false);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              }
              if (state is Timeout) {
                scaffold.showSnackBar(SnackBar(
                  content: Text('Request time out, try again'),
                  behavior: SnackBarBehavior.floating,
                  action: SnackBarAction(
                    onPressed: () => _submitNewPassword(),
                    label: AppLocalizations.of(context).retryButton,
                  ),
                ));
              }
              if (state is NetworkError) {
                scaffold.showSnackBar(SnackBar(
                  content: Text('No active connection found.'),
                  behavior: SnackBarBehavior.floating,
                  action: SnackBarAction(
                    onPressed: () => _submitNewPassword(),
                    label: AppLocalizations.of(context).retryButton,
                  ),
                ));
              }
              if (state is Failed) {
                scaffold.showSnackBar(SnackBar(
                  content: Text('Failed to change password.'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                ));
              }
            },
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Account Verified Successfully',
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text(
                      'Type your new password below',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      onEditingComplete: () {
                        FocusScope.of(context)
                            .requestFocus(_confirmNewPasswordFocusNode);
                      },
                      textInputAction: TextInputAction.next,
                      controller: _newPasswordTextController,
                      validator: (password) {
                        if (password.isEmpty) {
                          return AppLocalizations.of(context)
                              .passwordFieldEmpty;
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      decoration: buildInputDecoration(
                          'New password', FontAwesomeIcons.lock),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                        controller: _confirmNewPasswordTextController,
                        focusNode: _confirmNewPasswordFocusNode,
                        validator: (confirmPassword) {
                          if (confirmPassword.isEmpty) {
                            return 'Confirm password field empty';
                          } else if (confirmPassword !=
                              _newPasswordTextController.value.text) {
                            return 'password mismatch';
                          } else
                            return null;
                        },
                        obscureText: true,
                        decoration: buildInputDecoration(
                            'Confrim new password', FontAwesomeIcons.lock)),
                    SizedBox(
                      height: 16,
                    ),
                    Hero(
                      tag: 'button',
                      child: RaisedButton(
                        onPressed: () {
                          if (form.validate()) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            _submitNewPassword();
                          }
                        },
                        child: Text(AppLocalizations.of(context).submitButton),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitNewPassword() {
    _newPasswordBloc.dispatch(SubmitNewPassword(_newPasswordTextController.text,
        widget.resetToken, widget.phoneNumber));
  }
}
