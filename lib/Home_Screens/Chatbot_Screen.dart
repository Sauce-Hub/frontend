import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/network/chatbot_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _messageController =
      TextEditingController();

  final ScrollController _scrollController = ScrollController();

  final ChatService _chatService = ChatService();

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
  // SEND MESSAGE
  // --------------------------------------------------

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();

    if (text.isEmpty || _isLoading) {
      return;
    }

    // Add user's message
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

    try {
      // Call backend
      final prefs = await SharedPreferences.getInstance();
final userId = prefs.getInt('user_id');

print('CHAT USER ID: $userId');
print('CHAT MESSAGE: $text');


if (userId == null) {
  print('User ID not found');
  if (!mounted) return;

  setState(() {
    _messages.add(
      ChatMessage(
        text: 'User information not found. Please login again.',
        isUser: false,
      ),
    );
    _isLoading = false;
  });

  _scrollToBottom();
  return;
}
      final Response response =
          await _chatService.exploreChatResponse(
            userId: userId,
           userPrompt: text,
          );

      // Extract bot response
      final String botResponse = _extractBotResponse(response.data);

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
    } on DioException catch (e) {
      if (!mounted) return;

      String errorMessage;

      if (e.response?.statusCode == 400) {
        errorMessage =
            'Invalid request. Please check your message and try again.';
      } else if (e.response?.statusCode == 401) {
        errorMessage =
            'You are not authorized. Please login again.';
      } else if (e.response?.statusCode == 404) {
        errorMessage =
            'Chatbot endpoint was not found. Please check the API endpoint.';
      } else if (e.response?.statusCode == 500) {
        errorMessage =
            'The server encountered an error. Please try again later.';
      } else {
        errorMessage =
            'Something went wrong. Please check your connection and try again.';
      }

      setState(() {
        _messages.add(
          ChatMessage(
            text: errorMessage,
            isUser: false,
          ),
        );

        _isLoading = false;
      });

      _scrollToBottom();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _messages.add(
          ChatMessage(
            text: 'Something went wrong. Please try again.',
            isUser: false,
          ),
        );

        _isLoading = false;
      });

      _scrollToBottom();
    }
  }

  // --------------------------------------------------
  // EXTRACT RESPONSE
  // --------------------------------------------------

  String _extractBotResponse(dynamic data) {
    if (data == null) {
      return 'I received an empty response from the server.';
    }

    // If backend returns a String directly
    if (data is String) {
      return data;
    }

    // If backend returns JSON
    if (data is Map) {
      // Try the most common response keys
      if (data['response'] != null) {
        return data['response'].toString();
      }

      if (data['message'] != null) {
        return data['message'].toString();
      }

      if (data['reply'] != null) {
        return data['reply'].toString();
      }

      if (data['answer'] != null) {
        return data['answer'].toString();
      }

      if (data['data'] != null) {
        final nestedData = data['data'];

        if (nestedData is String) {
          return nestedData;
        }

        if (nestedData is Map) {
          if (nestedData['response'] != null) {
            return nestedData['response'].toString();
          }

          if (nestedData['message'] != null) {
            return nestedData['message'].toString();
          }

          if (nestedData['reply'] != null) {
            return nestedData['reply'].toString();
          }

          if (nestedData['answer'] != null) {
            return nestedData['answer'].toString();
          }
        }
      }

      return data.toString();
    }

    return data.toString();
  }

  // --------------------------------------------------
  // SCROLL TO BOTTOM
  // --------------------------------------------------

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

  // --------------------------------------------------
  // BUILD
  // --------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,

        leading: const Icon(
          Icons.smart_toy,
          color: primaryColor,
        ),

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
          // Bot Header
          _buildBotHeader(),

          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,

              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),

              itemCount:
                  _messages.length + (_isLoading ? 1 : 0),

              itemBuilder: (context, index) {
                if (index == _messages.length && _isLoading) {
                  return _buildTypingIndicator();
                }

                final message = _messages[index];

                return _buildMessageBubble(message);
              },
            ),
          ),

          // Input
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

      padding: const EdgeInsets.fromLTRB(
        20,
        10,
        20,
        16,
      ),

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

            child: Image.asset(
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
    final bool isUser = message.isUser;

    return Align(
      alignment:
          isUser ? Alignment.centerRight : Alignment.centerLeft,

      child: Container(
        constraints: BoxConstraints(
          maxWidth:
              MediaQuery.of(context).size.width * 0.78,
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
          color:
              isUser ? primaryColor : botBubbleColor,

          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),

            bottomLeft:
                Radius.circular(isUser ? 18 : 4),

            bottomRight:
                Radius.circular(isUser ? 4 : 18),
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
            color:
                isUser ? Colors.white : textColor,

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

          borderRadius:
              BorderRadius.circular(18),

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
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

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

                textInputAction:
                    TextInputAction.send,

                enabled: !_isLoading,

                onSubmitted: (_) {
                  _sendMessage();
                },

                decoration: InputDecoration(
                  hintText:
                      'Ask me about recipes...',

                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),

                  filled: true,

                  fillColor: backgroundColor,

                  contentPadding:
                      const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 13,
                  ),

                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(25),

                    borderSide: BorderSide.none,
                  ),

                  enabledBorder:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(25),

                    borderSide: BorderSide.none,
                  ),

                  focusedBorder:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(25),

                    borderSide:
                        const BorderSide(
                      color: primaryColor,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            GestureDetector(
              onTap:
                  _isLoading ? null : _sendMessage,

              child: Container(
                width: 48,
                height: 48,

                decoration: BoxDecoration(
                  color: _isLoading
                      ? Colors.grey
                      : primaryColor,

                  shape: BoxShape.circle,
                ),

                child: _isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(14),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
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