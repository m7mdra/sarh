import 'dart:io';

import 'package:Sarh/data/model/activity.dart';
import 'package:Sarh/data/model/company_size.dart';
import 'package:Sarh/dependency_provider.dart';
import 'package:Sarh/i10n/app_localizations.dart';
import 'package:Sarh/page/add_company_profile/bloc/company_size/company_size_bloc.dart';
import 'package:Sarh/page/add_company_profile/bloc/company_size/company_size_event.dart';
import 'package:Sarh/page/add_company_profile/bloc/company_size/company_size_state.dart';
import 'package:Sarh/page/add_company_profile/client_model.dart';
import 'package:Sarh/page/home/activity/bloc/activity_bloc.dart';
import 'package:Sarh/page/home/activity/bloc/activity_event.dart';
import 'package:Sarh/page/home/activity/bloc/activity_state.dart';
import 'package:Sarh/page/login/login_page.dart';
import 'package:Sarh/size_config.dart';
import 'package:Sarh/widget/media_picker_dialog.dart';
import 'package:Sarh/widget/progress_dialog.dart';
import 'package:Sarh/widget/stepper.dart';
import 'package:Sarh/widget/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart' as validator;
import 'bloc/client/add_client/bloc.dart';
import 'bloc/client/load_client/bloc.dart';
import 'bloc/complete_register/bloc.dart';

class AddCompanyInfoPage extends StatefulWidget {
  @override
  _AddCompanyInfoPageState createState() => _AddCompanyInfoPageState();
}

const _kFormFieldPadding = 12.0;

TextStyle get _hintTextStyle => const TextStyle(fontSize: 12);

TextStyle get _labelTextStyle => const TextStyle(fontSize: 14);

SizedBox get _sizedBox => const SizedBox(
      height: 4,
    );

BorderRadius get _border8Radius => BorderRadius.circular(8);

class _AddCompanyInfoPageState extends State<AddCompanyInfoPage> {
  int _currentStep = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  File _logoImage;
  DateTime _startFromDate;
  TextEditingController _startDateController;
  TextEditingController _companyDescriptionController;
  TextEditingController _landLineController;
  TextEditingController _addressController;
  TextEditingController _zipController;
  TextEditingController _websiteController;
  TextEditingController _facebookController;
  TextEditingController _instagramController;
  TextEditingController _twitterController;
  TextEditingController _linkedInController;
  TextEditingController _behanceController;
  CompanySize companySize;
  bool _nextEnable = false;
  File _tradeLicenseFile;
  CompanySizeBloc _companySizeBloc;
  LoadClientBloc _loadClientBloc;
  AddClientBloc _addClientBloc;
  ActivityBloc _activityBloc;
  CompleteRegisterBloc _completeRegisterBloc;
  Activity _activity;
  GlobalKey<FormState> _companyDetailsFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _companyContactFormKey = GlobalKey<FormState>();

  FormState get companyDetailsForm => _companyDetailsFormKey.currentState;

  FormState get companyContactForm => _companyContactFormKey.currentState;

  @override
  void initState() {
    super.initState();
    _companySizeBloc = CompanySizeBloc(DependencyProvider.provide());
    _completeRegisterBloc = CompleteRegisterBloc(
        DependencyProvider.provide());
    _completeRegisterBloc.state.listen((state) {
      print(state);
    });

    _activityBloc = ActivityBloc(DependencyProvider.provide());
    _activityBloc.dispatch(LoadActivities());
    _loadClientBloc = LoadClientBloc(DependencyProvider.provide());
    _addClientBloc = AddClientBloc(DependencyProvider.provide(),
        DependencyProvider.provide(), _loadClientBloc);
    _loadClientBloc.dispatch(LoadClients());
    _companySizeBloc.dispatch(LoadCompanySize());
    _startDateController = TextEditingController();
    _companyDescriptionController = TextEditingController();
    _landLineController = TextEditingController();
    _addressController = TextEditingController();
    _zipController = TextEditingController();
    _websiteController = TextEditingController();
    _facebookController = TextEditingController();
    _instagramController = TextEditingController();
    _twitterController = TextEditingController();
    _linkedInController = TextEditingController();
    _behanceController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _companySizeBloc.dispose();
    _loadClientBloc.dispose();
    _activityBloc.dispose();
    _completeRegisterBloc.dispose();
    _addClientBloc.dispose();
    _startDateController.dispose();
    _companyDescriptionController.dispose();
    _landLineController.dispose();
    _addressController.dispose();
    _zipController.dispose();
    _websiteController.dispose();
    _facebookController.dispose();
    _instagramController.dispose();
    _twitterController.dispose();
    _linkedInController.dispose();
    _behanceController.dispose();
  }

