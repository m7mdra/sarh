import 'dart:io';

import 'package:Sarh/data/model/company_size.dart';
import 'package:Sarh/page/home/main_page.dart';
import 'package:Sarh/size_config.dart';
import 'package:Sarh/widget/media_picker_dialog.dart';
import 'package:Sarh/widget/stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddCompanyInfoPage extends StatefulWidget {
  @override
  _AddCompanyInfoPageState createState() => _AddCompanyInfoPageState();
}

const _kFormFieldPadding = 12.0;

class _AddCompanyInfoPageState extends State<AddCompanyInfoPage> {
  int _currentStep = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  File _logoImage;
  DateTime _startFromDate;
  TextEditingController _startDateController;
  CompanySize companySize;
  bool _nextEnable = false;

  @override
  void initState() {
    super.initState();
    _startDateController = TextEditingController();
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
                  WeeStep(
                      content: Column(
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
                        title: Text(
                            'By checking, you are Indicating that your agree to the Privacy Policy and Terms of Conditions'),
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  )),
                  WeeStep(content: _buildCompanyDetailsWidgetStep()),
                  WeeStep(content: _buildContactInformationStep()),
                  WeeStep(content: _buildFeatureClientStep(context)),
                  WeeStep(content: _buildSocialMediaStep()),
                  WeeStep(
                      content: Column(
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
                      Container(
                        height: 150,
                        color: Color(0xffF6F6F6),
                        child: Center(
                          child: Icon(Icons.camera_alt),
                        ),
                      ),
                      _sizedBox,
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'Note: ',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        TextSpan(
                            text:
                                'The documents required to verify your account.\nyou can '
                                'skip this step by '
                                'pressing the next button, you can upload '
                                'it later from your profile.')
                      ]))
                    ],
                  )),
                ],
                currentStep: _currentStep,
                onStepContinue: () {
                  if (_currentStep != 4)
                    setState(() {
                      _currentStep += 1;
                    });
                  if (_currentStep == 4)
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MainPage()));
                  print('Current step: $_currentStep');

                },
                onPrevious: () {
                  setState(() {
                    if (_currentStep != 0) _currentStep -= 1;
                  });
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

  _buildTopArcAndLogo(BuildContext context) {
    return Opacity(
      opacity: _currentStep == 0 ? 0 : 1.0,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(64), bottomRight: Radius.circular(64)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: SizeConfig.blockSizeVertical * 30,
          child: Stack(
            fit: StackFit.loose,
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                top: 55,
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
                  bottomLeft: Radius.circular(64),
                  bottomRight: Radius.circular(64))),
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
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(_kFormFieldPadding),
              labelText: 'https:www.facebook.com/',
              hintStyle: _hintTextStyle,
              prefixIcon: Icon(FontAwesomeIcons.facebookF),
              labelStyle: _lableTextStyle,
              hintText: 'Enter facebook account',
              border: OutlineInputBorder()),
        ),
        _sizedBox,
        TextFormField(
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(_kFormFieldPadding),
              labelText: 'https:www.instagram.com/',
              hintStyle: _hintTextStyle,
              prefixIcon: Icon(FontAwesomeIcons.instagram),
              labelStyle: _lableTextStyle,
              hintText: 'Enter Instagram account',
              border: OutlineInputBorder()),
        ),
        _sizedBox,
        TextFormField(
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(_kFormFieldPadding),
              labelText: 'https:www.twitter.com/',
              hintStyle: _hintTextStyle,
              prefixIcon: Icon(FontAwesomeIcons.twitter),
              labelStyle: _lableTextStyle,
              hintText: 'Enter Instagram account',
              border: OutlineInputBorder()),
        ),
        _sizedBox,
        TextFormField(
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(_kFormFieldPadding),
              labelText: 'https:www.linkedin.com/',
              hintStyle: _hintTextStyle,
              prefixIcon: Icon(FontAwesomeIcons.linkedinIn),
              labelStyle: _lableTextStyle,
              hintText: 'Enter Instagram account',
              border: OutlineInputBorder()),
        ),
        _sizedBox,
        TextFormField(
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(_kFormFieldPadding),
              labelText: 'https:www.behance.com/',
              hintStyle: _hintTextStyle,
              prefixIcon: Icon(FontAwesomeIcons.behance),
              labelStyle: _lableTextStyle,
              hintText: 'Enter Instagram account',
              border: OutlineInputBorder()),
        ),
      ],
    );
  }

  Column _buildFeatureClientStep(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Featured clients',
          style: Theme.of(context).textTheme.title,
        ),
        _sizedBox,
        ListView.builder(
          primary: false,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('data$index'),
            );
          },
          itemCount: 3,
          shrinkWrap: true,
        ),
        _sizedBox,
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
            onPressed: () {
              scaffold.showBottomSheet(
                (context) {
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Enter the client details',
                          ),
                          _sizedBox,
                          TextFormField(
                            decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.all(_kFormFieldPadding),
                                labelText: 'Enter client name',
                                hintStyle: _hintTextStyle,
                                labelStyle: _lableTextStyle,
                                hintText: 'Enter Street/building address',
                                border: OutlineInputBorder()),
                          ),
                          _sizedBox,
                          TextFormField(
                            decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.all(_kFormFieldPadding),
                                labelText: 'Client website URL',
                                hintStyle: _hintTextStyle,
                                labelStyle: _lableTextStyle,
                                hintText: 'Enter Zip code',
                                border: OutlineInputBorder()),
                          ),
                          _sizedBox,
                          TextFormField(
                            decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.all(_kFormFieldPadding),
                                labelText: 'Client website URL',
                                hintStyle: _hintTextStyle,
                                labelStyle: _lableTextStyle,
                                hintText: 'Enter Zip code',
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
                                    borderRadius: BorderRadius.circular(16)),
                                color: Colors.grey.withAlpha(50),
                                textColor: Colors.black,
                                child: Text('Cancel'),
                              ),
                              RaisedButton(
                                elevation: 0,
                                onPressed: () {},
                                child: Text('Save'),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Text('Add client'),
          ),
        )
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  ScaffoldState get scaffold => _scaffoldKey.currentState;

  Column _buildContactInformationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Contact information.',
          style: Theme.of(context).textTheme.title,
        ),
        _sizedBox,
        TextFormField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(_kFormFieldPadding),
              labelText: 'Land line number',
              hintText: 'Enter land line number',
              hintStyle: _hintTextStyle,
              labelStyle: _lableTextStyle,
              border: OutlineInputBorder()),
        ),
        _sizedBox,
        TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(_kFormFieldPadding),
              labelText: 'Address',
              hintText: 'Enter company address',
              hintStyle: _hintTextStyle,
              labelStyle: _lableTextStyle,
              border: OutlineInputBorder()),
        ),
        _sizedBox,
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(_kFormFieldPadding),
              labelText: 'ZIP code',
              hintText: 'Enter ZIP code',
              hintStyle: _hintTextStyle,
              labelStyle: _lableTextStyle,
              border: OutlineInputBorder()),
        ),
        _sizedBox,
        TextFormField(
          keyboardType: TextInputType.url,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(_kFormFieldPadding),
              labelText: 'Website address URL',
              hintText: 'Enter Website address URL',
              hintStyle: _hintTextStyle,
              labelStyle: _lableTextStyle,
              border: OutlineInputBorder()),
        ),
      ],
    );
  }

  Column _buildCompanyDetailsWidgetStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Company details.',
          style: Theme.of(context).textTheme.title,
        ),
        _sizedBox,
        Form(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                var pickDate = await showDatePicker(
                    context: context,
                    initialDate: _startFromDate ?? DateTime.now(),
                    firstDate: DateTime(1900, 8),
                    lastDate: DateTime.now());
                if (pickDate == null) return;
                print(pickDate.toIso8601String());
                _startDateController.text =
                    '${pickDate.year}/${pickDate.month}/${pickDate.day}';
                setState(() {
                  _startFromDate = pickDate;
                });
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _startDateController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(_kFormFieldPadding),
                      labelText: 'Company start from',
                      hintStyle: _hintTextStyle,
                      labelStyle: _lableTextStyle,
                      border: OutlineInputBorder()),
                  readOnly: true,
                ),
              ),
            ),
            _sizedBox,
            TextFormField(
              maxLength: 400,
              maxLines: 2,
              maxLengthEnforced: true,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(_kFormFieldPadding),
                  labelText: 'Company description',
                  hintStyle: _hintTextStyle,
                  labelStyle: _lableTextStyle,
                  hintText: 'In less than 400 Characters describe the company',
                  border: OutlineInputBorder()),
            ),
            _sizedBox,
            Text('Number of Employees: ',
                style: Theme.of(context).textTheme.subtitle),
            DropdownButtonFormField<CompanySize>(
              value: companySize,
              items: <DropdownMenuItem<CompanySize>>[],
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(_kFormFieldPadding),
                  hintStyle: _hintTextStyle,
                  labelStyle: _lableTextStyle,
                  hintText: 'Number of Total Clients',
                  border: OutlineInputBorder()),
            ),
          ],
        ))
      ],
    );
  }

  TextStyle get _hintTextStyle => TextStyle(fontSize: 12);

  TextStyle get _lableTextStyle => TextStyle(fontSize: 14);

  SizedBox get _sizedBox => SizedBox(
        height: 4,
      );
}
