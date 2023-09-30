class MessageModel {
  String? senderid;
  String? receiverid;
  String? datetime;
  String? text;

  MessageModel({
    this.senderid,
    this.receiverid,
    this.datetime,
    this.text,
    required chatImage,
  });

  MessageModel.fromjason(Map<String, dynamic> jason) {
    senderid = jason['senderid'];
    receiverid = jason['receiverid'];
    datetime = jason['datetime'];
    text = jason['text'];
  }
  Map<String, dynamic> toMap() {
    return {
      'senderid': senderid,
      'receiverid': receiverid,
      'datetime': datetime,
      'text': text,
    };
  }
}
