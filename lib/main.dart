import 'dart:async';

import 'package:attendance_counter/screens/ImagePickerScreen.dart';
import 'package:attendance_counter/utilities/Class_data.dart';
import 'package:attendance_counter/screens/my_class_detailed_screen.dart';
import 'package:attendance_counter/screens/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'screens/Class_Screen.dart';
import 'screens/RegistrationScreen.dart';
import 'package:alarm/alarm.dart';
import 'package:attendance_counter/alarm_for_classes/screens/AlarmHomeScreen.dart';

import 'screens/WelcomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
// Import the generated file
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Alarm.init(showDebugLogs: true);
  runApp(const Attendance());
}

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  late StreamSubscription<User?> user;
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AllClassesData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: FirebaseAuth.instance.currentUser == null
            ? WelcomeScreen.id
            : ClassScreen.id,
        routes: {
          WelcomeScreen.id: (context) => const WelcomeScreen(),
          SignInPage.id: (context) => SignInPage(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          ClassScreen.id: (context) => const ClassScreen(),
          MyClassDetailedScreen.id: (context) => MyClassDetailedScreen(
                objectForDetailedClassScreen: null,
              ),
          homeScreenOfAlarm.id: (context) => const homeScreenOfAlarm(),
          ImagePickerScreen.id: (context) => const ImagePickerScreen(),
        },
        home: const WelcomeScreen(),
      ),
    );
  }
}
