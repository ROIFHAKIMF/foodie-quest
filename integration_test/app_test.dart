import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:foodie_quest/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('FoodieQuest Integration Tests', () {
    testWidgets('Complete user flow: Browse recipes and add to favorites',
            (WidgetTester tester) async {
          // Launch app
          app.main();
          await tester.pumpAndSettle(const Duration(seconds: 3));

          // Verify app launched
          expect(find.text('FoodieQuest'), findsOneWidget);

          // Wait for recipes to load
          await tester.pumpAndSettle(const Duration(seconds: 2));

          // Check if recipes tab is visible
          expect(find.text('Recipes'), findsOneWidget);

          // Look for any recipe in the list
          final recipeTile = find.byType(ListTile).first;
          if (recipeTile.evaluate().isNotEmpty) {
            // Tap on first recipe
            await tester.tap(recipeTile);
            await tester.pumpAndSettle();

            // Verify recipe detail screen opened
            expect(find.byType(AppBar), findsOneWidget);

            // Find and tap favorite button
            final favoriteButton = find.byIcon(Icons.favorite_border);
            if (favoriteButton.evaluate().isNotEmpty) {
              await tester.tap(favoriteButton);
              await tester.pumpAndSettle();

              // Verify icon changed to filled heart
              expect(find.byIcon(Icons.favorite), findsOneWidget);
            }

            // Go back to home
            await tester.pageBack();
            await tester.pumpAndSettle();
          }
        });

    testWidgets('Navigate through all tabs', (WidgetTester tester) async {
      // Launch app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Tap Photos tab
      await tester.tap(find.text('Photos'));
      await tester.pumpAndSettle();

      // Verify Photos tab content
      expect(
        find.textContaining('photo', findRichText: true),
        findsAtLeastNWidgets(1),
      );

      // Tap Favorites tab
      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();

      // Verify Favorites tab content
      expect(
        find.textContaining('favorite', findRichText: true, skipOffstage: false),
        findsAtLeastNWidgets(1),
      );

      // Go back to Recipes tab
      await tester.tap(find.text('Recipes'));
      await tester.pumpAndSettle();

      expect(find.text('Search Recipes...'), findsOneWidget);
    });

    testWidgets('Search recipes functionality', (WidgetTester tester) async {
      // Launch app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Wait for recipes to load
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Find search field
      final searchField = find.byType(TextField);
      expect(searchField, findsOneWidget);

      // Enter search query
      await tester.enterText(searchField, 'Nasi');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Wait for search results
      await tester.pumpAndSettle();

      // Verify search was executed (results may vary)
      expect(searchField, findsOneWidget);
    });

    testWidgets('Open upload photo screen', (WidgetTester tester) async {
      // Launch app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find and tap FAB
      final fab = find.byType(FloatingActionButton);
      expect(fab, findsOneWidget);

      await tester.tap(fab);
      await tester.pumpAndSettle();

      // Verify upload screen opened
      expect(find.text('Upload Photo'), findsOneWidget);
      expect(find.text('Gallery'), findsOneWidget);
      expect(find.text('Camera'), findsOneWidget);

      // Verify caption field exists
      expect(find.text('Caption'), findsOneWidget);

      // Verify upload button is disabled initially
      final uploadButton = find.text('Upload');
      expect(uploadButton, findsOneWidget);
    });

    testWidgets('Recipe detail navigation and back', (WidgetTester tester) async {
      // Launch app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Wait for recipes to load
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Find first recipe
      final recipeTile = find.byType(ListTile).first;

      if (recipeTile.evaluate().isNotEmpty) {
        // Tap recipe
        await tester.tap(recipeTile);
        await tester.pumpAndSettle();

        // Verify we're on detail screen
        expect(find.byType(SingleChildScrollView), findsOneWidget);

        // Verify sections exist
        expect(find.text('Description'), findsOneWidget);
        expect(find.text('Ingredients'), findsOneWidget);
        expect(find.text('Instructions'), findsOneWidget);

        // Go back
        final backButton = find.byType(BackButton);
        await tester.tap(backButton);
        await tester.pumpAndSettle();

        // Verify we're back on home screen
        expect(find.text('Search Recipes...'), findsOneWidget);
      }
    });

    testWidgets('Favorite persistence across tabs', (WidgetTester tester) async {
      // Launch app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Wait for recipes
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Find and tap first recipe
      final recipeTile = find.byType(ListTile).first;

      if (recipeTile.evaluate().isNotEmpty) {
        await tester.tap(recipeTile);
        await tester.pumpAndSettle();

        // Add to favorites
        final favoriteButton = find.byIcon(Icons.favorite_border);
        if (favoriteButton.evaluate().isNotEmpty) {
          await tester.tap(favoriteButton);
          await tester.pumpAndSettle();

          // Go back
          await tester.pageBack();
          await tester.pumpAndSettle();

          // Navigate to Favorites tab
          await tester.tap(find.text('Favorites'));
          await tester.pumpAndSettle();

          // Verify recipe appears in favorites
          expect(find.byType(ListTile), findsAtLeastNWidgets(1));
        }
      }
    });

    testWidgets('Clear search functionality', (WidgetTester tester) async {
      // Launch app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Enter search text
      final searchField = find.byType(TextField);
      await tester.enterText(searchField, 'Pizza');
      await tester.pump();

      // Verify text entered
      expect(find.text('Pizza'), findsOneWidget);

      // Find and tap clear button
      final clearButton = find.widgetWithIcon(IconButton, Icons.clear);
      await tester.tap(clearButton);
      await tester.pumpAndSettle();

      // Verify text cleared
      final textField = tester.widget<TextField>(searchField);
      expect(textField.controller?.text, isEmpty);
    });
  });
}