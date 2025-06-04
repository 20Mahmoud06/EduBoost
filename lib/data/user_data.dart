import 'dart:io';
import 'dart:convert'; // For jsonEncode and jsonDecode

class UserData {
  final String firstName;
  final String lastName;
  final String email;
  final String password; // STORED FOR LOCAL AUTH ONLY - NOT BEST PRACTICE FOR REAL APPS
  final String phoneNumber;
  final String? nationality;
  final String city;
  final String school;
  final String gender;
  final String day;
  final String month;
  final String year;
  File? profileImageFile; // This cannot be directly serialized to JSON easily
  String? profileImagePath; // We'll store the path instead

  UserData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password, // Added for local storage
    required this.phoneNumber,
    this.nationality,
    required this.city,
    required this.school,
    required this.gender,
    required this.day,
    required this.month,
    required this.year,
    this.profileImageFile, // Keep for runtime use
    this.profileImagePath, // For serialization
  });

  String get fullName => '$firstName $lastName';
  String get dateOfBirth => '$day ${getMonthName(month)} $year';

  static String getMonthName(String monthNumber) {
    try {
      int monthInt = int.parse(monthNumber);
      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      if (monthInt >= 1 && monthInt <= 12) return months[monthInt - 1];
    } catch (e) {/* ignore */}
    return monthNumber;
  }

  // Method to convert UserData instance to a Map
  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'password': password, // Storing password for local check
    'phoneNumber': phoneNumber,
    'nationality': nationality,
    'city': city,
    'school': school,
    'gender': gender,
    'day': day,
    'month': month,
    'year': year,
    'profileImagePath': profileImageFile?.path, // Store path of the image file
  };

  // Factory constructor to create a UserData instance from a Map
  factory UserData.fromJson(Map<String, dynamic> json) {
    String? imagePath = json['profileImagePath'];
    return UserData(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'], // Retrieve password
      phoneNumber: json['phoneNumber'],
      nationality: json['nationality'],
      city: json['city'],
      school: json['school'],
      gender: json['gender'],
      day: json['day'],
      month: json['month'],
      year: json['year'],
      profileImagePath: imagePath,
      profileImageFile: imagePath != null ? File(imagePath) : null,
    );
  }
}
