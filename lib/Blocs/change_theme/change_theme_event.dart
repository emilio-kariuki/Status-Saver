part of 'change_theme_bloc.dart';

abstract class ChangeThemeEvent extends Equatable {
  const ChangeThemeEvent();

  @override
  List<Object> get props => [];
}

class InitialTheme extends ChangeThemeEvent {}

class ChangeTheme extends ChangeThemeEvent {}


