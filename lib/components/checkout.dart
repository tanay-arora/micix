import 'package:flutter/material.dart';
import 'package:Micix/components/detail.dart';
import 'package:Micix/components/functions.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  bool show = false;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        bottomNavigationBar: buildBottomBar(
            context, _CheckoutPageState(), _formKey, {
          "name": _name,
          "email": _email,
          "phone": _phoneNumber,
          "address": _address
        }),
        body: Container(
            color: Color.fromARGB(255, 246, 246, 246),
            child: ListView(children: [
              Container(
                margin: EdgeInsets.only(top: 4),
                color: Colors.white,
                padding:
                    EdgeInsets.only(left: 18, right: 18, top: 18, bottom: 18),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        "Shipping Address",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      TextFormField(
                        controller: _name,
                        cursorColor: Color.fromRGBO(190, 142, 56, 1),
                        decoration: InputDecoration(
                            labelText: 'Name',
                            floatingLabelStyle: TextStyle(
                                color: Color.fromRGBO(190, 142, 56, 1)),
                            contentPadding: EdgeInsets.only(left: 2, right: 2),
                            focusColor: Color.fromRGBO(190, 142, 56, 1),
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(190, 142, 56, 1)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromRGBO(190, 142, 56, 1)))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      TextFormField(
                        controller: _email,
                        cursorColor: Color.fromRGBO(190, 142, 56, 1),
                        decoration: InputDecoration(
                            labelText: 'email',
                            floatingLabelStyle: TextStyle(
                                color: Color.fromRGBO(190, 142, 56, 1)),
                            contentPadding: EdgeInsets.only(left: 2, right: 2),
                            focusColor: Color.fromRGBO(190, 142, 56, 1),
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(190, 142, 56, 1)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromRGBO(190, 142, 56, 1)))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      TextFormField(
                          controller: _phoneNumber,
                          cursorColor: Color.fromRGBO(190, 142, 56, 1),
                          decoration: InputDecoration(
                              labelText: 'Phone number',
                              floatingLabelStyle: TextStyle(
                                  color: Color.fromRGBO(190, 142, 56, 1)),
                              contentPadding:
                                  EdgeInsets.only(left: 2, right: 2),
                              focusColor: Color.fromRGBO(190, 142, 56, 1),
                              labelStyle: TextStyle(
                                  color: Color.fromRGBO(190, 142, 56, 1)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3,
                                      color: Color.fromRGBO(190, 142, 56, 1)))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 7,
                      ),
                      TextFormField(
                        controller: _address,
                        cursorColor: Color.fromRGBO(190, 142, 56, 1),
                        decoration: InputDecoration(
                            labelText: 'Address',
                            floatingLabelStyle: TextStyle(
                                color: Color.fromRGBO(190, 142, 56, 1)),
                            contentPadding: EdgeInsets.only(left: 2, right: 2),
                            focusColor: Color.fromRGBO(190, 142, 56, 1),
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(190, 142, 56, 1)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromRGBO(190, 142, 56, 1)))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                future: CartBloc().getCartItems(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        padding: EdgeInsets.only(top: 3, bottom: 120),
                        child: ListView.builder(
                            padding: EdgeInsets.only(top: 3),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var document = snapshot.data[index];
                              if (snapshot.hasData) {
                                return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, -15),
                                          blurRadius: 20,
                                          color: Color(0xFFDADADA)
                                              .withOpacity(0.15),
                                        )
                                      ],
                                    ),
                                    padding:
                                        EdgeInsets.only(top: 12, bottom: 12),
                                    margin: EdgeInsets.only(
                                        top: 1, bottom: 1, left: 6, right: 6),
                                    height: 100,
                                    width: double.infinity,
                                    child: Row(children: [
                                      ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(14.0)),
                                          child: Image.network(
                                            document['image'],
                                            height: 100,
                                            width: 100,
                                          )),
                                      Padding(
                                        padding: EdgeInsets.only(left: 14),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                  "₹" +
                                                      document['price']
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 1.7,
                                                      fontSize: 15,
                                                      color: Color.fromRGBO(
                                                          190, 142, 56, 1)),
                                                ),
                                                SizedBox(
                                                  width: 13,
                                                ),
                                                Text(
                                                  "x" +
                                                      document['qty']
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.7),
                                                ),
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                IconButton(
                                                  color: Color.fromRGBO(
                                                      220, 166, 66, 1),
                                                  onPressed: () {
                                                    CartBloc().removeFromCart(
                                                        document['id'],
                                                        fl: true);
                                                    setState(() {});
                                                  },
                                                  icon: Icon(Icons.delete),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ]));
                              } else
                                return Text("");
                            }));
                  } else
                    return Text("");
                },
              ),
            ])));
  }
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
            padding: EdgeInsets.only(right: 58),
            child: Column(
              children: [
                SizedBox(
                  height: 3,
                ),
                Text(
                  "Checkout",
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
              ],
            )),
      ));
}

buildBottomBar(BuildContext context, State state, _formKey, formValues) {
  bool process = false;
  return Container(
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
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            )),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.only(top: 12, bottom: 12)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(190, 142, 56, 1))),
                        child: process
                            ? Container(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : Text("Place Order"),
                        onPressed: () {
                          if (1 == 1) {
                            _formKey.currentState.save();
                            process = true;

                            createOrder(_formKey, formValues, context);
                            process = false;
                          }
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
                                fontSize: 16, color: Colors.black, height: 1.5),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 190,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            )),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.only(top: 12, bottom: 12)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(190, 142, 56, 1))),
                        child: Text("Place Order"),
                        onPressed: () {},
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
  );
}
