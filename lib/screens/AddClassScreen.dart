import 'package:attendance_counter/utilities/Class_data.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AddClassScreen extends StatefulWidget {
  final dynamic objectOfThisClassForEditing;

  AddClassScreen({super.key, this.objectOfThisClassForEditing});

  @override
  State<AddClassScreen> createState() => _AddClassScreenState();
}

class _AddClassScreenState extends State<AddClassScreen> {
  late String initialNewClassTitle;

  late int initialMinimumPercentRequired;

  bool itsForEditing = false;
  @override
  void initState() {
    super.initState();
    if (widget.objectOfThisClassForEditing != null) {
      if ((widget.objectOfThisClassForEditing)!.getName() != null &&
          (widget.objectOfThisClassForEditing)!.getMinAttendance() != null) {
        setState(() {
          itsForEditing = true;
          initialNewClassTitle = (widget.objectOfThisClassForEditing).getName();
          initialMinimumPercentRequired =
              (widget.objectOfThisClassForEditing).getMinAttendance();
        });
      }
    }
  }

  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  late String newClassTitle;

  late int minimumPercentRequired;
  var textColor = Colors.black;

  var errorColor = Colors.red;

  var primaryColor = Colors.blue;

  var dividerColor = Colors.blueGrey;

  var disabledColor = Colors.grey;

  bool selected = false;
  bool yesSelected = false;
  bool noSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff757575),
      child: SingleChildScrollView(
        reverse: true,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      itsForEditing
                          ? "Edit the ClassDetails"
                          : "Add Class Details",
                      style: const TextStyle(
                          color: Colors.lightBlueAccent, fontSize: 30.0),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: TextField(
                          maxLines: 1,
                          maxLength: 10,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            labelText:
                                itsForEditing ? 'New Class Name' : 'Class Name',
                            hintText: 'eg:Maths',
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 0.7, color: errorColor)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.5, color: primaryColor)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.0, color: dividerColor)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.0, color: dividerColor)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.0, color: disabledColor)),
                          ),
                          //autofocus: true,
                          onChanged: (newText) {
                            newClassTitle = newText;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: TextField(
                          maxLines: 1,
                          maxLength: 2,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            labelText: itsForEditing
                                ? 'New Minimum percentage of Attendance required'
                                : 'Minimum percentage of Attendance required',
                            hintText: "eg:75% (don't use %)",
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 0.7, color: errorColor)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.5, color: primaryColor)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.0, color: dividerColor)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.0, color: dividerColor)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.0, color: disabledColor)),
                          ),
                          onChanged: (newText) {
                            minimumPercentRequired = int.parse(newText);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.lightBlueAccent),
                  ),
                  onPressed: () {
                    try {
                      if (widget.objectOfThisClassForEditing == null) {
                        Provider.of<AllClassesData>(context, listen: false)
                            .addNewClass(
                          newClassTitle,
                          minimumPercentRequired,
                        );
                      } else {
                        Provider.of<AllClassesData>(context, listen: false)
                            .editThisClass(
                          widget.objectOfThisClassForEditing,
                          newClassTitle,
                          minimumPercentRequired,
                        );
                      }
                      Navigator.pop(
                          context,
                          itsForEditing
                              ? widget.objectOfThisClassForEditing
                              : null);
                    } catch (e) {
                      showMessage(e.toString());
                    }
                  },
                  child: Center(
                      child: Text(
                    itsForEditing ? 'Save Changes' : 'Add',
                    style: const TextStyle(color: Colors.white),
                  )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
