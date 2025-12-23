part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

/// Event to start listening to messages for a conversation
class ListenToMessagesEvent extends ChatEvent {
  final String conversationId;

  const ListenToMessagesEvent(this.conversationId);

  @override
  List<Object?> get props => [conversationId];
}

/// Event to send a message
class SendMessageEvent extends ChatEvent {
  final String conversationId;
  final String senderId;
  final String receiverId;
  final String text;
  final String type;
  final String senderName;
  final String receiverName;
  final String? senderProfilePic;
  final String? receiverProfilePic;

  const SendMessageEvent({
    required this.conversationId,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.senderName,
    required this.receiverName,
    this.type = 'text',
    this.senderProfilePic,
    this.receiverProfilePic,
  });

  @override
  List<Object?> get props => [
    conversationId,
    senderId,
    receiverId,
    text,
    type,
    senderName,
    receiverName,
    senderProfilePic,
    receiverProfilePic,
  ];
}

/// Event to mark a message as read
class MarkMessageAsReadEvent extends ChatEvent {
  final String conversationId;
  final String messageId;

  const MarkMessageAsReadEvent({
    required this.conversationId,
    required this.messageId,
  });

  @override
  List<Object?> get props => [conversationId, messageId];
}

/// Event to stop listening to messages
class StopListeningToMessagesEvent extends ChatEvent {
  const StopListeningToMessagesEvent();
}
