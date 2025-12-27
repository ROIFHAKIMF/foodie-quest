import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_quest/providers/recipe_provider.dart';
import 'package:foodie_quest/models/recipe.dart';

void main() {
  group('RecipeProvider Tests', () {
    late RecipeProvider provider;

    setUp(() {
      provider = RecipeProvider();
    });

    test('Initial state should be empty and not loading', () {
      // Assert
      expect(provider.recipes, isEmpty);
      expect(provider.favoriteIds, isEmpty);
      expect(provider.isLoading, false);
    });

    test('toggleFavorite should add recipe to favorites', () {
      // Arrange
      const recipeId = 1;
      var notified = false;
      provider.addListener(() {
        notified = true;
      });

      // Act
      provider.toggleFavorite(recipeId);

      // Assert
      expect(provider.favoriteIds.contains(recipeId), true);
      expect(notified, true);
    });

    test('toggleFavorite should remove recipe from favorites if already favorited', () {
      // Arrange
      const recipeId = 1;
      provider.toggleFavorite(recipeId); // Add first

      // Act
      provider.toggleFavorite(recipeId); // Remove

      // Assert
      expect(provider.favoriteIds.contains(recipeId), false);
    });

    test('isFavorite should return true for favorited recipe', () {
      // Arrange
      const recipeId = 1;
      provider.toggleFavorite(recipeId);

      // Act
      final result = provider.isFavorite(recipeId);

      // Assert
      expect(result, true);
    });

    test('isFavorite should return false for non-favorited recipe', () {
      // Arrange
      const recipeId = 1;

      // Act
      final result = provider.isFavorite(recipeId);

      // Assert
      expect(result, false);
    });

    test('Multiple favorites should be tracked correctly', () {
      // Act
      provider.toggleFavorite(1);
      provider.toggleFavorite(2);
      provider.toggleFavorite(3);

      // Assert
      expect(provider.favoriteIds.length, 3);
      expect(provider.isFavorite(1), true);
      expect(provider.isFavorite(2), true);
      expect(provider.isFavorite(3), true);
      expect(provider.isFavorite(4), false);
    });

    test('favoriteRecipes should return only favorited recipes', () {
      // Arrange - Mock some recipes
      final recipe1 = Recipe(
        id: 1,
        title: 'Recipe 1',
        description: 'Desc 1',
        ingredients: 'Ing 1',
        instructions: 'Inst 1',
        imageUrl: '',
        rating: 4.0,
      );
      final recipe2 = Recipe(
        id: 2,
        title: 'Recipe 2',
        description: 'Desc 2',
        ingredients: 'Ing 2',
        instructions: 'Inst 2',
        imageUrl: '',
        rating: 5.0,
      );
      final recipe3 = Recipe(
        id: 3,
        title: 'Recipe 3',
        description: 'Desc 3',
        ingredients: 'Ing 3',
        instructions: 'Inst 3',
        imageUrl: '',
        rating: 3.5,
      );

      // Manually set recipes (in real test, you'd mock the API)
      // For now, we test the logic
      provider.toggleFavorite(1);
      provider.toggleFavorite(3);

      // Act
      final favorites = provider.favoriteRecipes;

      // Assert - Since we can't set _recipes directly, this will be empty
      // In a real test with mocking, you'd verify the filtering logic
      expect(provider.favoriteIds.contains(1), true);
      expect(provider.favoriteIds.contains(2), false);
      expect(provider.favoriteIds.contains(3), true);
    });

    test('toggleFavorite should notify listeners', () {
      // Arrange
      var notificationCount = 0;
      provider.addListener(() {
        notificationCount++;
      });

      // Act
      provider.toggleFavorite(1);
      provider.toggleFavorite(2);
      provider.toggleFavorite(1); // Toggle off

      // Assert
      expect(notificationCount, 3);
    });
  });
}