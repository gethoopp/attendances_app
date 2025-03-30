// ignore_for_file: unnecessary_null_comparison

import 'package:dart_amqp/dart_amqp.dart';

class AmqpConn {
  late Channel _channel;
  late Queue _queue;
  late Consumer _consumer;
  late Client _client;

  Future<void> initService() async {
    _client = Client(
      settings: ConnectionSettings(
          host: "localhost",
          port: 5672,
          authProvider: PlainAuthenticator('guset', 'guest')),
    );
    await _client.connect();
    _channel = await _client.channel();
    _queue = await _channel.queue("...", durable: true);
  }

  Future<void> listenMessage(Function(String message) onmessage) async {
    if (_queue != null) {
      _consumer.queue.consume();
      _consumer.listen((AmqpMessage messages) {
        String msg = messages.payloadAsString;
        onmessage(msg);
      });
    }
  }
}
