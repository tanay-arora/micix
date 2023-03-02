import 'package:flutter/material.dart';
import 'package:Micix/components/selectlogin.dart';

class OnboardingModel {
  final String image;

  OnboardingModel({required this.image});
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;
  final List<OnboardingModel> pages = [
    OnboardingModel(image: 'assets/img/onboard_1.webp'),
    OnboardingModel(image: 'assets/img/onboard_2.webp'),
    OnboardingModel(image: 'assets/img/onboard_3.webp'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        PageView.builder(
          controller: _controller,
          itemCount: pages.length,
          itemBuilder: (context, index) {
            return _buildPage(pages[index]);
          },
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
        ),
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

  Widget _buildPage(OnboardingModel page) {
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12, top: 42, bottom: 0),
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 112,
          ),
          Image(image: AssetImage(page.image), fit: BoxFit.contain),
        ],
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 20, right: 20, top: 22, bottom: 0),
        child: Column(
          children: [
            Container(
                width: double.infinity,
                height: (_currentPage != 0) ? 80 : 50,
                child: (_currentPage == 0)
                    ? ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          )),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(172, 172, 172, 1)),
                        ),
                        child: Text(
                          'Get started for free',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        onPressed: () {
                          (_currentPage != 2)
                              ? _controller.nextPage(
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.linear)
                              : Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginSignupPage()),
                                );
                        },
                      )
                    : Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                            color: Colors.teal,
                            onPressed: () {
                              (_currentPage != 2)
                                  ? _controller.nextPage(
                                      duration: Duration(milliseconds: 400),
                                      curve: Curves.linear)
                                  : Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginSignupPage()),
                                    );
                            },
                            iconSize: 80,
                            icon: Image(
                              image: AssetImage("assets/img/next.webp"),
                            )))),
            SizedBox(
              height: 32,
            ),
          ],
        ));
  }
}
