import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  final String? id;
  final String senderId;
  final String text;
  final Timestamp timestamp;
  final bool isRead;
  final String type; // text, image, file, etc.

  const MessageModel({
    this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    this.isRead = false,
    this.type = 'text',
  });

  // Factory constructor to create MessageModel from JSON
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String?,
      senderId: json['senderId'] as String,
      text: json['text'] as String,
      timestamp: json['timestamp'] as Timestamp,
      isRead: json['isRead'] as bool? ?? false,
      type: json['type'] as String? ?? 'text',
    );
  }

  // Method to convert MessageModel to JSON
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'senderId': senderId,
      'text': text,
      'timestamp': timestamp,
      'isRead': isRead,
      'type': type,
    };
  }

  // CopyWith method for immutability
  MessageModel copyWith({
    String? id,
    String? senderId,
    String? text,
    Timestamp? timestamp,
    bool? isRead,
    String? type,
  }) {
    return MessageModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [id, senderId, text, timestamp, isRead, type];
}
