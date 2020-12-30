import 'dart:core';
import 'package:xml/xml.dart' as xml;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insetos_em_ordem/key/QuestionNode.dart';
import 'package:insetos_em_ordem/key/ResultNode.dart';
import 'package:insetos_em_ordem/key/KeyOption.dart';

import 'package:insetos_em_ordem/key/IdentificationKey.dart';


class IdentificationPage extends StatelessWidget {
  
  String currentFragmentID;

  String  optionAEndPoint;
  String  optionBEndPoint;

  QuestionNode node;

  String title = "Identificacao";
  String questionText;
  String imageLocationA;
  String imageLocationB;

  IdentificationPage({Key key, @required this.currentFragmentID}) : super(key: key);
  
  var chave = new IdentificationKey().loadXML();

  @override
  Widget build(BuildContext context) {

    if(currentFragmentID==null){
      currentFragmentID="Q1";
    }
    node = chave.getQuestion(currentFragmentID);
    String texto = node.getQuestion().toString();
    //String textoParsed = xml.parse(texto) as String;
    print(texto);
    //print(textoParsed);
    optionAEndPoint = node.optionA.getGotoId().toString();
    optionBEndPoint = node.optionB.getGotoId().toString();

    imageLocationA = node.optionA.getImageLocation();
    imageLocationB = node.optionB.getImageLocation();

    //print(node.optionA.getImageLocation());

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text(title),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text(texto),
          //new Image(image: AssetImage('assets/$imageLocationA')),
          new Expanded(child: Container(),
          ),
          new Image(image: AssetImage('assets/${node.optionA.getImageLocation()}')),

          new GestureDetector(
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
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(node.optionA.getText().toString()),
      ),
      
    ),
          new Expanded(child: Container(
            child: Image(image: AssetImage('assets/${node.optionB.getImageLocation()}')),


          ),),
          new Image(image: AssetImage('assets/${node.optionB.getImageLocation()}')),
          new GestureDetector(
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
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(node.optionB.getText().toString()),
      ),
    )
        ],
      )
    );
  }
}

class ResultPage extends StatelessWidget {

  final String currentFragmentID;
  ResultNode finalResult;
  

  var chave = new IdentificationKey().loadXML();

  ResultPage({Key key, @required this.currentFragmentID}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    finalResult = chave.getResult(currentFragmentID);

    // Use the Todo to create the UI.
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        // title: Text(bundle.getResult().getId()),
      ),
      body: Padding(
        
        padding: EdgeInsets.all(16.0),
        child: new ListView(
          children: <Widget>[
            new Text(finalResult.getOrdem().toString()),
            new Text(finalResult.getDescription().toString()),
            new Image.asset(
              'assets_folder/${finalResult.getImageLocation()}',
            )
          ]
        ),
        // child: Text(bundle.description),
      ),
    );
  }
}
