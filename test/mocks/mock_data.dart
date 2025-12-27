import 'package:foodie_quest/models/recipe.dart';
import 'package:foodie_quest/models/food_photo.dart';

class MockData {
  // Mock Recipes
  static List<Recipe> get mockRecipes => [
    Recipe(
      id: 1,
      title: 'Nasi Goreng Spesial',
      description: 'Indonesian fried rice with a twist.',
      ingredients: 'Rice, Egg, Sweet Soy Sauce, Garlic, Chili',
      instructions:
      '1. Fry garlic.\n2. Add egg.\n3. Add rice and sauces.\n4. Serve hot.',
      imageUrl:
      'https://images.unsplash.com/photo-1512058564366-18510be2db19',
      rating: 4.8,
    ),
    Recipe(
      id: 2,
      title: 'Spaghetti Carbonara',
      description: 'Classic Italian pasta.',
      ingredients:
      'Spaghetti, Eggs, Pecorino Cheese, Guanciale, Black Pepper',
      instructions:
      '1. Boil pasta.\n2. Fry guanciale.\n3. Mix eggs and cheese.\n4. Combine all off heat.',
      imageUrl:
      'https://images.unsplash.com/photo-1612874742237-6526221588e3',
      rating: 4.5,
    ),
    Recipe(
      id: 3,
      title: 'Avocado Toast',
      description: 'Simple and healthy breakfast.',
      ingredients: 'Bread, Avocado, Salt, Pepper, Lemon Juice',
      instructions:
      '1. Toast bread.\n2. Mash avocado.\n3. Spread on toast.\n4. Season.',
      imageUrl:
      'https://images.unsplash.com/photo-1541519227354-08fa5d50c44d',
      rating: 4.2,
    ),
  ];

  static Recipe get singleRecipe => Recipe(
    id: 1,
    title: 'Test Recipe',
    description: 'Test Description',
    ingredients: 'Test Ingredients',
    instructions: 'Test Instructions',
    imageUrl: 'https://example.com/test.jpg',
    rating: 4.0,
  );

  // Mock Food Photos
  static List<FoodPhoto> get mockPhotos => [
    FoodPhoto(
      id: 1,
      imageUrl: 'https://example.com/photo1.jpg',
      caption: 'Delicious breakfast',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    FoodPhoto(
      id: 2,
      imageUrl: 'https://example.com/photo2.jpg',
      caption: 'Lunch special',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    FoodPhoto(
      id: 3,
      imageUrl: 'https://example.com/photo3.jpg',
      caption: 'Dinner delight',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  static FoodPhoto get singlePhoto => FoodPhoto(
    id: 1,
    imageUrl: 'https://example.com/test.jpg',
    caption: 'Test Photo',
    createdAt: DateTime.now(),
  );

  // Mock JSON responses
  static Map<String, dynamic> get recipeJson => {
    'id': 1,
    'title': 'Nasi Goreng',
    'description': 'Indonesian fried rice',
    'ingredients': 'Rice, Egg, Soy Sauce',
    'instructions': 'Fry rice with egg',
    'image_url': 'https://example.com/image.jpg',
    'rating': 4.5,
    'created_at': '2024-12-22T10:00:00Z',
  };

  static Map<String, dynamic> get photoJson => {
    'id': 1,
    'image_url': 'https://example.com/photo.jpg',
    'caption': 'Delicious food',
    'created_at': '2024-12-22T10:30:00Z',
    'uploaded_by': 'Anonymous',
  };

  static List<Map<String, dynamic>> get recipesJsonList => [
    recipeJson,
    {
      'id': 2,
      'title': 'Spaghetti Carbonara',
      'description': 'Classic Italian pasta',
      'ingredients': 'Pasta, Eggs, Cheese',
      'instructions': 'Boil pasta, mix with sauce',
      'image_url': 'https://example.com/pasta.jpg',
      'rating': 4.7,
      'created_at': '2024-12-21T15:00:00Z',
    },
  ];

  static List<Map<String, dynamic>> get photosJsonList => [
    photoJson,
    {
      'id': 2,
      'image_url': 'https://example.com/photo2.jpg',
      'caption': 'Another delicious meal',
      'created_at': '2024-12-21T12:00:00Z',
      'uploaded_by': 'User123',
    },
  ];

  // Mock error responses
  static Exception get networkException =>
      Exception('Network error: Failed to connect');

  static Exception get timeoutException =>
      Exception('Request timeout after 10 seconds');

  static Exception get unauthorizedException =>
      Exception('Unauthorized: Invalid credentials');

  static Exception get notFoundException =>
      Exception('Not found: Resource does not exist');

  // Helper methods
  static Recipe createRecipeWithId(int id) {
    return Recipe(
      id: id,
      title: 'Recipe $id',
      description: 'Description for recipe $id',
      ingredients: 'Ingredients for recipe $id',
      instructions: 'Instructions for recipe $id',
      imageUrl: 'https://example.com/recipe$id.jpg',
      rating: 4.0 + (id % 5) * 0.2,
    );
  }

  static FoodPhoto createPhotoWithId(int id) {
    return FoodPhoto(
      id: id,
      imageUrl: 'https://example.com/photo$id.jpg',
      caption: 'Photo caption $id',
      createdAt: DateTime.now().subtract(Duration(hours: id)),
    );
  }

  static List<Recipe> createRecipeList(int count) {
    return List.generate(count, (index) => createRecipeWithId(index + 1));
  }

  static List<FoodPhoto> createPhotoList(int count) {
    return List.generate(count, (index) => createPhotoWithId(index + 1));
  }
}