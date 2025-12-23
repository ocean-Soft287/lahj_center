import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatContactModel extends Equatable {
  final String? id; // conversationId
  final String otherUserId;
  final String otherUserName;
  final String? otherUserProfilePic;
  final String? lastMessage;
  final Timestamp? lastMessageTime;
  final int unreadCount;
  final bool isTyping;

  const ChatContactModel({
    this.id,
    required this.otherUserId,
    required this.otherUserName,
    this.otherUserProfilePic,
    this.lastMessage,
    this.lastMessageTime,
    this.unreadCount = 0,
    this.isTyping = false,
  });

  // Factory constructor to create ChatContactModel from JSON
  factory ChatContactModel.fromJson(Map<String, dynamic> json) {
    return ChatContactModel(
      id: json['id'] as String?,
      otherUserId: json['otherUserId'] as String,
      otherUserName: json['otherUserName'] as String,
      otherUserProfilePic: json['otherUserProfilePic'] as String?,
      lastMessage: json['lastMessage'] as String?,
      lastMessageTime: json['lastMessageTime'] as Timestamp?,
      unreadCount: json['unreadCount'] as int? ?? 0,
      isTyping: json['isTyping'] as bool? ?? false,
    );
  }

  // Method to convert ChatContactModel to JSON
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'otherUserId': otherUserId,
      'otherUserName': otherUserName,
      if (otherUserProfilePic != null)
        'otherUserProfilePic': otherUserProfilePic,
      if (lastMessage != null) 'lastMessage': lastMessage,
      if (lastMessageTime != null) 'lastMessageTime': lastMessageTime,
      'unreadCount': unreadCount,
      'isTyping': isTyping,
    };
  }

  // CopyWith method for immutability
  ChatContactModel copyWith({
    String? id,
    String? otherUserId,
    String? otherUserName,
    String? otherUserProfilePic,
    String? lastMessage,
    Timestamp? lastMessageTime,
    int? unreadCount,
    bool? isTyping,
  }) {
    return ChatContactModel(
      id: id ?? this.id,
      otherUserId: otherUserId ?? this.otherUserId,
      otherUserName: otherUserName ?? this.otherUserName,
      otherUserProfilePic: otherUserProfilePic ?? this.otherUserProfilePic,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
      isTyping: isTyping ?? this.isTyping,
    );
  }

  @override
  List<Object?> get props => [
    id,
    otherUserId,
    otherUserName,
    otherUserProfilePic,
    lastMessage,
    lastMessageTime,
    unreadCount,
    isTyping,
  ];
}
