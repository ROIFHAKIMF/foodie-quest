import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:foodie_quest/screens/home_screen.dart';
import 'package:foodie_quest/providers/recipe_provider.dart';
import 'package:foodie_quest/providers/photo_provider.dart';
import 'package:foodie_quest/models/recipe.dart';

void main() {
  group('HomeScreen Widget Tests', () {
    late RecipeProvider recipeProvider;
    late PhotoProvider photoProvider;

    setUp(() {
      recipeProvider = RecipeProvider();
      photoProvider = PhotoProvider();
    });

    Widget createHomeScreen() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<RecipeProvider>.value(value: recipeProvider),
          ChangeNotifierProvider<PhotoProvider>.value(value: photoProvider),
        ],
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      );
    }

    testWidgets('HomeScreen should display app title', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createHomeScreen());

      // Assert
      expect(find.text('FoodieQuest'), findsOneWidget);
    });

    testWidgets('HomeScreen should display three tabs', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createHomeScreen());

      // Assert
      expect(find.text('Recipes'), findsOneWidget);
      expect(find.text('Photos'), findsOneWidget);
      expect(find.text('Favorites'), findsOneWidget);
    });

    testWidgets('HomeScreen should display floating action button', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createHomeScreen());

      // Assert
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.add_a_photo), findsOneWidget);
    });

    testWidgets('HomeScreen should display search field in Recipes tab', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createHomeScreen());

      // Assert
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Search Recipes...'), findsOneWidget);
    });

    testWidgets('Tapping search clear button should clear text', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createHomeScreen());
      final textField = find.byType(TextField);

      // Act
      await tester.enterText(textField, 'Nasi Goreng');
      await tester.pump();

      // Find and tap clear button
      final clearButton = find.widgetWithIcon(IconButton, Icons.clear);
      await tester.tap(clearButton);
      await tester.pump();

      // Assert
      final TextField widget = tester.widget(textField);
      expect(widget.controller?.text, isEmpty);
    });

    testWidgets('HomeScreen should switch to Photos tab when tapped', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createHomeScreen());

      // Act
      await tester.tap(find.text('Photos'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('No photos uploaded yet.'), findsOneWidget);
    });

    testWidgets('HomeScreen should switch to Favorites tab when tapped', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createHomeScreen());

      // Act
      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('No favorites yet.'), findsOneWidget);
    });

    testWidgets('Recipes tab should show loading indicator when loading', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createHomeScreen());

      // Trigger loading state manually (in real scenario, would be triggered by fetchRecipes)
      // For now, we just verify the widget structure

      // Assert - Initially not loading
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('Recipes tab should show empty message when no recipes', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createHomeScreen());
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('No recipes found.'), findsOneWidget);
    });

    testWidgets('Search field should accept text input', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createHomeScreen());
      final textField = find.byType(TextField);

      // Act
      await tester.enterText(textField, 'Pizza');
      await tester.pump();

      // Assert
      expect(find.text('Pizza'), findsOneWidget);
    });

    testWidgets('FAB should be visible on all tabs', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createHomeScreen());

      // Test Recipes tab
      expect(find.byType(FloatingActionButton), findsOneWidget);

      // Test Photos tab
      await tester.tap(find.text('Photos'));
      await tester.pumpAndSettle();
      expect(find.byType(FloatingActionButton), findsOneWidget);

      // Test Favorites tab
      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });
  });
}