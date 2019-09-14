import 'package:Sarh/i10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:Sarh/form_commons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewPasswordPage extends StatefulWidget {
  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _newPasswordTextController;
  TextEditingController _confirmNewPasswordTextController;
  FocusNode _confirmNewPasswordFocusNode;

  FormState get form => _formKey.currentState;

  @override
  void initState() {
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
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
                        return AppLocalizations.of(context).passwordFieldEmpty;
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
    );
  }
}
