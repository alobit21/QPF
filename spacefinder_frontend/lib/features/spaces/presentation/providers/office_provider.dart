import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/office_model.dart';
import '../../data/office_repository.dart';

final officesProvider = FutureProvider.autoDispose<List<Office>>((ref) async {
  final repository = ref.watch(officeRepositoryProvider);
  return repository.getOffices(limit: 10); // Fetch top 10 for now
});

final officeDetailsProvider = FutureProvider.family.autoDispose<Office, String>((ref, id) async {
  final repository = ref.watch(officeRepositoryProvider);
  return repository.getOfficeById(id);
});
