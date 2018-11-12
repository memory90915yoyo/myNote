# thread


## function

```python
import threading
import random
import time
import datetime


def func(index):
    sleep_time = random.randint(1, 5)
    print("func call by thread {} and name {}, {}".format(index, threading.currentThread().getName(), datetime.datetime.now()))
    time.sleep(sleep_time)
    print("func call by thread {} and sleep {} second, {}".format(index, sleep_time, datetime.datetime.now()))


threads = []

for i in range(5):
    t = threading.Thread(target=func, args=(i,))
    threads.append(t)
    t.start()

for t in threads:
    t.join()
```

start(): 開始執行 thread

join(): 等待 thread 結束


## class

```python
import threading
import random
import time
import datetime


class MyThread(threading.Thread):
    def __init__(self, index):
        threading.Thread.__init__(self)
        self.index = index

    def run(self):
        sleep_time = random.randint(1, 5)
        print("class call by thread {} and name {}, {}".format(self.index, threading.currentThread().getName(), datetime.datetime.now()))
        time.sleep(sleep_time)
        print("class call by thread {} and sleep {} second, {}".format(self.index, sleep_time, datetime.datetime.now()))


threads = []

for i in range(5):
    t = MyThread(i)
    threads.append(t)
    t.start()

for t in threads:
    t.join()
```

overwrite run()


## queue

```python
import threading
import queue
import random
import time
import datetime


class Producer(threading.Thread):
    def __init__(self, queue):
        threading.Thread.__init__(self)
        self.queue = queue

    def run(self):
        for i in range(5):
            sleep_time = random.randint(1, 5)
            print("Producer: {}, sleep: {}, {}".format(threading.currentThread().getName(), sleep_time, datetime.datetime.now()))
            self.queue.put(sleep_time)


class Consumer(threading.Thread):
    def __init__(self, queue):
        threading.Thread.__init__(self)
        self.queue = queue

    def run(self):
        if self.queue.qsize() > 0:
            item = self.queue.get()
            print("Consumer: {}, {}".format(threading.currentThread().getName(), datetime.datetime.now()))
            time.sleep(item)
            print("Consumer: {}, sleep: {}, {}".format(threading.currentThread().getName(), item, datetime.datetime.now()))


q = queue.Queue()

p = Producer(q)
p.start()
p.join()

consumers = []

for i in range(5):
    c = Consumer(q)
    c.start()
    consumers.append(c)

for c in consumers:
    c.join()
```

queue.put(), queue.get()


## lock

```python
import threading
import datetime

resource_with_lock = 0
resource_without_lock = 0
COUNT = 1000000

lock = threading.Lock()


def increment_with_lock():
    global resource_with_lock
    for i in range(COUNT):
        lock.acquire()
        # print("increment_with_lock: {}, {}, {}".format(threading.currentThread().getName(), resource_with_lock,
        #                                                datetime.datetime.now()))
        resource_with_lock += 1
        lock.release()


def decrement_with_lock():
    global resource_with_lock
    for i in range(COUNT):
        lock.acquire()
        # print("decrement_with_lock: {}, {}, {}".format(threading.currentThread().getName(), resource_with_lock,
        #                                                datetime.datetime.now()))
        resource_with_lock -= 1
        lock.release()


def increment_without_lock():
    global resource_without_lock
    for i in range(COUNT):
        # print("increment_without_lock: {}, {}, {}".format(threading.currentThread().getName(), resource_without_lock,
        #                                                   datetime.datetime.now()))
        resource_without_lock += 1


def decrement_without_lock():
    global resource_without_lock
    for i in range(COUNT):
        # print("decrement_without_lock: {}, {}, {}".format(threading.currentThread().getName(), resource_without_lock,
        #                                                   datetime.datetime.now()))
        resource_without_lock -= 1


works = []
works.append(threading.Thread(target=increment_with_lock))
works.append(threading.Thread(target=decrement_with_lock))
works.append(threading.Thread(target=increment_without_lock))
works.append(threading.Thread(target=decrement_without_lock))

for work in works:
    work.start()

for work in works:
    work.join()

print(resource_with_lock)
print(resource_without_lock)
```

