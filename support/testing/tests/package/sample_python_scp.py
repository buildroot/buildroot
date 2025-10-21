import filecmp

from paramiko import SSHClient
from paramiko.client import AutoAddPolicy

from scp import SCPClient

ssh_client = SSHClient()
ssh_client.load_system_host_keys()
ssh_client.set_missing_host_key_policy(AutoAddPolicy)
ssh_client.connect('127.0.0.1', username='root')
scp_client = SCPClient(ssh_client.get_transport())
scp_client.get("/etc/hostname", "/tmp/hostname")

assert filecmp.cmp("/etc/hostname", "/tmp/hostname")
