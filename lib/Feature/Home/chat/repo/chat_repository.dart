import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/Home/chat/model/message_model.dart';
import 'package:lahijcenter/core/Failure/failure.dart';

abstract interface class ChatRepository {
  /// Get messages stream for a specific conversation
  Stream<Either<Failure, List<MessageModel>>> getMessages({
    required String conversationId,
  });

  /// Send a message to a conversation
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
  });

  /// Mark message as read
  Future<Either<Failure, void>> markMessageAsRead({
    required String conversationId,
    required String messageId,
  });
}
