import 'package:flutter/material.dart';

// ==========================================================
// REPLY MODEL
// ==========================================================

class Reply {
  String username;
  String userHandle;
  String text;
  String timeAgo;

  Reply({
    required this.username,
    required this.userHandle,
    required this.text,
    required this.timeAgo,
  });
}

// ==========================================================
// COMMENT MODEL
// ==========================================================

class Comment {
  String username;
  String userHandle;
  String text;
  String timeAgo;
  int likes;

  List<Reply> replies;

  Comment({
    required this.username,
    required this.userHandle,
    required this.text,
    required this.timeAgo,
    required this.likes,
    required this.replies,
  });
}

// ==========================================================
// COMMENTS SCREEN
// ==========================================================

class CommentsScreen extends StatefulWidget {
  final String recipeId;

  const CommentsScreen({
    super.key,
    required this.recipeId,
  });

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  // ========================================================
  // CONTROLLERS
  // ========================================================

  final TextEditingController commentController =
  TextEditingController();

  final TextEditingController replyController =
  TextEditingController();

  // ========================================================
  // CURRENT REPLY
  // ========================================================

  int? replyingToIndex;

  // ========================================================
  // DUMMY COMMENTS
  // ========================================================

  final List<Comment> comments = [
    Comment(
      username: 'Mariam Hassan',
      userHandle: '@mariam',
      text: 'This looks absolutely delicious! 😍',
      timeAgo: '2h',
      likes: 12,
      replies: [
        Reply(
          username: 'Noura Ahmed',
          userHandle: '@NouraChef',
          text: 'Thank you! I hope you try it ❤️',
          timeAgo: '1h',
        ),
        Reply(
          username: 'Sara Ali',
          userHandle: '@sara',
          text: 'I tried it yesterday and it was amazing!',
          timeAgo: '45m',
        ),
      ],
    ),

    Comment(
      username: 'Sara Mohamed',
      userHandle: '@saram',
      text: 'Can I use milk instead of heavy cream?',
      timeAgo: '4h',
      likes: 5,
      replies: [
        Reply(
          username: 'Noura Ahmed',
          userHandle: '@NouraChef',
          text: 'Yes, but the sauce will be a little lighter.',
          timeAgo: '3h',
        ),
      ],
    ),

    Comment(
      username: 'Aya Khaled',
      userHandle: '@ayak',
      text: 'How much parmesan did you use?',
      timeAgo: '6h',
      likes: 3,
      replies: [],
    ),

    Comment(
      username: 'Omar Ahmed',
      userHandle: '@omar',
      text: 'Adding this to my dinner list 🔥',
      timeAgo: '1d',
      likes: 8,
      replies: [],
    ),
  ];

  // ========================================================
  // ADD COMMENT
  // ========================================================

  void addComment() {
    final text = commentController.text.trim();

    if (text.isEmpty) {
      return;
    }

    setState(() {
      comments.insert(
        0,
        Comment(
          username: 'You',
          userHandle: '@you',
          text: text,
          timeAgo: 'now',
          likes: 0,
          replies: [],
        ),
      );

      commentController.clear();
    });
  }

  // ========================================================
  // START REPLY
  // ========================================================

  void startReply(int commentIndex) {
    setState(() {
      replyingToIndex = commentIndex;
    });

    // Focus the reply field.
    FocusScope.of(context).requestFocus();
  }

  // ========================================================
  // CANCEL REPLY
  // ========================================================

  void cancelReply() {
    setState(() {
      replyingToIndex = null;
      replyController.clear();
    });
  }

  // ========================================================
  // ADD REPLY
  // ========================================================

  void addReply(int commentIndex) {
    final text = replyController.text.trim();

    if (text.isEmpty) {
      return;
    }

    setState(() {
      comments[commentIndex].replies.add(
        Reply(
          username: 'You',
          userHandle: '@you',
          text: text,
          timeAgo: 'now',
        ),
      );

      replyController.clear();
      replyingToIndex = null;
    });
  }

  // ========================================================
  // LIKE COMMENT
  // ========================================================

  void likeComment(int index) {
    setState(() {
      comments[index].likes++;
    });
  }

  @override
  void dispose() {
    commentController.dispose();
    replyController.dispose();

    super.dispose();
  }

  // ========================================================
  // BUILD
  // ========================================================

