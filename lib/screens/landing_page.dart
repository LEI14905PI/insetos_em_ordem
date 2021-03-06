import 'package:flutter/material.dart';
import 'identification_page.dart';
import 'list_page.dart';
import 'credits_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _visible = true;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.greenAccent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Column(
                children: [],
              ),),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 66,vertical: 66),
                child: Image.asset('assets/refImages/logo1-web.png'),),
              Text('INSETOS EM ORDEM',style: TextStyle(color: Colors.white, fontSize: 33.0),),
              SizedBox(height: 10.0,),
              OutlinedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => IdentificationPage(currentFragmentID: "Q1"))),
                child: Text("IDENTIFICAR", style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListPage()),
                  );
                },
                child: Text("OS MEUS INSETOS", style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),
              ),
              OutlinedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CreditsPage())),
                child: Text("CRÉDITOS", style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),
              )
            ],
          ),
        ),
      ),
    );
  }
}