import 'dart:convert';
import 'package:loaduo/ViewPage/MyPage/AddMyCharacter/AddMyCharacter_model.dart';

class AddMyCharacterViewModel {
  Future<Map<String, dynamic>?> searchUser({required String userName}) async {
    var response =
        await AddMyCharacterModel().getUserSiblingsDataAPI(userName: userName);
    int statusCode = response.statusCode;
    List<Map<String, dynamic>> lupeon = [],
        silian = [],
        aman = [],
        kharmine = [],
        kazeros = [],
        abrelshud = [],
        kadan = [],
        ninave = [];
    Map<String, dynamic> characterData = {};
    var body;
    if (statusCode == 200) {
      body = jsonDecode(response.body);
      if (body != null) {
        for (final character in body) {
          switch (character['ServerName']) {
            case '루페온':
              lupeon.add(character);
              break;
            case '실리안':
              silian.add(character);
              break;
            case '아만':
              aman.add(character);
              break;
            case '카마인':
              kharmine.add(character);
              break;
            case '카제로스':
              kazeros.add(character);
              break;
            case '아브렐슈드':
              abrelshud.add(character);
              break;
            case '카단':
              kadan.add(character);
              break;
            case '니나브':
              ninave.add(character);
              break;
          }
        }
        final List<dynamic> serverList = [
          lupeon,
          silian,
          aman,
          kharmine,
          kazeros,
          abrelshud,
          kadan,
          ninave
        ];
        for (List<dynamic> server in serverList) {
          if (server.isNotEmpty) {
            if (server.length >= 2) {
              server.sort(
                ((a, b) => double.parse(a['ItemAvgLevel'].replaceAll(',', ''))
                    .compareTo(
                        double.parse(b['ItemAvgLevel'].replaceAll(',', '')))),
              );
              server = server.reversed.toList();
            }
            characterData.addAll({server[0]['ServerName']: server});
          }
        }
      }
    }
    Map<String, dynamic> responseData = {
      'statusCode': statusCode,
      'body': characterData.isNotEmpty ? characterData : body,
    };
    return responseData;
  }

  Future<void> addMyExpedition({
    required String serverName,
    required String userName,
  }) async {
    Map<String, dynamic> myExpedition = {
      'representServer': serverName,
      'representCharacter': userName,
    };

    await AddMyCharacterModel().updateMyCharacter(data: myExpedition);
  }
}
