// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bottom_navbar_bloc.dart';

@immutable
abstract class BottomNavbarEvent {
  final int navBarIndex;
  BottomNavbarEvent({
    required this.navBarIndex,
  });
  
}

class OnTappedEvent extends BottomNavbarEvent {
  OnTappedEvent({required super.navBarIndex});
}
