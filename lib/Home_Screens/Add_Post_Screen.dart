import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  List<Map<String, String>> ingredients = [
    {
      'name': 'Pasta',
      'quantity': '500',
      'unit': 'g',
    },
    {
      'name': 'Heavy Cream',
      'quantity': '1',
      'unit': 'cup',
    },
  ];

  List<Map<String, String>> steps = [
    {
      'description':
      'Boil pasta in a large pot of salted water until al dente.',
    },
    {
      'description':
      'Heat oil in a pan over medium heat. Sauté minced garlic until fragrant.',
    },
  ];

  List<String> categories = [
    'Italian',
    'Mexican',
    'Asian',
    'Dessert',
    'Breakfast',
  ];

  String selectedCategory = 'Italian';
  TextEditingController recipeNameController = TextEditingController();
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
          'Create Recipe',
          style: TextStyle(
            color: Color(0xFF302A28),
            fontSize: 16,
          ),
        ),

        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Post',
              style: TextStyle(
                color: Color(0xFFE8B9A9),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 255,
              width: double.infinity,

              decoration: BoxDecoration(
                color: const Color(0xFFFAF4F2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFEBC9BE),
                ),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE9E5E4),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add_a_photo_outlined,
                      size: 30,
                      color: Color(0xFF513F39),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Add Recipe Photo',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF513F39),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: recipeNameController,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF513F39),
              ),

              decoration: const InputDecoration(
                hintText: 'Recipe Name',

                hintStyle: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF513F39),
                ),

                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFEBC9BE),
                  ),
                ),

                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFBE3D00),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  bool selected =categories[index] == selectedCategory;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory =
                        categories[index];
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        right: 8,
                      ),
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 22,
                      ),
                      decoration: BoxDecoration(
                        color: selected
                            ? const Color(0xFFBE3D00)
                            : const Color(0xFFF3EFEE),

                        borderRadius:
                        BorderRadius.circular(25),
                      ),

                      child: Center(
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            color: selected
                                ? Colors.white
                                : const Color(
                              0xFF513F39,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              'Ingredients',
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

                    (index) => Container(
                  margin: const EdgeInsets.only(
                    bottom: 10,
                  ),

                  padding: const EdgeInsets.all(12),

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
                          color: Color(0xFFF5EFED),
                          shape: BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.restaurant_menu,
                          color: Color(0xFF513F39),
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            Text(
                              ingredients[index]
                              ['name']!,

                              style:
                              const TextStyle(
                                fontSize: 16,
                                color:
                                Color(0xFF302A28),
                              ),
                            ),

                            Text(
                              '${ingredients[index]['quantity']} ${ingredients[index]['unit']}',

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

                      IconButton(
                        onPressed: () {
                          setState(() {
                            ingredients
                                .removeAt(index);
                          });
                        },

                        icon: const Icon(
                          Icons.delete_outline,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),


            ElevatedButton.icon(
              onPressed: () {

                TextEditingController name =
                TextEditingController();

                TextEditingController quantity =
                TextEditingController();

                String unit = 'g';

                showModalBottomSheet(
                  context: context,

                  isScrollControlled: true,

                  builder: (context) {

                    return StatefulBuilder(
                      builder:
                          (context, sheetSetState) {

                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context)
                                .viewInsets
                                .bottom,
                          ),

                          child: Container(
                            padding:
                            const EdgeInsets.all(20),

                            decoration:
                            const BoxDecoration(
                              color: Color(0xFFFFFAF8),

                              borderRadius:
                              BorderRadius.vertical(
                                top: Radius.circular(28),
                              ),
                            ),

                            child: Column(
                              mainAxisSize:
                              MainAxisSize.min,

                              children: [

                                const Text(
                                  'Add Ingredient',

                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(
                                    height: 20),

                                TextField(
                                  controller: name,

                                  decoration:
                                  const InputDecoration(
                                    hintText:
                                    'Ingredient Name',
                                  ),
                                ),

                                const SizedBox(
                                    height: 10),

                                Row(
                                  children: [

                                    Expanded(
                                      child: TextField(
                                        controller:
                                        quantity,

                                        keyboardType:
                                        TextInputType
                                            .number,

                                        decoration:
                                        const InputDecoration(
                                          hintText:
                                          'Quantity',
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                        width: 10),

                                    Expanded(
                                      child:
                                      DropdownButtonFormField<
                                          String>(
                                        value: unit,

                                        items: const [

                                          DropdownMenuItem(
                                            value: 'g',
                                            child:
                                            Text('g'),
                                          ),

                                          DropdownMenuItem(
                                            value: 'kg',
                                            child:
                                            Text('kg'),
                                          ),

                                          DropdownMenuItem(
                                            value: 'ml',
                                            child:
                                            Text('ml'),
                                          ),

                                          DropdownMenuItem(
                                            value: 'cup',
                                            child:
                                            Text('cup'),
                                          ),
                                        ],

                                        onChanged: (value) {

                                          sheetSetState(() {
                                            unit = value!;
                                          });

                                        },
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                    height: 20),

                                SizedBox(
                                  width:
                                  double.infinity,

                                  child:
                                  ElevatedButton(
                                    onPressed: () {

                                      if (name.text
                                          .trim()
                                          .isEmpty ||
                                          quantity.text
                                              .trim()
                                              .isEmpty) {
                                        return;
                                      }

                                      setState(() {

                                        ingredients.add({
                                          'name':
                                          name.text.trim(),

                                          'quantity':
                                          quantity.text
                                              .trim(),

                                          'unit':
                                          unit,
                                        });

                                      });

                                      Navigator.pop(
                                          context);
                                    },

                                    style:
                                    ElevatedButton
                                        .styleFrom(
                                      backgroundColor:
                                      const Color(
                                          0xFFBE3D00),
                                    ),

                                    child:
                                    const Text(
                                      'Add Ingredient',

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
                  },
                );
              },

              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),

              label: const Text(
                'Add Ingredient',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),

              style: ElevatedButton.styleFrom(
                backgroundColor:
                const Color(0xFFBE3D00),

                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(25),
                ),
              ),
            ),

            const SizedBox(height: 35),

            const Text(
              'Steps',

              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 15),


            Column(
              children: List.generate(
                steps.length,

                    (index) => Container(
                  margin: const EdgeInsets.only(
                    bottom: 15,
                  ),

                  padding: const EdgeInsets.all(15),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(12),
                  ),

                  child: Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Container(
                        width: 34,
                        height: 34,

                        decoration: BoxDecoration(
                          color: index == 0
                              ? const Color(0xFFFFD9CE)
                              : const Color(0xFFF0ECEB),

                          shape: BoxShape.circle,
                        ),

                        alignment: Alignment.center,

                        child: Text(
                          '${index + 1}',
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Text(
                          steps[index]
                          ['description']!,

                          style:
                          const TextStyle(
                            fontSize: 16,
                            height: 1.45,
                            color:
                            Color(0xFF302A28),
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          setState(() {
                            steps.removeAt(index);
                          });
                        },

                        icon: const Icon(
                          Icons.delete_outline,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            ElevatedButton.icon(
              onPressed: () {

                TextEditingController description =
                TextEditingController();

                TextEditingController time =
                TextEditingController();

                TextEditingController temp =
                TextEditingController();

                showModalBottomSheet(
                  context: context,

                  isScrollControlled: true,

                  builder: (context) {

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context)
                            .viewInsets
                            .bottom,
                      ),

                      child: Container(
                        padding:
                        const EdgeInsets.all(20),

                        decoration:
                        const BoxDecoration(
                          color: Color(0xFFFFFAF8),

                          borderRadius:
                          BorderRadius.vertical(
                            top: Radius.circular(28),
                          ),
                        ),

                        child: Column(
                          mainAxisSize:
                          MainAxisSize.min,

                          children: [

                            const Text(
                              'Add Cooking Step',

                              style: TextStyle(
                                fontSize: 20,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                                height: 20),

                            TextField(
                              controller:
                              description,

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
                                height: 10),

                            Row(
                              children: [

                                Expanded(
                                  child: TextField(
                                    controller: time,

                                    decoration:
                                    const InputDecoration(
                                      hintText:
                                      '10 min',
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                    width: 10),

                                Expanded(
                                  child: TextField(
                                    controller: temp,

                                    decoration:
                                    const InputDecoration(
                                      hintText:
                                      '350°F',
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                                height: 20),

                            SizedBox(
                              width:
                              double.infinity,

                              child:
                              ElevatedButton(
                                onPressed: () {

                                  if (description
                                      .text
                                      .trim()
                                      .isEmpty) {
                                    return;
                                  }

                                  setState(() {

                                    steps.add({
                                      'description':
                                      description
                                          .text
                                          .trim(),
                                    });

                                  });

                                  Navigator.pop(
                                      context);
                                },

                                style:
                                ElevatedButton
                                    .styleFrom(
                                  backgroundColor:
                                  const Color(
                                      0xFFBE3D00),
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
              },

              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),

              label: const Text(
                'Add Step',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),

              style: ElevatedButton.styleFrom(
                backgroundColor:
                const Color(0xFFBE3D00),

                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}