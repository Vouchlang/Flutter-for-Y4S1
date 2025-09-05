import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String age;
  final String gender;
  final String dob;
  final String pob;
  final String currenAddress;
  final String status;
  final String job;
  final String hobby;

  const InfoScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.dob,
    required this.pob,
    required this.currenAddress,
    required this.status,
    required this.job,
    required this.hobby,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Info"),
        backgroundColor: Colors.cyan[200],
        elevation: 5,
        shadowColor: Colors.grey[50],
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  _buildInfoTile(
                    Icons.badge,
                    "First Name",
                    firstName,
                  ),
                  _buildInfoTile(
                    Icons.perm_identity,
                    "Last Name",
                    lastName,
                  ),
                  _buildInfoTile(
                    Icons.wc,
                    "Gender",
                    gender,
                  ),
                  _buildInfoTile(
                    Icons.cake_outlined,
                    "Age",
                    age,
                  ),
                  _buildInfoTile(
                    Icons.event,
                    "Date of Birth",
                    dob,
                  ),
                  _buildInfoTile(
                    Icons.location_on,
                    "Place of Birth",
                    pob,
                  ),
                  _buildInfoTile(
                    Icons.location_on,
                    "Current Address",
                    currenAddress,
                  ),
                  _buildInfoTile(
                    Icons.favorite,
                    "Status",
                    status,
                  ),
                  _buildInfoTile(Icons.work, "Job", job),
                  _buildInfoTile(
                    Icons.sports_soccer,
                    "Hobbies",
                    hobby,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildInfoTile(
  IconData icon,
  String label,
  String value,
) {
  return ListTile(
    contentPadding: const EdgeInsets.all(0),
    leading: Icon(icon),
    title: Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),
    subtitle: Text(
      value,
      style: const TextStyle(color: Colors.black54),
    ),
  );
}