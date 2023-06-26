part of 'bottom_navbar_bloc.dart';

@immutable
class BottomNavbarState {
  final int navBarIndex;

  BottomNavbarState({required this.navBarIndex});
}

class BottomNavbarInitial extends BottomNavbarState {
  BottomNavbarInitial({required super.navBarIndex});
}