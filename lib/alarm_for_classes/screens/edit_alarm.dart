// import 'package:alarm/alarm.dart';
// import 'package:flutter/material.dart';
//
// class ExampleAlarmEditScreen extends StatefulWidget {
//   final AlarmSettings? alarmSettings;
//
//   const ExampleAlarmEditScreen({Key? key, this.alarmSettings})
//       : super(key: key);
//
//   @override
//   State<ExampleAlarmEditScreen> createState() => _ExampleAlarmEditScreenState();
// }
//
// class _ExampleAlarmEditScreenState extends State<ExampleAlarmEditScreen> {
//   bool loading = false;
//   List<DropdownMenuItem<String>> get dropdownItems {
//     List<DropdownMenuItem<String>> menuItems = [
//       DropdownMenuItem(child: Text("Monday"), value: "monday"),
//       DropdownMenuItem(child: Text("Tuesday"), value: "tuesday"),
//       DropdownMenuItem(child: Text("Wednesday"), value: "wednesday"),
//       DropdownMenuItem(child: Text("Thursday"), value: "thursday"),
//       DropdownMenuItem(child: Text("Friday"), value: "friday"),
//       DropdownMenuItem(child: Text("Sarturday"), value: "saturday"),
//       DropdownMenuItem(child: Text("Sunday"), value: "sunday"),
//     ];
//     return menuItems;
//   }
//
//   late String selectedWeekday_from_dropdown = "monday";
//
//   late bool creating;
//   late DateTime selectedDateTime;
//   late DateTime selectedWeekday;
//   late bool loopAudio;
//   late bool vibrate;
//   late bool volumeMax;
//   late bool showNotification;
//   late String assetAudio;
//
//   @override
//   void initState() {
//     super.initState();
//     creating = widget.alarmSettings == null;
//
//     if (creating) {
//       selectedDateTime = DateTime.now().add(const Duration(minutes: 1));
//       selectedDateTime = selectedDateTime.copyWith(second: 0, millisecond: 0);
//       loopAudio = true;
//       vibrate = true;
//       volumeMax = false;
//       showNotification = true;
//       assetAudio = 'assets/marimba.mp3';
//     } else {
//       selectedDateTime = widget.alarmSettings!.dateTime;
//       loopAudio = widget.alarmSettings!.loopAudio;
//       vibrate = widget.alarmSettings!.vibrate;
//       volumeMax = widget.alarmSettings!.volumeMax;
//       showNotification = widget.alarmSettings!.notificationTitle != null &&
//           widget.alarmSettings!.notificationTitle!.isNotEmpty &&
//           widget.alarmSettings!.notificationBody != null &&
//           widget.alarmSettings!.notificationBody!.isNotEmpty;
//       assetAudio = widget.alarmSettings!.assetAudioPath;
//     }
//   }
//
//   String getDay() {
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final difference = selectedDateTime.difference(today).inDays;
//
//     if (difference == 0) {
//       return 'Today';
//     } else if (difference == 1) {
//       return 'Tomorrow';
//     } else if (difference == 2) {
//       return 'After tomorrow';
//     } else {
//       return 'In $difference days';
//     }
//   }
//
//   Future<void> pickTime() async {
//     final res = await showTimePicker(
//       initialTime: TimeOfDay.fromDateTime(selectedDateTime),
//       context: context,
//     );
//
//     if (res != null) {
//       setState(() {
//         selectedDateTime = selectedDateTime.copyWith(
//           hour: res.hour,
//           minute: res.minute,
//         );
//         if (selectedDateTime.isBefore(DateTime.now())) {
//           selectedDateTime = selectedDateTime.add(const Duration(days: 1));
//         }
//       });
//     }
//   }
//
//   Future<void> pickWeekday() async {
//     final res = await showDatePicker(
//       initialDate: DateTime.now(),
//       context: context,
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2050, 6, 6),
//     );
//
//     if (res != null) {
//       setState(() {
//         selectedDateTime = selectedDateTime.copyWith(
//             month: res.month, day: res.day, year: res.year);
//         if (selectedDateTime.isBefore(DateTime.now())) {
//           selectedDateTime = selectedDateTime.add(const Duration(days: 1));
//         }
//       });
//     }
//   }
//
//   AlarmSettings buildAlarmSettings() {
//     final id = creating
//         ? DateTime.now().millisecondsSinceEpoch % 10000
//         : widget.alarmSettings!.id;
//
//     final alarmSettings = AlarmSettings(
//       id: id,
//       dateTime: selectedDateTime,
//       loopAudio: loopAudio,
//       vibrate: vibrate,
//       volumeMax: volumeMax,
//       notificationTitle: showNotification ? 'Alarm example' : null,
//       notificationBody: showNotification ? 'Your alarm ($id) is ringing' : null,
//       assetAudioPath: assetAudio,
//     );
//     return alarmSettings;
//   }
//
//   void saveAlarm() {
//     setState(() => loading = true);
//     Alarm.set(alarmSettings: buildAlarmSettings()).then((res) {
//       if (res) Navigator.pop(context, true);
//     });
//     setState(() => loading = false);
//   }
//
//   void deleteAlarm() {
//     Alarm.stop(widget.alarmSettings!.id).then((res) {
//       if (res) Navigator.pop(context, true);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context, false),
//                 child: Text(
//                   "Cancel",
//                   style: Theme.of(context)
//                       .textTheme
//                       .titleLarge!
//                       .copyWith(color: Colors.blueAccent),
//                 ),
//               ),
//               TextButton(
//                 onPressed: saveAlarm,
//                 child: loading
//                     ? const CircularProgressIndicator()
//                     : Text(
//                         "Save",
//                         style: Theme.of(context)
//                             .textTheme
//                             .titleLarge!
//                             .copyWith(color: Colors.blueAccent),
//                       ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(6.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                     child: DropdownButton(
//                       iconSize: 34,
//                       value: selectedWeekday_from_dropdown,
//                       onChanged: (String? x) {
//                         setState(() {
//                           selectedWeekday_from_dropdown = x!;
//                         });
//                       },
//                       items: dropdownItems,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           RawMaterialButton(
//             onPressed: pickTime,
//             fillColor: Colors.grey[200],
//             child: Container(
//               margin: const EdgeInsets.all(15),
//               child: Text(
//                 TimeOfDay.fromDateTime(selectedDateTime).format(context),
//                 style: Theme.of(context)
//                     .textTheme
//                     .displayMedium!
//                     .copyWith(color: Colors.blueAccent),
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Loop alarm audio',
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//               Switch(
//                 value: loopAudio,
//                 onChanged: (value) => setState(() => loopAudio = value),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Vibrate',
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//               Switch(
//                 value: vibrate,
//                 onChanged: (value) => setState(() => vibrate = value),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'System volume max',
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//               Switch(
//                 value: volumeMax,
//                 onChanged: (value) => setState(() => volumeMax = value),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Show notification',
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//               Switch(
//                 value: showNotification,
//                 onChanged: (value) => setState(() => showNotification = value),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Sound',
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//               DropdownButton(
//                 value: assetAudio,
//                 items: const [
//                   DropdownMenuItem<String>(
//                     value: 'assets/marimba.mp3',
//                     child: Text('Marimba'),
//                   ),
//                   DropdownMenuItem<String>(
//                     value: 'assets/nokia.mp3',
//                     child: Text('Nokia'),
//                   ),
//                   DropdownMenuItem<String>(
//                     value: 'assets/mozart.mp3',
//                     child: Text('Mozart'),
//                   ),
//                   DropdownMenuItem<String>(
//                     value: 'assets/star_wars.mp3',
//                     child: Text('Star Wars'),
//                   ),
//                   DropdownMenuItem<String>(
//                     value: 'assets/one_piece.mp3',
//                     child: Text('One Piece'),
//                   ),
//                 ],
//                 onChanged: (value) => setState(() => assetAudio = value!),
//               ),
//             ],
//           ),
//           if (!creating)
//             TextButton(
//               onPressed: deleteAlarm,
//               child: Text(
//                 'Delete Alarm',
//                 style: Theme.of(context)
//                     .textTheme
//                     .titleMedium!
//                     .copyWith(color: Colors.red),
//               ),
//             ),
//           const SizedBox(),
//         ],
//       ),
//     );
//   }
// }
import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';

