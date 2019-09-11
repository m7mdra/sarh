import 'package:Sarh/data/model/city.dart';
import 'package:Sarh/dependency_provider.dart';
import 'package:Sarh/page/account_type/account_type_page.dart';
import 'package:Sarh/page/login/login_page.dart';
import 'package:Sarh/page/register/bloc/register_bloc.dart';
import 'package:Sarh/page/register/bloc/register_bloc_event.dart';
import 'package:Sarh/page/register/bloc/register_bloc_state.dart';
import 'package:Sarh/page/verify_account/verify_account_page.dart';
import 'package:Sarh/widget/progress_dialog.dart';
import 'package:Sarh/widget/relative_align.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Sarh/i10n/app_localizations.dart';
import 'package:Sarh/form_commons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../validators.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:Sarh/locale.dart';

class RegisterPage extends StatefulWidget {
  final AccountType accountType;

  const RegisterPage({Key key, this.accountType}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with Validators {
  City _selectCity;
  TextEditingController _nameTextEditingController;
  TextEditingController _emailTextEditingController;
  TextEditingController _phoneTextEditingController;
  TextEditingController _passwordTextEditingController;
  TextEditingController _confirmPasswordTextEditingController;
  FocusNode _nameFocusNode;
  FocusNode _usernameFocusNode;
  FocusNode _emailFocusNode;
  FocusNode _phoneFocusNode;
  FocusNode _passwordFocusNode;
  FocusNode _confirmPasswordFocusNode;
  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  RegisterBloc _registerBloc;

  ScaffoldState get scaffold => _scaffoldKey.currentState;

  FormState get form => _formKey.currentState;

  @override
  void initState() {
    super.initState();
    _registerBloc = RegisterBloc(DependencyProvider.provide(),
        DependencyProvider.provide(), DependencyProvider.provide());
    _registerBloc.dispatch(LoadCities());
    _nameTextEditingController = TextEditingController();
    _phoneTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _confirmPasswordTextEditingController = TextEditingController();
    _nameFocusNode = FocusNode();
    _usernameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _registerBloc.dispose();
    _nameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _phoneTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _confirmPasswordTextEditingController.dispose();
    _nameFocusNode.dispose();
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: BlocListener(
          listener: (context, state) {
            if (state is Loading) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => ProgressDialog(
                      message: AppLocalizations.of(context)
                          .creatingAccountProgressTitle(widget.accountType ==
                                  AccountType.personal
                              ? AppLocalizations.of(context).personalAccountType
                              : AppLocalizations.of(context)
                                  .serviceProviderAccountType)));
            }
            if (state is NetworkError) {
              Navigator.pop(context);
              scaffold
                ..hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss)
                ..showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text(AppLocalizations.of(context).noNetworkError),
                  action: SnackBarAction(
                      label: AppLocalizations.of(context).retryButton,
                      onPressed: () async {
                        await _attemptRegister();
                      }),
                ));
            }
            if (state is RegisterError) {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title:
                          Text(AppLocalizations.of(context).errorDialogTitle),
                      content: Text(state.error),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                              MaterialLocalizations.of(context).okButtonLabel),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  });
            }
            if (state is Success) {
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return VerifyAccountPage(
                  accountType: state.accountType,
                );
              }));
            }
          },
          bloc: _registerBloc,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50,
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
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          RelativeAlign(
                            alignment: ALIGN.Start,
                            child: Hero(
                              tag: 'screenName',
                              child: Text(
                                widget.accountType == AccountType.personal
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
                              FocusScope.of(context)
                                  .requestFocus(_usernameFocusNode);
                            },
                            validator: (name) {
                              if (name.isEmpty)
                                return AppLocalizations.of(context)
                                    .nameFieldIsEmpty;
                              else
                                return null;
                            },
                            decoration: buildInputDecoration(
                                widget.accountType == AccountType.personal
                                    ? AppLocalizations.of(context).fullName
                                    : AppLocalizations.of(context)
                                        .serviceProviderName,
                                widget.accountType == AccountType.personal
                                    ? FontAwesomeIcons.user
                                    : FontAwesomeIcons.building),
                          ),
                          _sizedBox,
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            focusNode: _emailFocusNode,
                            controller: _emailTextEditingController,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(_phoneFocusNode);
                            },
                            validator: (email) {
                              if (email.isEmpty)
                                return AppLocalizations.of(context)
                                    .emailFieldEmpty;
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
                            keyboardType: TextInputType.phone,
                            focusNode: _phoneFocusNode,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10)
                            ],
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
                            controller: _passwordTextEditingController,
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
                          BlocBuilder(
                            bloc: _registerBloc,
                            condition: (previous, current) {
                              return current is CitiesLoaded;
                            },
                            builder: (BuildContext context, state) {
                              if (state is CitiesLoaded)
                                return DropdownButtonFormField<City>(
                                  onChanged: (value) {
                                    setState(() {
                                      this._selectCity = value;
                                    });
                                  },
                                  validator: (city) {
                                    if (city == null)
                                      return AppLocalizations.of(context)
                                          .cityFieldEmpty;
                                    else
                                      return null;
                                  },
                                  value: _selectCity,
                                  items: state.cities.map((city) {
                                        return DropdownMenuItem(
                                            value: city,
                                            child: Text(
                                                currentLanguage(context) == 'ar'
                                                    ? city.arName
                                                    : city.name));
                                      }).toList() ??
                                      [],
                                  hint: Text(
                                      AppLocalizations.of(context).cityFieldHint),
                                  decoration: dropDownDecoration,
                                );
                              return DropdownButtonFormField(
                                  items: [],
                                  hint: Text(
                                      AppLocalizations.of(context).cityFieldHint),
                                  decoration: dropDownDecoration);
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Hero(
                            tag: 'button',
                            child: SizedBox(
                              child: RaisedButton(
                                onPressed: () async {
                                  if (form.validate()) await _attemptRegister();
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _attemptRegister() async {
    _registerBloc.dispatch(Register(
        city: _selectCity.id,
        name: _nameTextEditingController.text.trim(),
        accountType: widget.accountType == AccountType.personal ? 1 : 2,
        password: _passwordTextEditingController.text.trim(),
        email: _emailTextEditingController.text.trim(),
        phoneNumber: _phoneTextEditingController.text.trim(),
        messagingToken: await FirebaseMessaging().getToken()));
  }

  InputDecoration get dropDownDecoration {
    return InputDecoration(
      prefixIcon: Icon(FontAwesomeIcons.map),
      fillColor: Color(0xffECECEC),
      filled: true,
      contentPadding: const EdgeInsets.all(8),
      border: InputBorder.none,
    );
  }

  SizedBox get _sizedBox => SizedBox(height: 4);
}
