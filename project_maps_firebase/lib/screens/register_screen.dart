import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_maps_firebase/utils/color_utils.dart';
import 'package:project_maps_firebase/screens/home_screen.dart';
import 'package:project_maps_firebase/screens/login_screen.dart';
import '../reusable_widget/reusable_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "REGISTER",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            hexStringToColor("B6F492"),
            hexStringToColor("338B93"),
          ], begin: Alignment.topRight, end: Alignment.bottomLeft),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 160),
                reusableTextField("Enter Your Username", Icons.person_outline, false,
                    _userNameController),
                SizedBox(height: 20),
                reusableTextField("Enter Your Email", Icons.person_outline, false,
                    _emailController),
                SizedBox(height: 20),
                reusableTextField("Enter Your Password", Icons.lock_outline, true,
                    _passwordController),
                SizedBox(height: 20),
                firebaseUIButton(context, "REGISTER", () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text)
                      .then((value) {
                    print("Created New Account");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
