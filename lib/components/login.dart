import 'package:Micix/components/after-login.dart';
import 'package:flutter/material.dart';
import 'package:Micix/components/home.dart';
import 'package:Micix/components/navigation.dart';
import 'package:Micix/components/onboarding.dart';
import 'package:Micix/components/selectlogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'functions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
bool isLoading = false;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  final _formKey = GlobalKey<FormState>();

  // Create controllers for email and password text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 92,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            color: Color.fromARGB(255, 42, 41, 57),
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            "Sign in",
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 42, 41, 57)),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 56, bottom: 0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Email textfield

                          TextFormField(
                            controller: _emailController,
                            cursorColor: Color.fromRGBO(190, 142, 56, 1),
                            decoration: InputDecoration(
                                labelText: 'Email',
                                floatingLabelStyle: TextStyle(
                                    color: Color.fromRGBO(190, 142, 56, 1)),
                                contentPadding:
                                    EdgeInsets.only(left: 2, right: 2),
                                focusColor: Color.fromRGBO(190, 142, 56, 1),
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(190, 142, 56, 1)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3,
                                        color:
                                            Color.fromRGBO(190, 142, 56, 1)))),
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          // Password textfield
                          TextFormField(
                            controller: _passwordController,
                            cursorColor: Color.fromRGBO(190, 142, 56, 1),
                            decoration: InputDecoration(
                                labelText: 'Password',
                                floatingLabelStyle: TextStyle(
                                    color: Color.fromRGBO(190, 142, 56, 1)),
                                contentPadding:
                                    EdgeInsets.only(left: 2, right: 2),
                                focusColor: Color.fromRGBO(190, 142, 56, 1),
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(190, 142, 56, 1)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3,
                                        color:
                                            Color.fromRGBO(190, 142, 56, 1)))),
                            obscureText: true,
                            validator: (value) {
                              if (value!.runes.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 44,
                          ),

                          // Login button
                          Container(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  )),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromRGBO(190, 142, 56, 1)),
                                ),
                                child: isLoading
                                    ? Container(
                                        width: 24,
                                        height: 24,
                                        padding: const EdgeInsets.all(2.0),
                                        child: const CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : Text(
                                        'Sign in',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate() &&
                                      !isLoading) {
                                    try {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      _auth.setLanguageCode("en");

                                      UserCredential result = await _auth
                                          .signInWithEmailAndPassword(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text);
                                      // Get the user from the result
                                      User? user = result.user;
                                      // Check if the user is not null
                                      if (user != null) {
                                        // Navigate to the home page
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AfterLoginScreen()));
                                      } else {
                                        // Show an error message
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Error signing in, please try again')));
                                      }
                                    } catch (e) {
                                      print(e);
                                      setState(() {
                                        isLoading = false;
                                      });
                                      if (e
                                          .toString()
                                          .contains('network-request-failed')) {
                                        show_snackbar(context,
                                            'A network error occurred. Please check your internet connection and try again.');
                                      } else if (e
                                          .toString()
                                          .contains('invalid-email')) {
                                        show_snackbar(context,
                                            'The email address is badly formatted.');
                                      } else if (e
                                          .toString()
                                          .contains('wrong-password')) {
                                        show_snackbar(context,
                                            'The password is invalid.');
                                      } else if (e
                                          .toString()
                                          .contains('user-not-found'))
                                        show_snackbar(context,
                                            'There is no user record corresponding to this identifier.');
                                      else
                                        show_snackbar(context,
                                            'An unknown error occurred');
                                    }
                                  }
                                }),
                          ),
                        ]),
                  )),
              Padding(
                padding:
                    EdgeInsets.only(left: 32, right: 32, top: 140, bottom: 20),
                child: Row(children: <Widget>[
                  Expanded(
                      child: Divider(
                    thickness: 1.5,
                    color: Color.fromRGBO(190, 142, 56, 1),
                  )),
                  Padding(
                    padding: EdgeInsets.only(left: 26, right: 26),
                    child: Text("or sign with"),
                  ),
                  Expanded(
                      child: Divider(
                    thickness: 1.5,
                    color: Color.fromRGBO(190, 142, 56, 1),
                  )),
                ]),
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 0, 0, 0)),
                    ),
                    child: Wrap(
                      children: [
                        Image(
                          image: AssetImage('assets/img/google.webp'),
                          fit: BoxFit.contain,
                          height: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Sign in with google",
                          style: TextStyle(fontSize: 16, height: 1.6),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      User? user = await Authentication.signInWithGoogle(
                              context: context)
                          .then((value) => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AfterLoginScreen())));
                    },
                  ),
                )
              ]),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ));
  }
}
