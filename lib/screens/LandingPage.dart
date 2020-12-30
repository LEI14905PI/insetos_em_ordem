import 'package:flutter/material.dart';
import 'IdentificationPage.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.greenAccent,
      child: new InkWell(
        //onTap: () => print("tapppppppppppp"),
        onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new IdentificationPage(currentFragmentID: "Q1"))),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Insetos em Ordem", style: new TextStyle(color: Colors.white, fontSize: 70.0, fontWeight: FontWeight.bold),),
            new Text("Clique para iniciar", style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}