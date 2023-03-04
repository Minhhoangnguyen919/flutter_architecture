import 'dart:io';

class DataConnectionChecker {
  DataConnectionChecker._();

  static final DataConnectionChecker _instance = DataConnectionChecker._();

  /// More info on why default port is 53
  /// here:
  /// - https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers
  /// - https://www.google.com/search?q=dns+server+port
  // ignore: constant_identifier_names
  static const int default_port = 53;

  /// Default timeout is 3 seconds.
  /// Timeout is the number of seconds before a request is dropped
  /// and an address is considered unreachable
  // ignore: constant_identifier_names
  static const Duration default_time_out = Duration(seconds: 3);

  List<AddressCheckResult> _lastTryResults = <AddressCheckResult>[];

  static final List<AddressCheckOptions> _addresses = [
    // Try to connect to free and fast DNS
    // Related site: https://www.hpe.com/us/en/insights/articles/get-faster-internet-with-better-dns-1909.html
    AddressCheckOptions(
      InternetAddress('1.1.1.1'),
      port: default_port,
      timeout: default_time_out,
    ),
    AddressCheckOptions(
      InternetAddress('8.8.4.4'),
      port: default_port,
      timeout: default_time_out,
    ),
    AddressCheckOptions(
      InternetAddress('208.67.222.222'),
      port: default_port,
      timeout: default_time_out,
    ),
  ];

  factory DataConnectionChecker() => _instance;

  Future<bool> get hasConnection async {
    List<Future<AddressCheckResult>> requests = [];

    for (var addressOptions in _addresses) {
      requests.add(_isHostReachable(addressOptions));
    }
    _lastTryResults = (await Future.wait(requests)).toList();
    return _lastTryResults.map((result) => result.isSuccess).contains(true);
  }
}

Future<AddressCheckResult> _isHostReachable(
  AddressCheckOptions options,
) async {
  Socket? sock;
  try {
    sock = await Socket.connect(
      options.address,
      options.port,
      timeout: options.timeout,
    );
    sock.destroy();
    return AddressCheckResult(options, true);
  } catch (e) {
    sock?.destroy();
    return AddressCheckResult(options, false);
  }
}

class AddressCheckResult {
  final AddressCheckOptions options;
  final bool isSuccess;

  AddressCheckResult(
    this.options,
    this.isSuccess,
  );

  @override
  String toString() => "AddressCheckResult($options, $isSuccess)";
}

class AddressCheckOptions {
  final InternetAddress address;
  final int port;
  final Duration timeout;

  AddressCheckOptions(
    this.address, {
    this.port = DataConnectionChecker.default_port,
    this.timeout = DataConnectionChecker.default_time_out,
  });

  @override
  String toString() => "AddressCheckOptions($address, $port, $timeout)";
}
