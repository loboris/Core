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
 
 Stock OS: Lubuntu 14.04 (also supports Android, Debian)

 SoC: Allwinner H2
 
 CPU: ARMv7-A Cortex-A7 (4 @ 1.2GHz)
 
 Cache: L1 ??KB I/D, L2 ???KB (Shared)
 
 GPU: Mali-400MP2 @600MHz (? pixel processors + ? vertex shaders) OpenGL ES2 + AVE H264/H265/VC1
 
 FPU: ???
 
 RAM: 256MB (??) or 512MB (SEC628 K484G16)
 
 USB: 1 USB 2.0 host + 2 USB (13-pin header) + Micro-B OTG 
 
 LAN: 10/100 passive jack with H1102NL external magnetics and POE
  
 SD/MMC: MicroSD Card slot
 
 WiFi: Allwinner XR819 (RTL8189) 802.11 b/g/n and mini wifi antenna
 
 Bluetooth: Nil
 
 Display: CVBS (on 13-pin header)
 
 Other: RasPi B+ compatible GPIO (26-pin header), IR + TVOUT + Mic + Stereo Audio + 2 USB (13-pin header)
 Other: Serial debug port header, optional 2MB SPI NOR flash

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

