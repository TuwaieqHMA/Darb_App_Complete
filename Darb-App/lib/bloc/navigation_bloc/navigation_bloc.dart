import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final locator = GetIt.I.get<HomeData>();
  NavigationBloc() : super(NavigationInitial()) {
    on<ChangePageEvent>(changePage);
  }

  FutureOr<void> changePage(ChangePageEvent event, Emitter<NavigationState> emit) {
    locator.currentPageIndex = event.index;
    emit(ChangedPageState());
  }
  
}
