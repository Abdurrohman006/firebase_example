class MindModel {
  late String mind;
  late String author;
  final String docId;

  MindModel({required this.mind, required this.author, this.docId = ''});
  toJson() => {
        'mind': mind,
        'author': author,
        'docId': docId,
      };

  factory MindModel.fromJson(json) {
    return MindModel(mind: json["mind"], author: json["author"], docId: json['docId']);
  }
}
