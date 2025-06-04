import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learny/pages/enroll_page.dart';
import 'package:learny/widgets/custom_text_field.dart';
import 'package:learny/widgets/custom_checkbox_tile.dart';
import 'package:learny/widgets/custom_dropdown.dart';
import 'package:learny/data/nationalities.dart';
import 'package:learny/data/user_data.dart';
import 'package:learny/services/auth_service.dart';

class NewAccount extends StatefulWidget {
  final UserData? existingUserData;

  const NewAccount({super.key, this.existingUserData});

  @override
  State<NewAccount> createState() => _NewAccountState();
}

class _NewAccountState extends State<NewAccount> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _cityController = TextEditingController();
  final _schoolController = TextEditingController();
  final _dayController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();

  bool isMaleSelected = false;
  bool isFemaleSelected = false;
  String? selectedNationality;
  bool _isEditMode = false;

  static const Color fieldBackgroundColor = Color(0xFFBF33FF);
  static const Color fieldTextColor = Colors.white;
  // All error messages will now use this yellow color
  static const Color defaultErrorColor = Colors.yellow;

  @override
  void initState() {
    super.initState();
    if (widget.existingUserData != null) {
      _isEditMode = true;
      _populateFields(widget.existingUserData!);
    }
  }

  void _populateFields(UserData data) {
    _firstNameController.text = data.firstName;
    _lastNameController.text = data.lastName;
    _emailController.text = data.email;
    _phoneNumberController.text = data.phoneNumber;
    selectedNationality = data.nationality;
    _cityController.text = data.city;
    _schoolController.text = data.school;
    if (data.gender == "Male") {
      isMaleSelected = true;
      isFemaleSelected = false;
    } else if (data.gender == "Female") {
      isFemaleSelected = true;
      isMaleSelected = false;
    }
    _dayController.text = data.day;
    _monthController.text = data.month;
    _yearController.text = data.year;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    _cityController.dispose();
    _schoolController.dispose();
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    // 1. Validate the form: This will trigger validators and show error messages
    if (!_formKey.currentState!.validate()) {
      // If validation fails, show a general SnackBar and stop
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields correctly.'),
          backgroundColor: Colors.red, // SnackBar can remain red for emphasis
        ),
      );
      return;
    }

    // 2. Check gender selection
    if (!isMaleSelected && !isFemaleSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a gender.'), backgroundColor: Colors.red),
      );
      return;
    }

    // 3. Check password for new accounts
    if (!_isEditMode && _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password is required to create an account.'), backgroundColor: Colors.red),
      );
      return;
    }

    // If all checks pass, proceed to create/update UserData
    final userDataToSave = UserData(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      password: _isEditMode && _passwordController.text.isEmpty
          ? widget.existingUserData!.password
          : _passwordController.text,
      phoneNumber: _phoneNumberController.text,
      nationality: selectedNationality,
      city: _cityController.text,
      school: _schoolController.text,
      gender: isMaleSelected ? "Male" : "Female",
      day: _dayController.text,
      month: _monthController.text,
      year: _yearController.text,
      profileImageFile: _isEditMode ? widget.existingUserData?.profileImageFile : null,
      profileImagePath: _isEditMode ? widget.existingUserData?.profileImagePath : null,
    );

    if (_isEditMode) {
      bool success = await _authService.updateUser(userDataToSave);
      if (!mounted) return;
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account Updated Successfully!'), backgroundColor: Colors.green),
        );
        Navigator.pop(context, userDataToSave);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update account.'), backgroundColor: Colors.red),
        );
      }
    } else {
      bool success = await _authService.registerUser(userDataToSave);
      if (!mounted) return;
      if (success) {
        await _authService.saveCurrentUserSession(userDataToSave.email);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account Creation Successful! Logged In.'), backgroundColor: Colors.green),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EnrollPage(userData: userDataToSave)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration failed. Email might already exist.'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final Widget verticalSpacing = SizedBox(height: screenHeight * 0.01);
    final double fieldFontSize = screenWidth * 0.05;

    return SafeArea(
      child: Scaffold(
        appBar: _isEditMode
            ? AppBar(
          title: const Text('Edit Account', style: TextStyle(fontFamily: 'Afacad', color: Colors.white)),
          backgroundColor: fieldBackgroundColor,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        )
            : null,
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenHeight * 0.02),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled, // Ensures validation on submit
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (!_isEditMode) ...[
                    SizedBox(height: screenHeight * 0.01),
                    Center(
                      child: Text(
                        'Create new account',
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: screenWidth * 0.075,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                  ] else ...[
                    SizedBox(height: screenHeight * 0.02),
                  ],
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _firstNameController,
                          hint: 'First Name',
                          backgroundColor: fieldBackgroundColor,
                          textColor: fieldTextColor,
                          width: fieldFontSize,
                          errorTextColor: defaultErrorColor, // Pass yellow
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Please enter your first name';
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Expanded(
                        child: CustomTextField(
                          controller: _lastNameController,
                          hint: 'Last Name',
                          backgroundColor: fieldBackgroundColor,
                          textColor: fieldTextColor,
                          width: fieldFontSize,
                          errorTextColor: defaultErrorColor, // Pass yellow
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Please enter your last name';
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  verticalSpacing,
                  CustomTextField(
                    controller: _emailController,
                    hint: 'Email',
                    backgroundColor: fieldBackgroundColor,
                    textColor: fieldTextColor,
                    width: fieldFontSize,
                    errorTextColor: defaultErrorColor, // Pass yellow
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter an email';
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) return 'Please enter a valid email';
                      return null;
                    },
                  ),
                  if (!_isEditMode) ...[
                    verticalSpacing,
                    CustomTextField(
                      controller: _passwordController,
                      hint: 'Password',
                      backgroundColor: fieldBackgroundColor,
                      textColor: fieldTextColor,
                      isPassword: true,
                      width: fieldFontSize,
                      errorTextColor: defaultErrorColor, // Pass yellow
                      validator: (value) {
                        if (!_isEditMode && (value == null || value.isEmpty)) return 'Please enter a password';
                        if (value != null && value.isNotEmpty && value.length < 6) return 'Password must be at least 6 characters';
                        return null;
                      },
                    ),
                    verticalSpacing,
                    CustomTextField(
                      controller: _confirmPasswordController,
                      hint: 'Confirm Password',
                      backgroundColor: fieldBackgroundColor,
                      textColor: fieldTextColor,
                      width: fieldFontSize,
                      isPassword: true,
                      errorTextColor: defaultErrorColor, // Pass yellow
                      validator: (value) {
                        if (!_isEditMode && (value == null || value.isEmpty)) return 'Please confirm your password';
                        if (_passwordController.text.isNotEmpty && value != _passwordController.text) return 'Passwords do not match';
                        return null;
                      },
                    ),
                  ],
                  verticalSpacing,
                  CustomTextField(
                    controller: _phoneNumberController,
                    hint: 'Phone Number',
                    backgroundColor: fieldBackgroundColor,
                    textColor: fieldTextColor,
                    width: fieldFontSize,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    errorTextColor: defaultErrorColor, // Pass yellow
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter a phone number';
                      if (value.length < 10 || value.length > 11) return 'Enter a valid phone number';
                      return null;
                    },
                  ),
                  verticalSpacing,
                  CustomDropdownField(
                    hint: 'Nationality',
                    selectedValue: selectedNationality,
                    items: countries,
                    onChanged: (String? newValue) {
                      setState(() { selectedNationality = newValue; });
                    },
                    backgroundColor: fieldBackgroundColor,
                    textColor: fieldTextColor,
                    fontSize: fieldFontSize,
                    errorTextColor: defaultErrorColor, // Pass yellow
                    validator: (value) {
                      if (value == null) return 'Please select a nationality';
                      return null;
                    },
                  ),
                  verticalSpacing,
                  CustomTextField(
                    controller: _cityController,
                    hint: 'City',
                    backgroundColor: fieldBackgroundColor,
                    textColor: fieldTextColor,
                    width: fieldFontSize,
                    errorTextColor: defaultErrorColor, // Pass yellow
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter your city';
                      return null;
                    },
                  ),
                  verticalSpacing,
                  CustomTextField(
                    controller: _schoolController,
                    hint: 'School',
                    backgroundColor: fieldBackgroundColor,
                    textColor: fieldTextColor,
                    width: fieldFontSize,
                    errorTextColor: defaultErrorColor, // Pass yellow
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter your school';
                      return null;
                    },
                  ),
                  verticalSpacing,
                  Row(
                    children: [
                      Expanded(
                        child: CustomCheckboxTile(
                          title: 'Male',
                          initialValue: isMaleSelected,
                          backgroundColor: fieldBackgroundColor,
                          textColor: fieldTextColor,
                          onChanged: (newValue) {
                            setState(() {
                              if (newValue) { isMaleSelected = true; isFemaleSelected = false;}
                              else { isMaleSelected = false; }
                            });
                          },
                          fontSize: fieldFontSize,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      Expanded(
                        child: CustomCheckboxTile(
                          title: 'Female',
                          initialValue: isFemaleSelected,
                          backgroundColor: fieldBackgroundColor,
                          textColor: fieldTextColor,
                          onChanged: (newValue) {
                            setState(() {
                              if (newValue) { isFemaleSelected = true; isMaleSelected = false; }
                              else { isFemaleSelected = false; }
                            });
                          },
                          fontSize: fieldFontSize,
                        ),
                      ),
                    ],
                  ),
                  verticalSpacing,
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                          controller: _dayController,
                          hint: 'Day',
                          backgroundColor: fieldBackgroundColor,
                          textColor: fieldTextColor,
                          width: fieldFontSize,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(2)],
                          errorTextColor: defaultErrorColor, // Pass yellow
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Day?';
                            final day = int.tryParse(value);
                            if (day == null || day < 1 || day > 31) return 'Invalid';
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                          controller: _monthController,
                          hint: 'Month',
                          backgroundColor: fieldBackgroundColor,
                          textColor: fieldTextColor,
                          width: fieldFontSize,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(2)],
                          errorTextColor: defaultErrorColor, // Pass yellow
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Month?';
                            final month = int.tryParse(value);
                            if (month == null || month < 1 || month > 12) return 'Invalid';
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                          controller: _yearController,
                          hint: 'Year',
                          backgroundColor: fieldBackgroundColor,
                          textColor: fieldTextColor,
                          width: fieldFontSize,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4)],
                          errorTextColor: defaultErrorColor, // Pass yellow
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Year?';
                            final year = int.tryParse(value);
                            if (year == null || year < 1900 || year > DateTime.now().year) return 'Invalid';
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  verticalSpacing,
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      shadowColor: Colors.black54,
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15, vertical: screenHeight * 0.015),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: Text(
                      _isEditMode ? 'Save Changes' : 'Create',
                      style: TextStyle(fontFamily: 'Afacad', fontSize: screenWidth * 0.06, fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
