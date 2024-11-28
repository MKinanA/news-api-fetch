class News {
  final Map<String, dynamic> _data;

  News(this._data);

  // Defined getters and setters for the news context {
  String get title => _data['title'] ?? 'News title unavailable';
  set title(String? newValue) => _data['title'] = newValue;

  String get link => _data['link'] ?? '';
  set link(String? newValue) => _data['link'] = newValue;

  String get contentSnippet => _data['contentSnippet'] ?? 'Content snippet unavailable';
  set contentSnippet(String? newValue) => _data['contentSnippet'] = newValue;

  String get isoDate => _data['isoDate'] ?? '';
  set isoDate(String? newValue) => _data['isoDate'] = newValue;

  Map get image => _data['image'] != null ? _data['image'] is Map ? _data['image'] : _data['image'] is String ? {'only': _data['image']} : {} : {};
  set image(Map newValue) => _data['image'] = newValue;
  //}

  operator []=(String key, dynamic value) => _data[key] = value;
}
