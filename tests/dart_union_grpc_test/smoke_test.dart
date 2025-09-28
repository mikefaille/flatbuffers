import 'dart:typed_data';
import 'package:grpc/grpc.dart' as grpc;
import 'out/voice_gateway_zenith.voice_generated.dart' as fb;
import 'out/voice_gateway_zenith.voice_grpc.dart' as voice_grpc;

void main() async {
  // Test union ObjectBuilder
  final request = fb.AgentRequestObjectBuilder(
    sessionId: 'test-session-123',
    payloadType: fb.PayloadTypeId.TextInput,
    payload: fb.TextInputObjectBuilder(
      text: 'Hello voice gateway',
      confidence: 0.95),
    timestamp: BigInt.from(DateTime.now().millisecondsSinceEpoch)
  );

  // Test serialization
  final builder = fb.Builder(initialSize: 1024);
  final offset = request.finish(builder);
  builder.finish(offset);

  print('Serialized request: ${builder.buffer.length} bytes');

  // Test deserialization
  final parsed = fb.AgentRequest(builder.buffer);
  assert(parsed.sessionId == 'test-session-123');
  assert(parsed.payloadType == fb.PayloadTypeId.TextInput);

  final textInput = parsed.payload as fb.TextInput;
  assert(textInput.text == 'Hello voice gateway');
  assert(textInput.confidence! > 0.94 && textInput.confidence! < 0.96);

  print('✅ Union ObjectBuilder test passed');

  // Test gRPC client generation (compilation test)
  final channel = grpc.ClientChannel(
    'localhost',
    port: 50051,
    options: const grpc.ChannelOptions(
      credentials: grpc.ChannelCredentials.insecure(),
    ),
  );

  final client = voice_grpc.VoiceGatewayClient(channel);
  print('✅ gRPC client created successfully');

  await channel.shutdown();
  print('✅ All tests passed!');
}