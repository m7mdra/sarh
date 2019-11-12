import 'dart:async';
import 'dart:core' as prefix0;
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:pusher_websocket_flutter/pusher.dart';

class PusherService {
  var lastEvent;
  String lastConnectionState;
  var channel;

  StreamController<String> _eventData = StreamController<String>();
  Sink get _inEventData => _eventData.sink;
  Stream get eventStream => _eventData.stream;

  Future<void> initPusher() async {
    try {
      await Pusher.init('a1b5dfffe2ce60e288ca', PusherOptions(cluster: 'mt1'));
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  void connectPusher() {
    Pusher.connect(
        onConnectionStateChange: (ConnectionStateChange connectionState) async {
          lastConnectionState = connectionState.currentState.toString();
          prefix0.print("PUSHER CONNECT STATE In");
          print(lastConnectionState);
        }, onError: (ConnectionError e) {
      print("Error: ${e.message}");
    });

  }

  Future<void> subscribePusher(String channelName) async {
    prefix0.print('BEFORE SUBSCRIBE STATE');
    channel = await Pusher.subscribe(channelName);
    prefix0.print('SUBSCRIBE STATE');
    print(channel.toString());
  }

  void unSubscribePusher(String channelName) {
    Pusher.unsubscribe(channelName);
  }

  void bindEvent(String eventName) {
    channel.bind(eventName, (last) {
      prefix0.print('PUSHER BIND LAST DATA');
      print(last.data.toString());
      final String data = last.data;
      _inEventData.add(data);
    });
  }

  void unbindEvent(String eventName) {
    channel.unbind(eventName);
    _eventData.close();
  }

  Future<void> firePusher(String channelName, String eventName) async {
    await initPusher();
    connectPusher();
    await subscribePusher(channelName);
    bindEvent(eventName);
  }
}