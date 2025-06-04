import 'dart:convert'; // For jsonEncode and jsonDecode
import 'package:learny/data/user_data.dart'; // Your UserData model
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _usersKey = 'app_users';
  static const String _currentUserEmailKey = 'current_user_email';

  Future<List<UserData>> _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final String? usersString = prefs.getString(_usersKey);
    if (usersString != null) {
      final List<dynamic> usersJson = jsonDecode(usersString);
      return usersJson.map((json) => UserData.fromJson(json)).toList();
    }
    return [];
  }

  Future<void> _saveUsers(List<UserData> users) async {
    final prefs = await SharedPreferences.getInstance();
    final String usersString = jsonEncode(users.map((user) => user.toJson()).toList());
    await prefs.setString(_usersKey, usersString);
  }

  Future<bool> registerUser(UserData newUser) async {
    final users = await _loadUsers();
    if (users.any((user) => user.email == newUser.email)) {
      print('Error: Email already exists.');
      return false;
    }
    users.add(newUser);
    await _saveUsers(users);
    print('User registered: ${newUser.email}');
    return true;
  }

  Future<UserData?> loginUser(String email, String password) async {
    final users = await _loadUsers();
    try {
      final user = users.firstWhere(
            (user) => user.email == email && user.password == password,
      );
      print('User logged in: ${user.email}');
      return user;
    } catch (e) {
      print('Error: Invalid email or password.');
      return null;
    }
  }

  Future<void> saveCurrentUserSession(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentUserEmailKey, email);
    print('Session saved for: $email');
  }

  Future<String?> getCurrentUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentUserEmailKey);
  }

  Future<UserData?> getUserByEmail(String email) async {
    final users = await _loadUsers();
    try {
      return users.firstWhere((user) => user.email == email);
    } catch (e) {
      return null;
    }
  }

  Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserEmailKey);
    print('User session cleared.');
  }

  Future<bool> updateUser(UserData updatedUser) async {
    final users = await _loadUsers();
    int userIndex = users.indexWhere((user) => user.email == updatedUser.email);
    if (userIndex != -1) {
      users[userIndex] = updatedUser;
      await _saveUsers(users);
      print('User data updated for: ${updatedUser.email}');
      return true;
    }
    print('Error: User not found for update.');
    return false;
  }

  // ### NEW METHOD: Delete User ###
  Future<bool> deleteUser(String email) async {
    final users = await _loadUsers();
    final initialLength = users.length;
    users.removeWhere((user) => user.email == email); // Remove the user with the matching email

    if (users.length < initialLength) { // Check if a user was actually removed
      await _saveUsers(users);
      // Also clear the current session if the deleted user was the logged-in user
      final currentEmail = await getCurrentUserEmail();
      if (currentEmail == email) {
        await logoutUser(); // This clears the _currentUserEmailKey
      }
      print('User account deleted for: $email');
      return true; // Deletion successful
    }
    print('Error: User not found for deletion with email: $email');
    return false; // User not found or deletion failed
  }
}
