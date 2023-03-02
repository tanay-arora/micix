import 'package:Micix/components/quiz/questionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Micix/components/quiz/color.dart';
import 'package:Micix/components/quiz/resultScreen.dart';

class QuizzScreen extends StatefulWidget {
  final String uid;
  const QuizzScreen({Key? key, required String this.uid}) : super(key: key);

  @override
  _QuizzScreenState createState() => _QuizzScreenState();
}

class _QuizzScreenState extends State<QuizzScreen> {
  int question_pos = 0;
  int score = 0;
  bool btnPressed = false;
  PageController? _controller;
  String btnText = "Next Question";
  bool answered = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  Future<List<QuestionModel>> fetchQuestions() async {
    final query = await FirebaseFirestore.instance
        .collection('quiz_data')
        .where('quiz',
            isEqualTo:
                FirebaseFirestore.instance.collection('quiz').doc(widget.uid))
        .get();
    List<QuestionModel> questions = [];

    for (final doc in query.docs) {
      final rs = QuestionModel(doc['question'], {
        doc['option1']: (doc['answer'] == '1') ? true : false,
        doc['option2']: (doc['answer'] == '2') ? true : false,
        doc['option3']: (doc['answer'] == '3') ? true : false,
        doc['option4']: (doc['answer'] == '4') ? true : false
      });
      questions.add(rs);
    }
    return questions;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchQuestions(),
      builder: (context, AsyncSnapshot<List<QuestionModel>> snapshot) {
        final questions = snapshot.data!;
        if (snapshot.hasData)
          return Scaffold(
            backgroundColor: AppColor.pripmaryColor,
            body: Padding(
                padding: const EdgeInsets.all(18.0),
                child: PageView.builder(
                  controller: _controller!,
                  onPageChanged: (page) {
                    if (page == questions.length - 1) {
                      setState(() {
                        btnText = "See Results";
                      });
                    }
                    setState(() {
                      answered = false;
                    });
                  },
                  physics: new NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            "Question ${index + 1}/${questions.length}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28.0,
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 200.0,
                          child: Text(
                            "${questions[index].question}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                        for (int i = 0;
                            i < questions[index].answers!.length;
                            i++)
                          Container(
                            width: double.infinity,
                            height: 50.0,
                            margin: EdgeInsets.only(
                                bottom: 20.0, left: 12.0, right: 12.0),
                            child: RawMaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              fillColor: btnPressed
                                  ? questions[index].answers!.values.toList()[i]
                                      ? Color.fromARGB(255, 217, 161, 19)
                                      : Colors.red
                                  : AppColor.secondaryColor,
                              onPressed: !answered
                                  ? () {
                                      if (questions[index]
                                          .answers!
                                          .values
                                          .toList()[i]) {
                                        score++;
                                        print("yes");
                                      } else {
                                        print("no");
                                      }
                                      setState(() {
                                        btnPressed = true;
                                        answered = true;
                                      });
                                    }
                                  : null,
                              child: Text(
                                  questions[index].answers!.keys.toList()[i],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  )),
                            ),
                          ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Container(
                          width: 250,
                          child: RawMaterialButton(
                            onPressed: () {
                              if (_controller!.page?.toInt() ==
                                  questions.length - 1) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ResultScreen(score)));
                              } else {
                                _controller!.nextPage(
                                    duration: Duration(milliseconds: 250),
                                    curve: Curves.easeInExpo);

                                setState(() {
                                  btnPressed = false;
                                });
                              }
                            },
                            shape: StadiumBorder(),
                            fillColor: Color.fromARGB(127, 0, 0, 0),
                            padding: EdgeInsets.all(18.0),
                            elevation: 0.0,
                            child: Text(
                              btnText,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  itemCount: questions.length,
                )),
          );
        else
          return Text('');
      },
    );
  }
}
