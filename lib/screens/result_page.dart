import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:insetos_em_ordem/key/identification_key.dart';
import 'package:insetos_em_ordem/key/result_node.dart';
import 'package:insetos_em_ordem/screens/save_page.dart';

import 'package:full_screen_image/full_screen_image.dart';

class ResultPage extends StatelessWidget {

  final String currentFragmentID;
  ResultNode finalResult;

  ResultPage({Key key, @required this.currentFragmentID}) : super(key: key);

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
  Widget build(BuildContext context) {
    var chave = new IdentificationKey().loadXML();

    finalResult = chave.getResult(currentFragmentID);
    print(currentFragmentID);
    print(finalResult);

    String resultOrder = finalResult.getOrder().toString();
    String resultDescription = finalResult.getDescription().toString();
    String resultImagePath = finalResult.getImageLocation();

    // Use the Todo to create the UI.
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text('Resultado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  new Text(resultOrder),
                  //new Text(finalResult.getDescription().toString()),
                  OutlinedButton(
                    onPressed: () {
                      //_savePreferences();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SavePage(currentFragmentID:currentFragmentID,resultOrder:resultOrder, resultDescription:resultDescription, resultImagePath:resultImagePath)),
                      );
                    },
                    child: Text("GUARDAR", style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
              new Expanded(child:
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Text(resultDescription),
                    ),
                  )
              ),
              new Expanded(
                child: fullScreenImage('assets/$resultImagePath')
              ),
            ],
          ),
        ),
      ),
    );
  }
}