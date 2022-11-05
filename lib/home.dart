import 'package:flutter/material.dart';
import 'package:paintink/app_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundColor: const Color(0xff28282b),
              child: CircleAvatar(
                radius: 96,
                backgroundColor: const Color(0xfff0f1f5),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/PaintInk-1.png',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff28282b),
              ),
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const AppWidget(),
                  ),
                  (route) => false),
              child: const Text(
                'Start drawing',
                style: TextStyle(
                  color: Color(0xfff0f1f5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
