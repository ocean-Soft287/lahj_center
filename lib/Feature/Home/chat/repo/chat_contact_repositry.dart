import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/Home/chat/model/chat_contact_model.dart';
import 'package:lahijcenter/core/Failure/failure.dart';

abstract interface class ChatContactRepository {
  /// Get user conversations stream
  Stream<Either<Failure, List<ChatContactModel>>> getUserConversations({
    required String userId,
  });
}
