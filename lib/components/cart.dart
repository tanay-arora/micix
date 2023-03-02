import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Micix/components/checkout.dart';
import 'package:Micix/components/detail.dart';
import 'package:Micix/components/functions.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Container(
          color: Color.fromARGB(255, 246, 246, 246),
          child: FutureBuilder(
            future: CartBloc().getCartItems(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    padding: EdgeInsets.only(top: 3),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var document = snapshot.data[index];
                      return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, -15),
                                blurRadius: 20,
                                color: Color(0xFFDADADA).withOpacity(0.15),
                              )
                            ],
                          ),
                          padding: EdgeInsets.only(top: 12, bottom: 12),
                          margin: EdgeInsets.only(
                              top: 1, bottom: 1, left: 6, right: 6),
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
                                        fontSize: 19),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "₹" + document['price'].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            height: 1.7,
                                            fontSize: 15,
                                            color: Color.fromRGBO(
                                                190, 142, 56, 1)),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          CartBloc()
                                              .removeFromCart(document['id']);
                                          setState(() {});
                                        },
                                        icon: Icon(Icons.remove_circle_outline),
                                      ),
                                      Text(
                                        document['qty'].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            height: 1.7),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            if (document['qty'] >= 10)
                                              show_snackbar(context,
                                                  "You can't add more than 10 of this item.");
                                            if (document['qty'] < 10) {
                                              CartBloc()
                                                  .addToCart(document['id']);
                                              setState(() {});
                                            }
                                          },
                                          icon: Icon(Icons.add_circle_outline))
                                    ],
                                  )
                                ],
                              ),
                            )
                          ]));
                    });
              } else
                return Text("");
            },
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 30,
          ),
          // height: 174,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -15),
                blurRadius: 20,
                color: Color(0xFFDADADA).withOpacity(0.15),
              )
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: CartBloc().getTotalCost(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "Total:\n",
                              children: [
                                TextSpan(
                                  text: "₹${snapshot.data.toString()}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      height: 1.4,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(190, 142, 56, 1)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 190,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  )),
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          EdgeInsets.only(top: 12, bottom: 12)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromRGBO(190, 142, 56, 1))),
                              child: Text("Checkout"),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CheckoutPage(),
                                    ));
                              },
                            ),
                          ),
                        ],
                      );
                    else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "Total:\n",
                              children: [
                                TextSpan(
                                  text: "₹0",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      height: 1.5),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 190,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  )),
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          EdgeInsets.only(top: 12, bottom: 12)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromRGBO(190, 142, 56, 1))),
                              child: Text("Checkout"),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CheckoutPage()));
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, // change color of back button
        ),
        title: Align(
          child: Container(
            padding: EdgeInsets.only(right: 52),
            child: Column(children: [
              SizedBox(
                height: 3,
              ),
              Text(
                "Your Cart",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: 7,
              ),
              FutureBuilder(
                  future: CartBloc().getLength(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return Text(
                        "${snapshot.data} items",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 108, 108, 108),
                            fontSize: 13),
                      );
                    else
                      return Text(
                        "'0 items",
                        style: Theme.of(context).textTheme.caption,
                      );
                  })
            ]),
          ),
        ));
  }
}
