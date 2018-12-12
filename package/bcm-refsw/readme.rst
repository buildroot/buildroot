Common build instructions
=========================

Address space layout randomization
----------------------------------

You might need to disable address space layout randomization when working with pre-compiled headers. (Recent) GCC sources contain the file *gcc/c-family/c-pch.c'* that has the function *int c_common_valid_pch (cpp_reader *pfile, const char *name, int fd)* which contains:: 

  /* If the text segment was not loaded at the same address as it was
     when the PCH file was created, function pointers loaded from the
     PCH will not be valid.  We could in theory remap all the function
     pointers, but no support for that exists at present.
     Since we have the same executable, it should only be necessary to
     check one function.  */
