import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:telekonsul/models/user/user.dart';

class PatientProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<UserModel> _patient = [];
  List<UserModel> get patient => _patient;

  final List<UserModel> _listAllPatient = [];
  List<UserModel> get listAllPatient => _listAllPatient;

  // Adding the patient data to the doctor subCollection, with the same id as the users
  // So it will be easier to check whether the document already existed or not, to prevent redudance
  addPatient(String? uid, Map<String, dynamic> data) async {
    final dataPatient = await FirebaseFirestore.instance
        .doc('doctor/$uid/patient/${data['doc_id']}')
        .get();

    if (dataPatient.exists) {
      return;
    }

    await FirebaseFirestore.instance
        .doc('doctor/$uid/patient/${data['doc_id']}')
        .set(data);
  }




}
