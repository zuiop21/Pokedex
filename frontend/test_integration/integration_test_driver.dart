import 'dart:io';
import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  try {
    await integrationDriver(
      onScreenshot: (String name, List<int> bytes,
          [Map<String, Object?>? args]) async {
        final file =
            await File('screenshots/$name.png').create(recursive: true);
        await file.writeAsBytes(bytes);
        return true;
      },
    );
  } catch (e) {
    print("Error occured: $e");
  }
}
