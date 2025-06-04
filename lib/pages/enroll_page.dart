import 'package:flutter/material.dart';
import 'package:learny/pages/classes.dart';
import 'package:learny/widgets/custom_dropdown.dart';
import 'package:learny/data/grades.dart'; // Make sure this exports schoolGrades
import 'package:learny/data/subjects.dart'; // Make sure this exports schoolSubjects
import 'package:learny/widgets/custom_text_field.dart'; // Ensure this widget has a controller property
import 'package:learny/widgets/teachers.dart'; // Your teacher card widget
import 'package:learny/widgets/custom_appbar.dart'; // We want to use CustomAppbar from this file
import 'package:learny/data/teachers_data.dart'; // This should export the global 'teachersData' list
import 'package:learny/data/teacher_profile_data.dart'; // For TeacherProfileData type
// Hide CustomAppbar from teacher_profile_page.dart if it's causing ambiguity
import 'package:learny/pages/teacher_profile_page.dart' hide CustomAppbar;
import 'package:learny/widgets/custom_bottom_navigation_bar.dart';
import 'package:learny/widgets/navigation_menu.dart';
import 'package:learny/pages/account.dart';
import 'package:learny/data/user_data.dart';

class EnrollPage extends StatefulWidget {
  final UserData userData;

  const EnrollPage({super.key, required this.userData});

  @override
  State<EnrollPage> createState() => _EnrollPageState();
}

class _EnrollPageState extends State<EnrollPage> {
  String? selectedGrade;
  String? selectedSubject;
  int _selectedIndex = 0;

  String _searchQuery = '';
  List<TeacherProfileData> _filteredTeachers = [];
  final TextEditingController _searchController = TextEditingController();

  // Colors as per your image and description
  static const Color fieldBackgroundColor = Color(0xFFBF33FF); // Purple background
  static const Color fieldTextColor = Colors.white;           // White text/icons

  @override
  void initState() {
    super.initState();
    _updateFilteredTeachers();
    _searchController.addListener(_handleSearchChange);
  }

  @override
  void dispose() {
    _searchController.removeListener(_handleSearchChange);
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearchChange() {
    if (_searchQuery != _searchController.text) {
      setState(() {
        _searchQuery = _searchController.text;
        _updateFilteredTeachers();
      });
    }
  }

  void _updateFilteredTeachers() {
    List<TeacherProfileData> tempFilteredList = List.from(teachersData);

    final String? cleanSelectedGrade = selectedGrade?.toLowerCase().trim();
    final String? cleanSelectedSubject = selectedSubject?.toLowerCase().trim();

    if (cleanSelectedGrade != null && cleanSelectedGrade.isNotEmpty) {
      tempFilteredList = tempFilteredList.where((teacher) {
        return teacher.grade.toLowerCase().trim() == cleanSelectedGrade;
      }).toList();
    }

    if (cleanSelectedSubject != null && cleanSelectedSubject.isNotEmpty) {
      tempFilteredList = tempFilteredList.where((teacher) {
        return teacher.subject.toLowerCase().trim() == cleanSelectedSubject;
      }).toList();
    }

    if (_searchQuery.isNotEmpty) {
      final String cleanSearchQuery = _searchQuery.toLowerCase().trim();
      tempFilteredList = tempFilteredList.where((teacher) {
        return teacher.name.toLowerCase().trim().contains(cleanSearchQuery);
      }).toList();
    }
    setState(() {
      _filteredTeachers = tempFilteredList;
    });
  }


  List<Widget> _getPageContents(Widget enrollContent, UserData currentUserData) {
    return <Widget>[
      enrollContent,
      Classes(userData: currentUserData),
      Account(userData: currentUserData),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double bottomNavIconSize = screenWidth * 0.09;
    final double bottomNavLabelSize = screenWidth * 0.04;
    final double bottomNavBarHeight = screenHeight * 0.085;

    Widget enrollPageContent = LayoutBuilder(
      builder: (context, constraints) {
        double cWidth = constraints.maxWidth;
        double cHeight = constraints.maxHeight;
        final double cFieldFontSize = cWidth * 0.045;
        final Widget verticalSpacing = SizedBox(height: cHeight * 0.015);

        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpacing,
                    CustomDropdownField(
                      hint: 'Grade',
                      selectedValue: selectedGrade,
                      items: schoolGrades,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGrade = newValue;
                          _updateFilteredTeachers();
                        });
                      },
                      backgroundColor: fieldBackgroundColor, // Purple background
                      textColor: fieldTextColor,           // White text
                      fontSize: cFieldFontSize,
                    ),
                    verticalSpacing,
                    CustomDropdownField(
                      hint: 'Subject',
                      selectedValue: selectedSubject,
                      items: schoolSubjects,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSubject = newValue;
                          _updateFilteredTeachers();
                        });
                      },
                      backgroundColor: fieldBackgroundColor, // Purple background
                      textColor: fieldTextColor,           // White text
                      fontSize: cFieldFontSize,
                    ),
                    verticalSpacing,
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 1.5,
                color: const Color(0xFF2B2020),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: _searchController,
                        hint: 'Search Teacher...',
                        width: cWidth * 0.04, // This width aims for the large size you like
                        backgroundColor: fieldBackgroundColor, // Purple background
                        textColor: fieldTextColor,           // White text/hint/icon
                        suffixIcon: Icon(
                          Icons.search,
                          color: fieldTextColor.withOpacity(0.8), // White icon
                          size: cFieldFontSize * 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    InkWell(
                      onTap: () {
                        print("Filter button tapped. Implement advanced filters here.");
                      },
                      child: Image.asset('assets/logos/filter.png', height: cFieldFontSize * 1.3),
                    ),
                  ],
                ),
              ),
              _filteredTeachers.isEmpty && (_searchQuery.isNotEmpty || (selectedGrade != null && selectedGrade!.isNotEmpty) || (selectedSubject != null && selectedSubject!.isNotEmpty))
                  ? Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: Text(
                    _searchQuery.isNotEmpty
                        ? "No teacher found matching '$_searchQuery'"
                        : "No teachers found for the selected filters.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700, fontFamily: 'Afacad'),
                  ),
                ),
              )
                  : Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _filteredTeachers.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.70,
                  ),
                  itemBuilder: (context, index) {
                    final teacherProfile = _filteredTeachers[index];
                    return Teachers(
                      image: teacherProfile.imageAsset,
                      person: teacherProfile.name,
                      grade: teacherProfile.grade,
                      subject: teacherProfile.subject,
                      curriculum: teacherProfile.curriculum,
                      onTap: () {
                        // When navigating, ensure TeacherProfilePage is unambiguously resolved
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TeacherProfilePage(teacherData: teacherProfile),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    final List<Widget> pageContents = _getPageContents(enrollPageContent, widget.userData);

    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppbar(), // Uses CustomAppbar from widgets/custom_appbar.dart
        drawer: NavigationMenu(userData: widget.userData),
        backgroundColor: Colors.white,
        body: pageContents.elementAt(_selectedIndex),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          iconSize: bottomNavIconSize,
          labelSize: bottomNavLabelSize,
          barHeight: bottomNavBarHeight,
        ),
      ),
    );
  }
}