  @override
  Widget build(BuildContext context) {
    final totalComments = _getTotalComments();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F4),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            // Return the current number of comments
            // to RecipeDetailsScreen.
            Navigator.pop(
              context,
              totalComments,
            );
          },
        ),

        title: const Text(
          'Comments',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
      ),

      body: Column(
        children: [
          // ==================================================
          // COMMENTS LIST
          // ==================================================

          Expanded(
            child: comments.isEmpty
                ? _emptyComments()
                : ListView.builder(
              padding: const EdgeInsets.fromLTRB(
                16,
                15,
                16,
                15,
              ),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return _commentWidget(
                  comment: comments[index],
                  index: index,
                );
              },
            ),
          ),

          // ==================================================
          // REPLY INPUT
          // ==================================================

          if (replyingToIndex != null)
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(
                16,
                8,
                16,
                0,
              ),
              child: Row(
                children: [
                  Text(
                    'Replying to @${comments[replyingToIndex!].userHandle.replaceFirst('@', '')}',
                    style: const TextStyle(
                      color: Color(0xFFFF7043),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const Spacer(),

                  IconButton(
                    onPressed: cancelReply,
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),

          // ==================================================
          // COMMENT INPUT
          // ==================================================

          Container(
            padding: const EdgeInsets.fromLTRB(
              12,
              10,
              12,
              12,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Color(0xFFE8E3DF),
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Profile image
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xFFFFE4D7),
                  child: Icon(
                    Icons.person,
                    color: Color(0xFFFF7043),
                  ),
                ),

                const SizedBox(width: 10),

                // Text field
                Expanded(
                  child: TextField(
                    controller: replyingToIndex == null
                        ? commentController
                        : replyController,
                    minLines: 1,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: replyingToIndex == null
                          ? 'Add a comment...'
                          : 'Write a reply...',
                      filled: true,
                      fillColor: const Color(0xFFF5F2F0),
                      contentPadding:
                      const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 11,
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(22),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 5),

                // Send button
                IconButton(
                  onPressed: () {
                    if (replyingToIndex == null) {
                      addComment();
                    } else {
                      addReply(replyingToIndex!);
                    }
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Color(0xFFFF7043),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ========================================================
  // COMMENT WIDGET
  // ========================================================

  Widget _commentWidget({
    required Comment comment,
    required int index,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==================================================
          // MAIN COMMENT
          // ==================================================

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User image
              const CircleAvatar(
                radius: 21,
                backgroundColor: Color(0xFFFFE4D7),
                child: Icon(
                  Icons.person,
                  color: Color(0xFFFF7043),
                ),
              ),

              const SizedBox(width: 10),

              // Comment body
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      // Username
                      Row(
                        children: [
                          Text(
                            comment.username,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),

                          const SizedBox(width: 6),

                          Text(
                            comment.userHandle,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 7),

                      // Comment text
                      Text(
                        comment.text,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Comment actions
                      Row(
                        children: [
                          Text(
                            comment.timeAgo,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),

                          const SizedBox(width: 18),

                          // Like
                          GestureDetector(
                            onTap: () {
                              likeComment(index);
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.favorite_border,
                                  size: 17,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${comment.likes}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 18),

                          // Reply
                          GestureDetector(
                            onTap: () {
                              startReply(index);
                            },
                            child: const Text(
                              'Reply',
                              style: TextStyle(
                                color: Color(0xFFFF7043),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ==================================================
          // REPLIES
          // ==================================================

          if (comment.replies.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(
                left: 50,
                top: 10,
              ),
              child: Column(
                children: [
                  for (int replyIndex = 0;
                  replyIndex < comment.replies.length;
                  replyIndex++)
                    _replyWidget(
                      comment.replies[replyIndex],
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // ========================================================
  // REPLY WIDGET
  // ========================================================

  Widget _replyWidget(Reply reply) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Small profile picture
          const CircleAvatar(
            radius: 17,
            backgroundColor: Color(0xFFFFF0E9),
            child: Icon(
              Icons.person,
              size: 18,
              color: Color(0xFFFF7043),
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F2F0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        reply.username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(width: 5),

                      Text(
                        reply.userHandle,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  Text(
                    reply.text,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    reply.timeAgo,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
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

  // ========================================================
  // EMPTY COMMENTS
  // ========================================================

  Widget _emptyComments() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 55,
            color: Colors.grey,
          ),
          SizedBox(height: 12),
          Text(
            'No comments yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Be the first to comment!',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // ========================================================
  // TOTAL COMMENTS
  // ========================================================

  int _getTotalComments() {
    int total = comments.length;

    for (final comment in comments) {
      total += comment.replies.length;
    }

    return total;
  }
}