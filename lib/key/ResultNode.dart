class ResultNode {

  final String _id;
  final String _ordem;
  final String _description;
  final String _imageLocation;

  ResultNode(this._id,this._ordem,this._description,this._imageLocation);

  String getId() {
    return _id;
  }

  String getOrdem() {
    return _ordem;
  }

  String getDescription() {
    return _description;
  }

  String getImageLocation() {
    return _imageLocation;
  }
}