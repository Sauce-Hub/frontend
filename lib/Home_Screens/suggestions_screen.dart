import 'package:flutter/material.dart';
import 'package:frontend/Service/suggestion_service.dart';
import 'package:frontend/network/image_helper.dart';

class SuggestionsScreen extends StatefulWidget {
  final String recipeId;
  final String recipeTitle;
  final String recipeImageUrl;

  const SuggestionsScreen({
    super.key,
    required this.recipeId,
    required this.recipeTitle,
    required this.recipeImageUrl,
  });

  @override
  State<SuggestionsScreen> createState() =>
      _SuggestionsScreenState();
}

class _SuggestionsScreenState
    extends State<SuggestionsScreen> {
  final SuggestionService _suggestionService =
  SuggestionService();

  List<dynamic> suggestions = [];

  bool isLoading = true;
  int? approvingSuggestionId;

  @override
  void initState() {
    super.initState();
    loadSuggestions();
  }

  // ==========================================================
  // LOAD SUGGESTIONS
  // ==========================================================

  Future<void> loadSuggestions() async {
    try {
      setState(() {
        isLoading = true;
      });

      final result =
      await _suggestionService.getSuggestions(
        recipeId: int.parse(widget.recipeId),
      );

      if (!mounted) return;

      setState(() {
        suggestions = result;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to load suggestions: $e',
          ),
        ),
      );
    }
  }

  // ==========================================================
  // ACCEPT SUGGESTION
  // ==========================================================

  Future<void> acceptSuggestion(
      Map<String, dynamic> suggestion,
      ) async {
    final suggestionId =
    int.tryParse(
      suggestion['suggestion_id']?.toString() ??
          suggestion['id']?.toString() ??
          '',
    );

    if (suggestionId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Invalid suggestion ID.',
          ),
        ),
      );
      return;
    }

    // Confirmation dialog
    final shouldAccept =
    await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Accept Suggestion?',
          ),
          content: const Text(
            'This will replace the current ingredients '
                'and cooking steps of your recipe with the '
                'suggested version.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text(
                'Cancel',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                const Color(0xFFBE3D00),
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Accept',
              ),
            ),
          ],
        );
      },
    );

    if (shouldAccept != true) return;

    try {
      setState(() {
        approvingSuggestionId = suggestionId;
      });

      await _suggestionService.approveSuggestion(
        suggestionId: suggestionId,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Suggestion accepted! Your recipe has been updated.',
          ),
        ),
      );

      // Tell the previous screen that
      // the recipe was changed.
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        approvingSuggestionId = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to accept suggestion: $e',
          ),
        ),
      );
    }
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F7),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF9F7),
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF513F39),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Suggestions',
          style: TextStyle(
            color: Color(0xFF302A28),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFBE3D00),
        ),
      )
          : suggestions.isEmpty
          ? _emptyState()
          : RefreshIndicator(
        color: const Color(0xFFBE3D00),
        onRefresh: loadSuggestions,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _recipeHeader(),

            const SizedBox(height: 25),

            const Text(
              'Suggestions from your community',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF302A28),
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Review the suggestions below and '
                  'accept the ones you think improve your recipe.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 20),

            ...suggestions.map(
                  (suggestion) {
                return Padding(
                  padding:
                  const EdgeInsets.only(
                    bottom: 18,
                  ),
                  child: _suggestionCard(
                    suggestion:
                    Map<String, dynamic>.from(
                      suggestion,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // RECIPE HEADER
  // ==========================================================

  Widget _recipeHeader() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius:
            BorderRadius.circular(12),
            child: Image.network(
              buildImageUrl(widget.recipeImageUrl),
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) {
                return Container(
                  width: 70,
                  height: 70,
                  color: const Color(0xFFFFE7DF),
                  child: const Icon(
                    Icons.restaurant,
                    color: Color(0xFFBE3D00),
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Recipe',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  widget.recipeTitle,
                  maxLines: 2,
                  overflow:
                  TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF302A28),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // SUGGESTION CARD
  // ==========================================================

  Widget _suggestionCard({
    required Map<String, dynamic> suggestion,
  }) {
    final suggestionId =
    int.tryParse(
      suggestion['suggestion_id']?.toString() ??
          suggestion['id']?.toString() ??
          '',
    );

    final text =
        suggestion['text']?.toString() ?? '';

    final ingredients =
    suggestion['ingredients'] is List
        ? List<dynamic>.from(
      suggestion['ingredients'],
    )
        : <dynamic>[];

    final instructions =
    suggestion['instructions'] is List
        ? List<dynamic>.from(
      suggestion['instructions'],
    )
        : <dynamic>[];

    final user =
        suggestion['user'] ??
            suggestion['sender'] ??
            {};

    final username =
    user is Map
        ? user['username']?.toString() ??
        user['name']?.toString() ??
        'User'
        : 'User';

    final userImage =
    user is Map
        ? user['image_url']?.toString() ??
        user['image']?.toString() ??
        ''
        : '';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE9DFDB),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            // ==================================================
            // USER
            // ==================================================

            Row(
              children: [
                CircleAvatar(
                  radius: 23,
                  backgroundColor:
                  const Color(0xFFFFE7DF),
                  backgroundImage:
                  userImage.isNotEmpty
                      ? NetworkImage(
                    buildImageUrl(
                      userImage,
                    ),
                  )
                      : null,
                  child: userImage.isEmpty
                      ? const Icon(
                    Icons.person,
                    color:
                    Color(0xFFBE3D00),
                  )
                      : null,
                ),

                const SizedBox(width: 11),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style:
                        const TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 2),

                      const Text(
                        'Suggested an improvement',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // ==================================================
            // MESSAGE
            // ==================================================

            if (text.isNotEmpty) ...[
              const Text(
                'Suggestion',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF302A28),
                ),
              ),

              const SizedBox(height: 8),

              Container(
                width: double.infinity,
                padding:
                const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color:
                  const Color(0xFFFFF3EE),
                  borderRadius:
                  BorderRadius.circular(12),
                ),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Color(0xFF513F39),
                    height: 1.45,
                    fontSize: 14,
                  ),
                ),
              ),
            ],

            // ==================================================
            // INGREDIENTS
            // ==================================================

            if (ingredients.isNotEmpty) ...[
              const SizedBox(height: 20),

              const Text(
                'Suggested Ingredients',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF302A28),
                ),
              ),

              const SizedBox(height: 10),

              ...ingredients.map(
                    (ingredient) {
                  final item =
                  Map<String, dynamic>.from(
                    ingredient,
                  );

                  final name =
                      item['name']?.toString() ??
                          '';

                  final quantity =
                      item['quantity']
                          ?.toString() ??
                          '';

                  final unit =
                      item['unit']?.toString() ??
                          '';

                  return Padding(
                    padding:
                    const EdgeInsets.only(
                      bottom: 8,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons
                              .restaurant_menu,
                          size: 18,
                          color:
                          Color(0xFFBE3D00),
                        ),

                        const SizedBox(width: 9),

                        Expanded(
                          child: Text(
                            name,
                            style:
                            const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),

                        Text(
                          '$quantity $unit',
                          style:
                          const TextStyle(
                            color:
                            Color(0xFF65615E),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],

            // ==================================================
            // STEPS
            // ==================================================

            if (instructions.isNotEmpty) ...[
              const SizedBox(height: 20),

              const Text(
                'Suggested Steps',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF302A28),
                ),
              ),

              const SizedBox(height: 10),

              ...List.generate(
                instructions.length,
                    (index) {
                  final instruction =
                  Map<String, dynamic>.from(
                    instructions[index],
                  );

                  final description =
                      instruction['instruction']
                          ?.toString() ??
                          instruction[
                          'description']
                              ?.toString() ??
                          '';

                  return Padding(
                    padding:
                    const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration:
                          const BoxDecoration(
                            color:
                            Color(0xFFFFD9CE),
                            shape:
                            BoxShape.circle,
                          ),
                          alignment:
                          Alignment.center,
                          child: Text(
                            '${index + 1}',
                            style:
                            const TextStyle(
                              fontWeight:
                              FontWeight.bold,
                              color:
                              Color(0xFF513F39),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Text(
                            description,
                            style:
                            const TextStyle(
                              fontSize: 14,
                              height: 1.4,
                              color:
                              Color(0xFF383432),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],

            const SizedBox(height: 20),

            // ==================================================
            // ACCEPT
            // ==================================================

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed:
                approvingSuggestionId ==
                    suggestionId
                    ? null
                    : () {
                  acceptSuggestion(
                    suggestion,
                  );
                },
                icon:
                approvingSuggestionId ==
                    suggestionId
                    ? const SizedBox(
                  width: 19,
                  height: 19,
                  child:
                  CircularProgressIndicator(
                    strokeWidth: 2,
                    color:
                    Colors.white,
                  ),
                )
                    : const Icon(
                  Icons.check,
                ),
                label: Text(
                  approvingSuggestionId ==
                      suggestionId
                      ? 'Accepting...'
                      : 'Accept Suggestion',
                ),
                style:
                ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(0xFFBE3D00),
                  disabledBackgroundColor:
                  const Color(0xFFBE3D00)
                      .withOpacity(.6),
                  foregroundColor:
                  Colors.white,
                  elevation: 0,
                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(
                      25,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // EMPTY STATE
  // ==========================================================

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration:
              const BoxDecoration(
                color: Color(0xFFFFE7DF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.lightbulb_outline,
                size: 45,
                color: Color(0xFFBE3D00),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'No Suggestions Yet',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF302A28),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'When someone suggests an improvement '
                  'to your recipe, it will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}