import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:insetos_em_ordem/models/identification_model.dart';
import 'package:insetos_em_ordem/services/identification_service.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  var _identification = Identification();
  var _identificationService = IdentificationService();

  var identification;

  List<Identification> _identificationList = List<Identification>();

  String subject, body, email;


  final emailController = TextEditingController();

  @override
  void initState(){
    super.initState();
    getAllIdentifications();
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  _showSuccessSnackBar(message){
    var _snackBar = SnackBar(content: message);
    _globalKey.currentState.showSnackBar(_snackBar);
  }

  getAllIdentifications() async {
    _identificationList = List<Identification>();
    var identifications = await _identificationService.listIdentifications();
    identifications.forEach((identification){
      setState(() {
        var identificationModel = Identification();
        identificationModel.id = identification['id'];
        identificationModel.insectOrder = identification['insectOrder'];
        _identificationList.add(identificationModel);
      });
    });
  }

  _emailDialog(BuildContext context, identificationId){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            content: TextField(
              controller: emailController,
            ),
            actions: [
              FlatButton(
                color: Colors.grey,
                onPressed: () => Navigator.pop(context),
                child: Text('Cancelar'),
              ),
              FlatButton(
                color: Colors.redAccent,
                onPressed: ()   async {
                  email = emailController.text;
                  subject = identificationId;
                  body = identificationId;
                  _sendMail(email, subject, body);

                },
                child: Text('Enviar'),
              )
            ],
            title: Text('Insira o email para enviar.'),
          );
        }
    );
  }

  _deleteDialog(BuildContext context, identificationId){
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (param) {
        return AlertDialog(
          actions: [
            FlatButton(
              color: Colors.grey,
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            FlatButton(
              color: Colors.redAccent,
              onPressed: ()   async {
                var result = await _identificationService.deleteIdentification(identificationId);
                if (result > 0) {
                  Navigator.pop(context);
                  getAllIdentifications();
                  _showSuccessSnackBar(Text('Apagado com sucesso'));
                }
              },
              child: Text('Apagar'),
            )
          ],
          title: Text('Confirme para apagar.'),
        );
      }
    );
  }


  Widget listOrEmpty() {
    return _identificationList.isNotEmpty
    ? ListView.builder(
        itemCount: _identificationList.length, itemBuilder: (context, index){
      return Card(
        child: ListTile(
          leading: IconButton(
            icon: Icon(
              Icons.send,
            ),
            onPressed: () {
              _emailDialog(context, _identificationList[index].insectOrder);
            } ,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              _deleteDialog(context, _identificationList[index].id);
              //print(_identificationList[index]);
              getAllIdentifications();
            },),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_identificationList[index].insectOrder, style: TextStyle(fontSize: 10.0),),
            ],
          ),
        ),
      );
    }
    )
    : Center(
      child: Text('Ainda não tem insetos guardados.'),
    );
  }
  
  @override

  Widget build(BuildContext context) {

    return Scaffold(
      key: _globalKey,
      body: listOrEmpty()
    );
  }

  void _sendMail(String email, String subject, String body) async {
    final url = 'mailto:$email?subject=$subject&body=$body';
    if(await canLaunch(url)) {
      await launch(url);
    }else{
      throw 'Não foi possível enviar. $url';
    }
  }

}
