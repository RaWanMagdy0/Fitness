import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    if (kDebugMode) {
      log('${bloc.runtimeType}', name: '🟢 Bloc/Cubit Created');
    }
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    if (kDebugMode) {
      log('${bloc.runtimeType}', name: '🔄 State Changed');
      log('Current State: ${change.currentState}',
          name: '⏪ ${bloc.runtimeType}');
      log('Next State: ${change.nextState}', name: '⏩ ${bloc.runtimeType}');
    }
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      log('${bloc.runtimeType}, $error', name: '❌ Error');
    }
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    if (kDebugMode) {
      log('${bloc.runtimeType}', name: '🛑 Bloc/Cubit Closed');
    }
    super.onClose(bloc);
  }
}
