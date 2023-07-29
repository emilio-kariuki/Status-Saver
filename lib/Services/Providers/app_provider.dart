import 'package:status_saver_bloc/Services/Repositories/app_repository.dart';

class AppProviders {
  Future<void> askPermissions() async {
    await AppRepository().askPermissions();
  }
}
