import 'package:bkd_presence_bloc/app/models/user_model.dart';
import 'package:bkd_presence_bloc/app/services/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'presence_history_event.dart';
part 'presence_history_state.dart';

class PresenceHistoryBloc
    extends Bloc<PresenceHistoryEvent, PresenceHistoryState> {
  final ApiService apiService = ApiService();
  PresenceHistoryBloc() : super(PresenceHistoryInitial()) {
    on<GetAllPresenceHistory>((event, emit) async {
      emit(PresenceHistoryLoading());
      List<Presence> presences = [];
      try {
        Map<String, dynamic> responses = await apiService.get(
          endpoint: 'presence',
          requireToken: true,
        );
        presences = responses['data']['presences'].map<Presence>((presence) {
          return Presence.fromJson(presence);
        }).toList();
        emit(PresenceHistoryLoaded(presences: presences));
      } catch (e) {
        emit(PresenceHistoryError(message: e.toString()));
      }
    });
  }
}
