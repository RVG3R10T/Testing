import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user.dart';
import '../../services/auth_service.dart';
import '../../services/api_client.dart';

// Auth state provider
final authStateProvider = StreamProvider<FirebaseUser?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
});

// Current user provider
final currentUserProvider = FutureProvider<User?>((ref) async {
  final authService = ref.watch(authServiceProvider);
  final apiClient = await ref.watch(apiClientProvider.future);
  
  if (authService.currentUser == null) {
    return null;
  }

  try {
    final userId = authService.currentUser!.uid;
    final response = await apiClient.get(
      '/users/$userId',
      fromJson: (json) => User.fromJson(json),
    );
    return response;
  } catch (e) {
    print('Error fetching current user: $e');
    return null;
  }
});

// Login notifier
final loginNotifierProvider = StateNotifierProvider<LoginNotifier, AsyncValue<void>>(
  (ref) => LoginNotifier(ref),
);

class LoginNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  LoginNotifier(this.ref) : super(const AsyncValue.data(null));

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final authService = ref.read(authServiceProvider);
      await authService.loginWithEmail(
        email: email,
        password: password,
      );
      state = const AsyncValue.data(null);
      // Refresh current user
      ref.invalidate(currentUserProvider);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// Register notifier
final registerNotifierProvider = StateNotifierProvider<RegisterNotifier, AsyncValue<void>>(
  (ref) => RegisterNotifier(ref),
);

class RegisterNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  RegisterNotifier(this.ref) : super(const AsyncValue.data(null));

  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    int? companyId,
  }) async {
    state = const AsyncValue.loading();
    try {
      final authService = ref.read(authServiceProvider);
      final apiClient = await ref.read(apiClientProvider.future);

      // Create Firebase user
      final firebaseUser = await authService.registerWithEmail(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );

      if (firebaseUser == null) {
        throw Exception('Failed to create user');
      }

      // Get ID token
      final idToken = await firebaseUser.getIdToken();

      // Create user in database
      await apiClient.post(
        '/auth/register',
        data: {
          'email': email,
          'first_name': firstName,
          'last_name': lastName,
          'company_id': companyId,
        },
      );

      state = const AsyncValue.data(null);
      // Refresh current user
      ref.invalidate(currentUserProvider);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// Logout notifier
final logoutNotifierProvider = StateNotifierProvider<LogoutNotifier, AsyncValue<void>>(
  (ref) => LogoutNotifier(ref),
);

class LogoutNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  LogoutNotifier(this.ref) : super(const AsyncValue.data(null));

  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      final authService = ref.read(authServiceProvider);
      await authService.logout();
      state = const AsyncValue.data(null);
      // Invalidate cached data
      ref.invalidate(currentUserProvider);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
