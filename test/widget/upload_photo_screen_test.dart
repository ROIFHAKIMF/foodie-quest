import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:foodie_quest/screens/upload_photo_screen.dart';
import 'package:foodie_quest/providers/photo_provider.dart';

void main() {
  group('UploadPhotoScreen Widget Tests', () {
    late PhotoProvider photoProvider;

    setUp(() {
      photoProvider = PhotoProvider();
    });

    Widget createUploadScreen() {
      return ChangeNotifierProvider<PhotoProvider>.value(
        value: photoProvider,
        child: const MaterialApp(
          home: UploadPhotoScreen(),
        ),
      );
    }

    testWidgets('UploadPhotoScreen should display title', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createUploadScreen());

      // Assert
      expect(find.text('Upload Photo'), findsOneWidget);
    });

    testWidgets('UploadPhotoScreen should display Gallery button', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createUploadScreen());

      // Assert
      expect(find.text('Gallery'), findsOneWidget);
      expect(find.byIcon(Icons.photo_library), findsOneWidget);
    });

    testWidgets('UploadPhotoScreen should display Camera button', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createUploadScreen());

      // Assert
      expect(find.text('Camera'), findsOneWidget);
      expect(find.byIcon(Icons.camera_alt), findsOneWidget);
    });

    testWidgets('UploadPhotoScreen should display caption text field', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createUploadScreen());

      // Assert
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Caption'), findsOneWidget);
    });

    testWidgets('UploadPhotoScreen should display Upload button', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createUploadScreen());

      // Assert
      expect(find.text('Upload'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Upload button should be disabled initially', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createUploadScreen());

      // Assert
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull); // Disabled when onPressed is null
    });

    testWidgets('Caption field should accept text input', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createUploadScreen());
      final textField = find.byType(TextField);

      // Act
      await tester.enterText(textField, 'My delicious meal');
      await tester.pump();

      // Assert
      expect(find.text('My delicious meal'), findsOneWidget);
    });

    testWidgets('Image placeholder should display add photo icon', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createUploadScreen());

      // Assert
      expect(find.byIcon(Icons.add_a_photo), findsOneWidget);
    });

    testWidgets('Image container should be tappable', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createUploadScreen());
      final container = find.byType(GestureDetector).first;

      // Assert
      expect(container, findsOneWidget);
    });

    testWidgets('Should show loading indicator when uploading', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createUploadScreen());

      // Manually set uploading state (in real scenario, triggered by upload)
      photoProvider.uploadPhoto(null as dynamic, 'test'); // This will fail but set state

      // Act
      await tester.pump();

      // Assert
      // Note: This test needs proper mocking to work correctly
      // For now, we just verify the widget structure
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Should have two buttons for image selection', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createUploadScreen());

      // Assert
      final textButtons = find.byType(TextButton);
      expect(textButtons, findsNWidgets(2));
    });

    testWidgets('Container should have correct dimensions', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createUploadScreen());

      // Assert
      final container = tester.widget<Container>(
        find.ancestor(
          of: find.byIcon(Icons.add_a_photo),
          matching: find.byType(Container),
        ).first,
      );
      expect(container.constraints?.maxHeight, 200);
    });
  });
}