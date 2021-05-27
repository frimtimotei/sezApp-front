
import 'package:sezapp/api/seizure_api_service.dart';
import 'package:sezapp/model/Seizure.dart';

Future<List<Seizure>> getSeizures() async{

  var data= await apiGetAllSeizures();
  List<Seizure> seizures=[];
  for(var i in data)
  {
    Seizure seizure= Seizure.fromJson(i);
    seizures.add(seizure);
  }

  return seizures.reversed.toList();

}