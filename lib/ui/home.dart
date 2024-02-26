import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(5)),
          child: Container(
            width: double.infinity,
            color: const Color.fromARGB(255, 220, 198, 88),
            child: AppBar(
              title: Container(
                padding:
                    const EdgeInsets.only(top: 8), // Adjust the top padding
                child: const Text(
                  'AI CHATBOT',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontStyle: FontStyle.italic,
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
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            "assets/screen-2.jpg", // Replace with your image file path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Existing Container
                  Card(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFF69170),
                              Color(0xFF7D96E6),
                            ]),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: const Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 16.0, left: 16.0),
                                child: (Text("Hi! You Can Ask Me",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white))),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16.0),
                                child: (Text("Anything",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white))),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0, left: 16.0, bottom: 16.0),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/botface.jpg"),
                                    fit: BoxFit.cover),
                              ),
                              child: SizedBox(
                                height: 150,
                                width: 150,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: (Text("FEATURES AND BENEFITS",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255)))),
                  ),
                  const SizedBox(height: 25.0),
                  // Additional Containers
                  // Additional Containers
                  Container(
                    height: 200,
                    width: double.maxFinite,
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                        image: AssetImage(
                            "assets/screen-3.jpg"), // Replace with your image file path for Container 1
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Text(
                      "USER FEEDBACK",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    height: 200,
                    width: double.maxFinite,
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                        image: AssetImage(
                            "assets/screen-4.jpg"), // Replace with your image file path for Container 2
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Text(
                      "CHAT WITH BOT",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    height: 200,
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                        image: AssetImage("assets/screen-5.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Text(
                      "PROFILE PAGE",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
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
