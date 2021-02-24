import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';

import 'package:insetos_em_ordem/key/question_node.dart';
import 'package:insetos_em_ordem/key/result_node.dart';
import 'package:insetos_em_ordem/key/identification_key.dart';

import 'package:insetos_em_ordem/screens/result_page.dart';


class IdentificationPage extends StatelessWidget {

  // constructor
  IdentificationPage({Key key, @required this.currentFragmentID}) : super(key: key);

  Widget fullScreenImage(imagePath) => FullScreenWidget(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
      ),
    ),
  );

  @override

  QuestionNode node;
  String currentFragmentID;
  String  optionAEndPoint;
  String  optionBEndPoint;
  String title = "Identificação";
  String questionText;
  String imageLocationA;
  String imageLocationB;

  var chave = new IdentificationKey().loadXML();

  Widget build(BuildContext context) {

    /*if(currentFragmentID==null){
      currentFragmentID="Q1";
    }*/

    node = chave.getQuestion(currentFragmentID);
    String texto = node.getQuestion().toString();

    optionAEndPoint = node.optionA.getGotoId().toString();
    optionBEndPoint = node.optionB.getGotoId().toString();

    imageLocationA = "assets/" + node.optionA.getImageLocation();
    imageLocationB = "assets/" + node.optionB.getImageLocation();

    print(currentFragmentID);
    print(imageLocationA);
    print(imageLocationB);

    return Scaffold(
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: new Text(texto, style: TextStyle(
                  fontSize: 16.0,
                ),),
              ),

              SizedBox(height: 18.0,),
              new Expanded(child: Container(
                child: fullScreenImage(imageLocationA),
              ),),
              SizedBox(height: 8.0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
                child: new GestureDetector(
                  // When the child is tapped, go to next screen.
                  onTap: () {
                    if (chave.isQuestion(optionAEndPoint)) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IdentificationPage(currentFragmentID : optionAEndPoint),
                        ),
                      );
                    } else if (chave.isResult(optionAEndPoint)){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPage(currentFragmentID : optionAEndPoint),
                        ),
                      );
                    }
                  },
                  // The custom button
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).buttonColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(node.optionA.getText().toString()),
                  ),
                ),
              ),
              SizedBox(height: 18.0,),
              new Expanded(child: Container(
                child: fullScreenImage(imageLocationB),
              ),),
              SizedBox(height: 8.0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
                child: new GestureDetector(
                  // When the child is tapped, show a snackbar.
                  onTap: () {
                    if (chave.isQuestion(optionBEndPoint)) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IdentificationPage(currentFragmentID : optionBEndPoint),
                        ),
                      );
                    } else if (chave.isResult(optionBEndPoint)){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPage(currentFragmentID : optionBEndPoint),
                        ),
                      );
                    }
                  },
                  // The custom button
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).buttonColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(node.optionB.getText().toString()),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}