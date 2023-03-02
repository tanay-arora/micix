import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final blog;

  const BlogCard({key, required this.blog}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13.0),
        ),
        child: Container(
          width: 350,
          padding: EdgeInsets.only(top: 16, bottom: 16, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2, left: 5),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('assets/img/avt.webp'),
                      height: 48,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      blog['title'],
                      style: TextStyle(
                        fontSize: height * 0.024,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Text(
                blog['description'],
                style: TextStyle(
                  fontSize: height * 0.020,
                  height: 1.37,
                  color: Color.fromARGB(255, 30, 43, 53),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
