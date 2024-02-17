import 'package:attendance_counter/utilities/constants.dart';
import 'package:attendance_counter/screens/my_class_detailed_screen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../utilities/Class_data.dart';

class EachClassWidget extends StatefulWidget {
  //final void Function()? deleteCallback;

  final dynamic objectForThisClass;

  const EachClassWidget({
    super.key,
    //this.deleteCallback,
    this.objectForThisClass,
  });

  @override
  State<EachClassWidget> createState() => _EachClassWidgetState();
}

class _EachClassWidgetState extends State<EachClassWidget> {
  late double presentClassAttendance =
      widget.objectForThisClass.getPercentage();

  late String classTitle = widget.objectForThisClass.getName();

  late dynamic newClassObject = widget.objectForThisClass;

  bool selected = false;
  late bool wannaDelete = false;

  void updateAttendance() {
    setState(() {
      classTitle = newClassObject.getName();
      presentClassAttendance = newClassObject.getPercentage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kInactiveBoxColors,
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 7,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: kInactiveBoxColors,
                  textStyle: const TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  setState(() async {
                    newClassObject = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyClassDetailedScreen(
                          objectForDetailedClassScreen:
                              widget.objectForThisClass,
                        ),
                      ),
                    );
                    updateAttendance();
                  });
                },
                //onLongPress: widget.deleteCallback,
                child: Row(
                  children: [
                    CircularPercentIndicator(
                      radius: 35.0,
                      lineWidth: 6.0,
                      animation: true,
                      animationDuration: 3000,
                      percent: (presentClassAttendance),
                      animateFromLastPercent: true,
                      center: Text(
                        "${(((presentClassAttendance) * 100).toInt()).toString()}%",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.purple,
                      widgetIndicator: const RotatedBox(
                        quarterTurns: 1,
                        child: Icon(
                          Icons.man_4_sharp,
                          size: 35,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Text(
                      classTitle,
                      selectionColor: Colors.white,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: TextButton(
                onLongPress: () {
                  Provider.of<AllClassesData>(context, listen: false)
                      .deleteClass(newClassObject);
                },
                onPressed: () => showDialog<void Function()?>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Long Press on Delete Button'),
                    content:
                        const Text('This will permanently delete this class'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(
                          context,
                        ),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
