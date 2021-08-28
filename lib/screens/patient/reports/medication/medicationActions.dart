import 'package:sezapp/api/medication_api_service.dart';
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