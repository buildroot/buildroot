import argparse
import sysv_ipc

parser = argparse.ArgumentParser()
parser.add_argument("input", help="input message queue key", type=int)
parser.add_argument("output", help="output message queue key", type=int)
parser.add_argument("count", help="iterations count", type=int)
args = parser.parse_args()

incoming = sysv_ipc.MessageQueue(args.input)
outgoing = sysv_ipc.MessageQueue(args.output)

for i in range(0, args.count):
    outgoing.send(f"ping {i}")

    s, _ = incoming.receive()
    print(s.decode())
