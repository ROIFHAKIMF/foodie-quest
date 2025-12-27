import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_quest/models/recipe.dart';

void main() {
  group('Recipe Model Tests', () {
    test('Recipe.fromJson should parse JSON correctly', () {
      // Arrange
      final json = {
        'id': 1,
        'title': 'Nasi Goreng',
        'description': 'Indonesian fried rice',
        'ingredients': 'Rice, Egg, Soy Sauce',
        'instructions': 'Fry rice with egg',
        'image_url': 'https://example.com/image.jpg',
        'rating': 4.5,
      };

      // Act
      final recipe = Recipe.fromJson(json);

      // Assert
      expect(recipe.id, 1);
      expect(recipe.title, 'Nasi Goreng');
      expect(recipe.description, 'Indonesian fried rice');
      expect(recipe.ingredients, 'Rice, Egg, Soy Sauce');
      expect(recipe.instructions, 'Fry rice with egg');
      expect(recipe.imageUrl, 'https://example.com/image.jpg');
      expect(recipe.rating, 4.5);
    });

    test('Recipe.fromJson should handle null description', () {
      // Arrange
      final json = {
        'id': 1,
        'title': 'Test Recipe',
        'description': null,
        'ingredients': 'Test',
        'instructions': 'Test',
        'image_url': '',
        'rating': 0,
      };

      // Act
      final recipe = Recipe.fromJson(json);

      // Assert
      expect(recipe.description, '');
    });

    test('Recipe.fromJson should handle null image_url', () {
      // Arrange
      final json = {
        'id': 1,
        'title': 'Test Recipe',
        'description': 'Test',
        'ingredients': 'Test',
        'instructions': 'Test',
        'image_url': null,
        'rating': 0,
      };

      // Act
      final recipe = Recipe.fromJson(json);

      // Assert
      expect(recipe.imageUrl, '');
    });

    test('Recipe.fromJson should handle null rating', () {
      // Arrange
      final json = {
        'id': 1,
        'title': 'Test Recipe',
        'description': 'Test',
        'ingredients': 'Test',
        'instructions': 'Test',
        'image_url': '',
        'rating': null,
      };

      // Act
      final recipe = Recipe.fromJson(json);

      // Assert
      expect(recipe.rating, 0.0);
    });

    test('Recipe.toJson should convert to JSON correctly', () {
      // Arrange
      final recipe = Recipe(
        id: 1,
        title: 'Nasi Goreng',
        description: 'Indonesian fried rice',
        ingredients: 'Rice, Egg, Soy Sauce',
        instructions: 'Fry rice with egg',
        imageUrl: 'https://example.com/image.jpg',
        rating: 4.5,
      );

      // Act
      final json = recipe.toJson();

      // Assert
      expect(json['title'], 'Nasi Goreng');
      expect(json['description'], 'Indonesian fried rice');
      expect(json['ingredients'], 'Rice, Egg, Soy Sauce');
      expect(json['instructions'], 'Fry rice with egg');
      expect(json['image_url'], 'https://example.com/image.jpg');
      expect(json['rating'], 4.5);
    });

    test('Recipe.fromJson should parse integer rating to double', () {
      // Arrange
      final json = {
        'id': 1,
        'title': 'Test',
        'description': 'Test',
        'ingredients': 'Test',
        'instructions': 'Test',
        'image_url': '',
        'rating': 5, // Integer
      };

      // Act
      final recipe = Recipe.fromJson(json);

      // Assert
      expect(recipe.rating, 5.0);
      expect(recipe.rating, isA<double>());
    });
  });
}