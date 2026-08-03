import 'package:flutter_riverpod/flutter_riverpod.dart';

class GoogleAuthService {
  Future<dynamic> signIn() async {}
  Future<void> signOut() async {}
  Future<bool> hasDriveAccess() async => false;
  Future<bool> requestDriveAccess() async => false;
  Future<Map<String, String>?> getAuthHeaders() async => null;
}

final googleAuthProvider = NotifierProvider<GoogleAuthNotifier, dynamic>(
  GoogleAuthNotifier.new,
);

class GoogleAuthNotifier extends Notifier<dynamic> {
  @override
  dynamic build() => null;

  Future<void> signIn({Function? onSuccess, Function? onError, Function? onCanceled}) async {}
  Future<void> signOut() async {}
  Future<bool> hasDriveAccess() async => false;
  Future<bool> requestDriveAccess() async => false;
  Future<Map<String, String>?> getAuthHeaders() async => null;
}
