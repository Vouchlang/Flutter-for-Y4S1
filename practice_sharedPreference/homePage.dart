import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller =
      TextEditingController();
  String _savedUsername = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  // Load username from SharedPreferences
  void _loadUsername() async {
    SharedPreferences prefs =
        await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    if (username != null) {
      setState(() {
        _savedUsername = username;
      });
    }
  }

  // Save username to SharedPreferences
  void _saveUsername() async {
    String username = _controller.text;
    if (username.isEmpty) return;
    SharedPreferences prefs =
        await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    setState(() {
      _savedUsername = username;
    });
    _controller.clear();
  }

  // Clear saved username (logout)
  void _clearUsername() async {
    SharedPreferences prefs =
        await SharedPreferences.getInstance();
    await prefs.remove('username');
    setState(() {
      _savedUsername = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreferences Demo'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Enter Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveUsername,
                child: const Text('Save Username'),
              ),
              const SizedBox(height: 16),
              Text(
                _savedUsername.isEmpty
                    ? 'No user saved'
                    : 'Saved Username: $_savedUsername',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              if (_savedUsername.isNotEmpty)
                ElevatedButton(
                  onPressed: _clearUsername,
                  child: const Text('Logout'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}