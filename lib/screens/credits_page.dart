import 'package:flutter/material.dart';
import 'identification_page.dart';

class CreditsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _visible = true;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/refImages/cr_logo_ce3c-web.png', height: 100,),
              Image.asset('assets/refImages/cr_logo_muhnac-web.png', height: 100,),
              Image.asset('assets/refImages/cr_logo_pca-web.png', height: 100,),
              Image.asset('assets/refImages/cr_logo_tagis-web.png', height: 100,),
              SizedBox(height: 10.0,),
              Text("Esta aplicação foi realizada no âmbito da disciplina Projeto Integrado da Licenciatura de Engenharia Informática pelo IPBeja.", style: TextStyle(), textAlign: TextAlign.center,),
              SizedBox(height: 10.0,),
              Text("Elaborado por: Carlos Jacinto nº14905", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
              SizedBox(height: 7.0,),
              Text("Orientado por:João Paulo Barros, IPBeja", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            ],
          ),
        ),
      ),
    );
  }
}