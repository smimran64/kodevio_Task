import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  static const String _baseUrl =
      'https://jsonplaceholder.typicode.com/users';

  // Fetch users from API

  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        return data
            .map((json) => UserModel.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Failed to load users. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Something went wrong while fetching users');
    }
  }
}
