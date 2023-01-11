class Todo {
  String intitule;
  bool status;

  String hoursTartTask;
  String hoursEndTask;
  int? id;
  Todo({
    required this.intitule,
    required this.status,
    required this.hoursTartTask,
    required this.hoursEndTask,
  }) {
    id = DateTime.now().microsecondsSinceEpoch;
  }

  toJSONEncodable() {
    Map<String, dynamic> m = {};

    m['intitule'] = intitule;
    m['status'] = status;
    m['hoursTartTask'] = hoursTartTask;
    m['hoursEndTask'] = hoursEndTask;
    m['id'] = id;

    return m;
  }
}
