import 'package:Micix/components/editProfile.dart';
import 'package:flutter/material.dart';
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

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form

  @override
  Widget build(BuildContext context) {
    var user = getUserData();
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(children: [
                  Image(
                    image: AssetImage('assets/img/avt.webp'),
                    height: 124,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    user['name'],
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 21, 33, 46),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(user['uid'])
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var document = snapshot.data!.data();
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 6, bottom: 12),
                          child: Column(children: [
                            Text(
                              (document != null &&
                                      document.containsKey('email'))
                                  ? document['email']
                                  : user['email'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Color.fromARGB(255, 45, 59, 74),
                              ),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Text(
                              (document != null &&
                                      document.containsKey('about'))
                                  ? document['about']
                                  : "no bio",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.normal,
                                  color: Color.fromARGB(255, 21, 33, 46),
                                  height: 1.5),
                            ),
                          ]),
                        );
                      } else {
                        return CircularProgressIndicator(); // or any other loading indicator
                      }
                    },
                  ),
                ]),
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                padding: EdgeInsets.only(left: 8, right: 8),
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Wrap(
                    children: [
                      Text(
                        "Edit profile",
                        style: TextStyle(
                            fontSize: 16, height: 1.6, color: Colors.black),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => editProfilePage()));
                  },
                ),
              ),
              SizedBox(
                height: 54,
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 8, right: 8, top: 80, bottom: 20),
                child: Row(children: <Widget>[
                  Expanded(
                      child: Divider(
                    thickness: 1.5,
                    color: Colors.grey,
                  )),
                  Padding(
                    padding: EdgeInsets.only(left: 26, right: 26),
                    child: Text("switch accounts"),
                  ),
                  Expanded(
                      child: Divider(
                    thickness: 1.5,
                    color: Colors.grey,
                  )),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  padding: EdgeInsets.only(left: 8, right: 8),
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
                        Text(
                          "Logout",
                          style: TextStyle(fontSize: 16, height: 1.6),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      User? user = await FirebaseAuth.instance.signOut().then(
                          (value) => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginSignupPage())));
                    },
                  ),
                ),
              ])
            ],
          ),
        ));
  }
}
