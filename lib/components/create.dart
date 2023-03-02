import 'package:Micix/components/explore.dart';
import 'package:Micix/components/functions.dart';
import 'package:Micix/components/navigation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

bool isLoading = false;

class _CreatePageState extends State<CreatePage> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  String _selectedOption = "Quote";

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _publishData() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await Firebase.initializeApp();
      CollectionReference data = FirebaseFirestore.instance
          .collection((_selectedOption == 'Quote') ? 'quotes' : 'article');
      final auth_data = getUserData();
      if (_selectedOption == 'Quote')
        await data.add({
          'quote': _textController.text,
          'author': auth_data['name'],
          'uid': auth_data['uid'],
          'createdAt': FieldValue.serverTimestamp()
        });
      else if (_selectedOption == 'Article')
        await data.add({
          'description': _textController.text,
          'title': auth_data['name'],
          'uid': auth_data['uid'],
          'createdAt': FieldValue.serverTimestamp()
        });
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => navigation()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: .7,
        backgroundColor: Colors.white,
        title: Padding(
          padding: EdgeInsets.only(left: 7),
          child: Text(
            "Create - ${_selectedOption}",
            style: TextStyle(color: Colors.black, fontSize: 23),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: _textController,
                  maxLines: 15,
                  decoration: InputDecoration(
                    hintText: "Share your creative thinking...",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(229, 170, 61, 1), width: 2.0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(229, 170, 61, 1),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(20.0), // set the border radius
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter text";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: Text("Quote"),
                        activeColor: Color.fromRGBO(229, 170, 61, 1),
                        value: "Quote",
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value.toString();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: Text("Article"),
                        value: "Article",
                        groupValue: _selectedOption,
                        activeColor: Color.fromRGBO(229, 170, 61, 1),
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 36),
                Container(
                  height: 52,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      )),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey),
                    ),
                    child: isLoading
                        ? Container(
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.all(2.0),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : Text(
                            'Publish',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                    onPressed: _publishData,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
