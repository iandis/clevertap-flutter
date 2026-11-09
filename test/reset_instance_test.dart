import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('clevertap_plugin/dart_to_native');

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('resetInstance should call resetInstance on the native channel',
      () async {
    final calls = <MethodCall>[];
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      calls.add(call);
      return null;
    });

    await CleverTapPlugin.resetInstance();

    expect(calls, hasLength(1));
    expect(
      calls.single,
      isA<MethodCall>()
          .having((it) => it.method, 'method', 'resetInstance')
          .having((it) => it.arguments, 'arguments', isEmpty),
    );
  });
}
