import 'agent_demo_generated.dart' as demo;
import 'package:flat_buffers/flat_buffers.dart' as fb;

void main() {
  final req = demo.AgentRequestObjectBuilder()
    ..sessionId = 'abc'
    ..payloadType = demo.PayloadTypeId.TextInput
    ..payload = (demo.TextInputObjectBuilder()..text = 'hello');

  final b = fb.Builder(initialSize: 1024);
  final root = req.finish(b);
  b.finish(root);

  final buf = b.buffer;
  final agent = demo.AgentRequest(buf);
  assert(agent.payloadType == demo.PayloadTypeId.TextInput);
  final txt = agent.payload as demo.TextInput;
  assert(txt.text == 'hello');

  print('Dart smoke test passed!');
}