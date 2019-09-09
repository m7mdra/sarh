import 'package:Sarh/i10n/app_localizations.dart';
import 'package:Sarh/widget/attachment_widget.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:Sarh/widget/file_picker_sheet_modal.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RequestQuoteScreen extends StatefulWidget {
  @override
  _RequestQuoteScreenState createState() => _RequestQuoteScreenState();
}

class _RequestQuoteScreenState extends State<RequestQuoteScreen> {
  List<AttachmentFile> attachments = []..addAll([null, null, null, null]);
  int _selectedMethod = -1;
  TextEditingController _activityTextEditingController;
  TextEditingController _qouteSubjectTextEditingController;
  TextEditingController _qouteDetailsTextEditingController;
  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  FormState get form => _formKey.currentState;

  ScaffoldState get scaffold => _scaffoldKey.currentState;

  @override
  void initState() {
    super.initState();
    _activityTextEditingController = TextEditingController();
    _qouteSubjectTextEditingController = TextEditingController();
    _qouteDetailsTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _activityTextEditingController.dispose();
    _qouteSubjectTextEditingController.dispose();
    _qouteDetailsTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).requestQuotations,
          style: TextStyle(),
        ),
        leading: BackButtonNoLabel(Colors.white),
      ),
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).activity,
                  ),
                  _sizedBox(),
                  GestureDetector(
                    onTap: () {
                      print('Navigate to activity picker');
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        validator: (text) {
                          if (text.isEmpty)
                            return AppLocalizations.of(context)
                                .activityFieldEmptyError;
                          else
                            return null;
                        },
                        controller: _activityTextEditingController,
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).activityHint,
                            border: OutlineInputBorder(),
                            contentPadding: const EdgeInsets.all(12)),
                      ),
                    ),
                  ),
                  _sizedBox(),
                  Text(
                    AppLocalizations.of(context).requestMethod,
                  ),
                  _sizedBox(),
                  Container(
                    child: ExpansionTile(
                      initiallyExpanded: true,
                      title:
                          Text(AppLocalizations.of(context).requestMethodHint),
                      children: <Widget>[
                        RadioListTile(
                          selected: _selectedMethod == 0,
                          value: 0,
                          onChanged: (newValue) {
                            setState(() {
                              this._selectedMethod = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          secondary: Icon(FontAwesomeIcons.solidStar),
                          title: Text(AppLocalizations.of(context)
                              .favoriteRequestMethod),
                          subtitle: Text(AppLocalizations.of(context)
                              .favoriteRequestMethodHint),
                          groupValue: _selectedMethod,
                        ),
                        Divider(
                          height: 1,
                        ),
                        RadioListTile(
                          selected: _selectedMethod == 1,
                          controlAffinity: ListTileControlAffinity.leading,
                          value: 1,
                          groupValue: _selectedMethod,
                          secondary: Icon(FontAwesomeIcons.listOl),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedMethod = newValue;
                            });
                          },
                          title: Text(AppLocalizations.of(context)
                              .recommendationRequestMethod),
                          subtitle: Text(AppLocalizations.of(context)
                              .recommendationRequestMethodHint),
                        ),
                        Divider(
                          height: 1,
                        ),
                        RadioListTile(
                          selected: _selectedMethod == 2,
                          controlAffinity: ListTileControlAffinity.leading,
                          value: 2,
                          groupValue: _selectedMethod,
                          secondary: Icon(FontAwesomeIcons.listUl),
                          onChanged: (newValue) {
                            setState(() {
                              this._selectedMethod = newValue;
                            });
                          },
                          title: Text(
                              AppLocalizations.of(context).randomRequestMethod),
                          subtitle: Text(AppLocalizations.of(context)
                              .randomRequestMethodHint),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38),
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  _sizedBox(),
                  Text(
                    AppLocalizations.of(context).quotationSubject,
                  ),
                  _sizedBox(),
                  TextFormField(
                    validator: (text) {
                      if (text.isEmpty)
                        return AppLocalizations.of(context)
                            .quotationSubjectFieldEmptyError;
                      else
                        return null;
                    },
                    controller: _qouteSubjectTextEditingController,
                    decoration: InputDecoration(
                        hintText:
                            AppLocalizations.of(context).quotationSubjectHint,
                        border: OutlineInputBorder(),
                        contentPadding: const EdgeInsets.all(12)),
                  ),
                  Text(
                    AppLocalizations.of(context).quotationDetails,
                  ),
                  _sizedBox(),
                  TextFormField(
                    maxLines: 4,
                    controller: _qouteDetailsTextEditingController,
                    decoration: InputDecoration(
                        hintText:
                            AppLocalizations.of(context).quotationDetailsHint,
                        border: OutlineInputBorder(),
                        contentPadding: const EdgeInsets.all(12)),
                  ),
                  _sizedBox(),
                  Text(
                    AppLocalizations.of(context).attachments,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                  Container(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return AttachmentWidget(
                          attachments[index],
                          key: ObjectKey('Media$index'),
                          onRemove: () {
                            setState(() {
                              attachments.removeAt(index);
                            });
                          },
                        );
                      },
                      shrinkWrap: true,
                      itemCount: attachments.length,
                    ),
                  ),
                  _sizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton.icon(
                          onPressed: () {
                            form.validate();
                          },
                          icon: Icon(FontAwesomeIcons.paperPlane),
                          label:
                              Text(AppLocalizations.of(context).submitButton)),
                      FlatButton.icon(
                          onPressed: () async {
                            var file = await showFilePickDialog<AttachmentFile>(
                                context: context);
                            if (file != null)
                              setState(() {
                                attachments.removeWhere(
                                    (attachment) => attachment == null);
                                attachments.add(file);
                              });
                          },
                          icon: Icon(Icons.attach_file),
                          label: Text(
                              AppLocalizations.of(context).attachFileButton))
                    ],
                  )
                ],
              ))
        ],
      )),
    );
  }

  SizedBox _sizedBox() {
    return const SizedBox(
      height: 4,
    );
  }
}
