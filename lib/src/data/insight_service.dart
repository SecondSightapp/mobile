import "package:flutter/material.dart";
import './mood_star.dart';
import './moods.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'token.dart';
import './mood_star.dart';
import './insight.dart';

class InsightService {
  static Future<Insight> getInsight() async {
    const url = 'https://secondsight-backend.onrender.com/stars'; 

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${TokenService.token}', 
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> responseData = json.decode(response.body);
        return responseData.map((json) => Insight.fromJson(json)).toList()[0];
      } else {
        throw Exception('Failed to fetch moods. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred while fetching moods: $error');
      throw Exception('Error occurred while fetching moods: $error');
    }
  }
}