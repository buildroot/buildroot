#! /usr/bin/env python3

from gnuradio import blocks
from gnuradio import gr

INPUT_LENGTH = 100
MUL_CONST = 3
ADD_CONST = 5


def compute_expected_data(input_data):
    # demux input
    even = input_data[::2]
    odd = input_data[1::2]

    # multiply "even" list by MUL_CONST
    even = [x * MUL_CONST for x in even]

    # add 5 to all "odd" elements
    odd = [y + ADD_CONST for y in odd]

    # mux the two lists
    mux = [v for t in zip(even, odd) for v in t]

    return mux


def main():

    gr.log.info("Starting Buildroot Test for GNU Radio " + gr.version())

    input_data = list(range(INPUT_LENGTH))

    tb = gr.top_block()

    # Create Gnuradio Blocks
    src = blocks.vector_source_i(input_data)
    demux = blocks.deinterleave(gr.sizeof_int)
    mul = blocks.multiply_const_ii(MUL_CONST)
    add = blocks.add_const_ii(ADD_CONST)
    mux = blocks.interleave(gr.sizeof_int)
    sink = blocks.vector_sink_i()

    # Create connection in top block
    tb.connect(src, demux)
    tb.connect((demux, 0), mul)
    tb.connect((demux, 1), add)
    tb.connect(mul, (mux, 0))
    tb.connect(add, (mux, 1))
    tb.connect(mux, sink)

    tb.run()

    gnuradio_data = sink.data()
    expected_data = compute_expected_data(input_data)

    # For easy debugging
    if gnuradio_data != expected_data:
        print("Gnuradio output:", gnuradio_data)
        print("Expected output:", expected_data)

    assert gnuradio_data == expected_data

    gr.log.info("Test PASSED")


if __name__ == "__main__":
    main()
