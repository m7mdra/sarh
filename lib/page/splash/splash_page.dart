import 'dart:async';

import 'package:Sarh/page/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  void initState() {
    super.initState();
    animate();
  }



  void animate() {
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
        Future.delayed(Duration(milliseconds: 500)).then((val) {
          _logoTranslateController.forward();
        });
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
    _slogunOpacityController.addListener(() {
      if (_slogunOpacityAnimation.status == AnimationStatus.completed)
        Future.delayed(Duration(milliseconds: 500)).then((val) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        });
    });
    _logoScaleController.forward();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          animate();
        },
        child: Icon(Icons.replay),
      ),
      backgroundColor: Colors.grey,
      body: SafeArea(
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
