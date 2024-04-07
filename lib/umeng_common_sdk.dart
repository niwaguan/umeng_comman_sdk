import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class UmengCommonSdk {
  static const MethodChannel _channel = const MethodChannel('umeng_common_sdk');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<dynamic> preInit(String androidAppKey, String channel) async {
    if (Platform.isAndroid) {
      List<dynamic> params = [androidAppKey, channel];
      final dynamic result = await _channel.invokeMethod('preInit', params);
      return result;
    }
    return true;
  }

  static Future<dynamic> initCommon(
      String androidAppkey, String iosAppkey, String channel,
      [String? pushSecret]) async {
    List<dynamic> params = [];
    if (Platform.isAndroid) {
      params.addAll([androidAppkey, channel]);
    } else if (Platform.isIOS) {
      params.addAll([iosAppkey, channel]);
    }
    if (pushSecret?.isNotEmpty == true) {
      params.add(pushSecret);
    }
    final dynamic result = await _channel.invokeMethod('initCommon', params);
    return result;
  }

  static void onEvent(String event, Map<String, dynamic> properties) {
    List<dynamic> args = [event, properties];
    _channel.invokeMethod('onEvent', args);
  }

  static void onProfileSignIn(String userID) {
    List<dynamic> args = [userID];
    _channel.invokeMethod('onProfileSignIn', args);
  }

  static void onProfileSignOff() {
    _channel.invokeMethod('onProfileSignOff');
  }

  static void setPageCollectionModeManual() {
    _channel.invokeMethod('setPageCollectionModeManual');
  }

  static void onPageStart(String viewName) {
    List<dynamic> args = [viewName];
    _channel.invokeMethod('onPageStart', args);
  }

  static void onPageEnd(String viewName) {
    List<dynamic> args = [viewName];
    _channel.invokeMethod('onPageEnd', args);
  }

  static void setPageCollectionModeAuto() {
    _channel.invokeMethod('setPageCollectionModeAuto');
  }

  static void reportError(String error) {
    List<dynamic> args = [error];
    _channel.invokeMethod('reportError', args);
  }
}
