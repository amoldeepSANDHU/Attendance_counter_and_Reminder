import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'Class_Screen.dart';
import 'RegistrationScreen.dart';

import '../widgets/SelectableButtonWidget.dart';
import '../utilities/firebase_service.dart';
import '../utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInPage extends StatefulWidget {
  static const String id = 'Sign_in_page';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late String email;

  late String password;
  bool selected = false;

  bool textBlinder = true;
  bool showSpinner = false;

  bool toggleFun() {
    return !textBlinder;
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

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    Size size = MediaQuery.of(context).size;
    OutlineInputBorder border = const OutlineInputBorder(
        borderSide: BorderSide(color: Constants.kBorderColor, width: 3.0));
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Constants.kPrimaryColor,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: Constants.textSignInTitle,
                          style: TextStyle(
                            color: Constants.kBlackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          )),
                    ])),
                SizedBox(height: size.height * 0.01),
                const Text(
                  Constants.textSmallSignIn,
                  style: TextStyle(color: Constants.kDarkGreyColor),
                ),
                GoogleSignIn(),
                buildRowDivider(size: size),
                Padding(padding: EdgeInsets.only(bottom: size.height * 0.02)),
                SizedBox(
                  width: size.width * 0.8,
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'Enter your Email',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        enabledBorder: border,
                        focusedBorder: border),
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: TextField(
                    onChanged: (value) {
                      password = value;
                    },
                    textAlign: TextAlign.center,
                    obscureText: textBlinder,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      enabledBorder: border,
                      focusedBorder: border,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(top: 15, left: 15),
                        child: SelectableButton(
                          selected: selected,
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Colors.blue;
                                }
                                return null; // defer to the defaults
                              },
                            ),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Colors.white;
                                }
                                return null; // defer to the defaults
                              },
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              selected = !selected;
                              textBlinder = toggleFun();
                            });
                          },
                          child: const FaIcon(
                            FontAwesomeIcons.eye,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: size.height * 0.025)),
                SizedBox(
                  width: size.width * 0.8,
                  child: OutlinedButton(
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (user != null) {
                          Navigator.pushNamed(context, ClassScreen.id);
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        if (e is FirebaseAuthException) {
                          showMessage(e.message!);
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      }
                    },
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Constants.kPrimaryColor),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Constants.kBlackColor),
                        side: MaterialStateProperty.all<BorderSide>(
                            BorderSide.none)),
                    child: const Text(Constants.textSignIn),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: Constants.textAcc,
                              style: TextStyle(
                                color: Constants.kDarkGreyColor,
                              )),
                        ])),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(children: <TextSpan>[
                              TextSpan(
                                  // mouseCursor: ListTileCursor(),
                                  text: Constants.textSignUp,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Constants.kDarkBlueColor,
                                  )),
                            ])),
                      ),
                    ),
                  ],
                ),
              ])),
        ));
  }

  Widget buildRowDivider({required Size size}) {
    return SizedBox(
      width: size.width * 0.8,
      child: const Row(children: <Widget>[
        Expanded(child: Divider(color: Constants.kDarkGreyColor)),
        Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              "Or",
              style: TextStyle(color: Constants.kDarkGreyColor),
            )),
        Expanded(child: Divider(color: Constants.kDarkGreyColor)),
      ]),
    );
  }
}

class GoogleSignIn extends StatefulWidget {
  GoogleSignIn({Key? key}) : super(key: key);

  @override
  _GoogleSignInState createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignIn> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return !isLoading
        ? SizedBox(
            width: size.width * 0.8,
            child: OutlinedButton.icon(
              icon: const FaIcon(FontAwesomeIcons.google),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                FirebaseService service = FirebaseService();
                try {
                  await service.signInwithGoogle();
                } catch (e) {
                  if (e is FirebaseAuthException) {
                    showMessage(e.message!);
                  }
                }
                Navigator.pushNamed(context, ClassScreen.id);
                setState(() {
                  isLoading = false;
                });
              },
              label: const Text(
                Constants.textSignInGoogle,
                style: TextStyle(
                    color: Constants.kBlackColor, fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Constants.kGreyColor),
                  side: MaterialStateProperty.all<BorderSide>(BorderSide.none)),
            ),
          )
        : const CircularProgressIndicator();
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
}
