import 'package:flutter/material.dart';
import 'package:micix/components/selectlogin.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String description;

  OnboardingModel(
      {required this.image, required this.title, required this.description});
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;
  final List<OnboardingModel> pages = [
    OnboardingModel(
        image: 'assets/img/onboard_1.webp',
        title: 'Enjoy reading with exclusive range of our books.',
        description: 'Select book of your choice and get to your doorstep.'),
    OnboardingModel(
        image: 'assets/img/onboard_2.webp',
        title: "Let's buy a book according to your mood",
        description: 'Choose your intrest and we\'ll pickup books for you.'),
    OnboardingModel(
        image: 'assets/img/onboard_3.webp',
        title: 'Explore our Collections or connect with peoples',
        description: 'share your views, read write and explore.'),
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
            children: <Widget>[
              _buildPagination(pages.length),
              _buildNextButton(context)
            ],
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
          Image(image: AssetImage(page.image), fit: BoxFit.contain),
          Padding(
              padding: EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 7),
              child: Text(
                page.title,
                style: TextStyle(
                    color: Color.fromRGBO(63, 60, 85, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 7),
              child: Text(
                page.description,
                style: TextStyle(
                    color: Color.fromRGBO(63, 60, 85, 1), fontSize: 18),
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }

  Widget _buildPagination(int length) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        return Container(
          margin: EdgeInsets.all(5),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index != _currentPage
                  ? Colors.grey.withOpacity(0.4)
                  : Color.fromARGB(241, 220, 131, 15)),
        );
      }),
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
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    )),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(190, 142, 56, 1)),
                  ),
                  child: Text(
                    (_currentPage != 2) ? 'Next' : 'Get started',
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
                )),
            SizedBox(
              height: 16,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0, backgroundColor: Colors.white),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                        color: Color.fromRGBO(190, 142, 56, 1), fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginSignupPage()),
                    );
                  },
                ))
          ],
        ));
  }
}
