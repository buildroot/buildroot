import asyncio
from dbus_fast.aio import MessageBus
from dbus_fast.service import ServiceInterface, method
import dbus_fast.introspection as intr
from dbus_fast import BusType


class SampleInterface(ServiceInterface):
    def __init__(self):
        super().__init__('test.interface')

    @method()
    def Ping(self):
        pass

    @method()
    def ConcatStrings(self, what1: 's', what2: 's') -> 's':  # noqa: F821
        return what1 + what2


async def main():
    bus_name = 'dbus.fast.sample'
    obj_path = '/test/path'

    bus = await MessageBus(bus_type=BusType.SYSTEM).connect()
    bus2 = await MessageBus(bus_type=BusType.SYSTEM).connect()

    await bus.request_name(bus_name)

    service_interface = SampleInterface()
    bus.export(obj_path, service_interface)

    introspection = await bus2.introspect(bus_name, obj_path)
    assert type(introspection) is intr.Node
    obj = bus2.get_proxy_object(bus_name, obj_path, introspection)
    interface = obj.get_interface(service_interface.name)

    result = await interface.call_ping()
    assert result is None

    result = await interface.call_concat_strings('hello ', 'world')
    assert result == 'hello world'


asyncio.run(main())
