import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_navbar_event.dart';
part 'bottom_navbar_state.dart';

class BottomNavbarBloc extends Bloc<BottomNavbarEvent, BottomNavbarState> {
  BottomNavbarBloc() : super(BottomNavbarInitial(navBarIndex: 0)) {
    on<OnTappedEvent>((event, emit) {
      emit(BottomNavbarState(navBarIndex: event.navBarIndex));
    });
  }
}
