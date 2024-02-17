import 'dart:io';

import 'package:attendance_counter/screens/WelcomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class NavBar extends StatefulWidget {
  //final User user;
  //const NavBar();
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  File? galleryFile;
  final picker = ImagePicker();
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, WelcomeScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Oflutter.com'),
            accountEmail: Text('example@gmail.com'),
            currentAccountPicture: TextButton(
              onPressed: () {
                _showPicker(context: context);
              },
              child: CircleAvatar(
                radius: 20,
                child: galleryFile == null
                    ? ClipOval(
                        child: Image.asset(
                          'images/InitiaLImage.jpg',
                          fit: BoxFit.cover,
                          // width: 120,
                          // height: 120,
                        ),
                      )
                    : ClipOval(
                        child: Image.file(
                          galleryFile!,
                          fit: BoxFit.cover,
                          width: 90,
                          height: 90,
                        ),
                      ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.favorite),
          //   title: Text('Favorites'),
          //   onTap: () => null,
          // ),
          ListTile(
            leading: Icon(Icons.feedback_outlined),
            title: Text('Feedback'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share with friends'),
            onTap: () => null,
          ),
          // ListTile(
          //   leading: Icon(Icons.notifications),
          //   title: Text('Request'),
          //   onTap: () => null,
          //   trailing: ClipOval(
          //     child: Container(
          //       color: Colors.red,
          //       width: 20,
          //       height: 20,
          //       child: Center(
          //         child: Text(
          //           '8',
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 12,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          //Divider(),
          ListTile(
            leading: Icon(Icons.delete_forever),
            title: Text('Delete Account'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Description'),
            onTap: () => null,
          ),
          //Divider(),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => logout(),
          ),
        ],
      ),
    );
  }

  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
}
