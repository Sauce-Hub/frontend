import 'dart:async';
import 'package:flutter/material.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Hi! 👋 I'm Sauce Hub's assistant.\n\n"
          "I can help you find recipes, suggest ingredients, "
          "or give you cooking ideas. What are you looking for?",
      isUser: false,
    ),
  ];

  bool _isLoading = false;

  // App Theme
  static const Color primaryColor = Color(0xFFF97316);
  static const Color secondaryColor = Color(0xFFFBBF24);
  static const Color backgroundColor = Color(0xFFFFF8F2);
  static const Color textColor = Color(0xFF1F2937);
  static const Color botBubbleColor = Color(0xFFFFFFFF);

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // --------------------------------------------------
  // MOCK FUNCTION
  // --------------------------------------------------
  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();

    if (text.isEmpty || _isLoading) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          isUser: true,
        ),
      );

      _messageController.clear();
      _isLoading = true;
    });

    _scrollToBottom();

    // Mock AI response
    await Future.delayed(const Duration(seconds: 1));

    String botResponse;

    if (text.toLowerCase().contains('chicken') ||
        text.contains('فراخ') ||
        text.contains('فراخ')) {
      botResponse =
          "You can try a delicious chicken pasta! 🍝\n\n"
          "You'll need chicken, pasta, cream, garlic and "
          "some Parmesan cheese.";
    } else if (text.toLowerCase().contains('pasta') ||
        text.contains('مكرونة')) {
      botResponse =
          "How about a creamy pasta? 😋\n\n"
          "You can make it with pasta, cream, garlic, "
          "Parmesan and black pepper.";
    } else if (text.toLowerCase().contains('breakfast') ||
        text.contains('فطار')) {
      botResponse =
          "For breakfast, you could try scrambled eggs "
          "with avocado toast 🥑🍳";
    } else {
      botResponse =
          "That sounds delicious! 😋\n\n"
          "Tell me what ingredients you have, and I'll "
          "help you come up with a recipe.";
    }

    if (!mounted) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: botResponse,
          isUser: false,
        ),
      );

      _isLoading = false;
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,

        leading:Icon(Icons.smart_toy, color: (primaryColor),),

        title: const Text(
          'Sauce Hub',
          style: TextStyle(
            color: primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [
          // Chatbot Header
          _buildBotHeader(),

          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              itemCount: _messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isLoading) {
                  return _buildTypingIndicator();
                }

                final message = _messages[index];

                return _buildMessageBubble(message);
              },
            ),
          ),

          // Input Area
          _buildMessageInput(),
        ],
      ),
    );
  }

  // --------------------------------------------------
  // BOT HEADER
  // --------------------------------------------------

  Widget _buildBotHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child:  Image.asset(
              'assets/Logo.png',
            ),
          ),

          const SizedBox(width: 12),

          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sauce Assistant',
                style: TextStyle(
                  color: textColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 3),

              Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 8,
                    color: Color(0xFF22C55E),
                  ),

                  SizedBox(width: 5),

                  Text(
                    'Online',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------
  // MESSAGE BUBBLE
  // --------------------------------------------------

  Widget _buildMessageBubble(ChatMessage message) {
    final isUser = message.isUser;

    return Align(
      alignment:
          isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),

        margin: EdgeInsets.only(
          left: isUser ? 50 : 0,
          right: isUser ? 0 : 50,
          bottom: 12,
        ),

        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),

        decoration: BoxDecoration(
          color: isUser ? primaryColor : botBubbleColor,

          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isUser ? 18 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 18),
          ),

          boxShadow: [
            if (!isUser)
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
          ],
        ),

        child: Text(
          message.text,
          style: TextStyle(
            color: isUser ? Colors.white : textColor,
            fontSize: 15,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------
  // TYPING INDICATOR
  // --------------------------------------------------

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(
          right: 50,
          bottom: 12,
        ),

        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 14,
        ),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),

        child: const SizedBox(
          width: 35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Dot(),
              _Dot(),
              _Dot(),
            ],
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------
  // MESSAGE INPUT
  // --------------------------------------------------

  Widget _buildMessageInput() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          12,
          10,
          12,
          10,
        ),

        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color(0xFFF1F1F1),
            ),
          ),
        ),

        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,

                textInputAction: TextInputAction.send,

                onSubmitted: (_) {
                  _sendMessage();
                },

                decoration: InputDecoration(
                  hintText: 'Ask me about recipes...',

                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),

                  filled: true,
                  fillColor: backgroundColor,

                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 13,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: primaryColor,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            GestureDetector(
              onTap: _sendMessage,

              child: Container(
                width: 48,
                height: 48,

                decoration: const BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 21,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --------------------------------------------------
// MESSAGE MODEL
// --------------------------------------------------

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({
    required this.text,
    required this.isUser,
  });
}

// --------------------------------------------------
// TYPING DOT
// --------------------------------------------------

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: const BoxDecoration(
        color: Color(0xFFF97316),
        shape: BoxShape.circle,
      ),
    );
  }
}