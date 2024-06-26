import 'package:flutter/material.dart';

class HomepageThree extends StatefulWidget {
  const HomepageThree({super.key});

  @override
  State<HomepageThree> createState() => _HomepageThreeState();
}

class _HomepageThreeState extends State<HomepageThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade900,
              Colors.blue.shade700,
              Colors.blue.shade500,
              Colors.blue.shade300,
              Colors.blue.shade100,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomepageThree(),
                    ));
              },
              child: Center(
                child: Container(
                    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Refresh",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
