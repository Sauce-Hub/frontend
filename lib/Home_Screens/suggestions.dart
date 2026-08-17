import 'package:flutter/material.dart';

class SuggestImprovementScreen extends StatefulWidget {
  // ==========================================================
  // RECIPE INFORMATION
  // ==========================================================

  final String recipeId;

  final String recipeTitle;

  final String recipeImageUrl;

  // ==========================================================
  // AUTHOR INFORMATION
  // ==========================================================

  final String authorName;

  final String authorUsername;

  final String authorImageUrl;

  // ==========================================================
  // ORIGINAL RECIPE DATA
  // ==========================================================

  final List<Map<String, String>> ingredients;

  final List<Map<String, String>> steps;

  const SuggestImprovementScreen({
    super.key,

    required this.recipeId,

    required this.recipeTitle,

    required this.recipeImageUrl,

    required this.authorName,

    required this.authorUsername,

    required this.authorImageUrl,

    required this.ingredients,

    required this.steps,
  });

  @override
  State<SuggestImprovementScreen> createState() =>
      _SuggestImprovementScreenState();
}

class _SuggestImprovementScreenState
    extends State<SuggestImprovementScreen> {

  // ==========================================================
  // EDITABLE COPIES
  // ==========================================================
  //
  // We copy the original recipe data.
  //
  // This is VERY important.
  //
  // The user is editing their suggestion,
  // NOT the original recipe.
  // ==========================================================

  late List<Map<String, String>> ingredients;

  late List<Map<String, String>> steps;

  @override
  void initState() {
    super.initState();

    ingredients = widget.ingredients
        .map((ingredient) => Map<String, String>.from(ingredient))
        .toList();

    steps = widget.steps
        .map((step) => Map<String, String>.from(step))
        .toList();
  }

  // ==========================================================
  // SEND SUGGESTION
  // ==========================================================

  void sendSuggestion() {

    // This is the object you will eventually send to Firebase/API.
    //
    // It contains:
    // - recipe ID
    // - author
    // - suggested ingredients
    // - suggested steps
    //
    final suggestionData = {
      'recipeId': widget.recipeId,

      'authorUsername': widget.authorUsername,

      'suggestedIngredients': ingredients,

      'suggestedSteps': steps,

      'status': 'pending',

      'createdAt': DateTime.now().toIso8601String(),
    };

    // For now we only print it.
    //
    // Later you can replace this with Firebase.
    debugPrint(suggestionData.toString());

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Your suggestion has been sent to the recipe author!',
        ),
      ),
    );

    // Return to recipe details.
    Navigator.pop(context);
  }

  // ==========================================================
  // EDIT INGREDIENT
  // ==========================================================

  void editIngredient(int index) {

    final ingredient = ingredients[index];

    TextEditingController nameController =
    TextEditingController(
      text: ingredient['name'],
    );

    TextEditingController quantityController =
    TextEditingController(
      text: ingredient['quantity'],
    );

    String unit = ingredient['unit'] ?? 'g';

    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      backgroundColor: Colors.transparent,

      builder: (context) {

        return StatefulBuilder(
          builder: (context, sheetSetState) {

            return Padding(
              padding: EdgeInsets.only(
                bottom:
                MediaQuery.of(context).viewInsets.bottom,
              ),

              child: Container(
                padding: const EdgeInsets.all(20),

                decoration: const BoxDecoration(
                  color: Color(0xFFFFFAF8),

                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    const Text(
                      'Edit Ingredient',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: nameController,

                      decoration:
                      const InputDecoration(
                        labelText: 'Ingredient Name',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [

                        Expanded(
                          child: TextField(
                            controller:
                            quantityController,

                            decoration:
                            const InputDecoration(
                              labelText: 'Quantity',
                              border:
                              OutlineInputBorder(),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child:
                          DropdownButtonFormField<String>(
                            value: unit,

                            decoration:
                            const InputDecoration(
                              labelText: 'Unit',
                              border:
                              OutlineInputBorder(),
                            ),

                            items: const [

                              DropdownMenuItem(
                                value: 'g',
                                child: Text('g'),
                              ),

                              DropdownMenuItem(
                                value: 'kg',
                                child: Text('kg'),
                              ),

                              DropdownMenuItem(
                                value: 'ml',
                                child: Text('ml'),
                              ),

                              DropdownMenuItem(
                                value: 'cup',
                                child: Text('cup'),
                              ),

                              DropdownMenuItem(
                                value: 'tbsp',
                                child: Text('tbsp'),
                              ),

                              DropdownMenuItem(
                                value: 'tsp',
                                child: Text('tsp'),
                              ),

                              DropdownMenuItem(
                                value: 'piece',
                                child: Text('piece'),
                              ),
                            ],

                            onChanged: (value) {

                              if (value != null) {
                                sheetSetState(() {
                                  unit = value;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,

                      child: ElevatedButton(
                        onPressed: () {

                          if (nameController.text
                              .trim()
                              .isEmpty ||
                              quantityController.text
                                  .trim()
                                  .isEmpty) {
                            return;
                          }

                          setState(() {

                            ingredients[index] = {
                              'name':
                              nameController.text.trim(),

                              'quantity':
                              quantityController.text
                                  .trim(),

                              'unit': unit,
                            };
                          });

                          Navigator.pop(context);
                        },

                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color(0xFFBE3D00),

                          padding:
                          const EdgeInsets.symmetric(
                            vertical: 14,
                          ),

                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(25),
                          ),
                        ),

                        child: const Text(
                          'Save Change',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ==========================================================
  // ADD INGREDIENT
  // ==========================================================

  void addIngredient() {

    TextEditingController nameController =
    TextEditingController();

    TextEditingController quantityController =
    TextEditingController();

    String unit = 'g';

    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      backgroundColor: Colors.transparent,

      builder: (context) {

        return StatefulBuilder(
          builder: (context, sheetSetState) {

            return Padding(
              padding: EdgeInsets.only(
                bottom:
                MediaQuery.of(context).viewInsets.bottom,
              ),

              child: Container(
                padding: const EdgeInsets.all(20),

                decoration: const BoxDecoration(
                  color: Color(0xFFFFFAF8),

                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [

                    const Text(
                      'Add Ingredient',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: nameController,

                      decoration:
                      const InputDecoration(
                        labelText: 'Ingredient Name',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [

                        Expanded(
                          child: TextField(
                            controller:
                            quantityController,

                            decoration:
                            const InputDecoration(
                              labelText: 'Quantity',
                              border:
                              OutlineInputBorder(),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child:
                          DropdownButtonFormField<String>(
                            value: unit,

                            decoration:
                            const InputDecoration(
                              labelText: 'Unit',
                              border:
                              OutlineInputBorder(),
                            ),

                            items: const [

                              DropdownMenuItem(
                                value: 'g',
                                child: Text('g'),
                              ),

                              DropdownMenuItem(
                                value: 'kg',
                                child: Text('kg'),
                              ),

                              DropdownMenuItem(
                                value: 'ml',
                                child: Text('ml'),
                              ),

                              DropdownMenuItem(
                                value: 'cup',
                                child: Text('cup'),
                              ),

                              DropdownMenuItem(
                                value: 'tbsp',
                                child: Text('tbsp'),
                              ),

                              DropdownMenuItem(
                                value: 'tsp',
                                child: Text('tsp'),
                              ),

                              DropdownMenuItem(
                                value: 'piece',
                                child: Text('piece'),
                              ),
                            ],

                            onChanged: (value) {

                              if (value != null) {
                                sheetSetState(() {
                                  unit = value;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,

                      child: ElevatedButton(
                        onPressed: () {

                          if (nameController.text
                              .trim()
                              .isEmpty ||
                              quantityController.text
                                  .trim()
                                  .isEmpty) {
                            return;
                          }

                          setState(() {

                            ingredients.add({
                              'name':
                              nameController.text.trim(),

                              'quantity':
                              quantityController.text
                                  .trim(),

                              'unit': unit,
                            });
                          });

                          Navigator.pop(context);
                        },

                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color(0xFFBE3D00),

                          padding:
                          const EdgeInsets.symmetric(
                            vertical: 14,
                          ),

                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(25),
                          ),
                        ),

                        child: const Text(
                          'Add Ingredient',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ==========================================================
  // EDIT STEP
  // ==========================================================

  void editStep(int index) {

    TextEditingController controller =
    TextEditingController(
      text: steps[index]['description'],
    );

    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      backgroundColor: Colors.transparent,

      builder: (context) {

        return Padding(
          padding: EdgeInsets.only(
            bottom:
            MediaQuery.of(context).viewInsets.bottom,
          ),

          child: Container(
            padding: const EdgeInsets.all(20),

            decoration: const BoxDecoration(
              color: Color(0xFFFFFAF8),

              borderRadius: BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [

                const Text(
                  'Edit Step',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: controller,

                  maxLines: 5,

                  decoration: const InputDecoration(
                    labelText: 'Step Description',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(
                    onPressed: () {

                      if (controller.text
                          .trim()
                          .isEmpty) {
                        return;
                      }

                      setState(() {

                        steps[index] = {
                          'description':
                          controller.text.trim(),
                        };
                      });

                      Navigator.pop(context);
                    },

                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFFBE3D00),

                      padding:
                      const EdgeInsets.symmetric(
                        vertical: 14,
                      ),

                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(25),
                      ),
                    ),

                    child: const Text(
                      'Save Change',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==========================================================
  // ADD STEP
  // ==========================================================

  void addStep() {

    TextEditingController controller =
    TextEditingController();

    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      backgroundColor: Colors.transparent,

      builder: (context) {

        return Padding(
          padding: EdgeInsets.only(
            bottom:
            MediaQuery.of(context).viewInsets.bottom,
          ),

          child: Container(
            padding: const EdgeInsets.all(20),

            decoration: const BoxDecoration(
              color: Color(0xFFFFFAF8),

              borderRadius: BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [

                const Text(
                  'Add Cooking Step',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: controller,

                  maxLines: 5,

                  decoration: const InputDecoration(
                    labelText: 'Step Description',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(
                    onPressed: () {

                      if (controller.text
                          .trim()
                          .isEmpty) {
                        return;
                      }

                      setState(() {

                        steps.add({
                          'description':
                          controller.text.trim(),
                        });
                      });

                      Navigator.pop(context);
                    },

                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFFBE3D00),

                      padding:
                      const EdgeInsets.symmetric(
                        vertical: 14,
                      ),

                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(25),
                      ),
                    ),

                    child: const Text(
                      'Add Step',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
          'Suggest an Improvement',
          style: TextStyle(
            color: Color(0xFF302A28),
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),

        actions: [

          TextButton(
            onPressed: sendSuggestion,

            child: const Text(
              'Send',
              style: TextStyle(
                color: Color(0xFFBE3D00),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            // ==================================================
            // AUTHOR INFORMATION
            // ==================================================

            Container(
              padding: const EdgeInsets.all(14),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                BorderRadius.circular(14),
              ),

              child: Row(
                children: [

                  CircleAvatar(
                    radius: 25,

                    backgroundColor:
                    const Color(0xFFFFE7DF),

                    backgroundImage:
                    widget.authorImageUrl.isNotEmpty
                        ? NetworkImage(
                      widget.authorImageUrl,
                    )
                        : null,

                    child:
                    widget.authorImageUrl.isEmpty
                        ? const Icon(
                      Icons.person,
                      color:
                      Color(0xFFBE3D00),
                    )
                        : null,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        const Text(
                          'Suggesting an improvement for',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),

                        const SizedBox(height: 3),

                        Text(
                          widget.authorName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight:
                            FontWeight.bold,
                            color:
                            Color(0xFF302A28),
                          ),
                        ),

                        Text(
                          widget.authorUsername,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ==================================================
            // RECIPE
            // ==================================================

            const Text(
              'Recipe',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 8),

            Row(
              children: [

                ClipRRect(
                  borderRadius:
                  BorderRadius.circular(10),

                  child: Image.network(
                    widget.recipeImageUrl,

                    width: 75,
                    height: 75,

                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    widget.recipeTitle,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF302A28),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ==================================================
            // INFORMATION MESSAGE
            // ==================================================

            Container(
              padding: const EdgeInsets.all(14),

              decoration: BoxDecoration(
                color: const Color(0xFFFFEEE8),

                borderRadius:
                BorderRadius.circular(12),
              ),

              child: const Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Icon(
                    Icons.info_outline,
                    color: Color(0xFFBE3D00),
                  ),

                  SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      'Edit the recipe below to show the author what you think should be changed. The original recipe will not be changed until the author accepts your suggestion.',
                      style: TextStyle(
                        color: Color(0xFF6D4436),
                        height: 1.4,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ==================================================
            // INGREDIENTS
            // ==================================================

            const Text(
              'Suggested Ingredients',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF24201F),
              ),
            ),

            const SizedBox(height: 15),

            Column(
              children: List.generate(
                ingredients.length,

                    (index) {

                  final ingredient =
                  ingredients[index];

                  return Container(
                    margin:
                    const EdgeInsets.only(
                      bottom: 10,
                    ),

                    padding:
                    const EdgeInsets.all(12),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius:
                      BorderRadius.circular(12),
                    ),

                    child: Row(
                      children: [

                        Container(
                          width: 42,
                          height: 42,

                          decoration:
                          const BoxDecoration(
                            color:
                            Color(0xFFF5EFED),
                            shape: BoxShape.circle,
                          ),

                          child: const Icon(
                            Icons.restaurant_menu,
                            color:
                            Color(0xFF513F39),
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                            children: [

                              Text(
                                ingredient['name'] ??
                                    '',

                                style:
                                const TextStyle(
                                  fontSize: 16,
                                  color:
                                  Color(0xFF302A28),
                                  fontWeight:
                                  FontWeight.w500,
                                ),
                              ),

                              const SizedBox(height: 3),

                              Text(
                                '${ingredient['quantity']} ${ingredient['unit']}',

                                style:
                                const TextStyle(
                                  fontSize: 13,
                                  color:
                                  Color(0xFF513F39),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // EDIT
                        IconButton(
                          onPressed: () {
                            editIngredient(index);
                          },

                          icon: const Icon(
                            Icons.edit_outlined,
                            size: 19,
                          ),
                        ),

                        // DELETE
                        IconButton(
                          onPressed: () {

                            setState(() {
                              ingredients
                                  .removeAt(index);
                            });
                          },

                          icon: const Icon(
                            Icons.delete_outline,
                            size: 19,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // ADD INGREDIENT

            _addButton(
              text: 'Add Ingredient',
              icon: Icons.add,
              onPressed: addIngredient,
            ),

            const SizedBox(height: 35),

            // ==================================================
            // STEPS
            // ==================================================

            const Text(
              'Suggested Steps',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF24201F),
              ),
            ),

            const SizedBox(height: 15),

            Column(
              children: List.generate(
                steps.length,

                    (index) {

                  final step = steps[index];

                  return Container(
                    margin:
                    const EdgeInsets.only(
                      bottom: 12,
                    ),

                    padding:
                    const EdgeInsets.all(14),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius:
                      BorderRadius.circular(12),
                    ),

                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        // STEP NUMBER

                        Container(
                          width: 36,
                          height: 36,

                          decoration:
                          BoxDecoration(
                            color: index == 0
                                ? const Color(
                              0xFFFFD9CE,
                            )
                                : const Color(
                              0xFFF0ECEB,
                            ),

                            shape: BoxShape.circle,
                          ),

                          alignment:
                          Alignment.center,

                          child: Text(
                            '${index + 1}',

                            style:
                            const TextStyle(
                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // STEP TEXT

                        Expanded(
                          child: Text(
                            step['description'] ??
                                '',

                            style:
                            const TextStyle(
                              fontSize: 15,
                              height: 1.45,
                              color:
                              Color(0xFF302A28),
                            ),
                          ),
                        ),

                        // EDIT

                        IconButton(
                          onPressed: () {
                            editStep(index);
                          },

                          icon: const Icon(
                            Icons.edit_outlined,
                            size: 18,
                          ),
                        ),

                        // DELETE

                        IconButton(
                          onPressed: () {

                            setState(() {
                              steps.removeAt(index);
                            });
                          },

                          icon: const Icon(
                            Icons.delete_outline,
                            size: 18,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // ADD STEP

            _addButton(
              text: 'Add Step',
              icon: Icons.add,
              onPressed: addStep,
            ),

            const SizedBox(height: 30),

            // ==================================================
            // SEND BUTTON
            // ==================================================

            SizedBox(
              width: double.infinity,
              height: 52,

              child: ElevatedButton.icon(
                onPressed: sendSuggestion,

                icon: const Icon(
                  Icons.send_outlined,
                  color: Colors.white,
                ),

                label: const Text(
                  'Send Suggestion to Author',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                style:
                ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(0xFFBE3D00),

                  elevation: 0,

                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(27),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // ADD BUTTON
  // ==========================================================

  Widget _addButton({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
  }) {

    return SizedBox(
      width: double.infinity,

      child: OutlinedButton.icon(
        onPressed: onPressed,

        icon: Icon(
          icon,
          color: const Color(0xFFBE3D00),
        ),

        label: Text(
          text,
          style: const TextStyle(
            color: Color(0xFFBE3D00),
            fontWeight: FontWeight.w600,
          ),
        ),

        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: Color(0xFFBE3D00),
          ),

          padding:
          const EdgeInsets.symmetric(
            vertical: 13,
          ),

          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}