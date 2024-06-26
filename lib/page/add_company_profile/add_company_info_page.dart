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

import 'dart:io';

import 'package:Sarh/data/model/activity.dart';
import 'package:Sarh/data/model/category.dart';
import 'package:Sarh/data/model/company_size.dart';
import 'package:Sarh/dependency_provider.dart';
import 'package:Sarh/i10n/app_localizations.dart';
import 'package:Sarh/page/activity/bloc/bloc.dart';
import 'package:Sarh/page/add_company_profile/bloc/company_size/company_size_bloc.dart';
import 'package:Sarh/page/add_company_profile/bloc/company_size/company_size_event.dart';
import 'package:Sarh/page/add_company_profile/bloc/company_size/company_size_state.dart';
import 'package:Sarh/page/add_company_profile/client_model.dart';
import 'package:Sarh/page/home/category/bloc/category_bloc.dart';
import 'package:Sarh/page/home/category/bloc/category_event.dart';
import 'package:Sarh/page/home/category/bloc/category_state.dart';
import 'package:Sarh/page/home/main/main_page.dart';
import 'package:Sarh/page/location_picker/location_picker_page.dart';
import 'package:Sarh/page/login/bloc/login_event_state.dart';
import 'package:Sarh/page/login/login_page.dart';
import 'package:Sarh/page/privacy_policy/privacy_policy_page.dart';
import 'package:Sarh/page/profile_image_modify/bloc/bloc.dart';
import 'package:Sarh/page/profile_image_modify/bloc/modify_profile_image_bloc.dart';
import 'package:Sarh/page/profile_image_modify/bloc/modify_profile_image_event.dart';
import 'package:Sarh/page/sub_category/bloc/bloc.dart';
import 'package:Sarh/page/tos/tos_page.dart';
import 'package:Sarh/size_config.dart';
import 'package:Sarh/widget/media_picker_dialog.dart';
import 'package:Sarh/widget/progress_dialog.dart';
import 'package:Sarh/widget/stepper.dart';
import 'package:Sarh/widget/ui_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
  File _logoFile;
  bool _nextEnable = false;
  File _tradeLicenseFile;
  CompanySizeBloc _companySizeBloc;
  LoadClientBloc _loadClientBloc;
  AddClientBloc _addClientBloc;
  CategoryBloc _categoryBloc;
  ActivityBloc _activityBloc;
  SubCategoryBloc _subCategoryBloc;
  ModifyProfileImageBloc _modifyProfileImageBloc;
  CompleteRegisterBloc _completeRegisterBloc;
  Category _category;
  Category _subCategory;
  GlobalKey<FormState> _companyDetailsFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _companyContactFormKey = GlobalKey<FormState>();
  Location _location;
  Map<int, Activity> _selectedActivities = {};
  bool _showLocationError = false;

  FormState get companyDetailsForm => _companyDetailsFormKey.currentState;

  FormState get companyContactForm => _companyContactFormKey.currentState;

  @override
  void initState() {
    super.initState();
    _companySizeBloc = CompanySizeBloc(DependencyProvider.provide());
    _activityBloc = ActivityBloc(DependencyProvider.provide());
    _subCategoryBloc = SubCategoryBloc(DependencyProvider.provide());
    _completeRegisterBloc = CompleteRegisterBloc(DependencyProvider.provide(),
        DependencyProvider.provide(), DependencyProvider.provide());
    _modifyProfileImageBloc = ModifyProfileImageBloc(
        DependencyProvider.provide(), DependencyProvider.provide());
    _modifyProfileImageBloc.dispatch(Load());
    _categoryBloc = CategoryBloc(DependencyProvider.provide(),
        subCategoryBloc: _subCategoryBloc, activityBloc: _activityBloc);
    _categoryBloc.dispatch(LoadCategories());
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
    _categoryBloc.dispose();
    _activityBloc.dispose();
    _subCategoryBloc.dispose();
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: BlocListener(
        bloc: _completeRegisterBloc,
        listener: (context, state) {
          if (state is RegisterLoading) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => ProgressDialog(
                      message: 'Completing registering your account.',
                    ));
          }
          if (state is RegisterSuccess) {
            pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => MainPage()));
          }
          if (state is RegisterNetworkError) {
            pop(context);
            scaffold
              ..hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss)
              ..showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(AppLocalizations.of(context).noNetworkError),
                action: SnackBarAction(
                    label: AppLocalizations.of(context).retryButton,
                    onPressed: () {
                      _attemptRegister();
                    }),
              ));
          }
          if (state is RegisterSessionExpired) {
            pop(context);

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return LoginPage();
            }));
          }
          if (state is RegisterFailed) {
            pop(context);
            scaffold.showSnackBar(SnackBar(
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
                content: Text('Failed to complete registering.')));
          }
          if (state is RegisterTimeout) {
            pop(context);
            scaffold.showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('Request timeout, retry'),
              action: SnackBarAction(
                label: AppLocalizations.of(context).retryButton,
                onPressed: () {
                  _attemptRegister();
                },
              ),
            ));
          }
        },
        child: _registerStepper(context),
      ),
    );
  }

  _moveToNextStep() {
    setState(() {
      _currentStep += 1;
    });
  }

  void _onNextClicked() {
    if (_currentStep != 7) {
      switch (_currentStep) {
        case 0:
          _moveToNextStep();
          break;
        case 1:
           if (_selectedActivities.isEmpty) {
            scaffold.showSnackBar(SnackBar(
              content: Text('Selected atleast one activity'),
            ));
          } else {
            _moveToNextStep();
          }

          break;
        case 2:
           if (companyDetailsForm.validate()) {
            _moveToNextStep();
          }

          break;
        case 3:
          if (companyContactForm.validate()) {
            if (_location == null) {
              setState(() {
                _showLocationError = true;
              });
              return;
            }
            _moveToNextStep();
          }
          break;
        case 4:
        case 5:
          _moveToNextStep();
          break;
        case 6:
          _attemptRegister();
          break;
      }
    }
  }

  void _attemptRegister() {
    var model = CompleteRegistrationModel(
      startFromDate: _startDateController.value.text,
      about: _companyDescriptionController.value.text,
      companySize: companySize,
      landPhone: _landLineController.value.text,
      website: _websiteController.value.text,
      category: _category,
      activities: _selectedActivities.values
          .map((activity) => ActivityId(activity.id))
          .toList(),
      postCode: _zipController.value.text,
      location: _location,
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
    );
    _completeRegisterBloc.dispatch(CompleteRegister(model));
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

  Widget _activityPickerWidget(List<Category> categories,
      [bool error = false]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DropdownButtonFormField<Category>(
            onChanged: (category) {
              setState(() {
                _category = null;
                _subCategory = null;
                this._category = category;
              });
              _categoryBloc.dispatch(OnCategorySelectedEvent(category));
            },
            items: categories
                .map((category) => DropdownMenuItem(
                      child: Text('${category.nameEn} - ${category.nameAr}'),
                      value: category,
                    ))
                .toList(),
            value: _category,
            validator: (_activity) {
              if (_activity == null)
                return 'Select main category';
              else
                return null;
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(_kFormFieldPadding),
                hintStyle: _hintTextStyle,
                labelStyle: _labelTextStyle,
                hintText: 'Category',
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
                _categoryBloc.dispatch(LoadCategories());
              },
              child: Text(
                AppLocalizations.of(context).retryButton,
              )),
        )
      ],
    );
  }

  Widget _subActivityPickerWidget(List<Category> categories,
      [bool error = false]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DropdownButtonFormField<Category>(
            onChanged: (category) {
              setState(() {
                _subCategory = null;
                this._subCategory = category;
              });
              _activityBloc.dispatch(LoadActivitiesFromCategory(category.id));
            },
            items: categories
                .map((category) => DropdownMenuItem(
                      child: Text('${category.nameEn} - ${category.nameAr}'),
                      value: category,
                    ))
                .toList(),
            value: _subCategory,
            validator: (_activity) {
              if (_activity == null)
                return 'Select sub category';
              else
                return null;
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(_kFormFieldPadding),
                hintStyle: _hintTextStyle,
                labelStyle: _labelTextStyle,
                hintText: 'Sub Category',
                border: OutlineInputBorder())),
        Visibility(
          visible: error,
          child: Text('Failed to load categories',
              style: TextStyle(color: Theme.of(context).errorColor)),
        ),
        Visibility(
          visible: error,
          child: OutlineButton(
              onPressed: () {
                _subCategoryBloc.dispatch(LoadSubCategories(_category.id));
              },
              child: Text(
                AppLocalizations.of(context).retryButton,
              )),
        )
      ],
    );
  }

  Column _registerStepper(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildTopArcAndLogo(context),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: WeeStepper(
              nextEnabled: _nextEnable,
              steps: [
                WeeStep(content: _acceptTermsStep(context)),
                WeeStep(content: _activityStep(context)),
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
    );
  }

  Column _activityStep(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Company Activity',
          style: Theme.of(context).textTheme.title,
        ),
        _sizedBox,
        BlocListener(
          bloc: _activityBloc,
          listener: (context, state) {
            if (state is HideActivityState) {
              _selectedActivities.clear();
            }
            if (state is ActivitiesLoadedState) {
              _selectedActivities.clear();
            }
          },
          child: BlocListener(
            bloc: _subCategoryBloc,
            listener: (context, state) {
              if (state is HideSubCategoryState) {
                _selectedActivities.clear();
              }
            },
            child: BlocBuilder(
              bloc: _categoryBloc,
              builder: (BuildContext context, state) {
                if (state is CategorySuccess) {
                  return _activityPickerWidget(state.categoryList);
                }

                if (state is CategoryTimeout ||
                    state is CategoryNetworkError ||
                    state is CategoryError) {
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
          ),
        ),
        _sizedBox,
        BlocBuilder(
          bloc: _subCategoryBloc,
          builder: (context, state) {
            if (state is SubCategorySuccess) {
              return _subActivityPickerWidget(state.categoryList);
            }
            if (state is SubCategoryTimeout ||
                state is SubCategoryNetworkError ||
                state is SubCategoryError) {
              return _subActivityPickerWidget([], true);
            }
            if (state is SubCategoryEmpty) {
              return _subActivityPickerWidget([]);
            }
            if (state is SubCategoryLoading) {
              return Column(
                children: <Widget>[
                  _subActivityPickerWidget([]),
                  SizedBox(
                    child: LinearProgressIndicator(),
                    height: 1,
                  )
                ],
              );
            }
            if (state is HideSubCategoryState) {
              return Container();
            }
            return Container();
          },
        ),
        _sizedBox,
        BlocBuilder(
          bloc: _activityBloc,
          builder: (context, state) {
            if (state is ActivityLoadingState) {
              return Center(
                child: ProgressBar(),
              );
            }
            if (state is ActivitiesLoadedState) {
              return Wrap(
                spacing: 2,
                children: state.activities
                    .toList()
                    .map((activity) => ActivityWidget(
                          activity: activity,
                          onSelect: (activity) {
                            setState(() {
                              if (_selectedActivities.containsKey(activity.id))
                                _selectedActivities.remove(activity.id);
                              else
                                _selectedActivities[activity.id] = activity;
                            });
                          },
                          selected:
                              _selectedActivities.containsKey(activity.id),
                        ))
                    .toList(),
              );
            }
            if (state is ActivityEmptyState) {}
            if (state is ActivityTimeoutState ||
                state is ActivityNetworkErrorState ||
                state is ActivityErrorState) {
              return Center(
                child: GeneralErrorWidget(
                  onRetry: () {
                    int id;
                    if (_subCategory != null)
                      id = _subCategory.id;
                    else
                      id = _category.id;
                    _activityBloc.dispatch(LoadActivitiesFromCategory(id));
                  },
                ),
              );
            }
            return Container();
          },
        )
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
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
        Row(
          children: <Widget>[
            Checkbox(
                value: _nextEnable,
                onChanged: (value) {
                  setState(() {
                    _nextEnable = !_nextEnable;
                  });
                }),
            Flexible(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'By checking, you are Indicating that your '
                        'agree to the '),
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        PrivacyPolicyPage.navigate(context);
                      },
                    text: 'Privacy Policy',
                    style: _clickableTextStyle(context)),
                TextSpan(text: ' and '),
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        TosPage.navigate(context);
                      },
                    text: 'Terms of Conditions',
                    style: _clickableTextStyle(context))
              ])),
            ),
          ],
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }

  TextStyle _clickableTextStyle(BuildContext context) => TextStyle(
      decoration: TextDecoration.underline,
      color: Theme.of(context).primaryColor);

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
              BlocBuilder(
                bloc: _modifyProfileImageBloc,
                builder: (BuildContext context, state) {
                  if (state is ImageLoaded) {
                    return _pickImageWidget(context, state.imageUrl);
                  }
                  if (state is Loading) {
                    return _pickImageWidget(context, "", true);
                  }
                  return _pickImageWidget(context);
                },
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

  Widget _pickImageWidget(BuildContext context,
      [String imageUrl, bool progress = false]) {
    return Positioned(
      bottom: -30,
      left: 16,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: InkWell(
          onTap: () async {
            var pickImage = await showDialog(
                context: context, builder: (context) => MediaPickDialog());
            if (pickImage != null) {
              _modifyProfileImageBloc.dispatch(Modify(pickImage));
              _logoFile = pickImage;
              setState(() {});
            }
          },
          child: ClipOval(
            child: Container(
              width: 120,
              height: 120,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  imageUrl != null
                      ? Image.network(
                          imageUrl,
                          width: 120,
                          alignment: Alignment.center,
                          height: 120,
                          fit: BoxFit.fitWidth,
                        )
                      : Container(),
                  Icon(
                    Icons.camera_alt,
                    size: 30,
                  ),
                  Visibility(
                    child: ProgressBar(),
                    visible: progress,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
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
          Text('Geographic location'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _isLocationSelected()
                        ? 'Location not selected'
                        : 'Location selected',
                    style: TextStyle(
                        color: _isLocationSelected()
                            ? Colors.black
                            : Colors.green),
                  ),
                  Visibility(
                    child: Text(
                      'Selected location first',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(color: Theme.of(context).errorColor),
                    ),
                    visible: _isLocationSelected() && _showLocationError,
                  ),
                ],
              ),
              RaisedButton(
                onPressed: () async {
                  var pickedLocation = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LocationPickerScreen()));
                  if (pickedLocation != null) {
                    setState(() {
                      _location = pickedLocation;
                    });
                  }
                },
                child: Text('Pick Location'),
              )
            ],
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

  bool _isLocationSelected() => _location == null;

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

class ActivityWidget extends StatelessWidget {
  final Activity activity;
  final bool selected;
  final ValueSetter<Activity> onSelect;

  const ActivityWidget({Key key, this.activity, this.selected, this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(32),
      onTap: () => onSelect(activity),
      child: Chip(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        padding: const EdgeInsets.all(2),
        label: Text(
          Localizations.localeOf(context).languageCode == 'ar'
              ? activity.nameAr
              : activity.nameEn,
          style: TextStyle(color: selected ? Colors.white : Colors.black),
        ),
        backgroundColor: selected ? Colors.blue : Colors.grey,
      ),
    );
  }
}
