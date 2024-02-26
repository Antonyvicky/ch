import 'package:chatbot/Settings.dart';
import 'package:chatbot/userHomepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountDetailsPage extends StatelessWidget {
  final String enteredUsername;
  final String enteredEmail;
  final String enteredMobileNumber;
  final String enteredDOB;

  const AccountDetailsPage({
    super.key,
    required this.enteredUsername,
    required this.enteredEmail,
    required this.enteredMobileNumber,
    required this.enteredDOB,
  });

  Future<Map<String, String>> loadUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'username': prefs.getString('username') ?? '',
      'email': prefs.getString('email') ?? '',
      'mobileNumber': prefs.getString('mobileNumber') ?? '',
      'dob': prefs.getString('dob') ?? '',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: ClipRRect(
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(10)),
          child: Container(
            width: double.infinity,
            color: Colors.blue,
            child: AppBar(
              leading: Container(
                padding: const EdgeInsets.only(left: 8, top: 8),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserHomepage(),
                      ),
                    );
                  },
                ),
              ),
              title: Container(
                padding: const EdgeInsets.only(top: 8),
                child: const Text(
                  'User Account Details',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 10,
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Map<String, String>>(
          future: loadUserCredentials(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              String username = snapshot.data?['username'] ?? enteredUsername;
              String email = snapshot.data?['email'] ?? enteredEmail;
              String mobileNumber =
                  snapshot.data?['mobileNumber'] ?? enteredMobileNumber;
              String dob = snapshot.data?['dob'] ?? enteredDOB;

              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue,
                      child: Text(
                        username.substring(0, 1).toUpperCase(),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildCredentialBox('Username', username),
                    _buildCredentialBox('Email', email),
                    _buildCredentialBox('Mobile Number', mobileNumber),
                    _buildCredentialBox('Date of Birth', dob),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildCredentialBox(String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
