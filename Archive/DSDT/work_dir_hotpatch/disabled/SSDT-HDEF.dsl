// Automatic injection of HDEF properties

DefinitionBlock("", "SSDT", 2, "hack", "HDEF", 0)
{
    External(_SB.PCI0.HDEF, DeviceObj)
    External(_SB.PCI0.HDEF.XDSM, MethodObj)
    External(RMCF.AUDL, IntObj)
    
    External (RMDT.P5, MethodObj)
    // Note: If your ACPI set (DSDT+SSDTs) does not define HDEF (or AZAL or HDAS)
    // add this Device definition (by uncommenting it)
    //
    //Device(_SB.PCI0.HDEF)
    //{
    //    Name(_ADR, 0x001b0000)
    //    Name(_PRW, Package() { 0x0d, 0x05 }) // may need tweaking (or not needed)
    //}

    // inject properties for audio
    Method(_SB.PCI0.HDEF._DSM, 4)
    {
        \RMDT.P5("_SB.PCI0.HDEF._DSM, Args:", Arg0, Arg1, Arg2, Arg3)
        
        If (!Arg2) { Return (Buffer() { 0x03 } ) }
        
        // call build in _DSM
        If (CondRefOf(\_SB.PCI0.HDEF.XDSM)) 
        { 
            \_SB.PCI0.HDEF.XDSM(Arg0, Arg1, Arg2, Arg3) 
        }
        
        If (CondRefOf(\RMCF.AUDL)) 
        { 
            If (Ones == \RMCF.AUDL) 
            { 
                If (CondRefOf(\_SB.PCI0.HDEF.XDSM)) 
                { 
                    return (\_SB.PCI0.HDEF.XDSM(Arg0, Arg1, Arg2, Arg3))
                } else { Return(0) }
            }
        }

        
        Local0 = Package()
        {
            "layout-id", Buffer(4) { 3, 0, 0, 0 },
            "hda-gfx", Buffer() { "onboard-1" },
            
            "codec-id", Buffer (0x04) { 0x92, 0x08, 0xEC, 0x10 },
            "device-type", Buffer (0x07) { "ALC892" }, 
            
            "PinConfigurations", Buffer() { },
//            "MaximumBootBeepVolume", Buffer() { 0x01 },
            
            "AAPL,slot-name", Buffer() { "Built in" },
            "device_type", Buffer() { "Audio Controller" },
            "built-in", Buffer() { 0x00 },
        }
        If (CondRefOf(\RMCF.AUDL))
        {
            CreateDWordField(DerefOf(Local0[1]), 0, AUDL)
            AUDL = \RMCF.AUDL
        }
        Return(Local0)
    }
}
//EOF
