import 'package:mentoring_id/api/API.dart';
import 'package:mentoring_id/api/models/Ingfo.dart';
import 'package:url_launcher/url_launcher.dart';

class IngfoHandler {
  final API api;
  List<IngfoModel> cache;

  IngfoHandler(this.api);

  Future<void> fetch() async {
    await api.request(path: "info/view", animation: false).then((value) {
      final decode = api.safeDecoder(value.body) as List<dynamic>;
      cache = [];

      decode.forEach((ingfo) => cache.add(IngfoModel(ingfo)));
    });
  }

  void open(IngfoModel data) => launch(data.link);
}
