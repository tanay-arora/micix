import 'package:Micix/components/create.dart';
import 'package:Micix/components/sessions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Micix/components/blogFeed.dart';
import 'package:Micix/components/cart.dart';
import 'package:Micix/components/explore.dart';
import 'package:Micix/components/functions.dart';
import 'package:Micix/components/home.dart';
import 'package:Micix/components/profile.dart';

int selectedIndex = 0;

class navigation extends StatefulWidget {
  navigation() : super();
  @override
  navState createState() => navState();
}

selectRoute(int i) {
  if (i == 0) return HomePage();
  if (i == 1) return explorePage();
  if (i == 2) return CreatePage();
  if (i == 3) return sessionPage();
  if (i == 4) return ProfilePage();
}

class navState extends State<navigation> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
          body: selectRoute(selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(9),
                  child: FaIcon(
                    FontAwesomeIcons.house,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(9),
                  child: FaIcon(FontAwesomeIcons.compass),
                ),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(9),
                  child: FaIcon(FontAwesomeIcons.circlePlus),
                ),
                label: 'Create',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(9),
                  child: FaIcon(FontAwesomeIcons.users),
                ),
                label: 'Sessions',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(9),
                  child: FaIcon(FontAwesomeIcons.solidUser),
                ),
                label: 'Cart',
              ),
            ],
            currentIndex: selectedIndex,
            selectedItemColor: Color.fromARGB(255, 219, 159, 47),
            unselectedItemColor: Colors.grey,
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          )),

      if (selectedIndex == 0)
        Positioned(
          top: 38,
          right: 8,
          child: GestureDetector(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color.fromARGB(159, 144, 132, 104),
                shape: BoxShape.circle,
              ),
              child: SizedBox(
                child: FaIcon(
                  FontAwesomeIcons.cartShopping,
                  size: 26,
                  color: Color.fromARGB(255, 250, 250, 250),
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartPage()));
            },
          ),
        ),

      // if (selectedIndex == 0)
      //   Positioned(
      //     top: 36,
      //     right: 8,
      //     child: GestureDetector(
      //       child: Container(
      //         decoration: BoxDecoration(
      //           color: Color.fromARGB(255, 115, 115, 115),
      //           shape: BoxShape.circle,
      //         ),
      //         child: Icon(
      //           Icons.shopping_cart_rounded,
      //           color: Color.fromARGB(255, 255, 255, 255),
      //         ),
      //         padding: EdgeInsets.all(12),
      //       ),
      //       onTap: () {
      //         Navigator.push(
      //             context, MaterialPageRoute(builder: (context) => CartPage()));
      //       },
      //     ),
      //   ),
      // if (selectedIndex == 0)
      //   FutureBuilder(
      //       future: CartBloc().getLength(),
      //       builder: (context, snapshot) {
      //         if (snapshot.hasData && snapshot.data != 0) {
      //           return Positioned(
      //             top: 38,
      //             right: 12,
      //             child: Container(
      //               padding: EdgeInsets.all(2),
      //               decoration: BoxDecoration(
      //                 color: Colors.white,
      //                 shape: BoxShape.circle,
      //               ),
      //               constraints: BoxConstraints(
      //                 minWidth: 16,
      //                 minHeight: 16,
      //               ),
      //               child: Text(
      //                 snapshot.data.toString(),
      //                 style: TextStyle(
      //                   color: Color.fromARGB(255, 73, 73, 73),
      //                   fontSize: 12,
      //                   fontWeight: FontWeight.w600,
      //                 ),
      //                 textAlign: TextAlign.center,
      //               ),
      //             ),
      //           );
      //         } else {
      //           return Text("");
      //         }
      //       }),
    ]);
  }
}
