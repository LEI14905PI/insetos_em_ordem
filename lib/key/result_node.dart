class ResultNode {

  final String _id;
  final String _order;
  final String _description;
  final String _imageLocation;

  ResultNode(this._id,this._order,this._description,this._imageLocation);

  String getId() {
    return _id;
  }

  String getOrder() {
    return _order;
  }

  String getDescription() {
    return _description;
  }

  String getImageLocation() {
    return _imageLocation;
  }
}