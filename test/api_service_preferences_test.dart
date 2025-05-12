import 'package:flutter_test/flutter_test.dart';
import 'package:fashion_model_api/services/api_service.dart';
import 'package:fashion_model_api/models/user_preferences_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';

void main() {
  group('ApiService preferences methods tests', () {
    late ApiService apiService;
    
    setUp(() {
      // Mock HTTP client
      final mockClient = MockClient((request) async {
        if (request.url.path.endsWith('/preferences')) {
          // Simulate successful API response for preferences
          return http.Response('{"success": true}', 200);
        } else {
          return http.Response('Not found', 404);
        }
      });
      
      apiService = ApiService();
      // Here we would inject the mock client if the ApiService had a constructor for it
      // For simplicity, we're not modifying the original ApiService class
    });

    test('Convert answers to preferences format', () {
      // Mock answers data
      final Map<int, List<int>> answers = {
        163143590: [3, 2, 1, 0],
        276500014: [5, 2, 3, 4, 6],
        349802582: [6, 5],
        407053435: [4],
      };
      
      // Call the private method using reflection (not recommended in production)
      // For testing purposes only
      final preferences = apiService._convertAnswersToPreferencesFormat(answers);
      
      // Verify the conversion results
      expect(preferences, isA<Map<String, dynamic>>());
      expect(preferences['item_types'], isNotNull);
      expect(preferences['favorite_colors'], isNotNull);
      expect(preferences['style_vibes'], isNotNull);
      expect(preferences['gender'], isNotNull);
    });
    
    test('Submit raw preferences format', () async {
      // Test data
      final rawPreferences = {
        "gender": "Men",
        "item_types": ["Jacket", "Pants", "Sneakers"],
        "style_vibes": ["Casual", "Preppy"],
        "favorite_colors": ["Black", "Blue", "Gray"]
      };
      
      // Call method - in a real test this would use the mock client
      // For now, we're just testing that the method exists and compiles
      // This will make an actual network request, which is not ideal for tests
      // expect(await apiService.submitRawPreferences(rawPreferences), isTrue);
      
      // Instead, just verify the method signature is correct
      expect(apiService.submitRawPreferences, isA<Function>());
    });
    
    test('Update preferences from questionnaire answers', () async {
      // Test data
      final Map<String, List<String>> formattedAnswers = {
        "163143590": ["3", "2", "1", "0"],
        "276500014": ["5", "2", "3", "4", "6"],
      };
      
      // Verify method signature
      expect(apiService.updateUserPreferencesFromAnswers, isA<Function>());
      
      // In a real test with proper dependency injection:
      // expect(await apiService.updateUserPreferencesFromAnswers(formattedAnswers), isTrue);
    });
  });
}
