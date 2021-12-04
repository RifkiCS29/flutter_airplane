import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_airplane/models/destination_model.dart';

class DestinationService {
  CollectionReference _destinationReference =
      FirebaseFirestore.instance.collection('destinations');

  Future<List<DestinationModel>> fetchDestinations() async { 
    try {
      QuerySnapshot result = await _destinationReference.get();
      
      List<DestinationModel> destinations = result.docs.map(
        (data) => DestinationModel.fromJson(
          data.id, data.data() as Map<String, dynamic>)
      ).toList();
      return destinations;
    } catch (e) {
      throw e;
    }
  }
}