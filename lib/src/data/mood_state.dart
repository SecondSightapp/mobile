import "package:flutter/material.dart";
import 'package:secondsight/src/data/mood_star.dart';
import '../data/moods.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'token.dart';
import '../data/mood_star.dart';

class MoodService {
  static Future<List<MoodStar>> getStars() async {
    const url = 'https://secondsight-backend.onrender.com/stars'; 

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${TokenService.token}', 
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        return responseData.map((json) => MoodStar.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch moods. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred while fetching moods: $error');
      throw Exception('Error occurred while fetching moods: $error');
    }
  }

  static Future<void> addStar(String mood) async {
    const url = 'https://secondsight-backend.onrender.com/stars';

    final starData = {
      'mood': mood,
      'date': DateTime.now().toUtc().toIso8601String().substring(0, 10),
    };

    try {
      print('Request body: ${json.encode(starData)}');
      
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${TokenService.token}', 
          'Content-Type': 'application/json', 
        },
        body: json.encode(starData), 
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Star created successfully');
        print('Response body: ${response.body}');
      } else {
        print('Failed to create star. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }

    } catch (error) {
      print('Error occurred while creating star: $error');
      throw Exception('Error occurred while creating star: $error');
    }
  }
}