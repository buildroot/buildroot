# The test needs some code to profile, it does not have to be much.

def run(a):
    print(a[0])


if __name__ == '__main__':
    # make sure there's at least a small allocation
    a = ['Hello World!']
    run(a)
