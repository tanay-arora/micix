import 'package:Micix/components/navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Micix/components/selectlogin.dart';

class OnboardingModel {
  final String image;

  OnboardingModel({required this.image});
}

class AfterLoginScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<AfterLoginScreen> {
  final _controller = PageController();
  int _currentPage = 0;
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(top: 44),
            width: double.infinity,
            color: Colors.white,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('authors')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, ind) {
                          var document = snapshot.data!.docs[ind];
                          return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected = ind;
                                });
                              },
                              child: Container(
                                color: (selected == ind)
                                    ? Color.fromRGBO(218, 218, 218, 1)
                                    : Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 18, right: 18, top: 10, bottom: 10),
                                  child: Row(
                                    children: [
                                      Image(
                                        image: NetworkImage(document['image']),
                                        height: 80,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                          child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              document['title'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  height: 2.1),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(document['description'])
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              ));
                        });
                  } else
                    return Text('');
                })),
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Column(
            children: <Widget>[_buildNextButton(context)],
          ),
        )
      ],
    ));
  }

  Widget _buildNextButton(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 20, right: 20, top: 22, bottom: 0),
        child: Column(
          children: [
            Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    )),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(172, 172, 172, 1)),
                  ),
                  child: Text(
                    'Explore',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => navigation()),
                    );
                  },
                )),
          ],
        ));
  }
}
