import 'dart:async';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/core.dart';
import 'package:fl_clash/plugins/service.dart';
import 'package:fl_clash/state.dart';

import 'interface.dart';

class CoreLib extends CoreHandlerInterface {
  static CoreLib? _instance;

  Completer<bool> _connectedCompleter = Completer();

  CoreLib._internal();

  @override
  Future<String> preload() async {
    print('[CoreLib] preload() starting...');
    final res = await service?.init();
    print('[CoreLib] service?.init() result: $res');
    
    // CRITICAL FIX: Always complete the completer to prevent blocking
    // Even if init fails, we need to unblock other operations
    if (!_connectedCompleter.isCompleted) {
      _connectedCompleter.complete(true);
      print('[CoreLib] _connectedCompleter completed');
    }
    
    if (res?.isEmpty != true) {
      print('[CoreLib] preload() returning error: $res');
      return res ?? '';
    }
    
    final syncRes = await service?.syncAndroidState(
      globalState.getAndroidState(),
    );
    print('[CoreLib] syncAndroidState result: $syncRes');
    return syncRes ?? '';
  }

  factory CoreLib() {
    _instance ??= CoreLib._internal();
    return _instance!;
  }

  @override
  destroy() async {
    return true;
  }

  @override
  Future<bool> shutdown() async {
    await service?.shutdown();
    _connectedCompleter = Completer();
    return true;
  }

  @override
  Future<T?> invoke<T>({
    required ActionMethod method,
    dynamic data,
    Duration? timeout,
  }) async {
    final id = '${method.name}#${utils.id}';
    final result = await service
        ?.invokeAction(Action(id: id, method: method, data: data))
        .withTimeout(onTimeout: () => null);
    if (result == null) {
      return null;
    }
    return parasResult<T>(result);
  }

  @override
  Completer get completer => _connectedCompleter;
}

CoreLib? get coreLib => system.isAndroid ? CoreLib() : null;
