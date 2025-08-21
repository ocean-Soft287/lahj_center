
class ModelCurrency {
  final int id;
  final String arName;
  final String enName;

  ModelCurrency({required this.id, required this.arName, required this.enName});

  // fromJson
  factory ModelCurrency.fromJson(Map<String, dynamic> json) {


    final id = json['id'];
    final arName = json['arName'];
    final enName = json['enName'];



    // Handle different id types
    int parsedId;
    if (id == null) {
      parsedId = 0;
    } else if (id is int) {
      parsedId = id;
    } else if (id is String) {
      parsedId = int.tryParse(id) ?? 0;
    } else {
      parsedId = 0;
    }


    return ModelCurrency(id: parsedId, arName: arName ?? '', enName: enName ?? '');
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {'id': id, 'arName': arName, 'enName': enName};
  }
}