class AlarmEditScreen extends StatefulWidget {
  final AlarmSettings? alarmSettings;

  const AlarmEditScreen({Key? key, this.alarmSettings}) : super(key: key);

  @override
  State<AlarmEditScreen> createState() => _AlarmEditScreenState();
}

class _AlarmEditScreenState extends State<AlarmEditScreen> {
  bool loading = false;

  late bool creating;
  late DateTime selectedDateTime;
  late bool loopAudio;
  late bool vibrate;
  late bool volumeMax;
  late bool showNotification;
  late String assetAudio;

  List<DropdownMenuItem<int>> get dropdownItems {
    List<DropdownMenuItem<int>> menuItems = [
      const DropdownMenuItem(value: 1, child: Text("Monday")),
      const DropdownMenuItem(value: 2, child: Text("Tuesday")),
      const DropdownMenuItem(value: 3, child: Text("Wednesday")),
      const DropdownMenuItem(value: 4, child: Text("Thursday")),
      const DropdownMenuItem(value: 5, child: Text("Friday")),
      const DropdownMenuItem(value: 6, child: Text("Saturday")),
      const DropdownMenuItem(value: 7, child: Text("Sunday")),
    ];
    return menuItems;
  }

  late int selectedWeekdayFromDropdown;

  @override
  void initState() {
    super.initState();
    selectedWeekdayFromDropdown = (DateTime.now()).weekday;
    creating = widget.alarmSettings == null;

    if (creating) {
      selectedDateTime = DateTime.now().add(const Duration(minutes: 1));
      selectedDateTime = selectedDateTime.copyWith(second: 0, millisecond: 0);
      loopAudio = true;
      vibrate = true;
      volumeMax = false;
      showNotification = true;
      assetAudio = 'assets/marimba.mp3';
    } else {
      selectedDateTime = widget.alarmSettings!.dateTime;
      loopAudio = widget.alarmSettings!.loopAudio;
      vibrate = widget.alarmSettings!.vibrate;
      volumeMax = widget.alarmSettings!.volumeMax;
      showNotification = widget.alarmSettings!.notificationTitle != null &&
          widget.alarmSettings!.notificationTitle!.isNotEmpty &&
          widget.alarmSettings!.notificationBody != null &&
          widget.alarmSettings!.notificationBody!.isNotEmpty;
      assetAudio = widget.alarmSettings!.assetAudioPath;
    }
  }

