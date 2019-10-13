import 'package:Sarh/data/session.dart';
import 'package:Sarh/dependency_provider.dart';
import 'package:Sarh/page/company_gallery/bloc/company_gallery_bloc.dart';
import 'package:Sarh/page/company_gallery/bloc/bloc.dart';
import 'package:Sarh/page/company_gallery/company_gallery_page.dart';
import 'package:Sarh/page/home/home/bloc/gallery/bloc.dart';
import 'package:Sarh/page/my_company_gallery/add_new_company_image.dart';
import 'package:Sarh/page/my_company_gallery/bloc/bloc.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:Sarh/widget/ui_state/empty_widget.dart';
import 'package:Sarh/widget/ui_state/general_error_widget.dart';
import 'package:Sarh/widget/ui_state/network_error_widget.dart';
import 'package:Sarh/widget/ui_state/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/my_company_events.dart';

class MyCompanyGallery extends StatefulWidget {
  @override
  _MyCompanyGalleryState createState() => _MyCompanyGalleryState();
}

class _MyCompanyGalleryState extends State<MyCompanyGallery> {
  MyCompanyGalleryBloc _galleryBloc;

  Session session;

  @override
  void initState() {
    super.initState();

    _galleryBloc = MyCompanyGalleryBloc(DependencyProvider.provide());
    _dispatch();
  }

  void _dispatch() => _galleryBloc.dispatch(LoadMyCompanyGallery());

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          leading: BackButtonNoLabel(Colors.white),
          automaticallyImplyLeading: true,
          title: Text(
            'My Company\'s gallery',
          )),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder(
            bloc: _galleryBloc,
            builder: (context, state) {
              print(state);
              if (state is MyCompanyGalleryLoading) {
                return Center(child: ProgressBar());
              }
              if (state is MyCompanyGalleryNetworkError) {
                return Center(
                    child: NetworkErrorWidget(onRetry: () => _dispatch()));
              }
              if (state is MyCompanyGalleryError) {
                return Center(
                    child: GeneralErrorWidget(onRetry: () => _dispatch()));
              }
              if (state is MyCompanyGalleryEmpty) {
                return Center(
                  child: EmptyWidget(),
                );
              }
              if (state is MyCompanyGalleryLoaded) {
                List galleryItems = state.galleryItems;
                return ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      return CompanyGalleryItemWidget(
                          galleryItem: galleryItems[index]);
                    },
                    itemCount: galleryItems.length);
              }
              return Container();
            }),
      ),

      floatingActionButton:FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddNewCompanyImage()));
          },
          child: Icon(Icons.add),
      )
    );
  }
}
