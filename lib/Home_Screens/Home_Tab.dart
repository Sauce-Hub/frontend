import 'package:flutter/material.dart';
import 'package:frontend/Widgets/Post_widgets.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      leading: Icon(Icons.food_bank, color: Color(0xFFF97316),),
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
              recipeImageUrl: 'https://i.pinimg.com/1200x/8d/ee/00/8dee008e0cb24f5fff5007af39223bdf.jpg',
              name: 'Avocado Toast',
              category: 'Breakfast',
              likesCount: 245,
              commentsCount: 18, recipeId: '3',
               ingerdiants: '',
                instructions: '',
                 caption: 'delicous',
                  estimatedTime: 30, 
                   fats: 150, 
                   carbs: 450,
                    protein: 60, 
                    Calories: 780,
               
            ),

            const SizedBox(height: 16),

             RecipeCard(
              username: '@hana',
              timeAgo: '4h ago',
              recipeImageUrl: 'https://i.pinimg.com/1200x/6e/1e/06/6e1e0663df4ce9b20244dddf2a8233ff.jpg',
              name: 'Creamy pasta',
              category: 'launch',
              likesCount: 155,
              commentsCount: 3,
               recipeId: '4', 
               ingerdiants: 'dry pasta\nheavy cream\nParmesan cheese.',
             instructions: 
             '''Boil the Pasta\nBuild the Creamy Base\nCombine and Sauce
             ''', caption: '', 
             estimatedTime: 80,
              fats: 90, 
              carbs: 700,
               protein: 30,
                Calories: 707
             ,),

            
          ]

        )
    )
    );
  }
}
