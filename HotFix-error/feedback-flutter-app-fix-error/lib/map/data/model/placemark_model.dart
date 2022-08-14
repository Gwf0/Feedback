class Results {
  Results({
    required this.id,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.confirmLocation,
    required this.entity,
    required this.doerRequirements,
    required this.distance,
    required this.rewardAmount,
    required this.refundAmount,
    required this.comment,
  });
  late final int id;
  late final String type;
  late final String startDate;
  late final String endDate;
  late final bool confirmLocation;
  late final Entity entity;
  late final DoerRequirements doerRequirements;
  late final int distance;
  late final int rewardAmount;
  late final int refundAmount;
  late final String comment;

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    confirmLocation = json['confirm_location'];
    entity = Entity.fromJson(json['entity']);
    doerRequirements = DoerRequirements.fromJson(json['doer_requirements']);
    distance = json['distance'];
    rewardAmount = json['reward_amount'];
    refundAmount = json['refund_amount'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['type'] = type;
    _data['start_date'] = startDate;
    _data['end_date'] = endDate;
    _data['confirm_location'] = confirmLocation;
    _data['entity'] = entity.toJson();
    _data['doer_requirements'] = doerRequirements.toJson();
    _data['distance'] = distance;
    _data['reward_amount'] = rewardAmount;
    _data['refund_amount'] = refundAmount;
    _data['comment'] = comment;
    return _data;
  }
}

class Entity {
  Entity({
    required this.id,
    required this.name,
    required this.publicName,
    required this.address,
    required this.coords,
    required this.city,
  });
  late final int id;
  late final String name;
  late final String publicName;
  late final String address;
  late final Coords coords;
  late final City city;

  Entity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    publicName = json['public_name'];
    address = json['address'];
    coords = Coords.fromJson(json['coords']);
    city = City.fromJson(json['city']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['public_name'] = publicName;
    _data['address'] = address;
    _data['coords'] = coords.toJson();
    _data['city'] = city.toJson();
    return _data;
  }
}

class Coords {
  Coords({
    required this.lat,
    required this.lon,
  });
  late final double lat;
  late final double lon;

  Coords.fromJson(Map<String, dynamic> json) {
    json['lat'] == null ? 0.0 : json['lat'].toDouble();
    json['lon'] == null ? 0.0 : json['lon'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lat'] = lat;
    _data['lon'] = lon;
    return _data;
  }
}

class City {
  City({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class DoerRequirements {
  DoerRequirements({
    required this.age,
    required this.sex,
    required this.skills,
    required this.cityId,
    required this.education,
  });
  late final List<int> age;
  late final String sex;
  late final List<dynamic> skills;
  late final int? cityId;
  late final String education;

  DoerRequirements.fromJson(Map<String, dynamic> json) {
    age = List.castFrom<dynamic, int>(json['age']);
    sex = json['sex'];
    skills = List.castFrom<dynamic, dynamic>(json['skills']);
    cityId = json['city_id'];
    education = json['education'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['age'] = age;
    _data['sex'] = sex;
    _data['skills'] = skills;
    _data['city_id'] = cityId;
    _data['education'] = education;
    return _data;
  }
}