  _moveToNextStep() {
    setState(() {
      _currentStep += 1;
    });
  }

  void _onNextClicked() {
    if (_currentStep != 6) {
      switch (_currentStep ) {
        case 0:
          _moveToNextStep();
          break;
        case 1:
          if (companyDetailsForm.validate()) {
            if (_logoImage == null)
              scaffold.showSnackBar(SnackBar(
                content: Text('Please selected company logo first'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.orange,
              ));
            else
              _moveToNextStep();
          }
          break;
        case 2:
          if (companyContactForm.validate()) {
            _moveToNextStep();
          }
          break;
        case 3:
        case 4:
          _moveToNextStep();
          break;
        case 5:

          _completeRegisterBloc
              .dispatch(CompleteRegister(CompleteRegistrationModel(
            startFromDate: _startDateController.value.text,
            about: _companyDescriptionController.value.text,
            companySize: companySize,
            landPhone: _landLineController.value.text,
            website: _websiteController.value.text,
            activity: _activity,
            companyAttachments: [_tradeLicenseFile],
            socialMediaList: [
              SocialMedia(
                  link: _facebookController.value.text,
                  id: SocialMediaId.FACEBOOk.value),
              SocialMedia(
                  link: _instagramController.value.text,
                  id: SocialMediaId.INSTAGRAM.value),
              SocialMedia(
                  link: _twitterController.value.text,
                  id: SocialMediaId.TWITTER.value),
              SocialMedia(
                  link: _linkedInController.value.text,
                  id: SocialMediaId.LINKEDIN.value),
              SocialMedia(
                  link: _behanceController.value.text,
                  id: SocialMediaId.BEHANCE.value),
            ],
            address: _addressController.value.text,
          )));
          break;
      }
    }
  }

  Widget _buildCompanyDetailsWidgetStep() {
    return Form(
      key: _companyDetailsFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Company details.',
            style: Theme.of(context).textTheme.title,
          ),
          _sizedBox,
          BlocBuilder(
            bloc: _activityBloc,
            builder: (BuildContext context, state) {
              print(state);
              if (state is ActivitySuccess) {
                return _activityPickerWidget(state.activityList);
              }

              if (state is ActivityTimeout ||
                  state is ActivityNetworkError ||
                  state is ActivityError) {
                return _activityPickerWidget([], true);
              }

              return Column(
                children: <Widget>[
                  _activityPickerWidget([]),
                  SizedBox(
                    child: LinearProgressIndicator(),
                    height: 1,
                  )
                ],
              );
            },
          ),
          _sizedBox,
          GestureDetector(
            onTap: () async {
              var pickDate = await showDatePicker(
                  context: context,
                  initialDate: _startFromDate ?? DateTime.now(),
                  firstDate: DateTime(1900, 8),
                  lastDate: DateTime.now());
              if (pickDate == null) return;
              _startDateController.text =
                  '${pickDate.year}-${pickDate.month}-${pickDate.day}';
              setState(() {
                _startFromDate = pickDate;
              });
            },
            child: AbsorbPointer(
              child: TextFormField(
                validator: (date) {
                  if (date.isEmpty)
                    return 'Start date field is empty';
                  else
                    return null;
                },
                controller: _startDateController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(_kFormFieldPadding),
                    labelText: 'Company start from',
                    hintStyle: _hintTextStyle,
                    labelStyle: _labelTextStyle,
                    border: OutlineInputBorder()),
                readOnly: true,
              ),
            ),
          ),
          _sizedBox,
          TextFormField(
            maxLength: 100,
            maxLines: 2,
            controller: _companyDescriptionController,
            validator: (description) {
              if (description.isEmpty) {
                return 'Description field is empty';
              } else
                return null;
            },
            maxLengthEnforced: true,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(_kFormFieldPadding),
                labelText: 'Company description',
                hintStyle: _hintTextStyle,
                labelStyle: _labelTextStyle,
                hintText: 'In less than 100 Characters describe the company',
                border: OutlineInputBorder()),
          ),
          _sizedBox,
          Text('Number of Employees: ',
              style: Theme.of(context).textTheme.subtitle),
          BlocBuilder(
            bloc: _companySizeBloc,
            builder: (BuildContext context, state) {
              if (state is CompanySizeLoaded) {
                return _companySizeRange(false, state.sizes);
              }
              if (state is CompanySizeFailed) {
                return _companySizeRange(true, []);
              }
              return Container();
            },
          )
        ],
      ),
    );
  }

  Widget _activityPickerWidget(List<Activity> activities,
      [bool error = false]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DropdownButtonFormField<Activity>(
            onChanged: (activity) {
              setState(() {
                this._activity = activity;
              });
            },
            items: activities
                .map((activity) => DropdownMenuItem(
                      child: Text('${activity.nameEn} - ${activity.nameAr}'),
                      value: activity,
                    ))
                .toList(),
            value: _activity,
            validator: (_activity) {
              if (_activity == null)
                return 'Select main activity';
              else
                return null;
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(_kFormFieldPadding),
                hintStyle: _hintTextStyle,
                labelStyle: _labelTextStyle,
                hintText: 'Main activiy',
                border: OutlineInputBorder())),
        Visibility(
          visible: error,
          child: Text('Failed to load activities',
              style: TextStyle(color: Theme.of(context).errorColor)),
        ),
        Visibility(
          visible: error,
          child: OutlineButton(
              onPressed: () {
                _activityBloc.dispatch(LoadActivities());
              },
              child: Text(
                AppLocalizations.of(context).retryButton,
              )),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          _buildTopArcAndLogo(context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: WeeStepper(
                nextEnabled: _nextEnable,
                steps: [
                  WeeStep(content: _acceptTermsStep(context)),
                  WeeStep(content: _buildCompanyDetailsWidgetStep()),
                  WeeStep(content: _buildContactInformationStep()),
                  WeeStep(content: _buildFeatureClientStep(context)),
                  WeeStep(content: _buildSocialMediaStep()),
                  WeeStep(content: _documentsStep(context)),
                ],
                currentStep: _currentStep,
                onStepContinue: _onNextClicked,
                onPrevious: () {

                  setState(() {
                    if (_currentStep != 0) _currentStep -= 1;
                  });
                  print(_currentStep);

                },
                onStepTapped: (step) {
                  setState(() {
                    this._currentStep = step;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _documentsStep(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Documents',
          style: Theme.of(context).textTheme.title,
        ),
        _sizedBox,
        Text(
          'Upload company trade license',
          style: Theme.of(context).textTheme.caption,
        ),
        _sizedBox,
        Stack(
          children: <Widget>[
            if (_tradeLicenseFile != null)
              ClipRRect(
                borderRadius: _border8Radius,
                child: Image.file(
                  _tradeLicenseFile,
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            InkWell(
              onTap: () async {
                var file = await showDialog(
                    context: context, builder: (context) => MediaPickDialog());
                if (file != null)
                  setState(() {
                    _tradeLicenseFile = file;
                  });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: _border8Radius,
                  color: Colors.black12,
                ),
                height: 150,
                child: Center(
                  child: Icon(Icons.camera_alt),
                ),
              ),
            ),
          ],
        ),
        _sizedBox,
        Text.rich(TextSpan(children: [
          TextSpan(
              text: 'Note: ', style: TextStyle(fontWeight: FontWeight.w600)),
          TextSpan(
              text: 'The documents required to verify your account.\nyou can '
                  'skip this step by '
                  'pressing the next button, you can upload '
                  'it later from your profile.')
        ]))
      ],
    );
  }

  Column _acceptTermsStep(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          'assets/logo/logo.png',
          width: 150,
        ),
        _sizedBox,
        _sizedBox,
        _sizedBox,
        Text(
          'Welcome to Sarh',
          style: Theme.of(context).textTheme.title,
        ),
        Text(
          'Complete your Service provider registeration',
          style: Theme.of(context).textTheme.caption,
        ),
        _sizedBox,
        Text(
          'By comlpeting registeration, your profile will be'
          ' activated and other users/companies can interact with you',
          style: Theme.of(context).textTheme.body1,
          textAlign: TextAlign.center,
        ),
        _sizedBox,
        _sizedBox,
        CheckboxListTile(
          selected: _nextEnable,
          value: _nextEnable,
          dense: true,
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (bool value) {
            setState(() {
              _nextEnable = !_nextEnable;
            });
          },
          title: Text.rich(TextSpan(children: [
            TextSpan(
                text: 'By checking, you are Indicating that your '
                    'agree to the '),
            TextSpan(
                text: 'Privacy Policy',
                style: TextStyle(decoration: TextDecoration.underline)),
            TextSpan(text: '  '),
            TextSpan(
                text: 'Terms of Conditions',
                style: TextStyle(decoration: TextDecoration.underline))
          ])),
        )
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }

  _buildTopArcAndLogo(BuildContext context) {
    return Opacity(
      opacity: _currentStep == 0 ? 0 : 1.0,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: SizeConfig.blockSizeVertical * 25,
          child: Stack(
            fit: StackFit.loose,
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                bottom: -30,
                left: 16,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: InkWell(
                    onTap: () async {
                      var pickImage = await showDialog(
                          context: context,
                          builder: (context) => MediaPickDialog());
                      if (pickImage == null) return;

                      setState(() {
                        _logoImage = pickImage;
                      });
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      child: _logoImage == null
                          ? Icon(
                              Icons.camera_alt,
                              size: 30,
                            )
                          : ClipOval(
                              clipBehavior: Clip.antiAlias,
                              child: Image.file(
                                _logoImage,
                                width: 80,
                                alignment: Alignment.center,
                                height: 80,
                                fit: BoxFit.fitWidth,
                              )),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
              color: Color(0xff4AA2FB),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8))),
        ),
      ),
    );
  }

  Column _buildSocialMediaStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Social Media Accounts',
          style: Theme.of(context).textTheme.title,
        ),
        _sizedBox,
        TextFormField(
          controller: _facebookController,
          keyboardType: TextInputType.url,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(_kFormFieldPadding),
              labelText: 'https:www.facebook.com/',
              hintStyle: _hintTextStyle,
              prefixIcon: Icon(FontAwesomeIcons.facebookF),
              labelStyle: _labelTextStyle,
              hintText: 'Enter facebook account',
              border: OutlineInputBorder()),
        ),
        _sizedBox,
        TextFormField(
          keyboardType: TextInputType.url,
          controller: _instagramController,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(_kFormFieldPadding),
              labelText: 'https:www.instagram.com/',
              hintStyle: _hintTextStyle,
              prefixIcon: Icon(FontAwesomeIcons.instagram),
              labelStyle: _labelTextStyle,
              hintText: 'Enter Instagram account',
              border: OutlineInputBorder()),
        ),
        _sizedBox,
        TextFormField(
          keyboardType: TextInputType.url,
          controller: _twitterController,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(_kFormFieldPadding),
              labelText: 'https:www.twitter.com/',
              hintStyle: _hintTextStyle,
              prefixIcon: Icon(FontAwesomeIcons.twitter),
              labelStyle: _labelTextStyle,
              hintText: 'Enter Twitter account',
              border: OutlineInputBorder()),
        ),
        _sizedBox,
        TextFormField(
          keyboardType: TextInputType.url,
          controller: _linkedInController,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(_kFormFieldPadding),
              labelText: 'https:www.linkedin.com/',
              hintStyle: _hintTextStyle,
              prefixIcon: Icon(FontAwesomeIcons.linkedinIn),
              labelStyle: _labelTextStyle,
              hintText: 'Enter Linkedin account',
              border: OutlineInputBorder()),
        ),
        _sizedBox,
        TextFormField(
          keyboardType: TextInputType.url,
          controller: _behanceController,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(_kFormFieldPadding),
              labelText: 'https:www.behance.com/',
              hintStyle: _hintTextStyle,
              prefixIcon: Icon(FontAwesomeIcons.behance),
              labelStyle: _labelTextStyle,
              hintText: 'Enter Behance account',
              border: OutlineInputBorder()),
        ),
      ],
    );
  }

  Widget _buildFeatureClientStep(BuildContext context) {
    return BlocListener(
      bloc: _addClientBloc,
      listener: (context, state) {
        if (state is LoadingAdd) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => ProgressDialog(
                    message: 'Adding new client...',
                  ));
        }
        if (state is NewClientAdded) {
          pop(context);
          scaffold.showSnackBar(SnackBar(
            content: Text('Client added successfully.'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ));
        }
        if (state is AddError || state is AddNetworkError) {
          pop(context);
          scaffold.showSnackBar(SnackBar(
            content: Text('Failed to add new client'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: AppLocalizations.of(context).retryButton,
              onPressed: () {
                _addClientBloc.dispatch(RetryAdd());
              },
            ),
          ));
        }
        if (state is AddSessionExpired) {
          _onSessionExpired(context);
        }
      },
      child: Column(
        children: <Widget>[
          Text(
            'Featured clients',
            style: Theme.of(context).textTheme.title,
          ),
          _sizedBox,
          BlocListener(
            bloc: _loadClientBloc,
            child: BlocBuilder(
              bloc: _loadClientBloc,
              builder: (BuildContext context, LoadClientState state) {
                if (state is LoadingClients) {
                  return ProgressBar();
                }
                if (state is LoadError) {
                  return GeneralErrorWidget(onRetry: _onRetry);
                }
                if (state is EmptyWidget) {
                  return EmptyWidget();
                }
                if (state is LoadNetworkError) {
                  return NetworkErrorWidget(onRetry: _onRetry);
                }
                if (state is ClientsLoaded) {
                  return ListView.builder(
                    primary: false,
                    itemBuilder: (context, index) {
                      var client = state.clients[index];
                      return ListTile(
                        title: Text(
                          client.name,
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(client.website),
                        leading: Image.network(
                          client.logo,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    itemCount: state.clients.length,
                    shrinkWrap: true,
                  );
                }
                return Container();
              },
            ),
            listener: (BuildContext context, state) {
              if (state is LoadSessionExpired) _onSessionExpired(context);
            },
          ),
          _sizedBox,
          Center(
            child: RaisedButton(
              onPressed: () async {
                var featuredClient = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddClientPage(),
                        fullscreenDialog: true));
                if (featuredClient != null) {
                  _addClientBloc.dispatch(AddNewClient(featuredClient));
                }
              },
              child: Text('Add client'),
            ),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }

  void _onSessionExpired(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  }

  bool pop(BuildContext context) => Navigator.pop(context);

  void _onRetry() {
    _loadClientBloc.dispatch(RetryLoad());
  }

  ScaffoldState get scaffold => _scaffoldKey.currentState;

  Widget _buildContactInformationStep() {
    return Form(
      key: _companyContactFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Contact information.',
            style: Theme.of(context).textTheme.title,
          ),
          _sizedBox,
          TextFormField(
            validator: (landLine) {
              if (landLine.isEmpty) {
                return 'Land line field is empty';
              } else
                return null;
            },
            inputFormatters: [LengthLimitingTextInputFormatter(10)],
            keyboardType: TextInputType.phone,
            controller: _landLineController,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(_kFormFieldPadding),
                labelText: 'Land line number',
                hintText: 'Enter land line number',
                hintStyle: _hintTextStyle,
                labelStyle: _labelTextStyle,
                border: OutlineInputBorder()),
          ),
          _sizedBox,
          TextFormField(
            controller: _addressController,
            validator: (address) {
              if (address.isEmpty) {
                return 'Address field is empty';
              } else
                return null;
            },
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(_kFormFieldPadding),
                labelText: 'Address',
                hintText: 'Enter company address',
                hintStyle: _hintTextStyle,
                labelStyle: _labelTextStyle,
                border: OutlineInputBorder()),
          ),
          _sizedBox,
          TextFormField(
            controller: _zipController,
            validator: (zip) {
              if (zip.isEmpty) {
                return 'Zip field is empty';
              } else
                return null;
            },
            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(_kFormFieldPadding),
                labelText: 'ZIP code',
                hintText: 'Enter ZIP code',
                hintStyle: _hintTextStyle,
                labelStyle: _labelTextStyle,
                border: OutlineInputBorder()),
          ),
          _sizedBox,
          TextFormField(
            validator: (website) {
              if (website.isEmpty)
                return null;
              else {
                if (!validator.isURL(website)) {
                  return 'Invalid url';
                } else {
                  return null;
                }
              }
            },
            controller: _websiteController,
            keyboardType: TextInputType.url,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(_kFormFieldPadding),
                labelText: 'Website address URL',
                hintText: 'Enter Website address URL',
                hintStyle: _hintTextStyle,
                labelStyle: _labelTextStyle,
                border: OutlineInputBorder()),
          ),
        ],
      ),
    );
  }

  Widget _companySizeRange(bool failed, List<CompanySize> sizes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DropdownButtonFormField<CompanySize>(
          validator: (size) {
            if (size == null) {
              return 'Select number clients';
            } else
              return null;
          },
          onChanged: (newSize) {
            setState(() {
              this.companySize = newSize;
            });
          },
          value: companySize,
          items: sizes
              .map((size) => DropdownMenuItem(
                    child: Text('${size.size} employees'),
                    value: size,
                  ))
              .toList(),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(_kFormFieldPadding),
              hintStyle: _hintTextStyle,
              labelStyle: _labelTextStyle,
              hintText: 'Number of Total Clients',
              border: OutlineInputBorder()),
        ),
        Visibility(
          child: Text(
            'Failed to load data',
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
          visible: failed,
        ),
        Visibility(
            visible: failed,
            child: OutlineButton(
              onPressed: () {
                _companySizeBloc.dispatch(LoadCompanySize());
              },
              child: Text('Retry'),
            ))
      ],
    );
  }
}

