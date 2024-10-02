import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/commons/chat_bubble.dart';
import 'package:event_app/services/chat/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  final String recieverUserEmail;
  final String recieverUserId;

  const MessageScreen({
    super.key,
    required this.recieverUserEmail,
    required this.recieverUserId,
  });

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ScrollController _scrollController = ScrollController();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          _messageController.text, widget.recieverUserId);
      _messageController.clear();
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: theme.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.recieverUserEmail,
          style: TextStyle(color: theme.primaryColor),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: _buildMessageList(),
            ),
            _buildMessageInput(theme),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  // _buildMessageList
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.recieverUserId, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final messages = snapshot.data!.docs.reversed.toList();
        return ListView(
          controller: _scrollController,
          children:
              messages.map((document) => _buildMessageItem(document)).toList(),
        );
      },
    );
  }

  // _buildMessageItem
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data["senderId"] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        mainAxisAlignment: (data["senderId"] == _firebaseAuth.currentUser!.uid)
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        crossAxisAlignment: (data["senderId"] == _firebaseAuth.currentUser!.uid)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            data["senderEmail"],
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 5,
          ),
          ChatBubble(message: data["message"]),
        ],
      ),
    );
  }

  // _buildMessageInput
  Widget _buildMessageInput(theme) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            onFieldSubmitted: (_) => sendMessage,
            controller: _messageController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              fillColor: Colors.grey.withOpacity(0.4),
              filled: true,
              hintStyle: const TextStyle(color: Colors.grey),
              hintText: 'Send Message...',
              prefixIcon: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.send,
            color: theme.iconTheme.color,
          ),
          onPressed: sendMessage,
        ),
      ],
    );
  }
}
