import 'dart:io';

import 'package:Sarh/widget/media_picker_dialog.dart';
import 'package:Sarh/widget/stepper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddCompanyInfoPage extends StatefulWidget {
  @override
  _AddCompanyInfoPageState createState() => _AddCompanyInfoPageState();
}

const _kFormFieldPadding = 12.0;

class _AddCompanyInfoPageState extends State<AddCompanyInfoPage> {
  int current = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  File _logoImage;
  DateTime _startFromDate;
  TextEditingController _startDateController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startDateController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
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
                        Text('Documents'),
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
                  currentStep: current,
                  onStepContinue: () {
                    setState(() {
                      current += 1;
                    });
                  },
                  onPrevious: () {
                    setState(() {
                      current -= 1;
                    });
                  },
                  onStepTapped: (step) {
                    setState(() {
                      this.current = step;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
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
        height: 120,
        child: Stack(
          fit: StackFit.loose,
          overflow: Overflow.visible,
          children: <Widget>[
            Positioned(
              top: 35,
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
        Text('Social Media Accounts'),
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
        Text('Featured clients'),
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
              _scaffoldKey.currentState.showBottomSheet(
                (context) {
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Enter the client details'),
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
                backgroundColor: Colors.transparent,
              );
            },
            child: Text('Add client'),
          ),
        )
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Column _buildContactInformationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Contact information.'),
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
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(_kFormFieldPadding),
              labelText: 'Phone number',
              hintText: 'Enter Phone number',
              hintStyle: _hintTextStyle,
              labelStyle: _lableTextStyle,
              border: OutlineInputBorder()),
        ),
        _sizedBox,
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(_kFormFieldPadding),
              labelText: 'Email address',
              hintText: 'Enter Email address',
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
        _sizedBox,
        GestureDetector(
          onTap: () {
            _scaffoldKey.currentState.showBottomSheet(
              (context) {
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Enter the address'),
                        _sizedBox,
                        DropdownButtonFormField(
                          items: <DropdownMenuItem>[],
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.all(_kFormFieldPadding),
                              hintText: 'Choose country',
                              hintStyle: _hintTextStyle,
                              labelStyle: _lableTextStyle,
                              border: OutlineInputBorder()),
                        ),
                        _sizedBox,
                        DropdownButtonFormField(
                          items: <DropdownMenuItem>[],
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.all(_kFormFieldPadding),
                              hintText: 'Select city',
                              hintStyle: _hintTextStyle,
                              labelStyle: _lableTextStyle,
                              border: OutlineInputBorder()),
                        ),
                        _sizedBox,
                        TextFormField(
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.all(_kFormFieldPadding),
                              labelText: 'Address',
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
                              labelText: 'ZIP code',
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
              backgroundColor: Colors.transparent,
            );
          },
          child: AbsorbPointer(
            child: TextFormField(
              keyboardType: TextInputType.url,
              readOnly: true,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(_kFormFieldPadding),
                  labelText: 'Enter full address',
                  hintStyle: _hintTextStyle,
                  labelStyle: _lableTextStyle,
                  border: OutlineInputBorder()),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildCompanyDetailsWidgetStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Company details.'),
        _sizedBox,
        Form(
            child: Column(
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
            DropdownButtonFormField(
              items: <DropdownMenuItem>[
                DropdownMenuItem(child: Text('More than 10')),
                DropdownMenuItem(child: Text('More than 50')),
                DropdownMenuItem(child: Text('More than 100')),
                DropdownMenuItem(child: Text('More than 1000')),
              ],
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(_kFormFieldPadding),
                  hintText: 'Number of Employees',
                  hintStyle: _hintTextStyle,
                  labelStyle: _lableTextStyle,
                  border: OutlineInputBorder()),
            ),
            _sizedBox,
            DropdownButtonFormField(
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
            _sizedBox,
            DropdownButtonFormField(
              hint: Text('Total Project'),
              items: <DropdownMenuItem>[
                DropdownMenuItem(child: Text('More than 10')),
                DropdownMenuItem(child: Text('More than 50')),
                DropdownMenuItem(child: Text('More than 100')),
              ],
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(_kFormFieldPadding),
                  labelText: 'Total Project',
                  hintStyle: _hintTextStyle,
                  labelStyle: _lableTextStyle,
                  border: OutlineInputBorder()),
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
          ],
        ))
      ],
    );
  }

  TextStyle get _hintTextStyle => TextStyle(fontSize: 12);

  TextStyle get _lableTextStyle => TextStyle(fontSize: 14);

  SizedBox get _sizedBox => SizedBox(
        height: 8,
      );
}
