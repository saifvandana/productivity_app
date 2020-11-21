import 'package:flutter/material.dart';
import 'package:productivity_app/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './timer.dart';
import './widgets.dart';
import './timermodel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Work Timer',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: TimerHomepage(),
    );
  }
}

void emptyMethod() {}

class TimerHomepage extends StatelessWidget {
  final double defaultPadding = 5.0;
  final CountDownTimer timer = CountDownTimer();

  @override
  Widget build(BuildContext context) {
    timer.startWork();
    return MaterialApp(
      title: 'My Work Timer',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('My Work Timer'),
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
                          color: Color(0xff009688),
                          text: 'Work',
                          onPressed: emptyMethod)),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                      // ignore: missing_required_param
                      child: ProductivityButton(
                          color: Color(0xff009688),
                          text: 'Short Break',
                          onPressed: emptyMethod)),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                      // ignore: missing_required_param
                      child: ProductivityButton(
                          color: Color(0xff009688),
                          text: 'Long Break',
                          onPressed: emptyMethod)),
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
                          percent: timer.percent,
                          center: Text("30:00",
                              style: Theme.of(context).textTheme.headline4),
                          progressColor: Color(0xff009688),
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
                          color: Color(0xff009688),
                          text: 'Stop',
                          onPressed: emptyMethod)),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                      // ignore: missing_required_param
                      child: ProductivityButton(
                          color: Color(0xff009688),
                          text: 'Restart',
                          onPressed: emptyMethod)),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                ],
              )
            ]);
          })),
    );
  }
}
