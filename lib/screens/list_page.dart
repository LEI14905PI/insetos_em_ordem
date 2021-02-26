import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insetos_em_ordem/models/identification_model.dart';
import 'package:insetos_em_ordem/services/identification_service.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  var _identification = Identification();
  var _identificationService = IdentificationService();

  List<Identification> _identificationList = List<Identification>();

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
        identificationModel.insectOrder = identification['insectOrder'];
        _identificationList.add(identificationModel);
      });
    });
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: ListView.builder(
          itemCount: _identificationList.length, itemBuilder: (context, index){
            return Card(
              child: ListTile(
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _deleteDialog(context, _identificationList[index].id);
                    print(_identificationList[index].id);
                  },),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_identificationList[index].insectOrder, style: TextStyle(fontSize: 12.0),),
                  ],
                ),
              ),
            );
          }
      )
    );
  }
}
