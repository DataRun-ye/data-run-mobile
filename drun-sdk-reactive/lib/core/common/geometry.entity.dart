class Geometry {
  String? type;
  List<dynamic>? coordinates;

  Geometry({this.type, this.coordinates});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
        type: json['type'],
        coordinates: json['coordinates'] != null
            ? List<dynamic>.from(json['coordinates'])
            : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates?.map((e) => e.toString()).toList();
    return data;
  }

  double? get latitude {
    if (type == 'Point') {
      return coordinates?.elementAt(1);
    }

    return null;
  }

  double? get longitude {
    if (type == 'Point') {
      return coordinates?.elementAt(0);
    }
    return null;
  }
}
