import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:news/admin/domain/admin_model.dart';

class NewsRepository {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  NewsRepository(this.firestore, this.storage);

  // Add a news item to Firestore
  Future<void> addNews(NewsModel news, {File? imageFile}) async {
    try {
      String? imageUrl = news.imageUrl;

      // If an image file is provided, upload it and get the URL
      if (imageFile != null) {
        imageUrl = await _uploadImageToStorage(imageFile);
      }

      // Add the news data to Firestore
      await firestore.collection('news').add({
        'title': news.title,
        'description': news.description,
        'shortDescription': news.shortDescription,
        'time': news.time.toIso8601String(), // Convert DateTime to String for Firestore
        'location': news.location,
        'latitude': news.latitude,
        'longitude': news.longitude,
        'imageUrl': imageUrl, // Store the image URL if the image is uploaded or provided
      });
      print('News item added to Firestore successfully.');
    } catch (e) {
      print('Error adding news to Firestore: $e');
      throw Exception('Failed to add news: $e');
    }
  }

  // Upload image to Firebase Storage
  Future<String?> _uploadImageToStorage(File imageFile) async {
    try {
      print('Starting image upload...');
      String fileName = path.basename(imageFile.path);
      print('File name: $fileName');
      
      Reference storageRef = storage.ref().child('news_images').child(fileName);
      print('Storage reference path: ${storageRef.fullPath}');

      UploadTask uploadTask = storageRef.putFile(imageFile);
      
      // Listen to the upload task events
      uploadTask.snapshotEvents.listen((taskSnapshot) {
        print('Upload progress: ${taskSnapshot.bytesTransferred}/${taskSnapshot.totalBytes}');
        if (taskSnapshot.state == TaskState.running) {
          print('Upload in progress...');
        }
        if (taskSnapshot.state == TaskState.success) {
          print('Upload successful.');
        }
      });

      TaskSnapshot taskSnapshot = await uploadTask;

      // Get the download URL for the uploaded image
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      print('Image uploaded. Download URL: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      print('Image upload failed: $e');
      rethrow;  // Re-throw the error so it can be caught in the calling method
    }
  }

  Future<List<NewsModel>> fetchNews() async {
    try {
      print('Fetching news from Firestore...');
      QuerySnapshot snapshot = await firestore.collection('news').get();
      print('News fetched. Total documents: ${snapshot.docs.length}');
      
      return snapshot.docs.map((doc) {
        return NewsModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching news: $e');
      throw Exception('Failed to fetch news: $e');
    }
  }
}
