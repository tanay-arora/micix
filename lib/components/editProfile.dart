import 'package:Micix/components/profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Micix/components/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Micix/components/navigation.dart';
import 'package:Micix/components/selectlogin.dart';
import 'functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
bool isLoading = false;

class editProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<editProfilePage> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  final _formKey = GlobalKey<FormState>();

  // Create controllers for email and password text fields
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _about = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    // Get data from Firebase
    var user = getUserData();
    var snapshot = await _firestore.collection("users").doc(user['uid']).get();

    // Set the values to the corresponding text controllers
    _nameController.text = user['name'];
    _phoneController.text = snapshot.get("phone");
    _address.text = snapshot.get('address');
    _emailController.text = snapshot.get('email');
    _about.text = snapshot.get('about');
  }

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
            "Profile",
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
                            controller: _nameController,
                            cursorColor: Color.fromRGBO(190, 142, 56, 1),
                            decoration: InputDecoration(
                                labelText: 'Name',
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
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 24,
                          ),
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
                          TextFormField(
                            controller: _phoneController,
                            cursorColor: Color.fromRGBO(190, 142, 56, 1),
                            decoration: InputDecoration(
                                labelText: 'Phone',
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
                              if (value!.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              if (value.length < 10)
                                return 'Please enter a valid phone number';
                              return null;
                            },
                          ),

                          SizedBox(
                            height: 24,
                          ),
                          // Password textfield
                          TextFormField(
                            controller: _address,
                            cursorColor: Color.fromRGBO(190, 142, 56, 1),
                            decoration: InputDecoration(
                                labelText: 'address',
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
                            obscureText: false,
                            validator: (value) {
                              if (value!.runes.length < 1) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          TextFormField(
                            controller: _about,
                            maxLines: 4,
                            cursorColor: Color.fromRGBO(190, 142, 56, 1),
                            decoration: InputDecoration(
                                labelText: 'about',
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
                            obscureText: false,
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
                                        'Save',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                onPressed: () async {
                                  final user =
                                      FirebaseAuth.instance.currentUser;

                                  if (_formKey.currentState!.validate() &&
                                      !isLoading) {
                                    try {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      final fireRef = FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(user!.uid);
                                      await fireRef.set({
                                        "name": _nameController.text,
                                        "address": _address.text,
                                        "phone": _phoneController.text,
                                        "email": _emailController.text,
                                        "about": _about.text,
                                      }, SetOptions(merge: true)).then((value) {
                                        setState(() {
                                          isLoading = false;
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfilePage()));
                                        });
                                      });
                                    } catch (e) {
                                      show_snackbar(context, e.toString());
                                    }
                                  }
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 8, right: 8, top: 80, bottom: 20),
                            child: Row(children: <Widget>[
                              Expanded(
                                  child: Divider(
                                thickness: 1.5,
                                color: Color.fromRGBO(190, 142, 56, 1),
                              )),
                              Padding(
                                padding: EdgeInsets.only(left: 26, right: 26),
                                child: Text("switch accounts"),
                              ),
                              Expanded(
                                  child: Divider(
                                thickness: 1.5,
                                color: Color.fromRGBO(190, 142, 56, 1),
                              )),
                            ]),
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 8, right: 8),
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      )),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                    child: Wrap(
                                      children: [
                                        Text(
                                          "Logout",
                                          style: TextStyle(
                                              fontSize: 16, height: 1.6),
                                        ),
                                      ],
                                    ),
                                    onPressed: () async {
                                      User? user = await FirebaseAuth.instance
                                          .signOut()
                                          .then((value) =>
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginSignupPage())));
                                    },
                                  ),
                                )
                              ]),
                          SizedBox(
                            height: 40,
                          ),
                        ]),
                  ))
            ],
          ),
        ));
  }
}
