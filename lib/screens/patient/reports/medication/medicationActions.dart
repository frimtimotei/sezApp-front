import 'package:sezapp/api/medicationApiService.dart';
import 'package:sezapp/model/Medication.dart';

Future<List<Medication>> getMedications(userId) async{

  var data= await getAllMedications(userId);
  List<Medication> medications=[];
  for(var i in data)
  {
    Medication medication= Medication.fromJson(i);
    medications.add(medication);
  }

  return medications.toList();

}