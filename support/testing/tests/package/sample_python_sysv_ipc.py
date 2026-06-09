import subprocess
import sys
import sysv_ipc

key = [303, 808]
iterations = 6

queue = [
    sysv_ipc.MessageQueue(key[0], sysv_ipc.IPC_CREX),
    sysv_ipc.MessageQueue(key[1], sysv_ipc.IPC_CREX)
]

procs = [None] * 2

procs[0] = subprocess.Popen([sys.executable, "/root/ping.py", str(key[0]), str(key[1]), str(iterations)])
procs[1] = subprocess.Popen([sys.executable, "/root/pong.py", str(key[1]), str(key[0]), str(iterations)])

for p in procs:
    try:
        errs = p.wait(timeout=15)
    except subprocess.TimeoutExpired:
        p.kill()
        errs = p.wait()

for q in queue:
    q.remove()
