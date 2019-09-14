import 'package:Sarh/dependency_provider.dart';
import 'package:Sarh/i10n/app_localizations.dart';
import 'package:Sarh/page/account_reset_verification/account_reset_verification.dart';
import 'package:Sarh/page/verify_account/verify_account_page.dart';
import 'package:Sarh/widget/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:Sarh/form_commons.dart';
import 'package:flutter/services.dart';
import 'bloc/bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetAccountPage extends StatefulWidget {
  @override
  _ResetAccountPageState createState() => _ResetAccountPageState();
}

class _ResetAccountPageState extends State<ResetAccountPage> {
  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  AccountResetBloc _accountResetBloc;

  var _phoneNumber;

  @override
  void initState() {
    super.initState();
    _accountResetBloc = AccountResetBloc(DependencyProvider.provide());
  }

  @override
  void dispose() {
    super.dispose();
    _accountResetBloc.dispose();
  }

  _showSnackBar(snackbar) => _scaffold
    ..hideCurrentSnackBar()
    ..showSnackBar(snackbar);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: BlocListener(
          bloc: _accountResetBloc,
          listener: (context, state) {
            if (state is Loading) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return ProgressDialog(
                      message: 'Finding your account...',
                    );
                  });
            }
            if (state is RequestSuccess) {
              pop(context);
              _showSnackBar(SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Reset account requested successfully'),
                  behavior: SnackBarBehavior.floating));
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AccountResetVerificationPage(
                  phoneNumber: state.phoneNumber,
                );
              }));
            }
            if (state is Error) {
              pop(context);
              _showSnackBar(SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text('Unable to reset account at the moment'),
                  behavior: SnackBarBehavior.floating));
            }
            if (state is Timeout) {
              pop(context);
              _showSnackBar(SnackBar(
                content: Text('request timeout'),
                backgroundColor: Colors.grey,
                action: SnackBarAction(
                    label: AppLocalizations.of(context).retryButton,
                    onPressed: () {
                      _submitPhoneNumber();
                    }),
              ));
            }
            if (state is InvalidPhoneNumber) {
              pop(context);
              _showSnackBar(SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text('Phone number is invalid'),
                behavior: SnackBarBehavior.floating,
              ));
            }
            if (state is AccountNotFound) {
              pop(context);
              _showSnackBar(SnackBar(
                  backgroundColor: Colors.redAccent,
                  content:
                      Text('We couldnt find an account with your phone number'),
                  behavior: SnackBarBehavior.floating));
            }

            if (state is NetworkError) {
              pop(context);
              _showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(AppLocalizations.of(context).noNetworkError),
                action: SnackBarAction(
                    label: AppLocalizations.of(context).retryButton,
                    onPressed: () {
                      _submitPhoneNumber();
                    }),
              ));
            }
          },
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'assets/logo/logo.png',
                        width: 200,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Hero(
                    tag: 'screenName',
                    child: Text(
                      'Reset account',
                      style: Theme.of(context).textTheme.title.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Enter the phone number assoicated with your account below',
                    style: Theme.of(context).textTheme.subhead,
                  ),
                  Text(
                    'we will sent you a message to your phone number containing the verification code',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      onSaved: (phoneNumber) {
                        this._phoneNumber = phoneNumber;
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
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      decoration: buildInputDecoration(
                          AppLocalizations.of(context).phoneNumberFieldHint,
                          FontAwesomeIcons.phone),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Hero(
                    tag: 'button',
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 35,
                      child: RaisedButton(
                        onPressed: () {
                          if (_form.validate()) {
                            _submitPhoneNumber();
                          }
                        },
                        child: Text(AppLocalizations.of(context).submitButton),
                      ),
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

  void _submitPhoneNumber() {
    _form.save();
    _accountResetBloc.dispatch(ResetAccount(_phoneNumber));
  }

  void pop(BuildContext context) {
    Navigator.pop(context);
  }

  FormState get _form => _formKey.currentState;

  ScaffoldState get _scaffold => _scaffoldKey.currentState;
}
