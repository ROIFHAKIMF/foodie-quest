import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_quest/utils/date_helper.dart';

void main() {
  group('DateHelper Tests', () {
    test('formatFull should format date correctly', () {
      // Arrange
      final date = DateTime(2024, 12, 25);

      // Act
      final formatted = DateHelper.formatFull(date);

      // Assert
      expect(formatted, '2024-12-25');
    });

    test('formatFull should handle single digit month and day', () {
      // Arrange
      final date = DateTime(2024, 1, 5);

      // Act
      final formatted = DateHelper.formatFull(date);

      // Assert
      expect(formatted, '2024-01-05');
    });

    test('formatFull should handle leap year', () {
      // Arrange
      final date = DateTime(2024, 2, 29);

      // Act
      final formatted = DateHelper.formatFull(date);

      // Assert
      expect(formatted, '2024-02-29');
    });

    test('formatRelative should return relative time for recent date', () {
      // Arrange
      final now = DateTime.now();
      final fiveMinutesAgo = now.subtract(Duration(minutes: 5));

      // Act
      final formatted = DateHelper.formatRelative(fiveMinutesAgo);

      // Assert
      expect(formatted.contains('minute'), true);
    });

    test('formatRelative should return relative time for days ago', () {
      // Arrange
      final now = DateTime.now();
      final twoDaysAgo = now.subtract(Duration(days: 2));

      // Act
      final formatted = DateHelper.formatRelative(twoDaysAgo);

      // Assert
      expect(formatted.contains('day'), true);
    });

    test('formatRelative should handle future dates', () {
      // Arrange
      final now = DateTime.now();
      final future = now.add(Duration(hours: 2));

      // Act
      final formatted = DateHelper.formatRelative(future);

      // Assert - timeago library returns "a moment ago" for future dates
      expect(formatted, isNotEmpty);
    });

    test('formatFull should be consistent with ISO format', () {
      // Arrange
      final date = DateTime(2024, 12, 25, 15, 30, 45);

      // Act
      final formatted = DateHelper.formatFull(date);

      // Assert
      expect(formatted, '2024-12-25'); // Only date, no time
    });
  });
}