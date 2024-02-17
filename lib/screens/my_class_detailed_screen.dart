import 'package:attendance_counter/screens/AddClassScreen.dart';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../widgets/container_cards.dart';
import '../utilities/constants.dart';

import 'package:attendance_counter/alarm_for_classes/screens/AlarmHomeScreen.dart';

enum CardNumber {
  first,
  second,
  third,
  fourth,
  fifth,
}

class MyClassDetailedScreen extends StatefulWidget {
  final dynamic objectForDetailedClassScreen;

  const MyClassDetailedScreen(
      {super.key, required this.objectForDetailedClassScreen});
  static const String id = 'my_class_detailed_screen';

  @override
  State<MyClassDetailedScreen> createState() => _MyClassDetailedScreen();
}

class _MyClassDetailedScreen extends State<MyClassDetailedScreen> {
  late int minClassAttendance =
      (widget.objectForDetailedClassScreen).getMinAttendance();
  late String title = (widget.objectForDetailedClassScreen).getName();

  late bool myButtonIsPressed1 = false;
  late bool myButtonIsPressed2 = true;
  late bool myButtonIsPressed3 = true;
  late int minAttendance = minClassAttendance;
  late dynamic objectForDetailedScreenClassAfterEditing =
      widget.objectForDetailedClassScreen;

  @override
  void initState() {
    super.initState();
    counterForAttendance =
        (objectForDetailedScreenClassAfterEditing.getAttendance() == null)
            ? 0
            : objectForDetailedScreenClassAfterEditing.getAttendance();
    counterForClasses =
        (objectForDetailedScreenClassAfterEditing.getClasses() == null)
            ? 0
            : objectForDetailedScreenClassAfterEditing.getClasses();
    percentageOfAttendedClass =
        (objectForDetailedScreenClassAfterEditing.getPercentage() == null)
            ? 0.0
            : objectForDetailedScreenClassAfterEditing.getPercentage();
    requiredNumOfClassesToReachMin =
        (objectForDetailedScreenClassAfterEditing.getRequiredAttendance() ==
                null)
            ? 0
            : objectForDetailedScreenClassAfterEditing.getRequiredAttendance();

    counterForMissedClasses =
        (objectForDetailedScreenClassAfterEditing.getMissedClasses() == null)
            ? 0
            : objectForDetailedScreenClassAfterEditing.getMissedClasses();
  }

  void _incrementAttendanceCounter() {
    setState(() {
      counterForAttendance++;
      _calculateThePercentageOfAttendedClasses();
      _calculateRequiredNumOfClassesToReachMin();
      updateTheNewClassVariables();
    });
  }

  void _calculateThePercentageOfAttendedClasses() {
    setState(() {
      percentageOfAttendedClass = counterForAttendance / counterForClasses;
    });
  }

  void _calculateRequiredNumOfClassesToReachMin() {
    final a =
        (counterForAttendance - ((minAttendance / 100) * counterForClasses)) /
            ((minAttendance / 100) - 1);
    setState(() {
      requiredNumOfClassesToReachMin = (a <= 0) ? 0 : a.ceil();
    });
  }

  void _setTheTitleAndMinAttendance() {
    setState(() {
      minAttendance =
          objectForDetailedScreenClassAfterEditing.getMinAttendance();
      title = objectForDetailedScreenClassAfterEditing.getName();
    });
  }

  void updateTheNewClassVariables() {
    objectForDetailedScreenClassAfterEditing
        .setAttendance(counterForAttendance);
    objectForDetailedScreenClassAfterEditing.setClasses(counterForClasses);
    objectForDetailedScreenClassAfterEditing
        .setPercentage(percentageOfAttendedClass);
    objectForDetailedScreenClassAfterEditing
        .setRequiredAttendance(requiredNumOfClassesToReachMin);
    objectForDetailedScreenClassAfterEditing
        .setMissedClasses(counterForMissedClasses);
  }

  void _incrementClassesCounter() {
    setState(() {
      counterForClasses++;
      updateTheNewClassVariables();
    });
  }

  void _incrementMissedClassesCounter() {
    setState(() {
      counterForMissedClasses++;
      _calculateThePercentageOfAttendedClasses();
      _calculateRequiredNumOfClassesToReachMin();
      updateTheNewClassVariables();
    });
  }

  CardNumber? selectedCardNumber;
  int counterForAttendance = 0;
  int counterForClasses = 0;

  double percentageOfAttendedClass = 0.0;
  int requiredNumOfClassesToReachMin = 0;

  int counterForMissedClasses = 0;

  void setTheStates() {
    setState(() {
      counterForAttendance = 0;
      counterForClasses = 0;

      percentageOfAttendedClass = 0.0;
      requiredNumOfClassesToReachMin = 0;

      counterForMissedClasses = 0;
    });
  }

