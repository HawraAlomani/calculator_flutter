import 'package:calculator_app/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userInput='';
  var userAns='';
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0x34E3AF), Color(0xff2980b9)])),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(height: 40,),
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                        child: Text(userInput, style: TextStyle(fontSize: 18),)),
                    Container(
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.centerRight,
                        child: Text(userAns , style: TextStyle(fontSize: 40),))
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2, // to divide my screen (takes as twice space)
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                child: Container(
                  child: Center(
                      child: GridView.builder(
                          itemCount: buttons.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                          itemBuilder: (BuildContext context, int index) {
                           if(index == 0){
                             return MyButton(
                               //this is clear button
                                 buttonTapped:(){
                                   setState(() {
                                     userInput='';
                                   });},
                                 buttonText: buttons[index],
                                 color:  Colors.greenAccent ,
                                 textColor: Colors.white);

                           }else if (index == 1){
                               return MyButton(
                                   buttonTapped:(){
                                     setState(() {
                                       userInput=userInput.substring(0,userInput.length-1);
                                     });},
                                   buttonText: buttons[index],
                                   color:  Colors.redAccent ,
                                   textColor: Colors.white);
                           }else if (index == buttons.length-1){
                             return MyButton(
                                 buttonTapped:(){
                                   setState(() {
                                     equalPressed();
                                   });},
                                 buttonText: buttons[index],
                                 color:  Colors.lightBlue.withOpacity(0.3) ,
                                 textColor: Colors.white);
                           }
                           else{
                             return MyButton(
                                 buttonTapped:(){
                                   setState(() {
                                     userInput+=buttons[index];
                                   });},
                                 buttonText: buttons[index],
                                 color: isOperator(buttons[index]) ? Colors.lightBlue.withOpacity(0.3) : Colors.white ,
                                 textColor: isOperator(buttons[index]) ? Colors.white : Colors.blue );
                           }
                          })),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.white, Color(0x8AFFFFFF)])),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  bool isOperator(String x){
    if( x=='x'|| x=='-'|| x=='+'|| x=='/'|| x=='%'|| x=='='){
      return true;
    }
    else{
      return false;
    }
  }
  void equalPressed(){
    String finalQuestion = userInput;
    finalQuestion= finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);

    // Bind variables:
    ContextModel cm = ContextModel();
    // Evaluate expression:
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAns=eval.toString();
  }

}
