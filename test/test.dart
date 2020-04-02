import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kazpost_tracker/data/parcel.dart';

main() async {
  getParcel('RP166981607CV');
}

getParcel(String trackId) async {
  var url = 'http://track.kazpost.kz/api/v2/$trackId';

  var client = http.Client();
  var streamedRes = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRes.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((jsonParcel) => Parcel.fromMap(jsonParcel))
      .listen((data){
            if (data.error == null) {
              print(data.trackId);
            } else {
              print(data.error);
            }
          })
      .onDone(() => client.close());
}
