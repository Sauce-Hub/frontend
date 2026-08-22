import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:frontend/Service/post_service.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final PostService _postService = PostService();

  final TextEditingController recipeNameController =
  TextEditingController();

  final TextEditingController captionController =
  TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  File? selectedImage;

  bool isPosting = false;

  final List<String> categories = [
    'BREAKFAST',
    'LUNCH',
    'DINNER',
    'DESSERT',
    'SNACK',
    'ITALIAN',
    'MEXICAN',
    'ASIAN',
  ];

  String selectedCategory = 'DINNER';

  final List<Map<String, String>> ingredients = [];

  final List<String> steps = [ ];

  @override
  void dispose() {
    recipeNameController.dispose();
    captionController.dispose();
    super.dispose();
  }

  // ============================================================
  // IMAGE
  // ============================================================

  Future<void> _pickImage() async {
    try {
      final XFile? image =
      await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1200,
      );

      if (image == null) return;

      setState(() {
        selectedImage = File(image.path);
      });
    } catch (e) {
      _showMessage(
        'Could not select the image.',
        isError: true,
      );
    }
  }

  void _removeImage() {
    setState(() {
      selectedImage = null;
    });
  }

  // CREATE POST
  Future<void> _createPost() async {
    if (isPosting) return;

    final name =
    recipeNameController.text.trim();

    final caption =
    captionController.text.trim();

    // VALIDATION
    if (selectedImage == null) {
      _showMessage(
        'Please add a recipe photo.',
        isError: true,
      );
      return;
    }

    if (name.isEmpty) {
      _showMessage(
        'Please enter a recipe name.',
        isError: true,
      );
      return;
    }

    if (caption.isEmpty) {
      _showMessage(
        'Please enter a caption.',
        isError: true,
      );
      return;
    }

    if (ingredients.isEmpty) {
      _showMessage(
        'Please add at least one ingredient.',
        isError: true,
      );
      return;
    }

    if (steps.isEmpty) {
      _showMessage(
        'Please add at least one cooking step.',
        isError: true,
      );
      return;
    }

    setState(() {
      isPosting = true;
    });

    try {
      final imageFile = await MultipartFile.fromFile(
        selectedImage!.path,
        filename: selectedImage!.path
            .split(Platform.pathSeparator)
            .last,
      );

      await _postService.createPost(
        name: name,
        caption: caption,
        category: selectedCategory,

        ingredients: ingredients.map((ingredient) {
          return {
            'name': ingredient['name']!,
            'quantity': _parseQuantity(
              ingredient['quantity']!,
            ),
            'unit': ingredient['unit']!,
          };
        }).toList(),

        instructions: List<String>.from(steps),

        image: imageFile,
      );

      if (!mounted) return;

      _showMessage(
        'Recipe posted successfully!',
      );

      await Future.delayed(
        const Duration(milliseconds: 700),
      );

      if (!mounted) return;

      // true tells ProfileScreen to reload
      Navigator.pop(context, true);
    } on DioException catch (e) {
      if (!mounted) return;

      debugPrint(
        'POST ERROR STATUS: ${e.response?.statusCode}',
      );

      debugPrint(
        'POST ERROR DATA: ${e.response?.data}',
      );

      _showMessage(
        _getDioErrorMessage(e),
        isError: true,
      );
    } catch (e) {
      if (!mounted) return;

      _showMessage(
        'Something went wrong while posting.',
        isError: true,
      );
    } finally {
      if (mounted) {
        setState(() {
          isPosting = false;
        });
      }
    }
  }

  // ============================================================
  // QUANTITY
  // ============================================================

  dynamic _parseQuantity(String value) {
    final number = double.tryParse(value);

    if (number == null) {
      return value;
    }

    if (number == number.toInt()) {
      return number.toInt();
    }

    return number;
  }

  // ============================================================
  // ERROR
  // ============================================================

  String _getDioErrorMessage(
      DioException error,
      ) {
    final statusCode =
        error.response?.statusCode;

    if (statusCode == 400) {
      return 'Invalid recipe information.';
    }

    if (statusCode == 401) {
      return 'Your session has expired.';
    }

    if (statusCode == 403) {
      return 'You are not allowed to create a post.';
    }

    if (statusCode == 413) {
      return 'The image is too large.';
    }

    if (error.type ==
        DioExceptionType.connectionTimeout) {
      return 'Connection timeout.';
    }

    if (error.type ==
        DioExceptionType.receiveTimeout) {
      return 'Server response timeout.';
    }

    if (error.type ==
        DioExceptionType.connectionError) {
      return 'Could not connect to the server.';
    }

    return 'Failed to create recipe.';
  }

  // ============================================================
  // SNACKBAR
  // ============================================================

  void _showMessage(
      String message, {
        bool isError = false,
      }) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Colors.red.shade700
            : const Color(0xFF4CAF50),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFFFFF9F7),

      appBar: AppBar(
        backgroundColor:
        const Color(0xFFFFF9F7),

        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF513F39),
          ),
          onPressed: isPosting
              ? null
              : () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Create Recipe',
          style: TextStyle(
            color: Color(0xFF302A28),
            fontSize: 16,
          ),
        ),

        actions: [
          TextButton(
            onPressed:
            isPosting ? null : _createPost,
            child: isPosting
                ? const SizedBox(
              width: 20,
              height: 20,
              child:
              CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xFFBE3D00),
              ),
            )
                : const Text(
              'Post',
              style: TextStyle(
                color:
                Color(0xFFBE3D00),
                fontWeight:
                FontWeight.w600,
              ),
            ),
          ),
        ],
      ),

      body: AbsorbPointer(
        absorbing: isPosting,

        child: SingleChildScrollView(
          padding:
          const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [
              _buildImagePicker(),

              const SizedBox(height: 28),

              // NAME
              TextField(
                controller:
                recipeNameController,

                style: const TextStyle(
                  fontSize: 28,
                  fontWeight:
                  FontWeight.bold,
                  color:
                  Color(0xFF513F39),
                ),

                decoration:
                const InputDecoration(
                  hintText:
                  'Recipe Name',

                  hintStyle: TextStyle(
                    fontSize: 28,
                    fontWeight:
                    FontWeight.bold,
                    color:
                    Color(0xFF513F39),
                  ),

                  enabledBorder:
                  UnderlineInputBorder(
                    borderSide: BorderSide(
                      color:
                      Color(0xFFEBC9BE),
                    ),
                  ),

                  focusedBorder:
                  UnderlineInputBorder(
                    borderSide: BorderSide(
                      color:
                      Color(0xFFBE3D00),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // CAPTION
              TextField(
                controller:
                captionController,

                maxLines: 3,

                style: const TextStyle(
                  fontSize: 16,
                  color:
                  Color(0xFF302A28),
                ),

                decoration:
                InputDecoration(
                  hintText:
                  'Write a caption...',

                  hintStyle:
                  const TextStyle(
                    color:
                    Color(0xFF9C8F89),
                  ),

                  filled: true,

                  fillColor: Colors.white,

                  border:
                  OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(
                      14,
                    ),
                    borderSide:
                    BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // CATEGORY
              const Text(
                'Category',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                  FontWeight.w600,
                  color:
                  Color(0xFF24201F),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 40,

                child:
                ListView.builder(
                  scrollDirection:
                  Axis.horizontal,

                  itemCount:
                  categories.length,

                  itemBuilder:
                      (context, index) {
                    final category =
                    categories[index];

                    final selected =
                        category ==
                            selectedCategory;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory =
                              category;
                        });
                      },

                      child: Container(
                        margin:
                        const EdgeInsets
                            .only(
                          right: 8,
                        ),

                        padding:
                        const EdgeInsets
                            .symmetric(
                          horizontal: 18,
                        ),

                        decoration:
                        BoxDecoration(
                          color: selected
                              ? const Color(
                            0xFFBE3D00,
                          )
                              : const Color(
                            0xFFF3EFEE,
                          ),

                          borderRadius:
                          BorderRadius
                              .circular(
                            25,
                          ),
                        ),

                        child: Center(
                          child: Text(
                            category,

                            style: TextStyle(
                              color: selected
                                  ? Colors.white
                                  : const Color(
                                0xFF513F39,
                              ),

                              fontWeight:
                              selected
                                  ? FontWeight
                                  .w600
                                  : FontWeight
                                  .normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 38),

              // INGREDIENTS
              const Text(
                'Ingredients',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                  FontWeight.w600,
                  color:
                  Color(0xFF24201F),
                ),
              ),

              const SizedBox(height: 15),

              _buildIngredients(),

              const SizedBox(height: 5),

              _buildAddButton(
                label:
                'Add Ingredient',
                icon: Icons.add,
                onPressed:
                _showAddIngredientSheet,
              ),

              const SizedBox(height: 35),

              // STEPS
              const Text(
                'Steps',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                  FontWeight.w600,
                  color:
                  Color(0xFF24201F),
                ),
              ),

              const SizedBox(height: 15),

              _buildSteps(),

              const SizedBox(height: 5),

              _buildAddButton(
                label: 'Add Step',
                icon: Icons.add,
                onPressed:
                _showAddStepSheet,
              ),

              const SizedBox(height: 40),

              // POST BUTTON
              SizedBox(
                width: double.infinity,
                height: 52,

                child: ElevatedButton(
                  onPressed:
                  isPosting
                      ? null
                      : _createPost,

                  style:
                  ElevatedButton.styleFrom(
                    backgroundColor:
                    const Color(
                      0xFFBE3D00,
                    ),

                    foregroundColor:
                    Colors.white,

                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                        28,
                      ),
                    ),
                  ),

                  child: isPosting
                      ? const SizedBox(
                    width: 24,
                    height: 24,
                    child:
                    CircularProgressIndicator(
                      color:
                      Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    'Post Recipe',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // IMAGE PICKER
  // ============================================================

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,

      child: Container(
        height: 255,
        width: double.infinity,

        clipBehavior:
        Clip.antiAlias,

        decoration: BoxDecoration(
          color:
          const Color(0xFFFAF4F2),

          borderRadius:
          BorderRadius.circular(12),

          border: Border.all(
            color:
            const Color(0xFFEBC9BE),
          ),
        ),

        child: selectedImage == null
            ? Column(
          mainAxisAlignment:
          MainAxisAlignment
              .center,

          children: [
            Container(
              width: 64,
              height: 64,

              decoration:
              const BoxDecoration(
                color:
                Color(0xFFE9E5E4),
                shape:
                BoxShape.circle,
              ),

              child: const Icon(
                Icons
                    .add_a_photo_outlined,
                size: 30,
                color:
                Color(0xFF513F39),
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            const Text(
              'Add Recipe Photo',
              style: TextStyle(
                fontSize: 16,
                color:
                Color(0xFF513F39),
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            const Text(
              'required',
              style: TextStyle(
                fontSize: 13,
                color:
                Color(0xFF9C8F89),
              ),
            ),
          ],
        )
            : Stack(
          fit: StackFit.expand,

          children: [
            Image.file(
              selectedImage!,
              fit: BoxFit.cover,
            ),

            Positioned(
              top: 12,
              right: 12,

              child:
              GestureDetector(
                onTap:
                _removeImage,

                child: Container(
                  width: 38,
                  height: 38,

                  decoration:
                  const BoxDecoration(
                    color:
                    Colors.black54,
                    shape:
                    BoxShape.circle,
                  ),

                  child:
                  const Icon(
                    Icons.close,
                    color:
                    Colors.white,
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 12,
              left: 12,
              right: 12,

              child: Container(
                padding:
                const EdgeInsets
                    .symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),

                decoration:
                BoxDecoration(
                  color:
                  Colors.black54,
                  borderRadius:
                  BorderRadius
                      .circular(
                    10,
                  ),
                ),

                child:
                const Text(
                  'Tap to change photo',
                  textAlign:
                  TextAlign.center,
                  style: TextStyle(
                    color:
                    Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // INGREDIENTS
  // ============================================================

  Widget _buildIngredients() {
    return Column(
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

            decoration:
            BoxDecoration(
              color: Colors.white,

              borderRadius:
              BorderRadius.circular(
                12,
              ),
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
                    shape:
                    BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.restaurant_menu,
                    color:
                    Color(0xFF513F39),
                  ),
                ),

                const SizedBox(
                  width: 14,
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                    children: [
                      Text(
                        ingredient[
                        'name'] ??
                            '',

                        style:
                        const TextStyle(
                          fontSize: 16,
                          color:
                          Color(
                            0xFF302A28,
                          ),
                        ),
                      ),

                      Text(
                        '${ingredient['quantity']} ${ingredient['unit']}',

                        style:
                        const TextStyle(
                          fontSize: 13,
                          color:
                          Color(
                            0xFF513F39,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: () {
                    setState(() {
                      ingredients
                          .removeAt(
                        index,
                      );
                    });
                  },

                  icon: const Icon(
                    Icons
                        .delete_outline,
                    size: 20,
                    color:
                    Color(0xFF674F47),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // STEPS
  // ============================================================

  Widget _buildSteps() {
    return Column(
      children: List.generate(
        steps.length,

            (index) {
          return Container(
            margin:
            const EdgeInsets.only(
              bottom: 15,
            ),

            padding:
            const EdgeInsets.all(15),

            decoration:
            BoxDecoration(
              color: Colors.white,

              borderRadius:
              BorderRadius.circular(
                12,
              ),
            ),

            child: Row(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,

              children: [
                Container(
                  width: 34,
                  height: 34,

                  decoration:
                  BoxDecoration(
                    color: index == 0
                        ? const Color(
                      0xFFFFD9CE,
                    )
                        : const Color(
                      0xFFF0ECEB,
                    ),

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
                      FontWeight.w600,
                      color:
                      Color(
                        0xFF513F39,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  width: 14,
                ),

                Expanded(
                  child: Text(
                    steps[index],

                    style:
                    const TextStyle(
                      fontSize: 16,
                      height: 1.45,
                      color:
                      Color(
                        0xFF302A28,
                      ),
                    ),
                  ),
                ),

                IconButton(
                  onPressed: () {
                    setState(() {
                      steps.removeAt(
                        index,
                      );
                    });
                  },

                  icon: const Icon(
                    Icons
                        .delete_outline,
                    size: 18,
                    color:
                    Color(0xFF674F47),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // ADD BUTTON
  // ============================================================

  Widget _buildAddButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,

      icon: Icon(
        icon,
        color: Colors.white,
      ),

      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),

      style:
      ElevatedButton.styleFrom(
        backgroundColor:
        const Color(0xFFBE3D00),

        shape:
        RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(
            25,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ADD INGREDIENT
  // ============================================================

  void _showAddIngredientSheet() {
    final nameController =
    TextEditingController();

    final quantityController =
    TextEditingController();

    String unit = 'g';

    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      backgroundColor:
      Colors.transparent,

      builder: (context) {
        return StatefulBuilder(
          builder:
              (context, sheetSetState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom:
                MediaQuery.of(
                  context,
                ).viewInsets.bottom,
              ),

              child: Container(
                padding:
                const EdgeInsets.all(
                  20,
                ),

                decoration:
                const BoxDecoration(
                  color:
                  Color(0xFFFFFAF8),

                  borderRadius:
                  BorderRadius.vertical(
                    top:
                    Radius.circular(
                      28,
                    ),
                  ),
                ),

                child: Column(
                  mainAxisSize:
                  MainAxisSize.min,

                  children: [
                    const Text(
                      'Add Ingredient',

                      style:
                      TextStyle(
                        fontSize: 23,
                        fontWeight:
                        FontWeight.bold,
                        color:
                        Color(
                          0xFF302A28,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    TextField(
                      controller:
                      nameController,

                      decoration:
                      const InputDecoration(
                        hintText:
                        'Ingredient Name',
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child:
                          TextField(
                            controller:
                            quantityController,

                            keyboardType:
                            const TextInputType
                                .numberWithOptions(
                              decimal:
                              true,
                            ),

                            decoration:
                            const InputDecoration(
                              hintText:
                              'Quantity',
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 10,
                        ),

                        Expanded(
                          child:
                          DropdownButtonFormField<
                              String>(
                            initialValue:
                            unit,

                            items:
                            const [
                              DropdownMenuItem(
                                value: 'g',
                                child:
                                Text(
                                  'g',
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'kg',
                                child:
                                Text(
                                  'kg',
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'ml',
                                child:
                                Text(
                                  'ml',
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'l',
                                child:
                                Text(
                                  'l',
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'cup',
                                child:
                                Text(
                                  'cup',
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'tbsp',
                                child:
                                Text(
                                  'tbsp',
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'tsp',
                                child:
                                Text(
                                  'tsp',
                                ),
                              ),
                              DropdownMenuItem(
                                value:
                                'piece',
                                child:
                                Text(
                                  'piece',
                                ),
                              ),
                            ],

                            onChanged:
                                (value) {
                              if (value ==
                                  null) {
                                return;
                              }

                              sheetSetState(
                                    () {
                                  unit =
                                      value;
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      width:
                      double.infinity,

                      child:
                      ElevatedButton(
                        onPressed: () {
                          final name =
                          nameController
                              .text
                              .trim();

                          final quantity =
                          quantityController
                              .text
                              .trim();

                          if (name
                              .isEmpty ||
                              quantity
                                  .isEmpty) {
                            return;
                          }

                          setState(() {
                            ingredients
                                .add({
                              'name':
                              name,
                              'quantity':
                              quantity,
                              'unit':
                              unit,
                            });
                          });

                          Navigator.pop(
                            context,
                          );
                        },

                        style:
                        ElevatedButton
                            .styleFrom(
                          backgroundColor:
                          const Color(
                            0xFFBE3D00,
                          ),
                        ),

                        child:
                        const Text(
                          'Add Ingredient',
                          style:
                          TextStyle(
                            color:
                            Colors
                                .white,
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

  // ============================================================
  // ADD STEP
  // ============================================================

  void _showAddStepSheet() {
    final descriptionController =
    TextEditingController();

    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      backgroundColor:
      Colors.transparent,

      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom:
            MediaQuery.of(
              context,
            ).viewInsets.bottom,
          ),

          child: Container(
            padding:
            const EdgeInsets.all(20),

            decoration:
            const BoxDecoration(
              color:
              Color(0xFFFFFAF8),

              borderRadius:
              BorderRadius.vertical(
                top:
                Radius.circular(
                  28,
                ),
              ),
            ),

            child: Column(
              mainAxisSize:
              MainAxisSize.min,

              children: [
                const Text(
                  'Add Cooking Step',

                  style:
                  TextStyle(
                    fontSize: 20,
                    fontWeight:
                    FontWeight.bold,
                    color:
                    Color(
                      0xFF302A28,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                TextField(
                  controller:
                  descriptionController,

                  maxLines: 4,

                  decoration:
                  const InputDecoration(
                    hintText:
                    'Step Description',
                    border:
                    OutlineInputBorder(),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                SizedBox(
                  width:
                  double.infinity,

                  child:
                  ElevatedButton(
                    onPressed: () {
                      final description =
                      descriptionController
                          .text
                          .trim();

                      if (description
                          .isEmpty) {
                        return;
                      }

                      setState(() {
                        steps.add(
                          description,
                        );
                      });

                      Navigator.pop(
                        context,
                      );
                    },

                    style:
                    ElevatedButton
                        .styleFrom(
                      backgroundColor:
                      const Color(
                        0xFFBE3D00,
                      ),
                    ),

                    child:
                    const Text(
                      'Add Step',
                      style:
                      TextStyle(
                        color:
                        Colors.white,
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
}