  Widget buildBottomSheet(BuildContext context) {
    return AddClassScreen(
      objectOfThisClassForEditing: objectForDetailedScreenClassAfterEditing,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff111428),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, objectForDetailedScreenClassAfterEditing);
          },
        ),
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit_note),
            onPressed: () {
              setState(() async {
                objectForDetailedScreenClassAfterEditing =
                    await showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: buildBottomSheet(context)),
                  ),
                );
                _setTheTitleAndMinAttendance();
                if (counterForClasses == 0) {
                  setTheStates();
                } else {
                  updateTheNewClassVariables();
                  _calculateRequiredNumOfClassesToReachMin();
                  _calculateThePercentageOfAttendedClasses();
                }
              });
            },
          ),
        ],
        backgroundColor: const Color(0xf1111428),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ContainerCard(
                    onPress: () {
                      setState(() {});
                    },
                    myColor: kInactiveBoxColors,
                    myCardDetails: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: CircularPercentIndicator(
                                radius: 55.0,
                                lineWidth: 6.0,
                                animation: true,
                                animationDuration: 3000,
                                percent: percentageOfAttendedClass,
                                animateFromLastPercent: true,
                                center: Text(
                                  "${(percentageOfAttendedClass * 100).toInt()}%",
                                  style: const TextStyle(
                                    color: Color(0xFF8D8D98),
                                    fontSize: 34,
                                  ),
                                ),
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: Colors.purple,
                                widgetIndicator: const RotatedBox(
                                  quarterTurns: 1,
                                  child: Icon(
                                    Icons.airplanemode_active_outlined,
                                    size: 45,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Attendance",
                            style: kTextStyles,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ContainerCard(
                    onPress: () {},
                    myColor: kInactiveBoxColors,
                    myCardDetails: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 40, right: 10, bottom: 10),
                            child: ElevatedButton(
                              onPressed: (myButtonIsPressed1 == true &&
                                      myButtonIsPressed2 == false &&
                                      myButtonIsPressed3 == false)
                                  ? null
                                  : () {
                                      _incrementClassesCounter();
                                      setState(() {
                                        myButtonIsPressed1 = true;
                                        myButtonIsPressed2 = false;
                                        myButtonIsPressed3 = false;
                                      });
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: myButtonIsPressed1
                                    ? Colors.grey
                                    : Colors.deepPurple,
                                elevation: 3,
                              ),
                              child: const Text(
                                "yes",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Text("was there a class today?",
                              style: kTextStyles),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: ContainerCard(
              onPress: () {
                setState(() {});
              },
              myColor: kInactiveBoxColors,
              myCardDetails: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    flex: 3,
                    child: Text(
                      'Did you attend this class?',
                      style: kTextStyles,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: (myButtonIsPressed1 == false &&
                                    myButtonIsPressed2 == true &&
                                    myButtonIsPressed3 == true)
                                ? null
                                : () {
                                    setState(() {
                                      _incrementAttendanceCounter();
                                      myButtonIsPressed1 = false;
                                      myButtonIsPressed2 = true;
                                      myButtonIsPressed3 = true;
                                    });
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: myButtonIsPressed2
                                  ? Colors.grey
                                  : Colors.green,
                              elevation: 3,
                            ),
                            child: const Text(
                              "YES",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const Expanded(
                          child: SizedBox(
                            width: 20.0,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: (myButtonIsPressed1 == false &&
                                    myButtonIsPressed2 == true &&
                                    myButtonIsPressed3 == true)
                                ? null
                                : () {
                                    setState(() {
                                      _incrementMissedClassesCounter();
                                      myButtonIsPressed1 = false;
                                      myButtonIsPressed2 = true;
                                      myButtonIsPressed3 = true;
                                    });
                                  },
                            style: ElevatedButton.styleFrom(
                              //maximumSize: Size.infinite,
                              backgroundColor:
                                  myButtonIsPressed3 ? Colors.grey : Colors.red,
                              elevation: 3,
                            ),
                            child: const Text(
                              "NO",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Row(
              children: [
                Expanded(
                  child: ContainerCard(
                    onPress: () {},
                    myColor: kInactiveBoxColors,
                    myCardDetails: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("You need to attend", style: kTextStyles),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              requiredNumOfClassesToReachMin.toString(),
                              style: kNumberStyles,
                            ),
                            const SizedBox(width: 3),
                            const Text(
                              'Classes',
                              style: kTextColor,
                            )
                          ],
                        ),
                        const Text("to meet requirement.", style: kTextStyles),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ContainerCard(
                    onPress: () {},
                    myColor: kInactiveBoxColors,
                    myCardDetails: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Total Classes:',
                              style: kTextStyles,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              counterForClasses.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Missed Classes:',
                              style: kTextStyles,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              counterForMissedClasses.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Attended classes:',
                              style: kTextStyles,
                            ),
                            const SizedBox(width: 1),
                            Text(
                              counterForAttendance.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: ContainerCard(
              onPress: () {},
              myColor: kInactiveBoxColors,
              myCardDetails: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Text(
                      "Wanted to get notifications for the class?",
                      style: kTextStyles,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, homeScreenOfAlarm.id);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              elevation: 3,
                            ),
                            child: const Text(
                              "YES",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const Expanded(
                          child: SizedBox(
                            width: 20.0,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              elevation: 3,
                            ),
                            child: const Text(
                              "NO",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
