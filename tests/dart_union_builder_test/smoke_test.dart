import './out/agent_demo_generated.dart' as demo;
import 'package:flat_buffers/flat_buffers.dart' as fb;

void main() {
  // Test with TextInput
  final reqBuilder = demo.AgentRequestObjectBuilder(
      sessionId: 'abc-123',
      payloadType: demo.PayloadTypeId.TextInput,
      payload: demo.TextInputObjectBuilder(text: 'hello world'));

  final b = fb.Builder(initialSize: 1024);
  final root = reqBuilder.finish(b);
  b.finish(root);
  final buf = b.buffer;

  final agent = demo.AgentRequest(buf);
  assert(agent.sessionId == 'abc-123');
  assert(agent.payloadType == demo.PayloadTypeId.TextInput);
  final txt = agent.payload as demo.TextInput;
  assert(txt.text == 'hello world');
  print('TextInput union test passed!');

  // Test with Event
  final reqBuilder2 = demo.AgentRequestObjectBuilder(
      sessionId: 'def-456',
      payloadType: demo.PayloadTypeId.Event,
      payload: demo.EventObjectBuilder(code: 42));

  final b2 = fb.Builder(initialSize: 1024);
  final root2 = reqBuilder2.finish(b2);
  b2.finish(root2);
  final buf2 = b2.buffer;

  final agent2 = demo.AgentRequest(buf2);
  assert(agent2.sessionId == 'def-456');
  assert(agent2.payloadType == demo.PayloadTypeId.Event);
  final evt = agent2.payload as demo.Event;
  assert(evt.code == 42);
  print('Event union test passed!');

  // Test with StringValue
  final reqBuilder3 = demo.AgentRequestObjectBuilder(
      sessionId: 'ghi-789',
      payloadType: demo.PayloadTypeId.StringValue,
      payload: demo.StringValueObjectBuilder(value: 'a raw string'));

  final b3 = fb.Builder(initialSize: 1024);
  final root3 = reqBuilder3.finish(b3);
  b3.finish(root3);
  final buf3 = b3.buffer;

  final agent3 = demo.AgentRequest(buf3);
  assert(agent3.sessionId == 'ghi-789');
  assert(agent3.payloadType == demo.PayloadTypeId.StringValue);
  final strVal = agent3.payload as demo.StringValue;
  assert(strVal.value == 'a raw string');
  print('StringValue union test passed!');

  // Test with null union
  final reqBuilder4 = demo.AgentRequestObjectBuilder(
      sessionId: 'jkl-012', payloadType: null, payload: null);

  final b4 = fb.Builder(initialSize: 1024);
  final root4 = reqBuilder4.finish(b4);
  b4.finish(root4);
  final buf4 = b4.buffer;

  final agent4 = demo.AgentRequest(buf4);
  assert(agent4.sessionId == 'jkl-012');
  assert(agent4.payloadType == demo.PayloadTypeId.NONE);
  assert(agent4.payload == null);
  print('Null union test passed!');

  print('All tests passed!');
}