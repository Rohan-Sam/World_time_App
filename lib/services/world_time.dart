import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location="";
  String time = "";
  String? flag;
  String? url;
  bool? isDaytime;

  WorldTime({required this.location,required this.flag , required this.url});

  Future<void> getTime() async {

    //Make request
    Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
    Map data = jsonDecode(response.body);

    //get properties
    String datetime = data['datetime'];
    String offset = data['utc_offset'];

    DateTime now = DateTime.parse(datetime.substring(0,26));
    isDaytime = now.hour  >  6 && now.hour < 16 ? true : false;
    time = DateFormat.jm().format(now);
    
  }

}





