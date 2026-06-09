import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/sensor_reading.dart';

class HistoryNotifier extends StateNotifier<List<SensorReading>> {
  HistoryNotifier() : super([]);

  void addReading(SensorReading reading) {
    if (state.isNotEmpty && state.first.receivedAt == reading.receivedAt) {
      return;
    }

    final updated = [reading, ...state];

    if (updated.length > 20) {
      updated.removeLast();
    }

    state = updated;
  }
}

final historyProvider =
    StateNotifierProvider<HistoryNotifier, List<SensorReading>>(
      (ref) => HistoryNotifier(),
    );
