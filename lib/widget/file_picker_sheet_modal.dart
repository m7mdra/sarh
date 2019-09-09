import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:Sarh/i10n/app_localizations.dart';

enum Type { Image, Video, Document }

class AttachmentFile {
  final File file;
  final Type type;

  AttachmentFile(this.file, this.type);

  @override
  String toString() {
    return 'FileType{file: ${file.path}, type: $type}';
  }
}

Future<T> showFilePickDialog<T>({
  @required BuildContext context,
}) {
  return Navigator.push<T>(
      context,
      _FilePickerSheetModal<T>(
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
      ));
}

class _ModalBottomSheetLayout extends SingleChildLayoutDelegate {
  _ModalBottomSheetLayout(this.progress);

  final double progress;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return new BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        minHeight: 0.0,
        maxHeight: constraints.maxHeight * 9.0 / 16.0);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return new Offset(0.0, size.height - childSize.height * progress);
  }

  @override
  bool shouldRelayout(_ModalBottomSheetLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

class _FilePickerSheetModal<T> extends PopupRoute<T> {
  _FilePickerSheetModal({
    this.barrierLabel,
    RouteSettings settings,
  }) : super(settings: settings);

  @override
  Color get barrierColor => Colors.black38;

  @override
  bool get barrierDismissible => true;

  @override
  String barrierLabel;

  AnimationController _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator.overlay);
    return _animationController;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) => CustomSingleChildLayout(
            delegate: _ModalBottomSheetLayout(animation.value),
            child: BottomSheet(
              animationController: _animationController,
              onClosing: () => Navigator.pop(context),
              builder: (context) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Card(
                        margin: const EdgeInsets.all(0),
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              onTap: () async {
                                var file = await FilePicker.getFile(
                                    type: FileType.IMAGE);
                                if (file != null)
                                  Navigator.pop(context,
                                      new AttachmentFile(file, Type.Image));
                              },
                              leading: Icon(
                                FontAwesomeIcons.solidFileImage,
                                color: Theme.of(context).primaryColor,
                              ),
                              title: Text(
                                  AppLocalizations.of(context).attachImage),
                            ),
                            Divider(
                              height: 1,
                            ),
                            ListTile(
                              onTap: () async {
                                var file = await FilePicker.getFile(
                                    type: FileType.VIDEO);
                                if (file != null)
                                  Navigator.pop(context,
                                      new AttachmentFile(file, Type.Video));
                              },
                              leading: Icon(
                                FontAwesomeIcons.solidFileVideo,
                                color: Colors.green,
                              ),
                              title: Text(
                                  AppLocalizations.of(context).attachVideo),
                            ),
                            Divider(
                              height: 1,
                            ),
                            ListTile(
                              onTap: () async {
                                var file = await FilePicker.getFile(
                                    type: FileType.CUSTOM,
                                    fileExtension: 'pdf');
                                if (file != null)
                                  Navigator.pop(context,
                                      new AttachmentFile(file, Type.Document));
                              },
                              leading: Icon(
                                FontAwesomeIcons.solidFilePdf,
                                color: Colors.redAccent,
                              ),
                              title: Text(
                                  AppLocalizations.of(context).attachDocument),
                              subtitle: Text(AppLocalizations.of(context)
                                  .attachDocumentOnlyPdf),
                            ),
                          ],
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(MaterialLocalizations.of(context)
                            .cancelButtonLabel),
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get maintainState => false;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => Duration(milliseconds: 200);
}
