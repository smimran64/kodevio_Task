import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class UserProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<UserModel> _users = [];
  List<UserModel> _filteredUsers = [];

  // Search state check korar jonno ekti variable

  bool _isSearching = false;

  bool _isLoading = false;
  String? _errorMessage;

  // Corrected Getter: Logic updated

  List<UserModel> get users => _isSearching ? _filteredUsers : _users;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch users from API

  Future<void> fetchUsers() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final fetchedData = await _apiService.fetchUsers();
      _users = fetchedData;
      _isSearching = false;
    } catch (e) {

      debugPrint("API Error: $e");
      _errorMessage = "Failed to load users. Please check your internet.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Pull to refresh

  Future<void> refreshUsers() async {
    await fetchUsers();
  }

  // Search users by name


  void searchUsers(String query) {
    if (query.isEmpty) {
      _isSearching = false;
      _filteredUsers = [];
    } else {
      _isSearching = true;
      _filteredUsers = _users
          .where((user) =>
          user.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  // Clear search

  void clearSearch() {
    _isSearching = false;
    _filteredUsers = [];
    notifyListeners();
  }
}