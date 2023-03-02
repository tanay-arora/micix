import 'package:flutter/material.dart';
import 'package:Micix/components/login.dart';
import 'package:Micix/components/signup.dart';

class LoginSignupPage extends StatefulWidget {
  @override
  _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            alignment: Alignment.bottomCenter,
            child: Image.asset("assets/img/login_bg.webp"),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 52, bottom: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image(
                  image: AssetImage("assets/img/logo.webp"),
                  fit: BoxFit.contain,
                  height: 220,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Hi, what do you want\nto do?",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      height: 1.35,
                      color: Color.fromARGB(255, 42, 41, 57)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        )),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(190, 142, 56, 1)),
                      ),
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                    )),
                SizedBox(
                  height: 26,
                ),
                Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        )),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(190, 142, 56, 1)),
                      ),
                      child: Text(
                        'Create account',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SingUpPage()),
                        );
                      },
                    )),
                SizedBox(
                  height: 28,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
