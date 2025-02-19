class UserModel {
  final String id;
  final String name;
  final String email;
  final String location;
  final String? profileImageUrl;
  final bool? admin;
<<<<<<< HEAD
  final double? longitude; // Optional longitude
  final double? latitude; // Optional latitude
=======
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.location,
    this.profileImageUrl,
    required this.admin,
<<<<<<< HEAD
    this.longitude, // Added optional longitude
    this.latitude, // Added optional latitude
=======
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      location: json['location'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      admin: json['admin'] as bool,
<<<<<<< HEAD
      longitude: json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null, // Handle nullable longitude
      latitude: json['latitude'] != null
          ? (json['latitude'] as num).toDouble()
          : null, // Handle nullable latitude
=======
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'location': location,
      'profileImageUrl': profileImageUrl,
      'admin': admin,
<<<<<<< HEAD
      if (longitude != null) 'longitude': longitude, // Include if not null
      if (latitude != null) 'latitude': latitude, // Include if not null
=======
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? location,
    String? profileImageUrl,
    bool? admin,
<<<<<<< HEAD
    double? longitude,
    double? latitude,
=======
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      location: location ?? this.location,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      admin: admin ?? this.admin,
<<<<<<< HEAD
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
=======
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
    );
  }
}
