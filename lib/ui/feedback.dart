// ignore_for_file: must_be_immutable
import 'package:chatbot/userHomepage.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(
    BetterFeedback(
      theme: FeedbackThemeData(
        background: Colors.grey,
        feedbackSheetColor: Colors.grey[50]!,
        drawColors: [
          Colors.red,
          Colors.green,
          Colors.blue,
          Colors.yellow,
        ],
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalFeedbackLocalizationsDelegate(),
      ],
      localeOverride: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: ClipRRect(
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(05)),
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
                    'FEEDBACK',
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
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/screen-8.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: _FeedbackPage(),
        ),
      ),
    );
  }
}

class _FeedbackPage extends StatelessWidget {
  _FeedbackPage();

  double question1Rating = 3;
  double question2Rating = 3;
  double question3Rating = 3;
  String additionalFeedback = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildQuestionContainer(
            'Question 1: How satisfied are you with the service?',
            (rating) {
              question1Rating = rating;
            },
          ),
          const SizedBox(height: 16.0),
          _buildQuestionContainer(
            'Question 2: Did you find the information helpful?',
            (rating) {
              question2Rating = rating;
            },
          ),
          const SizedBox(height: 16.0),
          _buildQuestionContainer(
            'Question 3: Would you recommend us to your friends?',
            (rating) {
              question3Rating = rating;
            },
          ),
          const SizedBox(height: 20.0),
          _buildTextFeedbackContainer(),
          const SizedBox(height: 16.0),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (validateFeedback()) {
                  _showThankYouDialog(context);
                } else {
                  _showValidationError(context);
                }
              },
              child: const Text('Submit'),
            ),
          ),
          const SizedBox(height: 30.0),
        ],
      ),
    );
  }

  Widget _buildQuestionContainer(
      String question, Function(double) onRatingUpdate) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 4.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            question,
            style: const TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          const SizedBox(height: 8.0),
          RatingBar.builder(
            initialRating: 3,
            itemCount: 5,
            itemBuilder: (context, index) {
              IconData icon;
              Color color;
              switch (index) {
                case 0:
                  icon = Icons.sentiment_very_dissatisfied;
                  color = Colors.red;
                  break;
                case 1:
                  icon = Icons.sentiment_dissatisfied;
                  color = Colors.redAccent;
                  break;
                case 2:
                  icon = Icons.sentiment_neutral;
                  color = Colors.amber;
                  break;
                case 3:
                  icon = Icons.sentiment_satisfied;
                  color = Colors.lightGreen;
                  break;
                case 4:
                  icon = Icons.sentiment_very_satisfied;
                  color = Colors.green;
                  break;
                default:
                  icon = Icons.star;
                  color = Colors.amber;
              }
              return Icon(
                icon,
                color: color,
              );
            },
            onRatingUpdate: onRatingUpdate,
          ),
        ],
      ),
    );
  }

  Widget _buildTextFeedbackContainer() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 4.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Additional Feedback:',
            style: TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 8.0),
          TextField(
            maxLines: 10,
            onChanged: (value) {
              additionalFeedback = value;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              fillColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  bool validateFeedback() {
    return question1Rating > 0 &&
        question2Rating > 0 &&
        question3Rating > 0 &&
        additionalFeedback.isNotEmpty;
  }

  void _showValidationError(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Incomplete Feedback'),
          content: const Text(
              'Please answer all the questions and provide additional feedback.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showThankYouDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thank You!'),
          content: const Text('Your feedback has been submitted.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
