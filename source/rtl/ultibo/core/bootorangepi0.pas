{
Ultibo Initialization code for Orange Pi Zero

Copyright (C) 2016 - Rob Judd <judd@ob-wan.com>

Arch
====

 ARMv7-A (Cortex-A7)

Boards
======

 Orange Pi Zero

Licence
=======

 LGPLv2.1 with static linking exception (See COPYING.modifiedLGPL.txt)
 
Credits
=======

 Information for this unit was obtained from:

 
References
==========


Orange Pi Zero
==============

 Manufacturer: Xunlong, China
 
 Model: Orange Pi Zero
 
 Stock OS: Lubuntu 14.04

 SoC: Allwinner H2
 
 CPU: ARMv7-A Cortex-A7 (4 @ ??GHz)
 
 Cache: L1 ??KB I/D, L2 ???KB (Shared)
 
 GPU: Mali-400 (? pixel processors + ? vertex shaders) OpenGL ES2 ???MHz + AVE H264/H265/VC1
 
 FPU: ???
 
 RAM: 256MB or 512MB (Type?)
 
 USB: 1 USB 2.0 host + 2 USB (on 13-pin header) + Micro-B OTG 
 
 LAN: 10/100
  
 SD/MMC: MicroSD Card slot, optional SPI NOR flash on board
 
 WiFi: Allwinner XR819
 
 Bluetooth: Nil
 
 Display: CVBS (on 13-pin header)
 
 Other: GPIO (26), IR (on 13-pin header)

}

{$mode delphi} {Default to Delphi compatible syntax}
{$H+}          {Default to AnsiString} 
{$inline on}   {Allow use of Inline procedures}

unit BootOrangePi0;

interface

{==============================================================================}
{Global definitions} {Must be prior to uses}
{$INCLUDE GlobalDefines.inc}

uses GlobalConfig,GlobalConst,GlobalTypes,allwinnerh2,Platform,PlatformOrangePi0,PlatformARM,PlatformARMv7,Threads{$IFDEF CONSOLE_EARLY_INIT},Devices,Framebuffer,Console{$ENDIF}{$IFDEF LOGGING_EARLY_INIT},Logging{$ENDIF}; 

{==============================================================================}
{Boot Functions}
//procedure Startup;

//procedure Vectors; 
//procedure SecureVectors;

//procedure SecureMonitor;

//procedure StartupSwitch;
//procedure StartupSecure;
//procedure StartupHandler;

{==============================================================================}
{==============================================================================}

implementation

{==============================================================================}
{==============================================================================}
{Boot Functions}

{==============================================================================}
{==============================================================================}
 
end.

