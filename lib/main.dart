import 'package:flutter/material.dart';
import 'package:productivity_app/settings.dart';
import 'package:productivity_app/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './timer.dart';
import './widgets.dart';
import './timermodel.dart';
import './settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Work Timer',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: TimerHomepage(),
    );
  }
}

class TimerHomepage extends StatelessWidget {
  final double defaultPadding = 5.0;
  final CountDownTimer timer = CountDownTimer();

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItems = List<PopupMenuItem<String>>();
    menuItems.add(PopupMenuItem(
      value: 'Settings',
      child: Text('Settings'),
    ));

    timer.startWork();
    return MaterialApp(
      title: 'My Work Timer',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('My Work Timer'),
            actions: [
              PopupMenuButton<String>(
                itemBuilder: (BuildContext context) {
                  return menuItems.toList();
                },
                onSelected: (s) {
                  if (s == 'Settings') {
                    goToSettings(context);
                  }
                },
              )
            ],
          ),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            final double availableWidth = constraints.maxWidth;
            return Column(children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                      // ignore: missing_required_param
                      child: ProductivityButton(
                          color: Color(0xff4527A0),
                          text: 'Work',
                          onPressed: () => timer.startWork())),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                      // ignore: missing_required_param
                      child: ProductivityButton(
                          color: Color(0xff7E57C2),
                          text: 'Short Break',
                          onPressed: () => timer.startBreak(true))),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                      // ignore: missing_required_param
                      child: ProductivityButton(
                          color: Color(0xff4527A0),
                          text: 'Long Break',
                          onPressed: () => timer.startBreak(false))),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                ],
              ),
              Expanded(
                  child: StreamBuilder(
                      initialData: TimerModel('00:00', 1),
                      stream: timer.stream(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        TimerModel timer = snapshot.data;
                        return Container(
                            child: CircularPercentIndicator(
                          radius: availableWidth / 2,
                          lineWidth: 10.0,
                          percent: (timer.percent == null) ? 1 : timer.percent,
                          center: Text(
                              (timer.time == null) ? '00:00' : timer.time,
                              style: Theme.of(context).textTheme.headline4),
                          progressColor: Color(0xff7E57C2),
                        ));
                      })),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                      // ignore: missing_required_param
                      child: ProductivityButton(
                          color: Color(0xff7E57C2),
                          text: 'Stop',
                          onPressed: () => timer.stopTimer())),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                      // ignore: missing_required_param
                      child: ProductivityButton(
                          color: Color(0xff4527A0),
                          text: 'Resume',
                          onPressed: () => timer.startTimer())),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                ],
              )
            ]);
          })),
    );
  }

  void emptyMethod() {}
  void goToSettings(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsScreen()));
  }
}
