# FlatBuffers for Dart

This package is used to read and write [FlatBuffers](https://flatbuffers.dev).

Most consumers will want to use the [`flatc` - FlatBuffer compiler](https://github.com/google/flatbuffers) binary for your platform.
You can download the flatc version matching your dart package version from [GitHub releases](https://github.com/google/flatbuffers/releases).

The FlatBuffer compiler `flatc` reads a FlatBuffers IDL schema and generates Dart code.
The generated classes can be used to read or write binary data/files that are interoperable with
other languages and platforms supported by FlatBuffers, as illustrated in the `example.dart` in the
examples folder.

For more details and documentation, head over to the official site and read the
[Tutorial](https://flatbuffers.dev/tutorial.html) and how to
[use FlatBuffers in Dart](https://flatbuffers.dev/languages/dart.html).
