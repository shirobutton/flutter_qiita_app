import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client_provider.g.dart';

@riverpod
Dio apiClient(_) {
  final token = dotenv.env["QIITA_TOKEN"];
  final headers = token != null ? {"Authorization": "Bearer $token"} : null;
  final options = BaseOptions(
    baseUrl: 'https://qiita.com/api/v2/',
    headers: headers,
  );
  final dio = Dio(options);
  return dio;
}
