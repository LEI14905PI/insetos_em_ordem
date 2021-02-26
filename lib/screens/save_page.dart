import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insetos_em_ordem/models/identification_model.dart';
import 'package:insetos_em_ordem/screens/landing_page.dart';
import 'package:insetos_em_ordem/services/identification_service.dart';

import 'list_page.dart';

class SavePage extends StatelessWidget {
  /*void _retrievePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      resultOrder = (prefs.getString(resultOrder));
    });
  }*/

  String resultOrder;
  String resultDescription;
  String resultImagePath;

  String latitude;
  String longitude;
  String timestamp;

  SavePage( {Key key, @required this.resultOrder,this.resultDescription,this.resultImagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var _identification = Identification();
    var _identificationService = IdentificationService();

    var now = new DateTime.now();
    //print(now);
    //print(_locationData);

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text('Guardar resultado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            new Expanded(
              child: Column(
                children: [
                  new Text(resultOrder),
                  //new Text(finalResult.getDescription().toString()),
                  OutlinedButton(
                    onPressed: () async {
                      _identification.insectOrder = resultOrder;
                      var result = _identificationService.saveIdentification(_identification);
                      print(result);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListPage()),
                      );
                    },
                    child: Text("GUARDAR SEM FOTO", style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),
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
