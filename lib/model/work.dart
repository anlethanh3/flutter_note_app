class Work {
  final String id;
  String name;
  final int utcTime;
  bool isDone;

  Work(
      {this.id = '',
      this.name = '',
      this.utcTime = 0,
      this.isDone = false});

  Work.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        name = json['name'] ?? '',
        utcTime = json['utcTime'] ?? 0,
        isDone = json['isDone'] ?? false;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'utcTime': utcTime,
        'isDone': isDone,
      };
}