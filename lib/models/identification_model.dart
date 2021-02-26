class Identification{
  int id;
  String keyId;
  String insectOrder;
  double latitude;
  double longitude;
  String timestamp;
  String photoURI;

  identificationMap(){
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['keyId'] = keyId;
    mapping['insectOrder'] = insectOrder;
    //mapping['latitude'] = latitude;
    //mapping['longitude'] = longitude;
    mapping['timestamp'] = timestamp;
    //mapping['photoURI'] = photoURI;

    return mapping;
  }
}