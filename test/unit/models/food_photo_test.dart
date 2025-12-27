import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_quest/models/food_photo.dart';

void main() {
  group('FoodPhoto Model Tests', () {
    test('FoodPhoto.fromJson should parse JSON correctly', () {
      // Arrange
      final json = {
        'id': 1,
        'image_url': 'https://example.com/photo.jpg',
        'caption': 'Delicious food',
        'created_at': '2024-12-22T10:30:00Z',
      };

      // Act
      final photo = FoodPhoto.fromJson(json);

      // Assert
      expect(photo.id, 1);
      expect(photo.imageUrl, 'https://example.com/photo.jpg');
      expect(photo.caption, 'Delicious food');
      expect(photo.createdAt, DateTime.parse('2024-12-22T10:30:00Z'));
    });

    test('FoodPhoto.fromJson should handle null caption', () {
      // Arrange
      final json = {
        'id': 1,
        'image_url': 'https://example.com/photo.jpg',
        'caption': null,
        'created_at': '2024-12-22T10:30:00Z',
      };

      // Act
      final photo = FoodPhoto.fromJson(json);

      // Assert
      expect(photo.caption, '');
    });

    test('FoodPhoto.toJson should convert to JSON correctly', () {
      // Arrange
      final photo = FoodPhoto(
        id: 1,
        imageUrl: 'https://example.com/photo.jpg',
        caption: 'Delicious food',
        createdAt: DateTime.parse('2024-12-22T10:30:00Z'),
      );

      // Act
      final json = photo.toJson();

      // Assert
      expect(json['image_url'], 'https://example.com/photo.jpg');
      expect(json['caption'], 'Delicious food');
      expect(json.containsKey('id'), false); // toJson should not include id
      expect(json.containsKey('created_at'), false); // toJson should not include created_at
    });

    test('FoodPhoto should parse various date formats', () {
      // Arrange
      final json = {
        'id': 1,
        'image_url': 'https://example.com/photo.jpg',
        'caption': 'Test',
        'created_at': '2024-12-22T10:30:00.000Z',
      };

      // Act
      final photo = FoodPhoto.fromJson(json);

      // Assert
      expect(photo.createdAt.year, 2024);
      expect(photo.createdAt.month, 12);
      expect(photo.createdAt.day, 22);
    });
  });
}