class Room {
  static const String CollectionName = 'Room';

  String? id;
  String? roomTitle;
  String? categoryId;
  String? roomDescription;

  Room(
      {this.id,
      required this.roomTitle,
      required this.categoryId,
      required this.roomDescription});

  Room.fromJson(dynamic json) {
    id = json['id'] as String;
    roomTitle = json['roomTitle'] as String;
    categoryId = json['categoryId'] as String;
    roomDescription = json['roomDescription'] as String;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['roomTitle'] = roomTitle;
    map['categoryId'] = categoryId;
    map['roomDescription'] = roomDescription;
    return map;
  }
}
