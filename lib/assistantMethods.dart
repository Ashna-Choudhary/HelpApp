import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/address.dart';
import 'package:untitled1/appData.dart';
import 'package:untitled1/configMaps.dart';
import 'package:untitled1/requestAssistant.dart';

class AssistantMethods{

  static Future<String> searchCoordinateAddress(Position position, context) async
  {
    String placeAddress="";
    String url= "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";

    var response= await RequestAssistant.getRequest(url);

    if(response != "failed")
      {
        placeAddress= response["results"][0]["formatted_address"];

        Address userPickUpAddress = new Address();
        userPickUpAddress.longitude = position.longitude;
        userPickUpAddress.latitude = position.latitude;
        userPickUpAddress.placeName = placeAddress;

        Provider.of<AppData>(context, listen: false,).updatePickUpLocationAddress(userPickUpAddress);
      }
    return placeAddress;
  }
}