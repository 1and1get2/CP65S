{
    Scope (\)
    {

  0024: 10 4C 08 5C 00                                   // .L.\.

        Name (DPTR, 0xC70A0000)

  0029: 08 44 50 54 52 0C 00 00 0A C7                    // .DPTR.....

        Name (EPTR, 0xC70B0000)

  0033: 08 45 50 54 52 0C 00 00 0B C7                    // .EPTR.....

        Name (CPTR, 0xC70A0010)

  003D: 08 43 50 54 52 0C 10 00 0A C7                    // .CPTR.....

        Mutex (MMUT, 0x00)

  0047: 5B 01 4D 4D 55 54 00                             // [.MMUT.

        Method (MDBG, 1, Serialized)
        {
            Store (Acquire (MMUT, 0x03E8), Local0)

  004E: 14 42 06 4D 44 42 47 09 70 5B 23 4D 4D 55 54 E8  // .B.MDBG.p[#MMUT.
  005E: 03 60                                            // .`

            If (LEqual (Local0, Zero))
            {

  0060: A0 4E 04 93 60 00                                // .N..`.

                OperationRegion (ABLK, SystemMemory, CPTR, 0x10)

  0066: 5B 80 41 42 4C 4B 00 43 50 54 52 0A 10           // [.ABLK.CPTR..

                Field (ABLK, ByteAcc, NoLock, Preserve)
                {
                    AAAA,   128
                }

                Store (Arg0, AAAA)
                Add (CPTR, 0x10, CPTR)

  0073: 5B 81 0C 41 42 4C 4B 01 41 41 41 41 40 08 70 68  // [..ABLK.AAAA@.ph
  0083: 41 41 41 41 72 43 50 54 52 0A 10 43 50 54 52     // AAAArCPTR..CPTR

                If (
  0092: A0 16 92                                         // ...

LGreaterEqual (CPTR, EPTR))
                {

  0095: 95 43 50 54 52 45 50 54 52                       // .CPTREPTR

                    Add (DPTR, 0x10, CPTR)
                }


  009E: 72 44 50 54 52 0A 10 43 50 54 52                 // rDPTR..CPTR

                Release (MMUT)
            }


  00A9: 5B 27 4D 4D 55 54                                // ['MMUT

            Return (Local0)
        }
    }
}



Table Header:
Table Body (Length 0xB1)
