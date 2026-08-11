import 'package:flutter/material.dart';
import 'package:frontend/Widgets/Post_widgets.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      backgroundColor: Color.fromARGB(255, 252, 238, 228),
      centerTitle: true,
      title: Text("Sauce hub", selectionColor: Color(0xFFF97316),),
    ),

    body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            RecipeCard(
              username: '@yasmine',
              timeAgo: '1h ago',
              userImageUrl: 'https://i.pinimg.com/736x/66/cb/66/66cb667ee5e0b27df754a03f16112cd9.jpg',
              recipeImageUrl: 'https://i.pinimg.com/1200x/8d/ee/00/8dee008e0cb24f5fff5007af39223bdf.jpg',
              title: 'Avocado Toast',
              category: 'Breakfast',
              likesCount: 245,
              commentsCount: 18,
            ),

            const SizedBox(height: 16),

             RecipeCard(
              username: '@hana',
              timeAgo: '1h ago',
              userImageUrl: 'https://i.pinimg.com/736x/f4/f8/a6/f4f8a62a70b8d9b2a8c91f1bcd7a74a2.jpg',
              recipeImageUrl: 'https://i.pinimg.com/1200x/6e/1e/06/6e1e0663df4ce9b20244dddf2a8233ff.jpg',
              title: 'Creamy pasta',
              category: 'launch',
              likesCount: 155,
              commentsCount: 3,
            ),

            
          ]

        )
    )
    );
  }
}
