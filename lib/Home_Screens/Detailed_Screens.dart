import 'package:flutter/material.dart';
import 'package:frontend/Home_Screens/Comments_Screen.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final String recipeId;
  final String username;
  final String timeAgo;
  final String recipeImageUrl;
  final String title;
  final String category;
  final String ingerdiants;
  final String instructions;
  final int likesCount;
  final int commentsCount;

  const RecipeDetailsScreen({
    super.key,
    required this.recipeId,
    required this.username,
    required this.timeAgo,
    required this.recipeImageUrl,
    required this.title,
    required this.category,
    required this.ingerdiants,
    required this.instructions,
    required this.likesCount,
    required this.commentsCount,
  });

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  bool isLiked = false;
  bool isSaved = false;
  bool showCommentField = false;

  late int currentLikes;
  late int currentComments;

  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    currentLikes = widget.likesCount;
    currentComments = widget.commentsCount;
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;

      if (isLiked) {
        currentLikes++;
      } else {
        currentLikes--;
      }
    });
  }

  void toggleSave() {
    setState(() {
      isSaved = !isSaved;
    });
  }


  void addComment() {
    if (commentController.text.trim().isEmpty) {
      return;
    }

    setState(() {
      currentComments++;
      commentController.clear();
      showCommentField = false;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Comment added')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F2),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        actions: [
          IconButton(
            icon: Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: isSaved ? Colors.amber : Colors.black,
            ),
            onPressed: toggleSave,
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Image
            Hero(
              tag: 'recipe_${widget.recipeId}',
              child: Image.network(
                widget.recipeImageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // User
                  Row(
                    children: [
                      Icon(Icons.person_2_outlined, color: Color(0xFFF97316),),

                      const SizedBox(width: 10),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.username,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),

                          Text(
                            widget.timeAgo,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Category
                  Text(
                    widget.category,
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),

                  const SizedBox(height: 20),

                  // Actions
                  Row(
                    children: [
                      // LIKE
                      IconButton(
                        onPressed: toggleLike,
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.grey,
                          size: 28,
                        ),
                      ),

                      Text(
                        '$currentLikes',
                        style: const TextStyle(fontSize: 16),
                      ),

                      const SizedBox(width: 25),

                      // COMMENT
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                        context,
                          MaterialPageRoute(
                         builder: (context) => CommentsScreen(),
                           ),
                      );
                        },
                        icon: const Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.grey,
                          size: 27,
                        ),
                      ),

                      Text(
                        '$currentComments',
                        style: const TextStyle(fontSize: 16),
                      ),

                      const Spacer(),

                      // SAVE
                      IconButton(
                        onPressed: toggleSave,
                        icon: Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_border,
                          color: isSaved ? Colors.amber : Colors.grey,
                          size: 28,
                        ),
                      ),
                    ],
                  ),

                  // COMMENT TEXT FIELD
                  if (showCommentField) ...[
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: commentController,
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: 'Write a comment...',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        IconButton(
                          onPressed: addComment,
                          icon: const Icon(
                            Icons.send,
                            color: Color(0xFFF97316),
                          ),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: 30),

                  // Ingredients
                  const Text(
                    'Ingredients',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),
                  Text(
                    widget.ingerdiants,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(height: 25),

                  //instructions
                  const Text(
                    'Instructions',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    widget.instructions,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}