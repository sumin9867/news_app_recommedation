class SignUpModel {
  final String id;
  final String name;
  final String email;
  final String location;
  final String password;
  final String repassword;
<<<<<<< HEAD
  final String phoneNumber; // Phone number field
  final bool admin;
  final List<String> categories; // Categories field
  final double? longitude; // Optional longitude
  final double? latitude; // Optional latitude
=======
  final String phoneNumber; // Added phone number field
  final bool admin;
  final List<String> categories; // Added categories field
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d

  SignUpModel({
    required this.id,
    required this.name,
    required this.email,
    required this.location,
    required this.password,
    required this.repassword,
<<<<<<< HEAD
    required this.phoneNumber,
    required this.admin,
    required this.categories,
    this.longitude, // Made optional
    this.latitude, // Made optional
=======
    required this.phoneNumber, // Updated constructor
    required this.admin,
    required this.categories, // Updated constructor
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      location: json['location'] as String,
      password: json['password'] as String,
      repassword: json['repassword'] as String,
<<<<<<< HEAD
      phoneNumber: json['phoneNumber'] as String,
      admin: json['admin'] as bool,
      categories: List<String>.from(json['categories'] as List),
      longitude: json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null, // Handle nullable longitude
      latitude: json['latitude'] != null
          ? (json['latitude'] as num).toDouble()
          : null, // Handle nullable latitude
=======
      phoneNumber: json['phoneNumber'] as String, // Updated fromJson
      admin: json['admin'] as bool,
      categories:
          List<String>.from(json['categories'] as List), // Updated fromJson
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'location': location,
      'password': password,
      'repassword': repassword,
<<<<<<< HEAD
      'phoneNumber': phoneNumber,
      'admin': admin,
      'categories': categories,
      if (longitude != null) 'longitude': longitude, // Include if not null
      if (latitude != null) 'latitude': latitude, // Include if not null
=======
      'phoneNumber': phoneNumber, // Updated toJson
      'admin': admin,
      'categories': categories, // Updated toJson
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
    };
  }
}
