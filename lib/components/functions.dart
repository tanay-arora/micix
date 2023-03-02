import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:Micix/components/cart.dart';
import 'package:Micix/components/navigation.dart';
import 'package:Micix/components/order_done.dart';
import 'package:path_provider/path_provider.dart';

void show_snackbar(BuildContext context, String text) {
  final snackBar = SnackBar(
    content: Text(text),
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: 'Dismiss',
      disabledTextColor: Colors.white,
      textColor: Color.fromARGB(255, 255, 200, 18),
      onPressed: () {
        //Do whatever you want
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}

class Authentication {
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // ...
        } else if (e.code == 'invalid-credential') {
          // ...
        }
      } catch (e) {
        // ...
      }
    }

    return user;
  }
}

class CartItem {
  final String id;
  final int qty;

  CartItem({required this.id, this.qty = 1});

  Map toJson() {
    return {'id': id, 'qty': qty};
  }
}

class CartBloc {
  void addToCart(String id) async {
    loadCart().then((val) {
      var cart = val;
      if (!cart.containsKey(id) || cart[id]['qty'] < 10) {
        print(val);
        if (cart.containsKey(id)) {
          cart[id] = {'id': id, 'qty': (cart[id]['qty'] + 1)};
        } else {
          cart[id] = {'id': id, 'qty': 1};
        }
        print(cart);
        _saveCart(cart);
      }
    });
  }

  void removeFromCart(String id, {bool fl = false}) async {
    loadCart().then(
      (val) {
        var cart = val;
        if (cart.containsKey(id)) {
          if (cart[id]['qty'] > 0 && fl == false) {
            cart[id] = {'id': id, 'qty': (cart[id]['qty'] - 1)};
          } else {
            cart.remove(id);
          }
        }
        _saveCart(cart);
      },
    );
  }

  Future<int> getQty(String id) async {
    return loadCart().then((val) {
      return (val.containsKey(id)) ? val[id]['qty'] : 0;
    });
  }

  Future<int> getLength() async {
    return loadCart().then((val) {
      return val.length;
    });
  }

  Future getCartItems() async {
    return loadCart().then((val) {
      final cart = val;
      var items = [];

      // Create a list of Futures to retrieve the documents
      List<Future<DocumentSnapshot>> futures = [];
      cart.forEach((key, value) {
        futures
            .add(FirebaseFirestore.instance.collection('stock').doc(key).get());
      });

      // Wait for all Futures to complete
      return Future.wait(futures).then((snapshots) {
        snapshots.forEach((snapshot) {
          if (snapshot.exists && snapshot.data() != null) {
            Map documentData = snapshot.data() as Map;
            String id = snapshot.id;
            int qty = cart[id]['qty'];

            items.add({
              "id": id,
              "image": documentData['image'],
              "qty": qty,
              "title": documentData['title'],
              'price': documentData['price']
            });
          }
        });

        items.sort((a, b) => a['id'].compareTo(b['id']));
        return items;
      });
    });
  }

  Future<int> getTotalCost() async {
    return loadCart().then((val) {
      final cart = val;
      var total = 0;

      // Create a list of Futures to retrieve the documents
      List<Future<DocumentSnapshot>> futures = [];
      cart.forEach((key, value) {
        futures
            .add(FirebaseFirestore.instance.collection('stock').doc(key).get());
      });

      // Wait for all Futures to complete
      return Future.wait(futures).then((snapshots) {
        snapshots.forEach((snapshot) {
          if (snapshot.exists && snapshot.data() != null) {
            Map documentData = snapshot.data() as Map;

            String id = snapshot.id;
            int qty = cart[id]['qty'];
            int price = snapshot['price'];
            total += (price * qty);
          }
        });
        return total;
      });
    });
  }

  Future loadCart() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (doc.exists) {
        final cart = doc.data()!['cart'];
        if (cart != null) return cart;
      }
    }
    return {};
  }

  void _saveCart(Map items) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final cartRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      final cartData = {'cart': items};
      await cartRef.set(cartData, SetOptions(merge: false));
    }
  }
}

createOrder(key, form, context) async {
  if (key.currentState!.validate()) {
    final cart = await CartBloc().getCartItems();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null)
      FirebaseFirestore.instance.collection("orders").add({
        'user': user.uid,
        'order': cart,
        'name': form['name'].text,
        'address': form['address'].text,
        'phone': form['phone'].text,
        'email': form['email'].text
      }).then((value) {
        CartBloc()._saveCart({});
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => orderDone()));
      });
    else
      show_snackbar(context, "Something went wrong!");
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;

Map getUserData() {
  User? user = _auth.currentUser;
  String name = user?.displayName ?? "Unknown user";
  String uid = user?.uid ?? "Unknown ID";

  print('User name: $name');
  print('User ID: $uid');
  return {'name': name, 'uid': uid, 'email': user?.email};
}
