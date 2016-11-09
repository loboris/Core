{
Ultibo Odroid C2 unit

Copyright (C) 2016 - Rob Judd <judd@ob-wan.com>

Arch
====

 ARMv8 (Cortex A53)

Boards
======

 Odroid C2
 
Licence
=======

 LGPLv2.1 with static linking exception (See COPYING.modifiedLGPL.txt)
 
Credits
=======

 Information for this unit was obtained from:

 
References
==========

 

Odroid C2
=========
 
 This unit has no functionality other than to include all units relevant to the Nexus 7 (2012).
 
 This includes standard interfaces such as network, filesystem and storage as well as drivers
 that are specific to the Tegra 3 and are not included by anything else.
 
 Additional units can be included anywhere within a program and they will be linked during the
 compile process. This unit simply provides a convenient way to ensure all relevant units have
 been included.
 
}

{$mode delphi} {Default to Delphi compatible syntax}
{$H+}          {Default to AnsiString} 
{$inline on}   {Allow use of Inline procedures}

unit OdroidC2;

interface

uses GlobalConfig,
     GlobalConst,
     GlobalTypes,
     AmlogicS905,
     Platform,
     Threads,
     MMC,
     Mali450,
     USB,
     {DWCOTG,}
     {SMSC95XX,}
     Framebuffer,
     Console,
     Keyboard,
     Mouse,
     Filesystem,
     EXTFS,
     FATFS,
     NTFS,
     CDFS,
     VirtualDisk,
     Logging,
     Sockets,
     Winsock2,
     Services,
     SysUtils;

{==============================================================================}
{Nothing}
{==============================================================================}
{==============================================================================}

implementation

{==============================================================================}
{==============================================================================}
 
end.

