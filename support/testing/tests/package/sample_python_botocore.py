import botocore.session
session = botocore.session.get_session()
client = session.create_client('ec2', region_name="us-east-1")
