import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/Home/chat/model/message_model.dart';
import 'package:lahijcenter/Feature/Home/chat/repo/chat_repository.dart';

import '../../../../../../core/bloc/base_state.dart';

part 'chat_event.dart';

class ChatBloc extends Bloc<ChatEvent, BaseState<MessageModel>> {
  final ChatRepository _chatRepository;

  ChatBloc(this._chatRepository) : super(const BaseState<MessageModel>()) {
    on<ListenToMessagesEvent>(_onListenToMessages);
    on<SendMessageEvent>(_onSendMessage);
    on<MarkMessageAsReadEvent>(_onMarkMessageAsRead);
  }

  Future<void> _onListenToMessages(
    ListenToMessagesEvent event,
    Emitter<BaseState<MessageModel>> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    await emit.forEach(
      _chatRepository.getMessages(conversationId: event.conversationId),
      onData: (either) {
        return either.fold(
          (failure) => state.copyWith(
            status: Status.failure,
            errorMessage: failure.message,
            failure: failure,
          ),
          (messages) => state.copyWith(status: Status.success, items: messages),
        );
      },
      onError: (error, stackTrace) {
        return state.copyWith(
          status: Status.failure,
          errorMessage: error.toString(),
        );
      },
    );
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<BaseState<MessageModel>> emit,
  ) async {
    final result = await _chatRepository.sendMessage(
      conversationId: event.conversationId,
      senderId: event.senderId,
      receiverId: event.receiverId,
      text: event.text,
      type: event.type,
      senderName: event.senderName,
      receiverName: event.receiverName,
      senderProfilePic: event.senderProfilePic,
      receiverProfilePic: event.receiverProfilePic,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: Status.failure,
            errorMessage: failure.message,
            failure: failure,
          ),
        );
      },
      (messageId) {
        // Message sent successfully - stream will update automatically
        // You can emit a success state if needed for UI feedback
      },
    );
  }

  Future<void> _onMarkMessageAsRead(
    MarkMessageAsReadEvent event,
    Emitter<BaseState<MessageModel>> emit,
  ) async {
    await _chatRepository.markMessageAsRead(
      conversationId: event.conversationId,
      messageId: event.messageId,
    );
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
