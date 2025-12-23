import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/Home/chat/model/chat_contact_model.dart';
import 'package:lahijcenter/Feature/Home/chat/repo/chat_contact_repositry.dart';
import 'package:lahijcenter/core/Failure/failure.dart';
import 'package:lahijcenter/core/firebase/firebase.dart';

class ChatContactRepositoryImpl implements ChatContactRepository {
  final FirebaseConsumer _firebaseConsumer;

  const ChatContactRepositoryImpl(this._firebaseConsumer);

  @override
  Stream<Either<Failure, List<ChatContactModel>>> getUserConversations({
    required String userId,
  }) {
    return _firebaseConsumer.getCollection<ChatContactModel>(
      path: 'userConversations/$userId',
      fromJson: ChatContactModel.fromJson,
      orderBy: 'lastMessageTime',
      descending: true,
    );
  }
}
