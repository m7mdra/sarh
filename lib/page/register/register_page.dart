import 'dart:isolate';

import 'package:Sarh/page/account_type/account_type_page.dart';
import 'package:Sarh/page/login/login_page.dart';
import 'package:Sarh/page/verify_account/verify_account_page.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:Sarh/widget/progress_dialog.dart';
import 'package:Sarh/widget/relative_align.dart';
import 'package:Sarh/widget/sarh_text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Sarh/i10n/app_localizations.dart';
import 'package:Sarh/form_commons.dart';

import '../../email_validator.dart';

class RegisterPage extends StatefulWidget {
  final Account accountType;

  const RegisterPage({Key key, this.accountType}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with EmailValidator {
  var _selectCity;
  TextEditingController _nameTextEditingController;
  TextEditingController _emailTextEditingController;
  TextEditingController _phoneTextEditingController;
  TextEditingController _passwordTextEditingController;
  TextEditingController _confirmPasswordTextEditingController;
  FocusNode _nameFocusNode;
  FocusNode _emailFocusNode;
  FocusNode _phoneFocusNode;
  FocusNode _passwordFocusNode;
  FocusNode _confirmpPasswordFocusNode;
  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  ScaffoldState get scaffold => _scaffoldKey.currentState;

  FormState get form => _formKey.currentState;

  @override
  void initState() {
    super.initState();
    _nameTextEditingController = TextEditingController();
    _emailTextEditingController = TextEditingController();
    _phoneTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _confirmPasswordTextEditingController = TextEditingController();
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmpPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _nameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _phoneTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _confirmPasswordTextEditingController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmpPasswordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              RelativeAlign(
                  child: BackButtonNoLabel(Theme.of(context).accentColor),
                  alignment: ALIGN.Start),
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
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      RelativeAlign(
                        alignment: ALIGN.Start,
                        child: Hero(
                          tag: 'screenName',
                          child: Text(
                            widget.accountType == Account.personal
                                ? AppLocalizations.of(context).registerUser
                                : AppLocalizations.of(context)
                                    .registerServiceProvider,
                            style: Theme.of(context).textTheme.title.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                      _sizedBox,
                      TextFormField(
                        controller: _nameTextEditingController,
                        focusNode: _nameFocusNode,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(_emailFocusNode);
                        },
                        validator: (name) {
                          if (name.isEmpty)
                            return AppLocalizations.of(context)
                                .nameFieldIsEmpty;
                          else
                            return null;
                        },
                        decoration: buildInputDecoration(
                            widget.accountType == Account.personal
                                ? AppLocalizations.of(context).fullName
                                : AppLocalizations.of(context)
                                    .serviceProviderName,
                            widget.accountType == Account.personal
                                ? FontAwesomeIcons.user
                                : FontAwesomeIcons.building),
                      ),
                      _sizedBox,
                      TextFormField(
                        focusNode: _emailFocusNode,
                        controller: _emailTextEditingController,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(_phoneFocusNode);
                        },
                        validator: (email) {
                          if (email.isEmpty)
                            return AppLocalizations.of(context).emailFieldEmpty;
                          else if (!isValidEmailAddress(email))
                            return AppLocalizations.of(context)
                                .invalidEmailValidationError;
                          else
                            return null;
                        },
                        decoration: buildInputDecoration(
                            AppLocalizations.of(context).emailAddress,
                            FontAwesomeIcons.envelope),
                      ),
                      _sizedBox,
                      TextFormField(
                        focusNode: _phoneFocusNode,
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                        controller: _phoneTextEditingController,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          _passwordFocusNode.requestFocus();
                        },
                        validator: (phone) {
                          if (phone.isEmpty)
                            return AppLocalizations.of(context)
                                .phoneNumberFieldEmpty;
                          else if (phone.length < 10)
                            return AppLocalizations.of(context)
                                .phoneNumberFieldInvalid;
                          else
                            return null;
                        },
                        decoration: buildInputDecoration(
                            AppLocalizations.of(context).phoneNumberFieldHint,
                            FontAwesomeIcons.phone),
                      ),
                      _sizedBox,
                      TextFormField(
                        obscureText: true,
                        validator: (password) {
                          if (password.isEmpty)
                            return AppLocalizations.of(context)
                                .passwordFieldEmpty;
                          else
                            return null;
                        },
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        focusNode: _passwordFocusNode,
                        decoration: buildInputDecoration(
                            AppLocalizations.of(context).passwordFieldName,
                            FontAwesomeIcons.lock),
                      ),
                      _sizedBox,
                      DropdownButtonFormField(
                        onChanged: (value) {
                          setState(() {
                            this._selectCity = value;
                          });
                        },
                        validator: (city) {
                          if (city == null)
                            return AppLocalizations.of(context).cityFieldEmpty;
                          else
                            return null;
                        },
                        value: _selectCity,
                        items: [
                          DropdownMenuItem(
                            child: Text('ابوظبي'),
                            value: '1',
                          ),
                          DropdownMenuItem(
                            child: Text('عجمان'),
                            value: '2',
                          ),
                          DropdownMenuItem(
                            child: Text('الفجيرة'),
                            value: '3',
                          ),
                          DropdownMenuItem(
                            child: Text('الشارقة'),
                            value: '4',
                          ),
                        ],
                        hint: Text(AppLocalizations.of(context).cityFieldHint),
                        decoration: InputDecoration(
                          prefixIcon: Icon(FontAwesomeIcons.map),
                          fillColor: Color(0xffECECEC),
                          filled: true,
                          border: InputBorder.none,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Hero(
                        tag: 'button',
                        child: SizedBox(
                          child: RaisedButton(
                            onPressed: () {
                              if (form.validate())
                                showDialog(
                                    context: (context),
                                    builder: (context) {
                                      return ProgressDialog(
                                        message:
                                            'Please wait while creating your account',
                                      );
                                    });
                            },
                            child:
                                Text(AppLocalizations.of(context).nextButton),
                          ),
                          width: double.infinity,
                          height: 40,
                        ),
                      ),
                      SizedBox(
                        height: 8,
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
      ),
    );
  }

  SizedBox get _sizedBox => SizedBox(height: 4);
}
