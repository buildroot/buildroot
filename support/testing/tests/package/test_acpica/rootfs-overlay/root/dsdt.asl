DefinitionBlock ("", "DSDT", 2, "", "", 0x0)
{
    Name (STR0, "Hello Buildroot!")
    Name (INT1, 0x12345678)
    Method (TST2, 1)
    {
        printf ("Arg0=%o", Arg0)
    }
}