`unlocked`

```python
import threading


lock = threading.Lock()
lock.release()     # RuntimeError: release unlocked lock
```

`deadlock`

```python
import threading


lock = threading.Lock()
lock.acquire()
lock.acquire()     # block
lock.release()
```

lock.acquire()

lock.release()


## rlock

```python
import threading


lock = threading.RLock()
lock.acquire()
lock.acquire()
lock.release()
lock.release()
```


## semaphore

```python
import datetime
import random
import threading
import time

semaphore = threading.Semaphore(2)


def func(index):
    semaphore.acquire()
    sleep_time = random.randint(1, 5)
    print("func call by thread {} and name {}, {}".format(index, threading.currentThread().getName(), datetime.datetime.now()))
    time.sleep(sleep_time)
    print("func call by thread {} and sleep {} second, {}".format(index, sleep_time, datetime.datetime.now()))
    semaphore.release()


threads = []

for i in range(5):
    t = threading.Thread(target=func, args=(i,))
    threads.append(t)
    t.start()

for t in threads:
    t.join()
```

threading.Semaphore(n), n >= 0

semaphore.acquire(), => -1

semaphore.release(), => +1



## condition

```python
import datetime
import random
import threading
import time

items = []
condition = threading.Condition()


class Producer(threading.Thread):
    global condition
    global items

    def __init__(self):
        # threading.Thread.__init__(self)
        super().__init__()

    def run(self):
        condition.acquire()
        for i in range(5):
            sleep_time = random.randint(1, 5)
            print("Producer: {}, sleep: {}, {}".format(threading.currentThread().getName(), sleep_time, datetime.datetime.now()))
            items.append(sleep_time)
        condition.notify()
        condition.release()


class Consumer(threading.Thread):
    global condition
    global items

    def __init__(self):
        # threading.Thread.__init__(self)
        super().__init__()

    def run(self):
        condition.acquire()
        if len(items) <= 0:
            condition.wait()
            condition.notify()
        condition.release()

        item = items.pop()
        print("Consumer: {}, {}".format(threading.currentThread().getName(), datetime.datetime.now()))
        time.sleep(item)
        print("Consumer: {}, sleep: {}, {}".format(threading.currentThread().getName(), item, datetime.datetime.now()))
        

workers = []

for i in range(5):
    c = Consumer()
    c.start()
    workers.append(c)

p = Producer()
p.start()
workers.append(p)

for worker in workers:
    worker.join()

print(items)
```

condition.acquire()

condition.wait()

condition.notify()

condition.release()


## event

```python
import datetime
import random
import threading
import time

items = []
event = threading.Event()


class Producer(threading.Thread):
    global items

    def __init__(self, event):
        threading.Thread.__init__(self)
        self.event = event

    def run(self):
        for i in range(10):
            sleep_time = random.randint(1, 5)
            print("Producer: {}, sleep: {}, {}".format(threading.currentThread().getName(), sleep_time, datetime.datetime.now()))
            items.append(sleep_time)
        self.event.set()
        self.event.clear()


class Consumer(threading.Thread):
    global items

    def __init__(self, event):
        threading.Thread.__init__(self)
        self.event = event

    def run(self):
        if len(items) <= 0:
            self.event.wait()

        item = items.pop()
        print("Consumer: {}, {}".format(threading.currentThread().getName(), datetime.datetime.now()))
        time.sleep(item)
        print("Consumer: {}, sleep: {}, {}".format(threading.currentThread().getName(), item, datetime.datetime.now()))


workers = []

for i in range(5):
    c = Consumer(event)
    c.start()
    workers.append(c)

p = Producer(event)
p.start()
workers.append(p)

for worker in workers:
    worker.join()

print(items)
```
event.set()

event.clear()

event.wait()


## with

## barrier

## pool


---

# process


---

# async