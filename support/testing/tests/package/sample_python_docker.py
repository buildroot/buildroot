import docker

client = docker.from_env()
info = client.info()
images = client.images.list()

assert len(images) > 0

print('Version:', info['ServerVersion'])
print('Images:')
for i in images:
    print(i.tags[0])
