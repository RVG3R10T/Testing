import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/company.dart';
import '../../services/api_client.dart';

final companiesProvider = FutureProvider.family<Company, String>(
  (ref, companyId) async {
    final apiClient = await ref.watch(apiClientProvider.future);
    final response = await apiClient.get(
      '/companies/$companyId',
      fromJson: (json) => Company.fromJson(json),
    );
    return response;
  },
);

final createCompanyProvider = StateNotifierProvider<CreateCompanyNotifier, AsyncValue<Company>>(
  (ref) => CreateCompanyNotifier(ref),
);

class CreateCompanyNotifier extends StateNotifier<AsyncValue<Company>> {
  final Ref ref;

  CreateCompanyNotifier(this.ref) : super(const AsyncValue.loading());

  Future<void> createCompany({
    required String name,
    String? description,
    String? logo,
    String? website,
  }) async {
    state = const AsyncValue.loading();
    try {
      final apiClient = await ref.read(apiClientProvider.future);
      final company = await apiClient.post<Company>(
        '/companies',
        data: {
          'name': name,
          'description': description,
          'logo': logo,
          'website': website,
        },
        fromJson: (json) => Company.fromJson(json),
      );
      state = AsyncValue.data(company);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
