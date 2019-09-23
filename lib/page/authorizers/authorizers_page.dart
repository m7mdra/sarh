import 'package:Sarh/data/model/authorizer.dart';
import 'package:Sarh/dependency_provider.dart';
import 'package:Sarh/page/company_profile/bloc/authorizer/authorizer_bloc.dart';
import 'package:Sarh/page/company_profile/bloc/authorizer/bloc.dart';
import 'package:Sarh/size_config.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:Sarh/widget/ui_state.dart';
import 'package:Sarh/widget/ui_state/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorizersPage extends StatefulWidget {
  @override
  _AuthorizersPageState createState() => _AuthorizersPageState();
}

class _AuthorizersPageState extends State<AuthorizersPage> {
  AuthorizersBloc _authorizersBloc;

  @override
  void initState() {
    super.initState();
    _authorizersBloc = AuthorizersBloc(DependencyProvider.provide());
    _authorizersBloc.dispatch(LoadAuthroizers());
  }

  @override
  void dispose() {
    super.dispose();
    _authorizersBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: BlocBuilder(
        bloc: _authorizersBloc,
        builder: (context, state) {
          if (state is AuthorizerLoading) {
            return Center(
              child: ProgressBar(),
            );
          }
          if (state is AuthorizersFailed) {
            return Center(
              child: GeneralErrorWidget(
                onRetry: () {
                  _authorizersBloc.dispatch(LoadAuthroizers());
                },
              ),
            );
          }
          if(state is AuthorizersEmpty){
            return Center(child: EmptyWidget());
          }
          if (state is AuthorizersLoaded) {
            var authorizers = state.authorizers;
            return GridView.builder(
              padding: const EdgeInsets.only(
                  bottom: 80, left: 16, right: 16, top: 16),
              itemBuilder: (context, index) {
                return AuthorizerWidget(
                    authorizer: authorizers[index],
                    onDelete: (value) {},
                    onEdit: (value) {});
              },
              itemCount: authorizers.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 4, mainAxisSpacing: 4),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(FontAwesomeIcons.plus),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButtonNoLabel(Colors.white),
        title: Text('Authorizers'),
        centerTitle: true,
      ),
    );
  }
}

class AuthorizerWidget extends StatelessWidget {
  final ValueSetter<Authorizer> onDelete;
  final ValueSetter<Authorizer> onEdit;
  final Authorizer authorizer;

  const AuthorizerWidget({Key key, this.onDelete, this.onEdit, this.authorizer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(
            authorizer.logo,
            width: SizeConfig.blockSizeHorizontal * 50,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            authorizer.name,
          ),
          SizedBox(
            height: 4,
          ),
          Divider(
            height: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: () => onEdit(authorizer),
                icon: Icon(FontAwesomeIcons.solidEdit),
              ),
              IconButton(
                onPressed: () => onDelete(authorizer),
                icon: Icon(FontAwesomeIcons.solidTrashAlt),
              ),
            ],
          )
        ],
      ),
    );
  }
}
