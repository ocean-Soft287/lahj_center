import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lahijcenter/Feature/Home/chat/model/message_model.dart';
import 'package:lahijcenter/Feature/Home/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:lahijcenter/Feature/profile/manager/get_profile_cubit.dart';
import 'package:lahijcenter/Feature/profile/manager/get_profile_state.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';
import 'package:lahijcenter/core/constans/app_colors.dart';
import 'package:lahijcenter/core/utils/services/services_locator.dart';

import '../../../../core/network/local/flutter_secure_storage.dart';

class ChatScreen extends StatefulWidget {
  final String conversationId;
  final String currentUserId;
  final String receiverId;
  final String name; // other user name
  final Color avatar;
  final bool online;

  const ChatScreen({
    super.key,
    required this.conversationId,
    required this.currentUserId,
    required this.receiverId,
    required this.name,
    required this.avatar,
    required this.online,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final ChatBloc _chatBloc;

  @override
  void initState() {
    super.initState();
    _chatBloc = sl<ChatBloc>();
    _chatBloc.add(ListenToMessagesEvent(widget.conversationId));
  }

  @override
  void dispose() {
    _chatBloc.close();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (_controller.text.trim().isNotEmpty) {
      final text = _controller.text.trim();



      _chatBloc.add(
        SendMessageEvent(
          conversationId: widget.conversationId,
          senderId: widget.currentUserId,
          receiverId: widget.receiverId,
          text: text,
          senderName:await SecureStorageService.read(SecureStorageService.name)??"",
          receiverName: widget.name,
        ),
      );
      _controller.clear();
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a', 'ar').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _chatBloc,
      child: Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          shadowColor: Colors.black12,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.mainAppColor,
              size: 22,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Row(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: widget.avatar.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: widget.avatar,
                      child: Text(
                        widget.name[0],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  if (widget.online)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Color(0xFF4CAF50),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.5),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      widget.online ? 'نشط الآن' : 'غير متصل',
                      style: TextStyle(
                        color: widget.online
                            ? Color(0xFF4CAF50)
                            : Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert, color: AppColors.mainAppColor),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, BaseState<MessageModel>>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.isFailure) {
                    return Center(
                      child: Text(
                        state.errorMessage ?? 'Error loading messages',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  final messages = state.items;

                  if (messages.isEmpty) {
                    return const Center(
                      child: Text(
                        'لا توجد رسائل',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      final bool isSent = msg.senderId == widget.currentUserId;
                      final bool showAvatar =
                          index == 0 ||
                          messages[index - 1].senderId != msg.senderId;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: isSent
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (!isSent)
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: showAvatar
                                    ? CircleAvatar(
                                        radius: 16,
                                        backgroundColor: widget.avatar,
                                        child: Text(
                                          widget.name[0],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    : const SizedBox(width: 32),
                              ),
                            if (!isSent) const SizedBox(width: 8),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: isSent
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: isSent
                                          ? LinearGradient(
                                              colors: [
                                                AppColors.mainAppColor,
                                                AppColors.mainAppColor
                                                    .withValues(alpha: 0.85),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            )
                                          : null,
                                      color: isSent ? null : Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(20),
                                        topRight: const Radius.circular(20),
                                        bottomLeft: Radius.circular(
                                          isSent ? 20 : 4,
                                        ),
                                        bottomRight: Radius.circular(
                                          isSent ? 4 : 20,
                                        ),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: isSent
                                              ? AppColors.mainAppColor
                                                    .withValues(alpha: 0.3)
                                              : Colors.black.withValues(
                                                  alpha: 0.08,
                                                ),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      msg.text,
                                      style: TextStyle(
                                        color: isSent
                                            ? Colors.white
                                            : Colors.black87,
                                        fontSize: 15,
                                        height: 1.4,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    child: Text(
                                      _formatTime(msg.timestamp.toDate()),
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(26),
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                decoration: InputDecoration(
                                  hintText: 'اكتب رسالة...',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 15,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                ),
                                style: TextStyle(fontSize: 15),
                                onSubmitted: (value) => _sendMessage(),
                                textInputAction: TextInputAction.send,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.emoji_emotions_outlined,
                                color: Colors.grey[600],
                                size: 24,
                              ),
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Material(
                      color: AppColors.mainAppColor,
                      borderRadius: BorderRadius.circular(26),
                      elevation: 2,
                      shadowColor: AppColors.mainAppColor.withValues(
                        alpha: 0.4,
                      ),
                      child: InkWell(
                        onTap: _sendMessage,
                        borderRadius: BorderRadius.circular(26),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.mainAppColor,
                                AppColors.mainAppColor.withValues(alpha: 0.85),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
