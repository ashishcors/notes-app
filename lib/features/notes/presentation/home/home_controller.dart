import 'package:get/get.dart';

import '../../../../routing/app_pages.dart';
import '../../../auth/domain/usecases/get_logged_in_user_use_case.dart';
import '../../../auth/domain/usecases/sign_out_use_case.dart';
import '../../domain/entities/note.dart';
import '../../domain/usecases/get_notes_stream_use_case.dart';

class HomeController extends GetxController {
  final GetLoggedInUserUseCase _loggedInUserUseCase;
  final GetNotesSteamNoteUseCase _getNotesSteamNoteUseCase;
  final SignOutUseCase _signOutUseCase;

  HomeController(this._loggedInUserUseCase, this._getNotesSteamNoteUseCase,
      this._signOutUseCase);

  final isLoading = false.obs;

  // TODO: notes is exposed as mutable
  var notes = List<Note>.empty().obs;

  final userDisplayName = "".obs;

  @override
  void onInit() {
    super.onInit();
    _fetchUserDisplayName();
    _observerNotes();
  }

  Future<void> _fetchUserDisplayName() async {
    isLoading.value = true;
    final result = await _loggedInUserUseCase(null);
    result.fold(
      (value) {
        isLoading.value = false;
        userDisplayName.value = value.displayName;
      },
      (exception) {
        isLoading.value = false;
        Get.snackbar("Error!", exception.toString());
      },
    );
  }

  Future<void> _observerNotes() async {
    final result = await _getNotesSteamNoteUseCase(null);
    result.fold(
      (value) {
        value.listen((event) {
          notes.assignAll(event);
        });
      },
      (exception) {
        Get.snackbar("Error!", exception.toString());
      },
    );
  }

  void signOut() async {
    final result = await _signOutUseCase(null);
    result.fold(
      (value) => Get.offNamed(Routes.LOGIN),
      (exception) => Get.offNamed(Routes.LOGIN),
    );
  }
}
