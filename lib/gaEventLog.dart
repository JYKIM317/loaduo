import 'package:firebase_analytics/firebase_analytics.dart';

Future<void> gaEvent(
    {required String eventName, Map<String, dynamic>? eventParams}) async {
  await FirebaseAnalytics.instance
      .logEvent(name: eventName, parameters: eventParams ?? {});
}
