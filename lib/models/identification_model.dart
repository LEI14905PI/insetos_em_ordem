class Identification{
  int id;
  int keyId;
  String insectOrder;
  double latitude;
  double longitude;
  String timestamp;
  String photoURI;

  identificationMap(){
    var mapping = Map<String, dynamic>();
    mapping['rowid'] = id;
    //mapping['keyId'] = keyId;
    mapping['insectOrder'] = insectOrder;
    /*mapping['latitude'] = latitude;
    mapping['longitude'] = longitude;
    mapping['timestamp'] = timestamp;
    mapping['photoURI'] = photoURI;*/

    return mapping;
  }
}