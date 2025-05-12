import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:fashion_model_api/models/recommendation_model.dart';

void main() {
  group('Recommendation Model Tests', () {
    test('Recommendation.fromJson parses standard format correctly', () {
      final json = {
        'id': 1,
        'name': 'Business Casual Look',
        'description': 'Professional yet comfortable outfit for office environments',
        'image_url': 'https://example.com/image1.jpg',
        'confidence_score': 0.92,
        'tags': ['Office', 'Professional', 'Comfortable']
      };

      final recommendation = Recommendation.fromJson(json);
      
      expect(recommendation.id, 1);
      expect(recommendation.name, 'Business Casual Look');
      expect(recommendation.description, 'Professional yet comfortable outfit for office environments');
      expect(recommendation.imageUrl, 'https://example.com/image1.jpg');
      expect(recommendation.confidenceScore, 0.92);
      expect(recommendation.tags, ['Office', 'Professional', 'Comfortable']);
    });
    
    test('Recommendation.fromJson handles various field name formats', () {
      final json = {
        'id': '2', // String ID should be parsed to int
        'title': 'Weekend Casual', // Alternative field name
        'desc': 'Relaxed outfit for weekend outings', // Alternative field name
        'imageUrl': 'https://example.com/image2.jpg', // Alternative field name
        'score': 0.85, // Alternative field name
        'tags': ['Casual', 'Weekend']
      };

      final recommendation = Recommendation.fromJson(json);
      
      expect(recommendation.id, 2);
      expect(recommendation.name, 'Weekend Casual');
      expect(recommendation.description, 'Relaxed outfit for weekend outings');
      expect(recommendation.imageUrl, 'https://example.com/image2.jpg');
      expect(recommendation.confidenceScore, 0.85);
      expect(recommendation.tags, ['Casual', 'Weekend']);
    });
    
    test('Recommendation.fromJson handles missing fields gracefully', () {
      final json = {
        'id': 3,
        'name': 'Party Look'
        // Missing description, image_url, confidence_score, and tags
      };

      final recommendation = Recommendation.fromJson(json);
      
      expect(recommendation.id, 3);
      expect(recommendation.name, 'Party Look');
      expect(recommendation.description, 'No description available');
      expect(recommendation.imageUrl, contains('placeholder'));
      expect(recommendation.confidenceScore, 0.0);
      expect(recommendation.tags, isEmpty);
    });
    
    test('Recommendation.parseRecommendations parses list correctly', () {
      final responseBody = '''
      [
        {
          "id": 1,
          "name": "Business Casual",
          "description": "Perfect for office",
          "image_url": "https://example.com/image1.jpg",
          "confidence_score": 0.9,
          "tags": ["Office"]
        },
        {
          "id": 2,
          "name": "Weekend Casual",
          "description": "Relaxed style",
          "image_url": "https://example.com/image2.jpg",
          "confidence_score": 0.8,
          "tags": ["Casual"]
        }
      ]
      ''';

      final recommendations = Recommendation.parseRecommendations(responseBody);
      
      expect(recommendations.length, 2);
      expect(recommendations[0].name, 'Business Casual');
      expect(recommendations[1].name, 'Weekend Casual');
    });
  });
}
