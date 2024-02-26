// ignore_for_file: use_build_context_synchronously

import 'package:chatbot/chatdatapage.dart';
import 'package:chatbot/userHomepage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import your ChatPage class

class HistoryPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const HistoryPage({Key? key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> fetchedData = [];
  List<Map<String, dynamic>> filteredList = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<List<Map<String, dynamic>>> fetchDataFromFirestore() async {
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('chat_messages');
      QuerySnapshot querySnapshot = await collectionReference.get();
      List<Map<String, dynamic>> records = [];
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        data['documentId'] = documentSnapshot.id;
        records.add(data);
      }
      return records;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
      return [];
    }
  }

  Future<void> fetchData() async {
    try {
      fetchedData = await fetchDataFromFirestore();
      filteredList = fetchedData;
      if (kDebugMode) {
        print("Data fetched!");
      }
      setState(() {});
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
    }
  }

  Future<void> deleteDocument(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('chat_messages')
          .doc(documentId)
          .delete();
      if (kDebugMode) {
        print('Document deleted successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting document: $e');
      }
    }
  }

  void searchList(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        filteredList = List.from(fetchedData);
        if (kDebugMode) {
          print("search no");
        }
      } else {
        filteredList = fetchedData
            .where((map) => map['documentId']
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()))
            .toList();
        if (kDebugMode) {
          print('search yes');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: ClipRRect(
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(20)),
          child: Container(
            width: double.infinity,
            color: Colors.blue,
            child: AppBar(
              leading: IconButton(
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
              title: const Text(
                'CHAT HISTORY',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 10,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 8, 8, 8)),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      searchList(_searchController.text);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25.0),
            ElevatedButton(
              onPressed: () async {
                try {
                  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                      .collection('chat_messages')
                      .get();
                  for (QueryDocumentSnapshot documentSnapshot
                      in querySnapshot.docs) {
                    await documentSnapshot.reference.delete();
                  }
                  if (kDebugMode) {
                    print('All documents deleted successfully');
                  }
                } catch (e) {
                  if (kDebugMode) {
                    print('Error deleting documents: $e');
                  }
                }
                if (kDebugMode) {
                  print("Delete from delete history");
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HistoryPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size.fromHeight(50.0),
              ),
              child: const Text(
                'Delete history',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 25.0),
            filteredList.isEmpty
                ? const Center(
                    child: Text(
                      "No data!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      for (int i = filteredList.length - 1; i >= 0; i--)
                        Center(
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Chathistorydata(
                                      maintitle: filteredList[i]['documentId'],
                                      message: filteredList[i]['message'],
                                      isSender: filteredList[i]['isSender'],
                                    ),
                                  ),
                                );
                              },
                              title: Center(
                                child: Text(
                                  filteredList[i]['documentId'],
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Confirm DELETE"),
                                            content: const Text(
                                                "Do you want to delete this item?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Cancel"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  deleteDocument(filteredList[i]
                                                      ['documentId']);
                                                  if (kDebugMode) {
                                                    print("Delete message");
                                                  }
                                                  Navigator.pop(context);
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const HistoryPage(),
                                                    ),
                                                  );
                                                },
                                                child: const Text("Delete"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
