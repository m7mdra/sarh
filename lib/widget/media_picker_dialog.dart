import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Sarh/i10n/app_localizations.dart';

class MediaPickDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(AppLocalizations.of(context).imagePickerDialogTitle),
              const SizedBox(
                height: 8,
              ),
              ListTile(
                onTap: () async {
                  var file =
                      await ImagePicker.pickImage(source: ImageSource.camera);
                  Navigator.pop(context, file);
                },
                title: Text(AppLocalizations.of(context).camera),
                trailing: Icon(FontAwesomeIcons.camera),
              ),
              ListTile(
                onTap: () async {
                  var file =
                      await ImagePicker.pickImage(source: ImageSource.gallery);
                  Navigator.pop(context, file);
                },
                title: Text(AppLocalizations.of(context).gallery),
                trailing: Icon(FontAwesomeIcons.images),
              ),
              FlatButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child:
                      Text(MaterialLocalizations.of(context).cancelButtonLabel))
            ],
          ),
        ));
  }
}
