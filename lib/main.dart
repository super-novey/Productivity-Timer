import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:productivity_timer/settings.dart';
import 'package:productivity_timer/timermodel.dart';
import 'package:productivity_timer/widgets.dart';
import './timer.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Work Timer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        home: TimerHomePage());
  }
}

class TimerHomePage extends StatelessWidget {
  final double defaultPadding = 5.0;
  final CountDownTimer timer = CountDownTimer();

  TimerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItems = [];
    menuItems.add(const PopupMenuItem(
      value: 'Settings',
      child: Text('Settings'),
    ));

    timer.startWork();
    return Scaffold(
        appBar: AppBar(
          title: const Text('My work timer'),
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
          return Column(
            children: [
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: defaultPadding, top: defaultPadding)),
                  Expanded(
                      child: ProductivityButton(
                    color: const Color(0xff009688),
                    text: 'Work',
                    onPressed: () => timer.startWork(),
                  )),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                      child: ProductivityButton(
                          color: const Color(0xff607D8B),
                          text: "Short Break",
                          onPressed: () => timer.startBreak(true))),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                      child: ProductivityButton(
                          color: const Color(0xff455A64),
                          text: "Long Break",
                          onPressed: () => timer.startBreak(false))),
                  Padding(
                    padding: EdgeInsets.only(
                        right: defaultPadding, top: defaultPadding),
                  ),
                ],
              ),
              Expanded(
                  child: StreamBuilder(
                initialData: '00:00',
                stream: timer.stream(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  TimerModel timer = (snapshot.data == '00:00')
                      ? TimerModel('00:00', 1)
                      : snapshot.data;
                  return CircularPercentIndicator(
                    radius: availableWidth / 2.3,
                    lineWidth: 10.0,
                    percent: timer.percent,
                    center: Text(
                      timer.time,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    progressColor: const Color(0xff009688),
                  );
                },
              )),
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                      child: ProductivityButton(
                    color: const Color(0xff212121),
                    onPressed: () => timer.stopTimer(),
                    text: 'Stop',
                  )),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                      child: ProductivityButton(
                    color: const Color(0xff009688),
                    onPressed: () => timer.startTimer(),
                    text: 'Restart',
                  )),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          );
        }));
  }

  void emptyMethod() {}

  void goToSettings(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SettingsScreen()));
  }
}
