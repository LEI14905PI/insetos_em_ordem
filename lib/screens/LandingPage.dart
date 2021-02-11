import 'package:flutter/material.dart';
import 'IdentificationPage.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _visible = true;
    return new Material(
      color: Colors.greenAccent,
      child: new InkWell(
        onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new IdentificationPage(currentFragmentID: "Q1"))),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(child: Image.asset('assets/refImages/logo1-web.png'),),
            Center(child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
                child: new Text("Insetos em Ordem", style: new TextStyle(color: Colors.white, fontSize: 55.0, fontWeight: FontWeight.bold),)
            )
            ),
            SizedBox(height: 18),
            Container(
                child: new Text("Clique para iniciar", style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),))
          ],
        ),
      ),
    );
  }
}