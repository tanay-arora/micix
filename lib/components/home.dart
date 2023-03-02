import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Micix/components/detail.dart';
import 'package:Micix/components/functions.dart';

String selectedGenre = 'all genre';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Padding(
        padding: EdgeInsets.only(left: 7, right: 7, top: 12),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            child: Image.asset("assets/img/banner.jpg")),
      ),
      Padding(
        padding: EdgeInsets.only(top: 29, left: 16, bottom: 2),
        child: Title(
            color: Colors.black,
            child: Text(
              "Top 10 picks in start",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            )),
      ),
      Container(
        height: 300,
        margin: EdgeInsets.only(left: 8, right: 8),
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('top_books').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return ListView.builder(
                padding: EdgeInsets.only(top: 12),
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  return GestureDetector(
                      onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  id: document.id,
                                ),
                              ),
                            )
                          },
                      child: Container(
                          margin: EdgeInsets.all(8),
                          width: 180,
                          height: 220,
                          child: Column(children: [
                            ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0)),
                                child: Image.network(
                                  document['image'],
                                  height: 180,
                                  width: 180,
                                )),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 3),
                              title: Text(
                                document['title'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              subtitle: Text(
                                document['author'],
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, height: 1.7),
                              ),
                            )
                          ])));
                },
              );
            }),
      ),
      Container(
        height: 38,
        margin: EdgeInsets.only(left: 16, right: 16),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("stock").snapshots(),
            builder: ((context, snapshot) {
              Set<String> uniqueValues = Set<String>();

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  if (index == 0) {
                    return Padding(
                      padding: EdgeInsets.only(left: 4, right: 8),
                      child: TextButton(
                          child: Text(
                            "all genre",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                decoration: (selectedGenre == 'all genre')
                                    ? TextDecoration.underline
                                    : null,
                                color: (selectedGenre == "all genre")
                                    ? Color.fromRGBO(190, 142, 56, 1)
                                    : Colors.black),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedGenre = 'all genre';
                            });
                          }),
                    );
                  }
                  if (!uniqueValues.contains(document['genre'])) {
                    uniqueValues.add(document['genre']);
                    return Padding(
                      padding: EdgeInsets.only(left: 4, right: 8),
                      child: TextButton(
                          child: Text(
                            document['genre'],
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                decoration: (selectedGenre == document['genre'])
                                    ? TextDecoration.underline
                                    : null,
                                color: (selectedGenre == document['genre'])
                                    ? Color.fromRGBO(190, 142, 56, 1)
                                    : Colors.black),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedGenre = document['genre'];
                            });
                          }),
                    );
                  } else
                    return Padding(padding: EdgeInsets.all(0));
                },
              );
            })),
      ),
      Container(
        height: 290,
        margin: EdgeInsets.only(left: 8, right: 8),
        child: StreamBuilder(
            stream: (selectedGenre == 'all genre')
                ? FirebaseFirestore.instance.collection('stock').snapshots()
                : FirebaseFirestore.instance
                    .collection('stock')
                    .where('genre', isEqualTo: selectedGenre)
                    .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return ListView.builder(
                padding: EdgeInsets.only(top: 12),
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  return GestureDetector(
                      onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  id: document.id,
                                ),
                              ),
                            )
                          },
                      child: Container(
                          margin: EdgeInsets.all(8),
                          width: 180,
                          height: 250,
                          child: Column(children: [
                            ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0)),
                                child: Image.network(
                                  document['image'],
                                  height: 180,
                                  width: 180,
                                )),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 3),
                              title: Text(
                                document['title'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              subtitle: Text(
                                document['author'],
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, height: 1.7),
                              ),
                            )
                          ])));
                },
              );
            }),
      ),
      Padding(
        padding: EdgeInsets.only(top: 20, left: 12, bottom: 12),
        child: Title(
            color: Colors.black,
            child: Text(
              "Gift for book lovers",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            )),
      ),
      Container(
        margin: EdgeInsets.only(left: 8, right: 8),
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('gift_books').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: 12),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  return GestureDetector(
                      onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  id: document.id,
                                ),
                              ),
                            )
                          },
                      child: Container(
                          margin: EdgeInsets.only(top: 8, bottom: 8),
                          height: 100,
                          width: double.infinity,
                          child: Row(children: [
                            ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0)),
                                child: Image.network(
                                  document['image'],
                                  height: 100,
                                  width: 100,
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 14),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    document['title'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    document['author'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        height: 1.7),
                                  ),
                                ],
                              ),
                            )
                          ])));
                },
              );
            }),
      ),
    ]);
  }
}
