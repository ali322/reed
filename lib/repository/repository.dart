library repository;

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:reed/model/model.dart';

part 'feed.dart';
part 'entry.dart';
part 'api.dart';

class APIClient extends http.BaseClient {
  final String apiKey;
  final http.Client _inner = new http.Client();

  APIClient(this.apiKey);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['X-Auth-Token'] = apiKey;
    return _inner.send(request);
  }
}
