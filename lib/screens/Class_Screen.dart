import 'dart:io';

import 'package:attendance_counter/widgets/class_list_widget.dart';
import 'package:attendance_counter/utilities/constants.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'AddClassScreen.dart';
import 'NavBarScreen.dart';

final _auth = FirebaseAuth.instance;
final User user = _auth.currentUser!;

class ClassScreen extends StatefulWidget {
  const ClassScreen({Key? key}) : super(key: key);
  static const String id = 'Classes_List_screen';

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  Widget buildBottomSheet(BuildContext context) {
    return AddClassScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      backgroundColor: const Color(0xf1111428),
      appBar: AppBar(
        elevation: 8.0,
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => exit(0),
          ),
        ],
        title: const Text('Add Classes'),
        backgroundColor: const Color(0xf1111428),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: buildBottomSheet(context)),
            ),
          );
        },
        backgroundColor: kActiveBoxColors,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 20.0),
                decoration: const BoxDecoration(
                  color: Color(0xff111428),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: const Expanded(
                  child: ClassesList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
