import 'package:chatbot/ui/accounts.dart';
import 'package:chatbot/userHomepage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _selectedDOB = "Choose Date Of Birth";
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _cpassword = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _emailid = TextEditingController();
  final TextEditingController _mobileno = TextEditingController();

  bool validateEmail(String value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    return emailValid;
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> saveUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _username.text);
    prefs.setString('email', _emailid.text);
    prefs.setString('mobileNumber', _mobileno.text);
    prefs.setString('dob', _selectedDOB);
  }

  Future<Map<String, String>> loadUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'username': prefs.getString('username') ?? '',
      'email': prefs.getString('email') ?? '',
      'mobileNumber': prefs.getString('mobileNumber') ?? '',
      'dob': prefs.getString('dob') ?? '',
    };
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1990, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String formatDate = DateFormat("MMMM dd, yyyy").format(selectedDate);
        _selectedDOB = formatDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Form(
      key: _formkey,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: ClipRRect(
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(20)),
            child: Container(
              width: double.infinity,
              color: Colors.blue,
              child: AppBar(
                leading: Container(
                  padding: const EdgeInsets.only(
                      left: 10, top: 10), // Adjust the padding
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
                  padding:
                      const EdgeInsets.only(top: 10), // Adjust the top padding
                  child: const Text(
                    'USER PROFILE DETAILS',
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
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Enter User Personal Details",
                      style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _username,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter User Name";
                        }
                        return null;
                      },
                      style: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(
                          fontSize: 10,
                          fontStyle: FontStyle.italic,
                          color: Colors.red,
                        ),
                        labelText: "Enter User Name",
                        labelStyle: const TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _emailid,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter User Email ID";
                        } else if (!validateEmail(value)) {
                          return "Invalid Email ID";
                        }
                        return null;
                      },
                      style: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(
                          fontSize: 10,
                          fontStyle: FontStyle.italic,
                          color: Colors.red,
                        ),
                        labelText: "Enter User Email ID",
                        labelStyle: const TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _mobileno,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter User Mobile Number";
                        }
                        return null;
                      },
                      style: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(
                          fontSize: 10,
                          fontStyle: FontStyle.italic,
                          color: Colors.red,
                        ),
                        labelText: "Enter User Mobile Number",
                        labelStyle: const TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      width: size.width,
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        style: const ButtonStyle(
                          alignment: Alignment.centerLeft,
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.transparent),
                        ),
                        child: Text(
                          _selectedDOB,
                          style: const TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: _password,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter User Password";
                        } else if (value.length < 6) {
                          return "Password should be greater then 5 digit";
                        }
                        return null;
                      },
                      style: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(
                          fontSize: 10,
                          fontStyle: FontStyle.italic,
                          color: Colors.red,
                        ),
                        labelText: "Enter Password",
                        labelStyle: const TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _cpassword,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Confirm Password";
                        } else if (value.length < 6) {
                          return "Password should be greater then 5 digit";
                        } else if (value != _password.text) {
                          return "Confirm Password not matches with Password";
                        }
                        return null;
                      },
                      style: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(
                          fontSize: 10,
                          fontStyle: FontStyle.italic,
                          color: Colors.red,
                        ),
                        labelText: "Enter Confirm Password",
                        labelStyle: const TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: size.width,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            if (_selectedDOB == "Choose Date Of Birth") {
                              toastMessage("Choose Date Of Birth");
                            } else {
                              saveUserCredentials();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AccountDetailsPage(
                                    enteredUsername: _username.text,
                                    enteredEmail: _emailid.text,
                                    enteredMobileNumber: _mobileno.text,
                                    enteredDOB: _selectedDOB,
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: const Text("SUBMIT",
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
