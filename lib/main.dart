import 'package:Sarh/page/splash/splash_page.dart';
import 'package:Sarh/widget/stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'i10n/app_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sarh',
      theme: ThemeData(
        buttonColor: Color(0xff0078ff),
        buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        iconTheme: IconThemeData(color: Color(0xff5fabf6)),
        primaryColor: Color(0xff0078ff),
      ),
      supportedLocales: [
        const Locale('ar', ''),
        const Locale('en', ''),
      ],
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      home: TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int current=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WeeStepper(
        steps: [

         WeeStep(

              title: Text('Step one'),
              content: Text(
                'Step #1',
                style: Theme.of(context).textTheme.display4,
              )),
          WeeStep(
              title: Text('Step Two'),
              content: Text(
                'Step #2',
                style: Theme.of(context).textTheme.display4,
              )),

        ],
        currentStep: current,
        onStepContinue: (){
          if(current==1)
            return;
          setState(() {
            current+=1;
          });
        },
        onPrevious: (){
          if(current==0)
            return;
          setState(() {
            current-=1;
          });
        },
        onStepTapped: (step){
          setState(() {
            this.current=step;
          });
        },
      ),
    );
  }
}
