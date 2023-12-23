import 'package:loaduo/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ApiDataPage_model.dart';

class ApiDataViewModel {
  Future<void> launchAPIUrl() async {
    final Uri apiWeb = Uri.parse('https://developer-lostark.game.onstove.com');
    await launchUrl(apiWeb);
  }

  Future<void> saveAPI(String apikey) async {
    await ApiDataModel().saveApiKeyToLocal(apikey).then(
          (_) => Future.microtask(
            () => RoutePage(),
          ),
        );
  }
}
