import 'dart:io';

import 'package:Sarh/data/company/company_repository.dart';
import 'package:Sarh/dependency_provider.dart';
import 'package:Sarh/i10n/app_localizations.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:Sarh/widget/media_picker_dialog.dart';
import 'package:Sarh/widget/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_image_bloc/add_image_bloc.dart';
import 'add_image_bloc/add_image_event_state.dart';
import 'my_company_gallery.dart';

class AddNewCompanyImage extends StatefulWidget {
  @override
  _AddNewCompanyImageState createState() => _AddNewCompanyImageState();
}

class _AddNewCompanyImageState extends State<AddNewCompanyImage> {
  UploadImageBloc uploadImageBloc;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();


  File _logoImage;
  var title        = TextEditingController();
  var description  = TextEditingController();
  String Title , Desc ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uploadImageBloc = UploadImageBloc(DependencyProvider.provide());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    uploadImageBloc.dispose();
  }

  ScaffoldState get scaffold => _scaffoldKey.currentState;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          centerTitle: true,
          leading: BackButtonNoLabel(Colors.white),
          automaticallyImplyLeading: true,
          title: Text(
            'Add New Image',
          ),
      ),
      body: SafeArea(

          child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener(
            bloc: uploadImageBloc,
            listener: (context, state) {
              print(state);
              if (state is LoadingState) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => ProgressDialog(
                      message: "Waiting to upload image"
                    ));
              }
              if (state is SuccessState) {
//                scaffold.showSnackBar(SnackBar(
//                  behavior: SnackBarBehavior.floating,
//                  content: Text(
//                    'Successfully Upload Image',
//                  ),
//                ));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyCompanyGallery()));
              }
              if (state is NetworkError || state is Timeout ) {
                scaffold.showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text(
                    'Unable to upload image right now, try later.',
                  ),
                ));
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Comapny New Image',
                  style: Theme.of(context).textTheme.subhead,
                ),
                _sizedBox,
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () async {
                    var pickedFile = await showDialog(
                        context: context, builder: (context) => MediaPickDialog());
                    if (pickedFile != null)
                      setState(() {
                        _logoImage = pickedFile;
                      });
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(8)),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Icon(FontAwesomeIcons.camera),
                        if (_logoImage != null)
                          ClipRRect(
                            child: Image.file(
                              _logoImage,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          )
                      ],
                    ),
                  ),
                ),
                _sizedBox,
                Text(
                  'Image Title',
                  style: Theme.of(context).textTheme.subhead,
                ),
                _sizedBox,
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(12)),
                  controller: title,
                ),
                _sizedBox,
                Text(
                  'Image Description',
                  style: Theme.of(context).textTheme.subhead,
                ),
                _sizedBox,
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(12)),
                  controller: description,
                ),
                _sizedBox,
                RaisedButton(onPressed: ()async{

                  Title = title.text;
                  Desc  = description.text;
                  uploadImageBloc.dispatch(AttemptUpload(_logoImage,Title,Desc,context));


                },
                  child: Text(AppLocalizations.of(context).submitButton),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox get _sizedBox {
    return SizedBox(
      height: 8,
    );
  }
}
/*

 */