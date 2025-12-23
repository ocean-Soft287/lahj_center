import 'dart:async';

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
    emit(state.copyWith(status: Status.loading));

    await emit.forEach(
      _chatContactRepository.getUserConversations(userId: event.userId),
      onData: (either) {
        return either.fold(
          (failure) => state.copyWith(
            status: Status.failure,
            errorMessage: failure.message,
            failure: failure,
          ),
          (conversations) =>
              state.copyWith(status: Status.success, items: conversations),
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

  @override
  Future<void> close() {
    return super.close();
  }
}
