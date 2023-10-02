import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:proximity_picks/screens/home.dart';

import '../models/user_model.dart';
import '../utils/utils.dart';

class PreferenceController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isEditLoading = false.obs;
  List selectedOptions = [];
  List options = [];
  CollectionReference keywordscollection =
      FirebaseFirestore.instance.collection('keywords');
  CollectionReference shopscollection =
      FirebaseFirestore.instance.collection('shops');

  void getInfo(bool isEditing) async {
    isLoading.value = true;
    options.clear();
    selectedOptions.clear();
    try {
      if (isEditing) {
        QuerySnapshot querySnapshot = await shopscollection.get();
        List allData = querySnapshot.docs.map((doc) => doc.data()).toList();

        for (var i = 0; i < allData.length; i++) {
          options.addAll((allData[i] as Map)['shop']['keywords']);
        }
        update();
      }
    } catch (ex) {
      showMessage(ex.toString(), Get.context!);
    } finally {
      isLoading.value = false;
    }
  }

  void addAndUpdateSelectedOptions(context) async {
    isEditLoading.value = true;
    try {
      final user = Provider.of<MyUser?>(context, listen: false);
      if ((await keywordscollection.doc(user!.uid).get()).exists) {
        keywordscollection
            .doc(user.uid)
            .update({'keywords': selectedOptions})
            // ignore: avoid_print
            .then((_) => print('Updated'))
            // ignore: avoid_print
            .catchError((error) => print('Update failed: $error'));
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          PageTransition(
            child: HomePage(uid: user.uid),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 300),
          ),
        );
      } else {
        keywordscollection
            .doc(user.uid)
            .set({'keywords': selectedOptions})
            // ignore: avoid_print
            .then((_) => print('Added'))
            // ignore: avoid_print
            .catchError((error) => print('Add failed: $error'));
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          PageTransition(
            child: HomePage(uid: user.uid),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 300),
          ),
        );
      }
    } catch (ex) {
      showMessage(ex.toString(), context);
    } finally {
      isEditLoading.value = false;
    }
  }
}