class AddClientPage extends StatefulWidget {
  const AddClientPage({Key key}) : super(key: key);

  @override
  _AddClientPageState createState() => _AddClientPageState();
}

class _AddClientPageState extends State<AddClientPage> {
  File _logoFile;
  TextEditingController _clientNameController;
  TextEditingController _clientWebsiteUrl;
  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _clientNameController = TextEditingController();
    _clientWebsiteUrl = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _clientWebsiteUrl.dispose();
    _clientNameController.dispose();
  }

  FormState get form => _formKey.currentState;

  ScaffoldState get scaffold => _scaffoldKey.currentState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add Featured Client'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    'Enter the client details',
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text('Featured client will be shown in your profile'),
                  _sizedBox,
                  _sizedBox,
                  Text('Client logo'),
                  _sizedBox,
                  Stack(
                    children: <Widget>[
                      if (_logoFile != null)
                        ClipRRect(
                          borderRadius: _border8Radius,
                          child: Image.file(
                            _logoFile,
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      InkWell(
                        onTap: () async {
                          var file = await showDialog(
                              context: context,
                              builder: (context) {
                                return MediaPickDialog();
                              });
                          if (file != null)
                            setState(() {
                              this._logoFile = file;
                            });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: _border8Radius,
                            color: Colors.black12,
                          ),
                          height: 150,
                          width: 150,
                          child: Center(
                            child: Icon(Icons.camera_alt),
                          ),
                        ),
                      ),
                    ],
                  ),
                  _sizedBox,
                  _sizedBox,
                  TextFormField(
                    controller: _clientNameController,
                    validator: (name) {
                      if (name.isEmpty) {
                        return 'Client name is empty';
                      } else
                        return null;
                    },
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.all(_kFormFieldPadding),
                        labelText: 'Enter client name',
                        hintStyle: _hintTextStyle,
                        labelStyle: _labelTextStyle,
                        hintText: 'Client name',
                        border: OutlineInputBorder()),
                  ),
                  _sizedBox,
                  TextFormField(
                    controller: _clientWebsiteUrl,
                    validator: (website) {
                      if (website.isEmpty)
                        return null;
                      else {
                        if (!validator.isURL(website)) {
                          return 'invalid url';
                        } else {
                          return null;
                        }
                      }
                    },
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.all(_kFormFieldPadding),
                        labelText: 'Client website URL',
                        hintStyle: _hintTextStyle,
                        labelStyle: _labelTextStyle,
                        hintText: 'Website',
                        border: OutlineInputBorder()),
                  ),
                  _sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: _border8Radius),
                        color: Colors.grey.withAlpha(50),
                        textColor: Colors.black,
                        child: Text('Cancel'),
                      ),
                      RaisedButton(
                        elevation: 0,
                        onPressed: () {
                          if (form.validate()) {
                            if (_logoFile == null) {
                              scaffold.showSnackBar(SnackBar(
                                content: Text('Client logo is required'),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.redAccent,
                              ));
                              return;
                            }
                            Navigator.pop(
                                context,
                                FeaturedClient(
                                    name: _clientNameController.text,
                                    logo: _logoFile,
                                    website: _clientWebsiteUrl.text));
                          }
                        },
                        child: Text('Save'),
                        shape: RoundedRectangleBorder(
                            borderRadius: _border8Radius),
                      ),
                    ],
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
