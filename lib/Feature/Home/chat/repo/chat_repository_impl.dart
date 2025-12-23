import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/Home/chat/model/message_model.dart';
import 'package:lahijcenter/core/Failure/failure.dart';
import 'package:lahijcenter/core/firebase/firebase.dart';

import 'chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final FirebaseConsumer _firebaseConsumer;

  const ChatRepositoryImpl(this._firebaseConsumer);

  @override
  Stream<Either<Failure, List<MessageModel>>> getMessages({
    required String conversationId,
  }) {
    return _firebaseConsumer.getSubcollection<MessageModel>(
      parentPath: 'conversations/$conversationId',
      subcollectionName: 'messages',
      fromJson: MessageModel.fromJson,
      orderBy: 'timestamp',
      descending: false,
    );
  }

  @override
  Future<Either<Failure, String>> sendMessage({
    required String conversationId,
    required String senderId,
    required String receiverId,
    required String text,
    required String senderName,
    required String receiverName,
    String type = 'text',
    String? senderProfilePic,
    String? receiverProfilePic,
  }) async {
    try {
      final now = Timestamp.now();
      final message = MessageModel(
        senderId: senderId,
        text: text,
        timestamp: now,
        isRead: false,
        type: type,
      );

      // Add message to messages subcollection
      final result = await _firebaseConsumer.addToSubcollection(
        parentPath: 'conversations/$conversationId',
        subcollectionName: 'messages',
        data: message.toJson(),
      );

      return result.fold((failure) => Left(failure), (messageId) async {
        // Prepare global conversation meta-data
        final conversationData = {
          'lastMessage': text,
          'lastMessageTime': now,
          'lastMessageSenderId': senderId,
          'members': [senderId, receiverId],
        };

        // Prepare sender's local inbox entry
        final senderConversation = {
          'id': conversationId,
          'otherUserId': receiverId,
          'otherUserName': receiverName,
          'otherUserProfilePic': receiverProfilePic,
          'lastMessage': text,
          'lastMessageTime': now,
          'unreadCount': 0,
        };

        // Prepare receiver's local inbox entry
        final receiverConversation = {
          'id': conversationId,
          'otherUserId': senderId,
          'otherUserName': senderName,
          'otherUserProfilePic': senderProfilePic,
          'lastMessage': text,
          'lastMessageTime': now,
        };

        // Execute batch update or sequential updates (FirebaseConsumer doesn't have an easy batch helper for 'set with merge')
        // We will use multiple await calls for simplicity if batching is complex here,
        // but let's try to use setDocument since it's cleaner.

        await _firebaseConsumer.setDocument(
          path: 'conversations/$conversationId',
          data: conversationData,
          merge: true,
        );

        await _firebaseConsumer.setDocument(
          path: 'userConversations/$senderId/$conversationId',
          data: senderConversation,
          merge: true,
        );

        await _firebaseConsumer.setDocument(
          path: 'userConversations/$receiverId/$conversationId',
          data: receiverConversation,
          merge: true,
        );

        return Right(messageId);
      });
    } catch (e) {
      return Left(FirebaseFailure('Error sending message: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> markMessageAsRead({
    required String conversationId,
    required String messageId,
  }) {
    return _firebaseConsumer.updateDocument(
      path: 'conversations/$conversationId/messages/$messageId',
      data: {'isRead': true},
    );
  }
}
