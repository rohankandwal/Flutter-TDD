import 'dart:io';

// Used for reading the fixture JSONs. This is used to ensure that the test cases
// run without internet and with multiple scenarios
String fixture(String name) => File('test/fixtures/$name').readAsStringSync();