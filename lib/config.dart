import 'package:flutter/material.dart';

class Config extends ChangeNotifier {
  final String _baseUrl = 'http://127.0.0.1:8000/api'; // 백엔드 서버 주소

  String get baseUrl => _baseUrl;
}
