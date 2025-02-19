class UserModel {
  final String id;
  final String name;
  final String email;
  final String location;
  final String? profileImageUrl;
  final bool? admin;
  final double? longitude; // Optional longitude
  final double? latitude; // Optional latitude

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.location,
    this.profileImageUrl,
    required this.admin,
    this.longitude, // Added optional longitude
    this.latitude, // Added optional latitude
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      location: json['location'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      admin: json['admin'] as bool,
      longitude: json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null, // Handle nullable longitude
      latitude: json['latitude'] != null
          ? (json['latitude'] as num).toDouble()
          : null, // Handle nullable latitude
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
      if (longitude != null) 'longitude': longitude, // Include if not null
      if (latitude != null) 'latitude': latitude, // Include if not null
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? location,
    String? profileImageUrl,
    bool? admin,
    double? longitude,
    double? latitude,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      location: location ?? this.location,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      admin: admin ?? this.admin,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }
}
