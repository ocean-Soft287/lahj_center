part of 'chat_contact_bloc.dart';

sealed class ChatContactEvent extends Equatable {
  const ChatContactEvent();

  @override
  List<Object?> get props => [];
}

/// Event to start listening to user conversations
class ListenToUserConversationsEvent extends ChatContactEvent {
  final String userId;

  const ListenToUserConversationsEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

/// Event to stop listening to conversations
class StopListeningToConversationsEvent extends ChatContactEvent {
  const StopListeningToConversationsEvent();
}
