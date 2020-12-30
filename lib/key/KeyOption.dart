class KeyOption {

  final String _gotoId;      //  It's the attribute of option id. Ex: goto=Q2
  final String _description;
  final String _imageLocation;
  final String _text;

  KeyOption(this._gotoId,this._description,this._imageLocation,this._text);

  String getGotoId() {
    return _gotoId;
  }

  String getDescription() {
    return _description;
  }

  String getImageLocation() {
    return _imageLocation;
  }

  String getText() {
    return _text;
  }

  String toString() {
    return "KeyOption{" +
            "gotoId='" + _gotoId + '\'' +
            ", description='" + _description + '\'' +
            ", imageLocation='" + _imageLocation + '\'' +
            ", text='" + _text + '\'' +
            '}';
  }

}