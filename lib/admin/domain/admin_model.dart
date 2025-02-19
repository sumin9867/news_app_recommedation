class NewsModel {
  final String title;
  final String description;
  final String shortDescription;
  final DateTime time;
  final String location;
  final double latitude;
  final double longitude;
  final String? imageUrl; // Added the image URL as an optional field

  NewsModel({
    required this.title,
    required this.description,
    required this.shortDescription,
    required this.time,
    required this.location,
    required this.latitude,
    required this.longitude,
    this.imageUrl, // Constructor updated to accept imageUrl
  });

  // Convert NewsModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'shortDescription': shortDescription,
      'time': time.toIso8601String(),
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'imageUrl': imageUrl, // Add imageUrl to the map
    };
  }

  // Create a NewsModel from Map (Firestore Document)
  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      title: map['title'],
      description: map['description'],
      shortDescription: map['shortDescription'],
      time: DateTime.parse(map['time']),
      location: map['location'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      imageUrl: map['imageUrl'], // Retrieve imageUrl from the map
    );
  }
}
