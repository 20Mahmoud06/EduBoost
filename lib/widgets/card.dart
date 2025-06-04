import 'package:flutter/material.dart';
import 'package:learny/pages/new_account.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    super.key,
    required this.width,
    required this.image,
    required this.person,
  });

  final double width;
  final String image;
  final String person;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.4,
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NewAccount()));
        },
        child: Card(
          color: Color(0xFFC347FE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      image,
                      width: width * 0.3,
                      height: width * 0.25,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  person,
                  style: TextStyle(
                    fontFamily: 'Afacad',
                    fontSize: width * 0.06,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
