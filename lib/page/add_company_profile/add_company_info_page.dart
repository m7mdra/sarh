import 'dart:io';

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
                steps: [
                  WeeStep(content: _buildCompanyDetailsWidgetStep()),
                  WeeStep(content: _buildContactInformationStep()),
                  WeeStep(content: _buildFeatureClientStep(context)),
                  WeeStep(content: _buildSocialMediaStep()),
                  WeeStep(
                      content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Documents',style: Theme.of(context).textTheme.title,),
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
                  print('Current step: $_currentStep');
                  if (_currentStep != 4)
                    setState(() {
                      _currentStep += 1;
                    });
                  if (_currentStep == 4)
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MainPage()));
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
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(64), bottomRight: Radius.circular(64)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: SizeConfig.blockSizeVertical*30,
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
    );
  }

  Column _buildSocialMediaStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Social Media Accounts',style: Theme.of(context).textTheme.title,),
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
        Text('Featured clients',style: Theme.of(context).textTheme.title,),
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
                          Text('Enter the client details',),
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
        Text('Contact information.',style: Theme.of(context).textTheme.title,),
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

  var _numberOfEmployees = 5.0;
  var _numberOfClients = 0.0;

  Column _buildCompanyDetailsWidgetStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Company details.',style: Theme.of(context).textTheme.title,),
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
                    firstDate: DateTime(1980, 8),
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

            Text.rich(TextSpan(children: [
              TextSpan(text: 'Number of Employees: ',style: Theme.of(context).textTheme.subtitle),
              TextSpan(text: '\n'),
              TextSpan(text: 'More than '),
              TextSpan(
                  text: ' ${_numberOfEmployees.round()} employee',
                  style: TextStyle(fontWeight: FontWeight.bold))
            ])),
            DropdownButtonFormField(
              value: null,
              items: <DropdownMenuItem>[
                DropdownMenuItem(child: Text('More than 10')),
                DropdownMenuItem(child: Text('More than 50')),
                DropdownMenuItem(child: Text('More than 100')),
              ],
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
