import 'package:flutter/material.dart';
import 'package:productivity_timer/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: const Settings());
  }
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late TextEditingController txtWork;
  late TextEditingController txtShort;
  late TextEditingController txtLong;

  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";

  late SharedPreferences prefs;

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 24);
    return Container(
      padding: const EdgeInsets.all(5),
      child: GridView.count(
        crossAxisCount: 3,
        scrollDirection: Axis.vertical,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          Text(
            "Work",
            style: textStyle,
          ),
          const Text(""),
          const Text(""),
          SettingsButton(
            callBack: updateSettings,
            setting: WORKTIME,
            text: "-",
            value: -1,
            color: const Color(0xff455A64),
          ),
          TextField(
              controller: txtWork,
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number),
          SettingsButton(
            callBack: updateSettings,
            setting: WORKTIME,
            text: "+",
            value: 1,
            color: const Color(0xff009688),
          ),
          Text("Short", style: textStyle),
          const Text(""),
          const Text(""),
          SettingsButton(
            callBack: updateSettings,
            setting: SHORTBREAK,
            text: "-",
            value: -1,
            color: const Color(0xff455A64),
          ),
          TextField(
              controller: txtShort,
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number),
          SettingsButton(
            callBack: updateSettings,
            setting: SHORTBREAK,
            text: "+",
            value: 1,
            color: const Color(0xff009688),
          ),
          Text("Long", style: textStyle),
          const Text(""),
          const Text(""),
          SettingsButton(
            callBack: updateSettings,
            setting: LONGBREAK,
            text: "-",
            value: -1,
            color: const Color(0xff455A64),
          ),
          TextField(
              controller: txtLong,
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number),
          SettingsButton(
            callBack: updateSettings,
            setting: LONGBREAK,
            text: "+",
            value: 1,
            color: const Color(0xff009688),
          ),
        ],
      ),
    );
  }

  void readSettings() async {
    prefs = await SharedPreferences.getInstance();
    int? workTime = prefs.getInt(WORKTIME);
    if (workTime == null) {
      workTime = 30;
      prefs.setInt(WORKTIME, workTime);
    }
    int? shortBreak = prefs.getInt(SHORTBREAK);
    if (shortBreak == null) {
      shortBreak = 5;
      prefs.setInt(SHORTBREAK, shortBreak);
    }
    int? longBreak = prefs.getInt(LONGBREAK);
    if (longBreak == null) {
      longBreak = 20;
      prefs.setInt(LONGBREAK, longBreak);
    }
    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  void updateSettings(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int workTime = prefs.getInt(WORKTIME)!;
          workTime += value;
          if (workTime >= 1 && workTime <= 180) {
            prefs.setInt(WORKTIME, workTime);
            setState(() {
              txtWork.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          int short = prefs.getInt(SHORTBREAK)!;
          short += value;
          if (short >= 1 && short <= 120) {
            prefs.setInt(SHORTBREAK, short);
            setState(() {
              txtShort.text = short.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          int long = prefs.getInt(LONGBREAK)!;
          long += value;
          if (long >= 1 && long <= 180) {
            prefs.setInt(LONGBREAK, long);
            setState(() {
              txtLong.text = long.toString();
            });
          }
        }
        break;
    }
  }
}
