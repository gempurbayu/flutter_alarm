import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'h_event.dart';
part 'h_state.dart';

class HourBloc extends Bloc<HourEvent, HourState> {
  HourBloc() : super(HourInitial()) {
    on<SetHour>((event, emit) {
      var hour = event.hour.toString();
      if (hour.length < 2) {
        hour = '0' + hour;
      }
      emit(LoadedHour(hour: hour));
    });
  }
}