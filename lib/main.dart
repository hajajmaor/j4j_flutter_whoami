/// Created by Maor Meir Hajaj
/// Github:
/// https://github.com/hajajmaor

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'J4J Introduce Yourself',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyan[100]!,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController,
      _emailController,
      _backgroundController,
      _techStackController,
      _ideasController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _backgroundController = TextEditingController();
    _techStackController = TextEditingController();
    _ideasController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _backgroundController.dispose();
    _techStackController.dispose();
    _ideasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Intrduce yourself"),
        actions: [
          IconButton(
            tooltip: "Reset the form",
            onPressed: () => _formKey.currentState?.reset(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Name",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Name is required";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email is required";
                }
                if (!value.contains("@")) {
                  return "Email must be valid";
                }
                return null;
              },
            ),
            TextFormField(
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              controller: _backgroundController,
              decoration: const InputDecoration(
                labelText: "Share Your Background",
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              controller: _techStackController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: "Tech Stack",
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              controller: _ideasController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Ideas",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final newListing = Listing(
                    name: _nameController.text,
                    email: _emailController.text,
                    background: _backgroundController.text,
                    techStack: _techStackController.text,
                    ideas: _ideasController.text,
                  );
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Your Listing"),
                        content: Text(newListing.toString()),
                        actions: [
                          TextButton.icon(
                            onPressed: () {
                              print(newListing);
                              _formKey.currentState!.reset();
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.send),
                            label: const Text("Submit"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text("Submit"),
            ),
          ]
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: e,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class Listing {
  final String name, email;
  final String? background, techStack, ideas;

  Listing({
    required this.name,
    required this.email,
    this.background,
    this.techStack,
    this.ideas,
  });

  @override
  String toString() {
    return "Name: $name\nEmail: $email\nBackground: $background\nTech Stack: $techStack\nIdeas: $ideas";
  }
}
