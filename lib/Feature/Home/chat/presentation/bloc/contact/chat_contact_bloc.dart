import 'dart:async';
import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/Home/chat/model/chat_contact_model.dart';
import 'package:lahijcenter/Feature/Home/chat/repo/chat_contact_repositry.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';

part 'chat_contact_event.dart';

class ChatContactBloc
    extends Bloc<ChatContactEvent, BaseState<ChatContactModel>> {
  final ChatContactRepository _chatContactRepository;

  ChatContactBloc(this._chatContactRepository)
    : super(const BaseState<ChatContactModel>()) {
    on<ListenToUserConversationsEvent>(_onListenToUserConversations);
  }

  Future<void> _onListenToUserConversations(
    ListenToUserConversationsEvent event,
    Emitter<BaseState<ChatContactModel>> emit,
  ) async {
    developer.log(
      "ChatContactBloc: Listening to conversations for userId: ${event.userId}",
    );
    emit(state.copyWith(status: Status.loading));

    await emit.forEach(
      _chatContactRepository.getUserConversations(userId: event.userId),
      onData: (either) {
        return either.fold(
          (failure) {
            developer.log(
              "ChatContactBloc: Error fetching conversations: ${failure.message}",
            );
            return state.copyWith(
              status: Status.failure,
              errorMessage: failure.message,
              failure: failure,
            );
          },
          (conversations) {
            developer.log(
              "ChatContactBloc: Successfully fetched ${conversations.length} conversations",
            );
            return state.copyWith(status: Status.success, items: conversations);
          },
        );
      },
      onError: (error, stackTrace) {
        developer.log("ChatContactBloc: Stream error: $error");
        return state.copyWith(
          status: Status.failure,
          errorMessage: error.toString(),
        );
      },
    );
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
