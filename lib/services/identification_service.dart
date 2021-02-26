import 'package:insetos_em_ordem/database/database_helper.dart';
import 'package:insetos_em_ordem/models/identification_model.dart';

class IdentificationService{

  DatabaseHelper _databaseHelper;

  IdentificationService(){
    _databaseHelper = DatabaseHelper();
  }
  saveIdentification(Identification identification) async{
    return await _databaseHelper.insertData('identifications', identification.identificationMap());
  }
  listIdentifications() async {
    return await _databaseHelper.readData('identifications');
  }
  readIdentificationById(identificationId) async {
    return await _databaseHelper.readDataById('identifications', identificationId);
  }
  deleteIdentification(identificationId) async {
    return await _databaseHelper.deleteDataById('identifications', identificationId);
  }
}