#include <pybind11/pybind11.h>
namespace py = pybind11;

int add (int i, int j) {
    return i + j;
}

PYBIND11_MODULE (example, m) {
    // optional module description
    m.doc() = "pybind11 example plugin";
    // test a module method
    m.def("add", &add, "example::add adds two integer numbers");
    // test a module attribute
    py::object hello = py::cast("Hello World");
    m.attr("says") = hello;
}
