import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String text;
  final String mediaUrl;
  final String mediaType;
  final DateTime timestamp;
  final String userId;

  PostModel({
    required this.id,
    required this.text,
    required this.mediaUrl,
    required this.mediaType,
    required this.timestamp,
    required this.userId,
  });

  // Convert Firestore document to a Post object
  factory PostModel.fromFirestore(DocumentSnapshot doc) {
    // Safely cast the Firestore document data to a Map
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return PostModel(
      id: doc.id,
      text: data['text'] ?? '',
      mediaUrl: data['mediaUrl'] ?? '',
      mediaType: data['mediaType'] ?? '',
      timestamp: data['timestamp'] is Timestamp
          ? (data['timestamp'] as Timestamp)
              .toDate() // Convert Firestore Timestamp to DateTime
          : DateTime.parse(data['timestamp']), // Handle timestamp as a String
      userId: data['userId'] ?? '',
    );
  }

  // Convert Post object to JSON for saving to Firestore
  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'mediaUrl': mediaUrl,
        'mediaType': mediaType,
        'timestamp': timestamp.toIso8601String(),
        'userId': userId,
      };
}
