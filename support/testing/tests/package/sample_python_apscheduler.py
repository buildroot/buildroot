from queue import Queue
from apscheduler.schedulers.background import BackgroundScheduler

queue = Queue()


def work():
    queue.put("Ping!")


scheduler = BackgroundScheduler()
scheduler.add_job(work, "interval", seconds=1)
scheduler.start()
result = queue.get(timeout=3)
assert result == "Ping!"
