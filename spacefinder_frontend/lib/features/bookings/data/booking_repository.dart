import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';

final bookingRepositoryProvider = Provider<BookingRepository>((ref) {
  return BookingRepository(ref.read(dioProvider));
});

class BookingRepository {
  final Dio _dio;

  BookingRepository(this._dio);

  Future<void> createBooking(String officeId, String slotId, int duration) async {
    await _dio.post('/bookings', data: {
      'officeId': officeId,
      'slotId': slotId,
      'duration': duration,
    });
  }
}
