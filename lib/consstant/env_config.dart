class EnvConfig {
  /// REST API
  static const baseUrl = String.fromEnvironment(
    'BASE_URL',

    /*Dev*/
    defaultValue: 'http://192.168.0.6:85/',

    /*Prod*/
    // defaultValue: 'https://go-attendance-app-f1a53d9d812c.herokuapp.com/',
  );

  /// WebSocket
  static const baseSocket = String.fromEnvironment(
    'BASE_SOCKET',
    /*Dev*/
    defaultValue: 'ws://192.168.0.6:85/',
    /*Production*/
    // defaultValue:  'wss://go-attendance-app-f1a53d9d812c.herokuapp.com/';
  );
}
