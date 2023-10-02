import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:proximity_picks/utils/utils.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;

  List proximityPicks = [];

  CollectionReference keywordscollection =
      FirebaseFirestore.instance.collection('keywords');
  CollectionReference shopscollection =
      FirebaseFirestore.instance.collection('shops');

  void getInfo(context) async {
    isLoading.value = true;
    proximityPicks.clear();
    try {
      QuerySnapshot querySnapshot1 = await shopscollection.get();
      QuerySnapshot querySnapshot2 = await keywordscollection.get();

      List allData = querySnapshot1.docs.map((doc) => doc.data()).toList();
      List allKeys = querySnapshot2.docs.map((doc) => doc.data()).toList();

      for (var i = 0; i < allData.length; i++) {
        Map data = allData[i] as Map;
        Map data2 = allKeys[i] as Map;

        // checking for matching keywords
        String key =
            findMatchingLists(data['shop']['keywords'], data2['keywords']);

        if (key.isNotEmpty) {
          if (calculateDistanceInMeter(data['shop'].latitude,
                  data['shop'].longitude, 12.8426859, 80.1565408) <
              10) {
            data["distance"] = calculateDistanceInMeter(data['shop'].latitude,
                data['shop'].longitude, 12.8426859, 80.1565408);
            data["matched_key"] = key;
            proximityPicks.add(data);
            // print(data);
          }
        }

        update();
      }
    } catch (ex) {
      showMessage(ex.toString(), context);
    } finally {
      isLoading.value = false;
    }
  }
}
