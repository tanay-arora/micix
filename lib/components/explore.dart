import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Micix/components/blogFeed.dart';
import 'package:Micix/components/functions.dart';
import 'package:Micix/components/quiz/quizScreen.dart';

class explorePage extends StatefulWidget {
  explorePage();
  @override
  _exploreState createState() => _exploreState();
}

class _exploreState extends State<explorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
              padding: EdgeInsets.only(top: 12),
              height: 228.0,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("quotes")
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
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
                                  width: 350.0,
                                  padding: EdgeInsets.all(24.0),
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 2, left: 5),
                                        child: Column(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  'assets/img/avt.webp'),
                                              height: 48,
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              data['author'],
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Center(
                                        child: Text(
                                          '"${data['quote']}"',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color:
                                                Color.fromARGB(255, 61, 61, 61),
                                            height: 1.5,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 12.0),
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
          Container(
            padding: EdgeInsets.only(top: 12, bottom: 12, left: 16),
            child: Text(
              'Exciting Quizzes',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 240,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('quiz').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var document = snapshot.data!.docs[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        QuizzScreen(uid: document.id)));
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.0),
                              ),
                              elevation: .7,
                              child: Container(
                                width: 350.0,
                                padding: EdgeInsets.all(24.0),
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Column(children: [
                                        Image(
                                          image:
                                              AssetImage('assets/img/avt.webp'),
                                          height: 48,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          'Admin',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ]),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(top: 12, bottom: 18),
                                      child: Center(
                                        child: Text(
                                          document['title'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color:
                                                Color.fromARGB(255, 61, 61, 61),
                                            height: 1.5,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 12.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                else
                  return Text('');
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 12, bottom: 12, left: 16),
            child: Text(
              'Insightful Articles',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 7, right: 7, top: 3, bottom: 3),
              child: BlogFeed(),
            ),
          ),
        ],
      ),
    );
  }
}
