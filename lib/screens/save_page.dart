import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:insetos_em_ordem/models/identification_model.dart';
import 'package:insetos_em_ordem/screens/list_page.dart';
import 'package:insetos_em_ordem/services/identification_service.dart';

class SavePage extends StatefulWidget {

  String currentFragmentID;
  String resultOrder;
  String resultDescription;
  String resultImagePath;


  SavePage( {Key key, @required this.currentFragmentID,this.resultOrder,this.resultDescription,this.resultImagePath}) : super(key: key);

  @override
  _SavePageState createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  String latitude;

  String longitude;


  Position _currentPosition;


  //String timestamp = DateFormat('yyyy-MM-dd – kk:mm').format(time);
  //String convertedDateTime = "${now.year.toString()}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')} ${now.hour.toString()}-${now.minute.toString()}";

  @override
  Widget build(BuildContext context) {

    var _identification = Identification();
    var _identificationService = IdentificationService();

    DateTime now = DateTime.now();
    String timestamp = DateFormat('yyyy-MM-dd – kk:mm').format(now);

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text('Guardar resultado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              new Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    new Text(widget.resultOrder, style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),
                    new Text(timestamp),
                    //new Text(finalResult.getDescription().toString()),
                    if (_currentPosition != null)
                      Text(
                          "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
                    RaisedButton(
                      child: Text("Obter coordenadas."),
                      onPressed: () {
                        _getCurrentLocation();
                      },
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        _identification.keyId = widget.currentFragmentID;
                        _identification.insectOrder = widget.resultOrder;
                        _identification.timestamp = timestamp;
                        _identification.latitude = _currentPosition.latitude;
                        _identification.longitude = _currentPosition.longitude;
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
      ),
    );
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
}
