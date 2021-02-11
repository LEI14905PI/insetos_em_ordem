import 'package:flutter/material.dart';
import 'package:insetos_em_ordem/key/IdentificationKey.dart';

// not in use right now

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    /// aqui puxa os argumentos das settings
    final IdentificationKey bundle = ModalRoute.of(context).settings.arguments;

    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        // title: Text(bundle.getResult().getId()),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        // child: Text(bundle.description),
      ),
    );
  }
}