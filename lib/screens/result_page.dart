import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:insetos_em_ordem/key/identification_key.dart';
import 'package:insetos_em_ordem/key/result_node.dart';
import 'package:insetos_em_ordem/screens/identification_page.dart';
//import 'package:insetos_em_ordem/screens/email_sender.dart';

//import 'package:flutter_email_sender/flutter_email_sender.dart';
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
    var now = new DateTime.now();
    print(now);

    finalResult = chave.getResult(currentFragmentID);
    print(currentFragmentID);
    print(finalResult);
    // Use the Todo to create the UI.
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text('Resultado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            new Expanded(
              child: Column(
                children: [
                  new Text(finalResult.getOrder().toString()),
                  //new Text(finalResult.getDescription().toString()),
                ],
              ),
            ),
            new Expanded(
              child: fullScreenImage('assets/${finalResult.getImageLocation()}')
            ),
          ],
        ),
      ),
    );
  }
}