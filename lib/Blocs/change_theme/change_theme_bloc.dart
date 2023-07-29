import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../Utilities/shared_preference_manager.dart';

part 'change_theme_event.dart';
part 'change_theme_state.dart';

class ChangeThemeBloc extends Bloc<ChangeThemeEvent, ChangeThemeState> {
  ChangeThemeBloc() : super(const ChangeThemeChanged(isDark: false)) {

    on<InitialTheme>((event, emit) async {
      final bool isDark = await SharedPreferenceManager().isDark();
      emit(ChangeThemeChanged(isDark: isDark));
    });

    on<ChangeTheme>((event, emit) async {
      final bool isDark = await SharedPreferenceManager().isDark();
      emit(ChangeThemeChanged(isDark: !isDark));
      await SharedPreferenceManager().setTheme(isDark);
    });
  }
}
