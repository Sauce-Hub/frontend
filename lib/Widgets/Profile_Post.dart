import 'package:flutter/material.dart';
import 'package:frontend/network/image_helper.dart';

class ProfilePost extends StatelessWidget {
  final String recipeId;
  final String username;
  final String timeAgo;
  final String recipeImageUrl;
  final String title;
  final String category;

  final int likesCount;
  final int commentsCount;

  const ProfilePost({
    super.key,
    required this.recipeId,
    required this.username,
    required this.timeAgo,
    required this.recipeImageUrl,
    required this.title,
    required this.category,
    required this.likesCount,
    required this.commentsCount,
  });

  @override
  Widget build(BuildContext context) {
    final fullImageUrl = buildImageUrl(recipeImageUrl);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // IMAGE
          Expanded(
            flex: 6,
            child: Stack(
              children: [

                Positioned.fill(
                  child: Hero(
                    tag: 'recipe_$recipeId',

                    child: fullImageUrl.isNotEmpty
                        ? Image.network(
                      fullImageUrl,
                      fit: BoxFit.cover,

                      errorBuilder: (context, error, stackTrace) {
                        debugPrint('IMAGE URL: $fullImageUrl');
                        debugPrint('IMAGE ERROR: $error');
                        debugPrint('STACK: $stackTrace');

                        return _buildPlaceholder();
                      },
                    )
                        : _buildPlaceholder(),
                  ),
                ),

                // Favorite button
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      size: 19,
                      color: Color(0xFF675B57),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // INFORMATION

          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                12,
                9,
                8,
                8,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  // Category
                  Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F1F0),
                      borderRadius:
                      BorderRadius.circular(15),
                    ),
                    child: Text(
                      category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF674F47),
                      ),
                    ),
                  ),

                  const SizedBox(height: 7),

                  // Recipe name
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF24201F),
                    ),
                  ),

                  const Spacer(),

                  // Time
                  if (timeAgo.isNotEmpty)
                    Text(
                      timeAgo,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF9C8F89),
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

  Widget _buildPlaceholder() {
    return Container(
      color: const Color(0xFFFFE4D7),
      child: const Center(
        child: Icon(
          Icons.restaurant_menu,
          size: 50,
          color: Color(0xFFFF7043),
        ),
      ),
    );
  }
}