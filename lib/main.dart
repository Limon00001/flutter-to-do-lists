import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // add key parameter

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
              'Curved Container with Floating Button'), // add const keyword
        ),
        body: Center(
          child: Container(
            width: 200.0,
            height: 200.0,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: const Center(
              child: Text(
                'Basic Container & Button UI',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your action here
          }, // add const keyword
          backgroundColor: Colors.blueAccent,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
              bottom: 16.0), // Adjust the padding as needed
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: Container(
              height: 56.0,
            ),
          ),
        ),
      ),
    );
  }
}
