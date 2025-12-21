import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lahijcenter/core/constans/app_colors.dart';

class ChatListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> chats = [
    {
      'name': 'أحمد محمد',
      'lastMessage': 'تمام هكلمك بكره',
      'time': '5 د',
      'unread': 2,
      'avatar': Colors.blue,
      'online': true,
    },
    {
      'name': 'سارة علي',
      'lastMessage': 'شكراً جداً 😊',
      'time': '١٥ د',
      'unread': 0,
      'avatar': Colors.pink,
      'online': true,
    },
    {
      'name': 'محمود حسن',
      'lastMessage': 'ماشي هشوفك بعدين',
      'time': '١ س',
      'unread': 0,
      'avatar': Colors.green,
      'online': false,
    },
    {
      'name': 'مريم يوسف',
      'lastMessage': 'انت فين دلوقتي؟',
      'time': '٢ س',
      'unread': 5,
      'avatar': Colors.purple,
      'online': false,
    },
    {
      'name': 'كريم عادل',
      'lastMessage': 'تمام كده',
      'time': 'أمس',
      'unread': 0,
      'avatar': Colors.orange,
      'online': false,
    },
  ];

  ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      // appBar: AppBar(
      //   backgroundColor: AppColors.mainAppColor,
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     icon: Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.white,
      //       size: 22,
      //     ),
      //   ),
      //   elevation: 2,
      //   shadowColor: Colors.black26,
      //   centerTitle: true,
      //   title: Text(
      //     'الرسائل',
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontSize: 22,
      //       fontWeight: FontWeight.w700,
      //       letterSpacing: 0.5,
      //     ),
      //   ),
      //   actions: [
      //     Container(
      //       margin: EdgeInsets.only(left: 8),
      //       child: IconButton(
      //         onPressed: () {},
      //         icon: Icon(
      //           Icons.search,
      //           color: Colors.white,
      //           size: 26,
      //         ),
      //       ),
      //     ),

     // ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 8),
        itemCount: chats.length,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          thickness: 0.5,
          indent: 80,
          endIndent: 16,
          color: Colors.grey[300],
        ),
        itemBuilder: (context, index) {
          final chat = chats[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ChatScreen(
                    name: chat['name'],
                    avatar: chat['avatar'],
                    online: chat['online'],
                  ),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                              color: chat['avatar'].withOpacity(0.3),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: chat['avatar'],
                          child: Text(
                            chat['name'][0],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      if (chat['online'])
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Color(0xFF4CAF50),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chat['name'],
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            letterSpacing: 0.2,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          chat['lastMessage'],
                          style: TextStyle(
                            color: chat['unread'] > 0
                                ? Colors.black87
                                : Colors.grey[600],
                            fontSize: 14,
                            fontWeight: chat['unread'] > 0
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
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        chat['time'],
                        style: TextStyle(
                          color: chat['unread'] > 0
                              ? AppColors.mainAppColor
                              : Colors.grey[500],
                          fontSize: 13,
                          fontWeight: chat['unread'] > 0
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                      if (chat['unread'] > 0) ...[
                        SizedBox(height: 6),
                        Container(
                          padding: EdgeInsets.all(6),
                          constraints: BoxConstraints(minWidth: 22),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.mainAppColor,
                                AppColors.mainAppColor.withValues(alpha: 0.8),
                              ],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.mainAppColor.withValues(alpha:0.4),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              '${chat['unread']}',
                              style: TextStyle(
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
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String name;
  final Color avatar;
  final bool online;

  const ChatScreen({
    super.key,
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
  final List<Map<String, dynamic>> messages = [
    {'text': 'أهلاً، عامل ايه؟', 'isSent': false, 'time': '10:30 ص'},
    {'text': 'تمام الحمد لله، انت عامل ايه؟', 'isSent': true, 'time': '10:32 ص'},
    {'text': 'كويس، عاوزك في موضوع', 'isSent': false, 'time': '10:33 ص'},
    {'text': 'اتفضل، قول', 'isSent': true, 'time': '10:35 ص'},
    {'text': 'ممكن نتقابل بكره؟', 'isSent': false, 'time': '10:36 ص'},
    {'text': 'أكيد، الساعة كام؟', 'isSent': true, 'time': '10:37 ص'},
  ];

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        messages.add({
          'text': _controller.text,
          'isSent': true,
          'time': TimeOfDay.now().format(context),
        });
      });
      _controller.clear();
      Future.delayed(Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black12,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.mainAppColor, size: 22),
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
                        color: widget.avatar.withValues(alpha:0.3),
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
                      color: widget.online ? Color(0xFF4CAF50) : Colors.grey[600],
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
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final bool showAvatar = index == 0 ||
                    messages[index - 1]['isSent'] != msg['isSent'];

                return Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: msg['isSent']
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (!msg['isSent'])
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: showAvatar
                              ? CircleAvatar(
                            radius: 16,
                            backgroundColor: widget.avatar,
                            child: Text(
                              widget.name[0],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                              : SizedBox(width: 32),
                        ),
                      if (!msg['isSent']) SizedBox(width: 8),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: msg['isSent']
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                gradient: msg['isSent']
                                    ? LinearGradient(
                                  colors: [
                                    AppColors.mainAppColor,
                                    AppColors.mainAppColor.withValues(alpha:0.85),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                                    : null,
                                color: msg['isSent'] ? null : Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(msg['isSent'] ? 20 : 4),
                                  bottomRight: Radius.circular(msg['isSent'] ? 4 : 20),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: msg['isSent']
                                        ? AppColors.mainAppColor.withValues(alpha:0.3)
                                        : Colors.black.withValues(alpha:0.08),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                msg['text'],
                                style: TextStyle(
                                  color: msg['isSent'] ? Colors.white : Colors.black87,
                                  fontSize: 15,
                                  height: 1.4,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                msg['time'],
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
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.08),
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
                      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 2),
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
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                              ),
                              style: TextStyle(fontSize: 15),
                              onSubmitted: (value) => _sendMessage(),
                              textInputAction: TextInputAction.send,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.emoji_emotions_outlined,
                                color: Colors.grey[600], size: 24),
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
                    shadowColor: AppColors.mainAppColor.withValues(alpha:0.4),
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
                              AppColors.mainAppColor.withValues(alpha:0.85),
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
    );
  }
}