import 'package:Sarh/i10n/app_localizations.dart';
import 'package:Sarh/widget/attachment_widget.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:Sarh/widget/file_picker_sheet_modal.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateQuotePage extends StatefulWidget {
  @override
  _CreateQuotePageState createState() => _CreateQuotePageState();
}

class _CreateQuotePageState extends State<CreateQuotePage> {
  List<AttachmentFile> attachments = []..addAll([null, null, null, null]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Qoutation creation',
              style: TextStyle(
              ),
            ),
            Text(
              'for Mohamed sed',
              style: Theme.of(context).textTheme.caption.copyWith(color:Colors.white),
            )
          ],
        ),
        leading: BackButtonNoLabel(Colors.white),
      ),
      body: SafeArea(
          child: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Create new quotation',
                style: Theme.of(context).textTheme.title,
              ),
              _sizedBox(),
              _sizedBox(),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(12)),
              ),
              _sizedBox(),
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: 'Details/description',
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton.icon(
                        onPressed: () {
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
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  SizedBox _sizedBox() {
    return const SizedBox(
      height: 8,
    );
  }
}
