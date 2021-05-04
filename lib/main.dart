import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String result="0";
  String equation="0";
  Color clr= Colors.white;

  void pressed(String str){
    if(str=="C"){
      result="0";
      equation="0";
    }
    else if(str=="Del"){
      if(equation.length>1)
        equation=equation.substring(0,equation.length-1);
      else
        equation="0";
    }
    else if(str=="="){
      Parser p=Parser();
      result=p.parse(equation).evaluate(EvaluationType.REAL, null).toString();
    }
    else{
      if(equation.length==1 && equation[0]=="0")
        equation="";
      if(str=="x")
        str="*";
      equation += str;
    }
  }

  Widget  createButton(String str,Color clr,Color clr1){
    if(str=='=')
      return Container(
        child: MaterialButton(
          hoverColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          padding: EdgeInsets.symmetric(vertical: 14.0,horizontal: 82),
          onPressed:(){
            setState(() {
              pressed(str);
            });
          },
          child:Center(
            child: Text(
              str,
              style: TextStyle(
                fontSize: 38.0,
                color: clr1,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          color: clr,
        ),
      );
    else
      return Container(
      child: MaterialButton(
          shape: CircleBorder(),
          padding: EdgeInsets.all(22),
          onPressed:(){
            setState(() {
              pressed(str);
            });
          },
          child:Center(
            child: Text(
              str,
              style: TextStyle(
                fontSize: 26.0,
                color: clr1,
              ),
            ),
          ),
        color: clr,
          ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Calculator'),
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 5.0, 10.0),

                    child: Text(
                      equation,
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 15.0, 5.0, 15.0),
                    child: Text(
                        result,
                        style: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      createButton('C', Colors.amber,clr),
                      createButton('Del', Colors.amber,clr),
                      createButton('%', clr,Colors.green),
                      createButton('/', clr,Colors.green),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      createButton('7', clr,Colors.black),
                      createButton('8', clr,Colors.black),
                      createButton('9', clr,Colors.black),
                      createButton('x', clr,Colors.green),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      createButton('6', clr,Colors.black),
                      createButton('5', clr,Colors.black),
                      createButton('4', clr,Colors.black),
                      createButton('-', clr,Colors.green),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      createButton('1', clr,Colors.black),
                      createButton('2', clr,Colors.black),
                      createButton('3', clr,Colors.black),
                      createButton('+', clr,Colors.green),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      createButton('0', clr,Colors.black),
                      createButton('.', clr,Colors.black),
                      createButton('=', Colors.amberAccent,clr),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
