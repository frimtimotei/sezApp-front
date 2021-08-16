import 'package:sezapp/api/doctor_api_service.dart';
import 'package:sezapp/model/Medication.dart';

Future<List<Medication>> getPatientMedications(patientId) async{

  var data= await getAllPatientMedications(patientId);
  List<Medication> medications=[];
  for(var i in data)
  {
    Medication medication= Medication.fromJson(i);
    medications.add(medication);
  }

  return medications.toList();

}