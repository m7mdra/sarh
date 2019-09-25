import 'dart:async';

import 'package:Sarh/page/add_company_profile/add_company_info_page.dart';
import 'package:Sarh/page/home/main/main_page.dart';
import 'package:Sarh/page/login/login_page.dart';
import 'package:Sarh/page/splash/bloc/session_bloc.dart';
import 'package:Sarh/page/splash/bloc/session_bloc_event.dart';
import 'package:Sarh/page/splash/bloc/session_bloc_state.dart';
import 'package:Sarh/page/verify_account/verify_account_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _logoScaleController;
  AnimationController _logoTranslateController;
  Animation<double> _logoScaleAnimation;
  Animation<double> _logoTranslateAnimation;
  AnimationController _slogunOpacityController;
  Animation<double> _slogunOpacityAnimation;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  SessionBloc _sessionBloc;

  @override
  void initState() {
    super.initState();
    animate();
    _sessionBloc = BlocProvider.of<SessionBloc>(context)
      ..dispatch(AppStarted());
  }

  void animate() {
    initNotificationAndListen();
    _logoScaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() => setState(() {}));
    _logoTranslateController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() => setState(() {}));
    _slogunOpacityController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() => setState(() {}));

    _logoScaleAnimation =
        Tween<double>(begin: 100, end: 180).animate(_logoScaleController);
    _logoScaleAnimation.addListener(() {
      if (_logoScaleAnimation.status == AnimationStatus.completed)
        _logoTranslateController.forward();
    });

    _slogunOpacityAnimation =
        Tween<double>(begin: 0, end: 1).animate(_slogunOpacityController);
    _logoTranslateAnimation = Tween<double>(begin: 0, end: 50).animate(
        CurvedAnimation(
            parent: _logoTranslateController, curve: Curves.fastOutSlowIn));
    _logoTranslateAnimation.addListener(() {
      if (_logoTranslateAnimation.status == AnimationStatus.completed)
        _slogunOpacityController.forward();
    });
    _slogunOpacityController.addListener(() {});
    _logoScaleController.forward();
  }

  void initNotificationAndListen() {
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));

    firebaseMessaging.setAutoInitEnabled(true);
    firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> message) {
        print("onLaunch: $message");
        return Future.value(false);
      },
      onMessage: (Map<String, dynamic> message) {
        return Future.value(false);
      },
      onResume: (Map<String, dynamic> message) {
        print("onResume: $message");
        return Future.value(false);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _logoScaleController.dispose();
    _logoTranslateController.dispose();
    _slogunOpacityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: BlocListener(
          bloc: _sessionBloc,
          listener: (context, state) {
            if (state is AccountNotVerified) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return VerifyAccountPage();
              }));
            }
            if (state is UserAuthenticated) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return MainPage();
              }));
            }
            if (state is UserUnauthenticated) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return LoginPage();
              }));
            }
            if (state is ProfileNotCompleted) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return AddCompanyInfoPage();
              }));
            }
          },
          child: Stack(
            children: <Widget>[
              Image.asset(
                'assets/background/background.jpg',
                scale: 4,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              buildCenter(),
            ],
          ),
        ),
      ),
    );
  }

  Center buildCenter() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Transform(
            transform: Matrix4.translationValues(
              0,
              -_logoTranslateAnimation.value,
              _logoTranslateAnimation.value,
            ),
            child: Column(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'assets/logo/logo.png',
                    width: _logoScaleAnimation.value,
                  ),
                ),
                Opacity(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Solgun of company here',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  opacity: _slogunOpacityAnimation.value,
                )
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
