import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahijcenter/Feature/Home/chat/model/chat_contact_model.dart';
import 'package:lahijcenter/Feature/Home/chat/presentation/bloc/contact/chat_contact_bloc.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';
import '../../../../core/constans/app_colors.dart';
import 'package:lahijcenter/core/utils/services/services_locator.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatefulWidget {
  final String currentUserId; // The logged-in user's ID

  const ChatListScreen({super.key, required this.currentUserId});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  late final ChatContactBloc _chatContactBloc;

  @override
  void initState() {
    log("user id is ${widget.currentUserId}");
    super.initState();
    _chatContactBloc = sl<ChatContactBloc>();
    _chatContactBloc.add(ListenToUserConversationsEvent(widget.currentUserId));
  }

  @override
  void dispose() {
    _chatContactBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _chatContactBloc,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: BlocBuilder<ChatContactBloc, BaseState<ChatContactModel>>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.isFailure) {
              return Center(
                child: Text(
                  state.errorMessage ?? 'Error loading conversations',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            final contacts = state.items;

            if (contacts.isEmpty) {
              return const Center(
                child: Text(
                  'لا توجد محادثات',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: contacts.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                thickness: 0.5,
                indent: 80,
                endIndent: 16,
                color: Colors.grey[300],
              ),
              itemBuilder: (context, index) {
                final contact = contacts[index];
                // For UI purposes, using a simple color hash based on user ID
                final avatarColor = _getColorFromString(contact.otherUserId);

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ChatScreen(
                          conversationId: contact.id ?? '',
                          currentUserId: widget.currentUserId,
                          receiverId: contact.otherUserId,
                          name: contact.otherUserName,
                          avatar: avatarColor,
                          online:
                              false, // You can add online status to the model if needed
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: avatarColor.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: avatarColor,
                                backgroundImage:
                                    contact.otherUserProfilePic != null
                                    ? NetworkImage(contact.otherUserProfilePic!)
                                    : null,
                                child: contact.otherUserProfilePic == null
                                    ? Text(
                                        contact.otherUserName[0],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                contact.otherUserName,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                contact.lastMessage,
                                style: TextStyle(
                                  color: contact.unreadCount > 0
                                      ? Colors.black87
                                      : Colors.grey[600],
                                  fontSize: 14,
                                  fontWeight: contact.unreadCount > 0
                                      ? FontWeight.w500
                                      : FontWeight.normal,
                                  height: 1.3,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              _formatTime(contact.lastMessageTime.toDate()),
                              style: TextStyle(
                                color: contact.unreadCount > 0
                                    ? AppColors.mainAppColor
                                    : Colors.grey[500],
                                fontSize: 13,
                                fontWeight: contact.unreadCount > 0
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                            if (contact.unreadCount > 0) ...[
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.all(6),
                                constraints: const BoxConstraints(minWidth: 22),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.mainAppColor,
                                      AppColors.mainAppColor,
                                    ],
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.mainAppColor,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    '${contact.unreadCount}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  // Helper to generate color from string
  Color _getColorFromString(String str) {
    final colors = [
      Colors.blue,
      Colors.pink,
      Colors.green,
      Colors.purple,
      Colors.orange,
      Colors.teal,
      Colors.indigo,
    ];
    return colors[str.hashCode % colors.length];
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'الآن';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} د';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} س';
    } else if (difference.inDays < 2) {
      return 'أمس';
    } else {
      return '${difference.inDays} يوم';
    }
  }
}
