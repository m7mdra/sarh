import 'package:Sarh/i10n/app_localizations.dart';
import 'package:Sarh/widget/attachment_widget.dart';
import 'package:Sarh/widget/file_picker_sheet_modal.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdCommunityPostPage extends StatefulWidget {
  @override
  _AdCommunityPostPageState createState() => _AdCommunityPostPageState();
}

class _AdCommunityPostPageState extends State<AdCommunityPostPage> {
  List<AttachmentFile> attachments = []..addAll([null, null, null, null]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).newPost),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            Text(
              AppLocalizations.of(context).activity,
            ),
            _sizedBox(),
            GestureDetector(
              onTap: (){
                print('open activity picker screen');
              },
              child: AbsorbPointer(
                child: TextFormField(
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
              'Post Title',
            ),
            _sizedBox(),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Enter the Post title',
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.all(12)),
            ),
            _sizedBox(),
            Text(
              'Post Body',
            ),
            _sizedBox(),
            TextFormField(
              maxLines: 3,
              decoration: InputDecoration(
                  hintText: 'Explain what you want to quary about...',
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.all(12)),
            ),
            _sizedBox(),
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
                    onPressed: () {},
                    icon: Icon(FontAwesomeIcons.paperPlane),
                    label: Text(AppLocalizations.of(context).submitButton)),
                FlatButton.icon(
                    onPressed: () async {
                      var file = await showFilePickDialog<AttachmentFile>(
                          context: context);
                      if (file != null)
                        setState(() {
                          attachments
                              .removeWhere((attachment) => attachment == null);
                          attachments.add(file);
                        });
                    },
                    icon: Icon(Icons.attach_file),
                    label: Text(AppLocalizations.of(context).attachFileButton))
              ],
            )
          ],
        ),
      ),
    );
  }

  SizedBox _sizedBox() {
    return const SizedBox(
      height: 8,
    );
  }
}
