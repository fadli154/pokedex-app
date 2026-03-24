class Province {
  final String id;
  final String name;

  Province({required this.id, required this.name});

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(id: json['code'], name: json['name']);
  }

  @override
  String toString() => name; // 🔥 penting buat tampil di dropdown
}
