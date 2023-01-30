import 'package:flutter/material.dart';
import 'package:micix/components/functions.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(onPressed: () => {signOut()}, child: Text("logoout")),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: Text("Featured"),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(16),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            width: 200,
                            height: double.infinity,
                            color: Colors.grey[300],
                            child: Center(child: Text("Item 1")),
                            margin: EdgeInsets.all(8),
                          ),
                          Container(
                            width: 200,
                            height: double.infinity,
                            color: Colors.grey[300],
                            child: Center(child: Text("Item 2")),
                            margin: EdgeInsets.all(8),
                          ),
                          Container(
                            width: 200,
                            height: double.infinity,
                            color: Colors.grey[300],
                            child: Center(child: Text("Item 3")),
                            margin: EdgeInsets.all(8),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: ListView(
                children: [
                  Container(
                    height: 200,
                    color: Colors.grey[400],
                    child: Center(child: Text("Article 1")),
                    margin: EdgeInsets.all(8),
                  ),
                  Container(
                    height: 200,
                    color: Colors.grey[400],
                    child: Center(child: Text("Article 2")),
                    margin: EdgeInsets.all(8),
                  ),
                  Container(
                    height: 200,
                    color: Colors.grey[400],
                    child: Center(child: Text("Article 3")),
                    margin: EdgeInsets.all(8),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[500],
              child: Center(
                child: Text("Profile"),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[600],
              child: Center(
                child: Text("Quizzes"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
