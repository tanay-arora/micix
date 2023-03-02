import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Micix/components/blogFeed.dart';
import 'package:Micix/components/functions.dart';
import 'package:Micix/components/quiz/quizScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class sessionPage extends StatefulWidget {
  sessionPage();
  @override
  _sessionState createState() => _sessionState();
}

class _sessionState extends State<sessionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 12),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("sessions")
                .orderBy('time', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                            elevation: .7,
                            child: Container(
                              padding: EdgeInsets.all(24.0),
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      '${data['category']}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Color.fromARGB(255, 61, 61, 61),
                                        height: 1.5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      'Topic - ${data['topic']}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Color.fromARGB(255, 61, 61, 61),
                                        height: 1.5,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      'Counsellor - ${data['counsellor']}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Color.fromARGB(255, 61, 61, 61),
                                        height: 1.5,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      )),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color.fromARGB(255, 61, 73, 83)),
                                    ),
                                    child: Text("Join"),
                                    onPressed: () async {
                                      var url = data['link'];
                                      print(url);
                                      // if (await canLaunchUrl(Uri.parse(url))) {
                                      await launchUrl(
                                        Uri.parse(url),
                                      );
                                      // } else {
                                      // print("can't");
                                      // }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              else
                return Text("");
            },
          )),
    );
  }
}
