import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import 'home.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage(
      {super.key, required this.isEditing, required this.uid});
  final bool isEditing;
  final String uid;

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  CollectionReference keywordscollection =
      FirebaseFirestore.instance.collection('keywords');
  CollectionReference shopscollection =
      FirebaseFirestore.instance.collection('shops');

  List selectedOptions = [];
  List options = [];

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  void getInfo() async {
    if (widget.isEditing) {
      QuerySnapshot querySnapshot = await shopscollection.get();
      List allData = querySnapshot.docs.map((doc) => doc.data()).toList();

      for (var i = 0; i < allData.length; i++) {
        options.addAll((allData[i] as Map)['shop']['keywords']);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFF4F4),
            Colors.white,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).padding.top + 10, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.grid_4x4_rounded,
                    size: 22,
                    color: Color(0xFFE05656),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.isEditing
                    ? "Edit Your Favourites"
                    : "Choose Your Favourites",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Wrap(
                        children: options.map((tag) {
                          return GestureDetector(
                            onTap: () {
                              if (selectedOptions.contains(tag)) {
                                setState(() {
                                  selectedOptions.remove(tag);
                                });
                              } else {
                                setState(() {
                                  selectedOptions.add(tag);
                                });
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 8, top: 12),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: selectedOptions.contains(tag)
                                      ? const Color(0xFFE05656).withOpacity(0.2)
                                      : Colors.white,
                                  border: Border.all(
                                    width:
                                        selectedOptions.contains(tag) ? 2 : 1,
                                    color: selectedOptions.contains(tag)
                                        ? const Color(0xFFE05656)
                                        : Colors.grey,
                                  )),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: selectedOptions.contains(tag)
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: selectedOptions.contains(tag)
                                      ? const Color(0xFFE05656)
                                      : const Color(0xFF737373),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final user =
                            Provider.of<MyUser?>(context, listen: false);
                        if ((await keywordscollection.doc(user!.uid).get())
                            .exists) {
                          keywordscollection
                              .doc(user.uid)
                              .update({'keywords': selectedOptions})
                              .then((_) => print('Updated'))
                              .catchError(
                                  (error) => print('Update failed: $error'));
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => HomePage(uid: user.uid)),
                          );
                        } else {
                          keywordscollection
                              .doc(user.uid)
                              .set({'keywords': selectedOptions})
                              .then((_) => print('Added'))
                              .catchError(
                                  (error) => print('Add failed: $error'));
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => HomePage(uid: user.uid)),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: const Color(0xFFE05656),
                        ),
                        child: const Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
