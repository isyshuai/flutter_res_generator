
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterRes {
  static const MethodChannel _channel =
      const MethodChannel('flutter_res');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

