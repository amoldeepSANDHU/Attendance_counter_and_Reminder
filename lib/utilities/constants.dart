import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Constants {
  //colors
  static const kPrimaryColor = Color(0xFFFFFFFF);
  static const kGreyColor = Color(0xFFEEEEEE);
  static const kBlackColor = Color(0xFF000000);
  static const kDarkGreyColor = Color(0xFF9E9E9E);
  static const kDarkBlueColor = Color(0xFF6057FF);
  static const kBorderColor = Color(0xFFEFEFEF);

  //text
  static const title = "Google Sign In";
  static const textIntro = "Growing your \n business is ";
  static const textIntroDesc1 = "easier \n ";
  static const textIntroDesc2 = "then you think!";
  static const textSmallSignUp = "Sign up takes only 2 minutes!";
  static const textSignIn = "Sign In";
  static const register = "Register";
  static const textStart = "Get Started";
  static const textSignInTitle = "Welcome back!";
  static const textSignUpTitle = "Welcome Book Worm!";

  static const textSmallSignIn = "You've been missed";
  static const textSmallSignUp1 = "Register First :)";
  static const textSignInGoogle = "Sign In With Google";
  static const textSignUpGoogle = "Sign Up With Google";
  static const textAcc = "Don't have an account? ";
  static const textAcc1 = "Already have an account? ";

  static const textSignUp = "Sign Up here";
  static const textSignInhere = "Sign IN here";
  static const textHome = "Home";

  //navigate
  static const signInNavigate = '/sign-in';
  static const homeNavigate = '/home';

  static const statusBarColor = SystemUiOverlayStyle(
      statusBarColor: Constants.kPrimaryColor,
      statusBarIconBrightness: Brightness.dark);
}

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
const kBottomBarHeight = 80.0;
const kBottomContainerColor = Color(0xFF363A3D);

const kInactiveBoxColors = Color(0xFF1D1F33);
const kActiveBoxColors = Color(0xFF575861);

const kTextStyles = TextStyle(
  color: Color(0xFF8D8D98),
  fontSize: 18,
);

const kTextColor = TextStyle(
  color: Color(0xFF8D8D98),
);

const kNumberStyles = TextStyle(
  fontWeight: FontWeight.w800,
  fontSize: 50,
  color: Colors.red,
);

const kActiveTrackColor = Color(0xFFE4706F);
const kInactiveTrackColor = Color(0xFF8D602A);
const kThumbColor = Color(0xFFEBAB25);
const kOverlayColor = Color(0x29EBAB25);
const kThumbShape = RoundSliderThumbShape(
  enabledThumbRadius: 12,
);
const kOverlayShape = RoundSliderOverlayShape(overlayRadius: 25);
const kValueIndicatorShape = PaddleSliderValueIndicatorShape();
const kValueIndicatorColor = Color(0xFFEBAB25);

const kOutputText = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 30,
  color: Color(0xFF8E919E),
);

const kResultText = TextStyle(
  fontWeight: FontWeight.w600,
  fontStyle: FontStyle.normal,
  fontSize: 30,
  letterSpacing: 3,
  color: Color(0xFFF4C18B),
);
List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "Monday", child: Text("Monday")),
    const DropdownMenuItem(value: "Tuesday", child: Text("Tuesday")),
    const DropdownMenuItem(value: "Wednesday", child: Text("Wednesday")),
    const DropdownMenuItem(value: "Thursday", child: Text("Thursday")),
    const DropdownMenuItem(value: "Friday", child: Text("Friday")),
    const DropdownMenuItem(value: "Saturday", child: Text("Saturday")),
    const DropdownMenuItem(value: "Sunday", child: Text("Sunday")),
  ];
  return menuItems;
}
