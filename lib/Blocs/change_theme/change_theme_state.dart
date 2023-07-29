part of 'change_theme_bloc.dart';

abstract class ChangeThemeState extends Equatable {
  final bool isDark ;
  const ChangeThemeState(this.isDark);

  @override
  List<Object> get props => [];
}

class ChangeThemeChanged extends ChangeThemeState {

  const ChangeThemeChanged({required bool isDark}) : super(isDark);

  @override
  List<Object> get props => [isDark];
}
