import 'package:flutter/material.dart';
import 'package:learny/widgets/card.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            double height = constraints.maxHeight;

            return Column(
              children: [
                Image.asset('assets/logos/logo.png',
                  width: width * 0.7,
                  height: height * 0.33,
                ),
                Text(
                  'Sign up as',
                  style: TextStyle(
                    fontFamily: 'NotoSerifTC',
                    fontSize: width * 0.095,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: height * 0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyCard(
                      width: width,
                      image: 'assets/people/student.png',
                      person: 'A student',
                    ),
                    MyCard(
                      width: width,
                      image: 'assets/people/parent.png',
                      person: 'A parent',
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02,),
                MyCard(
                    width: width,
                    image: 'assets/people/teacher.png',
                    person: 'A teacher',
                  ),
                SizedBox(height: height * 0.02,),
                TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    'Or go back to log in page',
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

