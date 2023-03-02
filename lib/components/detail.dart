import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'functions.dart';

class DetailPage extends StatefulWidget {
  final String id;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DetailPage({required this.id}) : super();

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Color fcolor = Colors.black;

  void _updatePaletteGenerator(url) async {
    var paletteGenerator = await PaletteGenerator.fromImageProvider(
      Image.network(url).image,
    );
    setState(() {
      var ct = paletteGenerator.dominantColor!.color;
      fcolor = Color.fromRGBO(ct.red, ct.green, ct.blue, 0.72);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fcolor,
        elevation: 0,
      ),
      bottomNavigationBar: Container(
          child: Padding(
        padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
        child: FutureBuilder<int>(
          future: CartBloc().getQty(widget.id),
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            if (snapshot.hasData && snapshot.data != 0) {
              return Row(
                children: [
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        CartBloc().removeFromCart(widget.id);
                      },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.only(top: 12, bottom: 12)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(190, 142, 56, 1))),
                      child: Text("-"),
                    ),
                  ),
                  Expanded(
                      child: Text(
                    snapshot.data.toString(),
                    textAlign: TextAlign.center,
                  )),
                  Container(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.only(top: 12, bottom: 12)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              (snapshot.data! < 10)
                                  ? Color.fromRGBO(190, 142, 56, 1)
                                  : Colors.grey)),
                      onPressed: () {
                        if (snapshot.data! < 10)
                          CartBloc().addToCart(widget.id);
                        else
                          show_snackbar(context,
                              "You can't add more than 10 of this item.");
                      },
                      child: Text("+"),
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              );
            } else {
              return ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.only(top: 12, bottom: 12)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    )),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(190, 142, 56, 1))),
                child: Text(
                  "Add to cart",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () => {CartBloc().addToCart(widget.id)},
              );
            }
          },
        ),
      )),
      body: FutureBuilder(
        future: widget.firestore.collection("stock").doc(widget.id).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var data = snapshot.data?.data();
          if (data != null) _updatePaletteGenerator(data['image']);
          return Container(
            color: Colors.white,
            child: ListView(
              children: [
                if (data != null)
                  Container(
                      color: fcolor,
                      padding: EdgeInsets.only(top: 36, bottom: 28),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(14.0)),
                        child: Image.network(
                          data['image'],
                          height: 380,
                        ),
                      )),
                if (data != null)
                  Container(
                    padding: EdgeInsets.only(left: 12, right: 12, top: 8),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 3),
                      title: Text(
                        data['title'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24),
                      ),
                      subtitle: Text(
                        data['author'],
                        style:
                            TextStyle(fontWeight: FontWeight.w400, height: 1.7),
                      ),
                    ),
                  ),
                if (data != null)
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          margin: EdgeInsets.all(1),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(children: [
                              Text(
                                data['genre'],
                                style: TextStyle(
                                  color: Color.fromRGBO(190, 142, 56, 1),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Genre",
                                style: TextStyle(height: 1.7),
                              ),
                            ]),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          margin: EdgeInsets.all(1),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(children: [
                              Text(
                                data['language'],
                                style: TextStyle(
                                  color: Color.fromRGBO(190, 142, 56, 1),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Lang",
                                style: TextStyle(height: 1.7),
                              ),
                            ]),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          margin: EdgeInsets.all(1),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(children: [
                              Text(
                                data['pages'].toString(),
                                style: TextStyle(
                                  color: Color.fromRGBO(190, 142, 56, 1),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Pages",
                                style: TextStyle(height: 1.7),
                              ),
                            ]),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          margin: EdgeInsets.all(1),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(children: [
                              Text(
                                data['year'].toString(),
                                style: TextStyle(
                                  color: Color.fromRGBO(190, 142, 56, 1),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Year",
                                style: TextStyle(height: 1.7),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (data != null)
                  Padding(
                    padding: EdgeInsets.only(
                        left: 12, right: 12, top: 16, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Description",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text('₹' + data['price'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                  color: Color.fromRGBO(190, 142, 56, 1),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (data != null)
                  Container(
                    width: double.infinity,
                    child: Card(
                      margin: EdgeInsets.all(0),
                      child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Text(
                                data['description'],
                                style: TextStyle(
                                    color: Color.fromARGB(255, 63, 63, 63),
                                    height: 1.38),
                              ),
                            ],
                          )),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
