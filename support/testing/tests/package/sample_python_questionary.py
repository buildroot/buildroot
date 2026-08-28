# questionary is tricky to test as there seems to be no option to pass in stdin.
# Therefore the ask is going to time out on purpose so the test can check if the ask
# was successfully written to stdout.

import questionary
import asyncio

async def main():
    try:
        async with asyncio.timeout(5):
            await questionary.press_any_key_to_continue().ask_async()
    except:
        raise

if __name__ == '__main__':
    asyncio.run(main())
