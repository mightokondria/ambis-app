import 'dart:async';

class TryoutTimer {
  final int duration;
  final int timestamp;
  final Function(DateTime date, double progress) callback;
  final int interval;

  static String translate(int minutes) {
    String result = "";

    final DateTime convert =
        DateTime.fromMillisecondsSinceEpoch(minutes * 60 * 1000, isUtc: true);

    if (convert.day > 1) result += "${convert.day - 1} hari ";
    if (convert.hour > 0) result += "${convert.hour} jam ";
    if (convert.minute > 0) result += "${convert.minute} menit";

    return result;
  }

  TryoutTimer(this.duration, this.timestamp, this.callback,
      {this.interval: 1000}) {
    final int durationMs = (duration * 60 * 1000),
        target = getRounded() - durationMs;
    Timer.periodic(Duration(milliseconds: interval), (timer) {
      final int rounded = getRounded(), calculated = (durationMs - rounded);
      final DateTime result =
          DateTime.fromMillisecondsSinceEpoch(calculated, isUtc: true);
      final double progress = (calculated / target).abs();

      if (progress <= 0) timer.cancel();

      callback(result, 1 - progress);
    });
  }

  int getRounded() {
    return ((DateTime.now().millisecondsSinceEpoch - timestamp) / 1000)
            .round() *
        1000;
  }
}
