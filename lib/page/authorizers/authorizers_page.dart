import 'package:Sarh/data/model/authorizer.dart';
import 'package:Sarh/size_config.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthorizersPage extends StatefulWidget {
  @override
  _AuthorizersPageState createState() => _AuthorizersPageState();
}

class _AuthorizersPageState extends State<AuthorizersPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.only(bottom: 80,left: 16,right: 16,top: 16),
        itemBuilder: (context, index) {
          return AuthorizerWidget();
        },
        itemCount: 10,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 4,mainAxisSpacing: 4),
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
          Image.asset(
            'assets/logo/logo.png',
            width: SizeConfig.blockSizeHorizontal * 50,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            'Authorizer name',
          ),
          SizedBox(
            height: 4,
          ),
          Divider(height: 1,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: () => onEdit(authorizer),
                icon: Icon(FontAwesomeIcons.solidEdit),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          title: Text('Delete record'),
                          content: Text('Are your sure?'),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: Text('DELETE')),
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                child: Text(MaterialLocalizations.of(context)
                                    .cancelButtonLabel))
                          ],
                        );
                      });
                },
                icon: Icon(FontAwesomeIcons.solidTrashAlt),
              ),
            ],
          )
        ],
      ),
    );
  }
}
