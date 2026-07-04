import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../domain/office_model.dart';

final officeRepositoryProvider = Provider<OfficeRepository>((ref) {
  return OfficeRepository(ref.watch(dioProvider));
});

class OfficeRepository {
  final Dio _dio;

  OfficeRepository(this._dio);

  Future<List<Office>> getOffices({int page = 1, int limit = 10, String? city}) async {
    try {
      final Map<String, dynamic> queryParams = {
        'page': page,
        'limit': limit,
      };
      if (city != null) {
        queryParams['city'] = city;
      }
      
      final response = await _dio.get('/offices', queryParameters: queryParams);
      
      if (response.statusCode == 200) {
        final data = response.data['items'] as List;
        return data.map((e) => Office.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load offices');
      }
    } catch (e) {
      rethrow;
    }
  }
}
