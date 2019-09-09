import 'package:Sarh/widget/file_picker_sheet_modal.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

class AttachmentWidget extends StatelessWidget {
  final VoidCallback onRemove;
  final AttachmentFile file;

  const AttachmentWidget(this.file, {Key key, this.onRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Builder(
            builder: (BuildContext context) {
              if (file == null)
                return Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(4)));
              else {
                if (file.type == Type.Document)
                  return DocumentAttachment();
                else if (file.type == Type.Video)
                  return VideoAttachWidget(attachment: file);
                else
                  return ImageAttachment(attachment: file);
              }
            },
          ),
          Visibility(
            visible: file!=null,
            child: PositionedDirectional(
              start: 10,
              end: 10,
              top: -5,
              child: InkWell(
                onTap: onRemove,
                child: Container(
                  alignment: Alignment.center,
                  child: Icon(
                    FontAwesomeIcons.solidTimesCircle,
                  ),
                  padding: const EdgeInsets.all(4),
                  decoration:
                      BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageAttachment extends StatelessWidget {
  final AttachmentFile attachment;

  const ImageAttachment({Key key, this.attachment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Image.file(
        attachment.file,
        width: 120,
        height: 120,
        fit: BoxFit.cover,
      ),
    );
  }
}

class DocumentAttachment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 120,
        height: 120,
        child: Icon(
          FontAwesomeIcons.filePdf,
          color: Colors.white,
          size: 30,
        ),
        decoration: BoxDecoration(
            color: Colors.black38, borderRadius: BorderRadius.circular(4)));
  }
}

class VideoAttachWidget extends StatefulWidget {
  final AttachmentFile attachment;

  const VideoAttachWidget({Key key, this.attachment}) : super(key: key);

  @override
  _VideoAttachWidgetState createState() => _VideoAttachWidgetState();
}

class _VideoAttachWidgetState extends State<VideoAttachWidget> {
  VideoPlayerController _controller;
  bool _isPlayling = false;
  Future videoInit;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.attachment.file);
    videoInit = _controller.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        splashColor: Colors.red,
        onTap: (){
          if (!_isPlayling) {
            _controller.play();
          } else {
            _controller.pause();
          }
          _isPlayling = !_isPlayling;
          setState(() {});
        },
        borderRadius: BorderRadius.circular(4),
        child: Container(
          width: 120,
          height: 120,
          child: Stack(
            children: <Widget>[
              FutureBuilder(
                future: videoInit,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return VideoPlayer(_controller);
                  } else {
                    return Container(
                      width: 120,
                      height: 120,
                    );
                  }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
