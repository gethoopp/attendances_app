import 'dart:convert';

import 'package:attendance_app/component/url.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketController {
  late WebSocketChannel webSocketChannel;

  void connectSocket() async {
    webSocketChannel =
        WebSocketChannel.connect(Uri.parse(Url.baseSocket + Url.socketUrl));
    await webSocketChannel.ready;
  }

  Stream<Map<String, dynamic>> get stream =>
      webSocketChannel.stream.map((event) => jsonDecode(event));

  void close() {
    webSocketChannel.sink.close();
  }
}