  String getDay() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final difference = selectedDateTime.difference(today).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else if (difference == 2) {
      return 'After tomorrow';
    } else {
      return 'In $difference days';
    }
  }

  Future<void> pickTime() async {
    final res = await showTimePicker(
      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      context: context,
    );

    if (res != null) {
      setState(() {
        selectedDateTime = selectedDateTime.copyWith(
          hour: res.hour,
          minute: res.minute,
        );


      });
    }

    pickWeekDay(selectedWeekdayFromDropdown);
  }

  Future<void> pickDate() async {
    final res = await showDatePicker(
      initialDate: DateTime.now(),
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050, 6, 6),
    );

    if (res != null) {
      setState(() {
        selectedDateTime = selectedDateTime.copyWith(
          day: res.day,
          month: res.month,
          year: res.year,
        );

      });
    }
    //pickWeekDay(selectedWeekdayFromDropdown);
  }

  Future<void> pickWeekDay(int selectedWeekdayFromDropdown) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final int todayDayNum = today.weekday;
    DateTime selectedDateTimeAccordingToWeekday = today;

    int i;
    for (i = 1; i <= 6; i++) {
      selectedDateTimeAccordingToWeekday =
          today.copyWith(day: now.day).add(Duration(days: i));
      if (selectedDateTimeAccordingToWeekday.weekday ==
          selectedWeekdayFromDropdown) {
        break;
      }
    }

    // final difference = selectedDateTimeAccordingToWeekday.difference(today).inDays;

    if (todayDayNum != selectedWeekdayFromDropdown) {
      setState(() {
        selectedDateTime =
            selectedDateTime.copyWith(day: now.day).add(Duration(days: i));
      });
    } else {
      setState(() {
        if (selectedDateTime
            .copyWith(
              year: now.year,
              month: now.month,
              day: now.day,
            )
            .isBefore(DateTime.now())) {
          selectedDateTime = selectedDateTime
              .copyWith(day: now.day)
              .add(const Duration(days: 7));
        } else {
          setState(() {
            selectedDateTime = selectedDateTime.copyWith(
              year: now.year,
              month: now.month,
              day: now.day,
            );
          });
        }
      });
    }
  }

  AlarmSettings buildAlarmSettings() {
    final id = creating
        ? DateTime.now().millisecondsSinceEpoch % 10000
        : widget.alarmSettings!.id;

    final alarmSettings = AlarmSettings(
      id: id,
      dateTime: selectedDateTime,
      loopAudio: loopAudio,
      vibrate: vibrate,
      volumeMax: volumeMax,
      notificationTitle: showNotification ? 'Alarm example' : null,
      notificationBody: showNotification ? 'Your alarm ($id) is ringing' : null,
      assetAudioPath: assetAudio,
    );
    return alarmSettings;
  }

  void saveAlarm() {
    setState(() => loading = true);
    Alarm.set(alarmSettings: buildAlarmSettings()).then((res) {
      if (res) Navigator.pop(context, true);
    });
    setState(() => loading = false);
  }

  void deleteAlarm() {
    Alarm.stop(widget.alarmSettings!.id).then((res) {
      if (res) Navigator.pop(context, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  "Cancel",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: saveAlarm,
                child: loading
                    ? const CircularProgressIndicator()
                    : Text(
                        "Save",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.blueAccent),
                      ),
              ),
            ],
          ),
          Text(
            getDay(),
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.blueAccent.withOpacity(0.8)),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: DropdownButton(
              iconSize: 34,
              value: selectedWeekdayFromDropdown,
              onChanged: (int? x) {
                setState(() {
                  selectedWeekdayFromDropdown = x!;
                  pickWeekDay(selectedWeekdayFromDropdown);
                });
              },
              items: dropdownItems,
            ),
          ),
          Text(
            "Date of class",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.blueAccent.withOpacity(0.8)),
          ),
          RawMaterialButton(
            onPressed: pickDate,
            fillColor: Colors.grey[200],
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Text(
                "${selectedDateTime.day.toString()}:${selectedDateTime.month.toString()}:${selectedDateTime.year.toString()}",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Colors.blueAccent),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          RawMaterialButton(
            onPressed: pickTime,
            fillColor: Colors.grey[200],
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Text(
                TimeOfDay.fromDateTime(selectedDateTime).format(context),
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Colors.blueAccent),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Loop alarm audio',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Switch(
                value: loopAudio,
                onChanged: (value) => setState(() => loopAudio = value),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Vibrate',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Switch(
                value: vibrate,
                onChanged: (value) => setState(() => vibrate = value),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'System volume max',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Switch(
                value: volumeMax,
                onChanged: (value) => setState(() => volumeMax = value),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Show notification',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Switch(
                value: showNotification,
                onChanged: (value) => setState(() => showNotification = value),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sound',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              DropdownButton(
                value: assetAudio,
                items: const [
                  DropdownMenuItem<String>(
                    value: 'assets/marimba.mp3',
                    child: Text('Marimba'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'assets/nokia.mp3',
                    child: Text('Nokia'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'assets/mozart.mp3',
                    child: Text('Mozart'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'assets/star_wars.mp3',
                    child: Text('Star Wars'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'assets/one_piece.mp3',
                    child: Text('One Piece'),
                  ),
                ],
                onChanged: (value) => setState(() => assetAudio = value!),
              ),
            ],
          ),
          if (!creating)
            TextButton(
              onPressed: deleteAlarm,
              child: Text(
                'Delete Alarm',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.red),
              ),
            ),
          const SizedBox(),
        ],
      ),
    );
  }
}
