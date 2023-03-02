import 'package:flutter/material.dart';
import 'package:Micix/components/navigation.dart';
import 'package:Micix/components/selectlogin.dart';

class orderDone extends StatefulWidget {
  @override
  _orderDone createState() => _orderDone();
}

class _orderDone extends State<orderDone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 24, right: 24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/order_done.webp',
                width: double.infinity,
              ),
              SizedBox(height: 32),
              Text(
                'Order Placed Successfully!',
                style: TextStyle(
                  color: Color.fromRGBO(209, 148, 16, 1),
                  fontSize: 24,
                  height: 1.3,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Thank you for your order. We will notify you when your order has shipped.',
                style: TextStyle(
                  color: Color.fromARGB(255, 71, 71, 71),
                  fontSize: 16,
                  height: 1.3,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 52),
              Container(
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      )),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.only(top: 12, bottom: 12)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(223, 157, 15, 1))),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => navigation()));
                  },
                  child: Container(
                    padding:
                        EdgeInsets.only(top: 7, bottom: 7, left: 26, right: 26),
                    child: Text("Back to Home",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
