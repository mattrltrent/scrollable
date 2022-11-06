// Example using ScrollableView, though it provides context to ScrollHaptics and KeyboardDismiss as well.

import 'package:flutter/material.dart';
import 'package:scrollable/exports.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController controller = ScrollController();

  @override
  void dispose() {
    controller.dispose(); // <----- Remember to dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Includes haptics (hard to show)"),
      ),
      body: ScrollableView(
        // MORE PROPERTIES GO HERE
        controller: controller,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          // ... HAS MANY MORE PROPERTIES ...
          controller: controller,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.blue,
                child: const Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "^ Inline padding. This allows the ScrollableView to have an 'in-scroll' offset, instead of having to wrap the outside of the scroll view with padding, or filling it with SizedBoxes. At bottom too.",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(width: double.infinity, height: 150, color: Colors.red),
              Container(
                  width: double.infinity, height: 150, color: Colors.green),
              Container(
                  width: double.infinity, height: 150, color: Colors.pink),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    const Text(
                      "Example textfield to open keyboard, and show it closes on scroll (or tap).",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 35),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Example textfield.",
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  width: double.infinity, height: 150, color: Colors.purple),
              Container(
                  width: double.infinity, height: 150, color: Colors.cyan),
              Container(
                  width: double.infinity, height: 150, color: Colors.brown),
              Container(
                  width: double.infinity,
                  height: 150,
                  color: Colors.orangeAccent),
              Container(
                  width: double.infinity,
                  height: 150,
                  color: Colors.lightGreen),
              Container(
                  width: double.infinity,
                  height: 150,
                  color: Colors.yellowAccent),
            ],
          ),
        ),
      ),
    );
  }
}
