{
Ultibo BeFS File System interface unit

Copyright (C) 2015 - Rob Judd <judd@ob-wan.com>

Arch
====

 <All>

Boards
======

 <All>

Licence
=======

 LGPLv2.1 with static linking exception (See COPYING.modifiedLGPL.txt)
 
Credits
=======

 Information for this unit was obtained from:

 
References
==========

 "Practical File System Design with the Be File System" by Dominic Giampaolo
 
 
BE FileSystem
=============


}

{$mode delphi} {Default to Delphi compatible syntax}
{$H+}          {Default to AnsiString}
{$inline on}   {Allow use of Inline procedures}

unit BEFS;

interface

uses GlobalConfig,GlobalConst,GlobalTypes,Platform,Threads,FileSystem,SysUtils,Classes,Unicode,Ultibo,UltiboUtils,UltiboClasses;


{==============================================================================}
{Global definitions}
{$INCLUDE GlobalDefines.inc}

{==============================================================================}
const
 {BEFS specific constants}
 befs = 0;

 befsNames: String = ('BEFS');
             
{==============================================================================}
type
 {BEFS specific types}
 TBEFSType = (etNONE,etBEFS);
 
{==============================================================================}
type
 {BEFS specific classes}
 TBEFSRecognizer = class(TRecognizer)
   constructor Create(ADriver:TFileSysDriver);
  private
   {Private Variables}
   
  protected
   {Protected Variables}

   {Protected Methods}
   function GetName:String; override;
  public
   {Public Variables}

   {Public Methods}
   function RecognizePartitionId(APartitionId:Byte):Boolean; override;
   function RecognizeBootSector(ABootSector:PBootSector;const AStartSector,ASectorCount:Int64):Boolean; override;
   
   function RecognizePartition(APartition:TDiskPartition):Boolean; override;
   function RecognizeVolume(AVolume:TDiskVolume):Boolean; override;
   function MountVolume(AVolume:TDiskVolume;ADrive:TDiskDrive):Boolean; override;
 end;
 
 TBEFSPartitioner = class(TDiskPartitioner)
   constructor Create(ADriver:TFileSysDriver;ARecognizer:TRecognizer);
  private
   {Private Variables}

   {Private Methods}
  protected
   {Protected Variables}

   {Protected Methods}
   function CheckLogical(ADevice:TDiskDevice;AParent:TDiskPartition;APartitionId:Byte):Boolean; override;
   function CheckExtended(ADevice:TDiskDevice;AParent:TDiskPartition;APartitionId:Byte):Boolean; override;

   function GetPartitionId(ADevice:TDiskDevice;AParent:TDiskPartition;AStart,ACount:LongWord;APartitionId:Byte):Byte; override;

   function InitPartition(ADevice:TDiskDevice;AParent:TDiskPartition;AStart,ACount:LongWord;APartitionId:Byte):Boolean; override;
  public
   {Public Variables}

   {Public Methods}
   function AcceptPartition(ADevice:TDiskDevice;APartition,AParent:TDiskPartition;APartitionId:Byte):Boolean; override;
 end;
 
 TBEFSFileSystem = class(TFileSystem)
   constructor Create(ADriver:TFileSysDriver;AVolume:TDiskVolume;ADrive:TDiskDrive);
   destructor Destroy; override;
  private
   {Private Variables}
  public
   {Public Variables}
   //To Do
 end;
 
{==============================================================================}
{var}
 {BEFS specific variables}
 
{==============================================================================}
{Initialization Functions}
procedure BEFSInit;
procedure BEFSQuit;

{==============================================================================}
{BEFS Functions}
//To Do 

{==============================================================================}
{BEFS Helper Functions}
//To Do 

{==============================================================================}
{==============================================================================}

implementation

{==============================================================================}
{==============================================================================}
var
 {BEFS specific variables}
 BEFSInitialized:Boolean;

{==============================================================================}
{==============================================================================}
{TBEFSRecognizer}
constructor TBEFSRecognizer.Create(ADriver:TFileSysDriver);
begin
 {}
 inherited Create(ADriver);
 FAllowDrive:=False;
 FAllowDefault:=False;
 
 FPartitioner:=TBEFSPartitioner.Create(FDriver,Self);
 //To Do
end;

{==============================================================================}

function TBEFSRecognizer.GetName:String;
begin
 {}
 Result:='BEFS';
end;

{==============================================================================}

function TBEFSRecognizer.RecognizePartitionId(APartitionId:Byte):Boolean; 
begin
 {}
 Result:=False;

 if not ReaderLock then Exit;
 try
  if FDriver = nil then Exit;

  case APartitionId of
   pidBeOSExtended,pidExtended,pidExtLBA:begin
     {BeOS or DOS Extended Partition}
     Result:=True;
    end;
   pidBeOSSwap:begin
     {BeOS Swap Partition}
     Result:=True;
    end;
   pidBeOSNative:begin
     {BeOS Native Partition}
     Result:=True;
    end;
  end;
 finally  
  ReaderUnlock;
 end; 
end;
  
{==============================================================================}
  
function TBEFSRecognizer.RecognizeBootSector(ABootSector:PBootSector;const AStartSector,ASectorCount:Int64):Boolean; 
begin
 {}
 Result:=False;

 if not ReaderLock then Exit;
 try
  if FDriver = nil then Exit;

  //To Do
 finally  
  ReaderUnlock;
 end; 
end;
  
{==============================================================================}

function TBEFSRecognizer.RecognizePartition(APartition:TDiskPartition):Boolean;
begin
 {}
 Result:=False;

 if not ReaderLock then Exit;
 try
  if FDriver = nil then Exit;
  if APartition = nil then Exit;

  case APartition.PartitionId of
   pidBeOSExtended,pidExtended,pidExtLBA:begin
     {BeOS or DOS Extended Partition}
     APartition.Extended:=True;
     APartition.Recognized:=True;
     
     Result:=True;
    end;
   pidBeOSSwap:begin
     {BeOS Swap Partition}
     APartition.Recognized:=True;
     APartition.NonVolume:=True;
     
     Result:=True;
    end;
   pidBeOSNative:begin
     {BeOS Native Partition}
     APartition.Recognized:=True;
     
     Result:=True;
    end;
  end;
 finally  
  ReaderUnlock;
 end; 
end;

{==============================================================================}

function TBEFSRecognizer.RecognizeVolume(AVolume:TDiskVolume):Boolean;
begin
 {}
 Result:=False;

 if not ReaderLock then Exit;
 try
  if FDriver = nil then Exit;
  if AVolume = nil then Exit;

  //To Do
 finally  
  ReaderUnlock;
 end; 
end;

{==============================================================================}

function TBEFSRecognizer.MountVolume(AVolume:TDiskVolume;ADrive:TDiskDrive):Boolean;
var
 FileSystem:TBEFSFileSystem;
begin
 {}
 Result:=False;

 if not ReaderLock then Exit;
 try
  if FDriver = nil then Exit;
  if AVolume = nil then Exit;

  {Check Recognized}
  if not RecognizeVolume(AVolume) then Exit;

  {Create FileSystem}
  FileSystem:=TBEFSFileSystem.Create(FDriver,AVolume,ADrive);
  FileSystem.FileSystemInit;
  FileSystem.MountFileSystem;
  
  Result:=True;
 finally  
  ReaderUnlock;
 end; 
end;

{==============================================================================}
{==============================================================================}
{TBEFSPartitioner}
constructor TBEFSPartitioner.Create(ADriver:TFileSysDriver;ARecognizer:TRecognizer);
begin
 {}
 inherited Create(ADriver,ARecognizer);
end;

{==============================================================================}

function TBEFSPartitioner.CheckLogical(ADevice:TDiskDevice;AParent:TDiskPartition;APartitionId:Byte):Boolean;
{Note: Caller must hold the device and parent lock}
begin
 {}
 Result:=False;
 
 if ADevice = nil then Exit;

 {Check Type}
 case APartitionId of
  pidBeOSNative:begin
    if AParent = nil then Exit;
    
    Result:=True;
   end;
 end;
end;

{==============================================================================}

function TBEFSPartitioner.CheckExtended(ADevice:TDiskDevice;AParent:TDiskPartition;APartitionId:Byte):Boolean;
{Note: Caller must hold the device and parent lock}
begin
 {}
 Result:=False;
 
 if ADevice = nil then Exit;

 {Check Type}
 case APartitionId of
  pidBeOSExtended,pidExtended,pidExtLBA:begin
    Result:=True;
   end;
 end;
end;

{==============================================================================}

function TBEFSPartitioner.GetPartitionId(ADevice:TDiskDevice;AParent:TDiskPartition;AStart,ACount:LongWord;APartitionId:Byte):Byte;
{Note: Start is the absolute start sector on the device}
{Note: Caller must hold the device and parent lock}
var
 LBA:Boolean;
begin
 {}
 Result:=pidUnused;
 
 if ACount = 0 then Exit;
 if ADevice = nil then Exit;

 {Get LBA}
 LBA:=(ADevice.LBA and ((ADevice.PhysicalCylinders > 1024) or (ADevice.PhysicalCylinders = 0)));
 {Check Type}
 case APartitionId of
  pidBeOSExtended:begin
    Result:=APartitionId;
    if AParent <> nil then
     begin
      {Check Parent}
      case AParent.PartitionId of
       pidExtended,pidExtLBA:begin
         {Parent is DOS Extended}
         Result:=pidExtended;
         
         {DOS only allows standard type for second level Extended}
         {if (LBA) and (AParent = nil) then Result:=pidExtLBA;}
        end;
      end;
     end;
   end;
  pidExtended,pidExtLBA:begin
    Result:=APartitionId;
    {DOS only allows standard type for second level Extended}
    if (LBA) and (AParent = nil) then Result:=pidExtLBA;
    if AParent <> nil then
     begin
      {Check Parent}
      case AParent.PartitionId of
       pidBeOSExtended:begin
         Result:=pidBeOSExtended;
        end;
      end;
     end;
   end;
  pidBeOSNative,pidBeOSSwap:begin
    Result:=APartitionId;
   end;
 end;
end;

{==============================================================================}

function TBEFSPartitioner.InitPartition(ADevice:TDiskDevice;AParent:TDiskPartition;AStart,ACount:LongWord;APartitionId:Byte):Boolean;
{Note: Start is the absolute start sector on the device}
{Note: Caller must hold the device and parent lock}
begin
 {}
 Result:=False;
 
 if ACount = 0 then Exit;
 if ADevice = nil then Exit;

 {Check Type}
 case APartitionId of
  pidBeOSExtended,pidExtended,pidExtLBA:begin
    {Initialize Partition Record}
    Result:=FillSectors(ADevice,nil,AStart,1,FInitChar);
   end;
  pidBeOSNative,pidBeOSSwap:begin
    {Initialize Boot Sectors}
    Result:=FillSectors(ADevice,nil,AStart,16,FInitChar);
   end;
 end;
end;

{==============================================================================}

function TBEFSPartitioner.AcceptPartition(ADevice:TDiskDevice;APartition,AParent:TDiskPartition;APartitionId:Byte):Boolean;
{Note: Caller must hold the device, partition and parent lock}
begin
 {}
 Result:=False;

 if not ReaderLock then Exit;
 try
  if FDriver = nil then Exit;
  if FRecognizer = nil then Exit;

  if APartition = nil then
   begin
    {Accept Create Partition}
    if ADevice = nil then Exit;
    
    {Check Device}
    if (ADevice.MediaType <> mtFIXED) and (ADevice.MediaType <> mtREMOVABLE) then Exit;
    
    {Check Partition and Volume}
    if (FDriver.GetPartitionByDevice(ADevice,False,FILESYS_LOCK_NONE) = nil) and (FDriver.GetVolumeByDevice(ADevice,False,FILESYS_LOCK_NONE) <> nil) then Exit; {Do not lock}
    
    {Check Parent}
    if AParent <> nil then
     begin
      {Check Extended}
      if not AParent.Extended then Exit;
      
      {Check First Level}
      if AParent.Partition <> nil then Exit;
     end;
     
    {Check Type}
    case APartitionId of
     pidBeOSExtended,pidExtended,pidExtLBA,pidBeOSSwap:begin
       {Check Parent}
       if AParent <> nil then Exit;
       
       Result:=True;
      end;
     pidBeOSNative:begin
       Result:=True;
      end;
    end;
   end
  else
   begin
    if APartitionId = pidUnused then
     begin
      {Accept Delete Partition}
      {Check Children}
      if (AParent = nil) and (FDriver.GetPartitionByPartition(APartition,False,FILESYS_LOCK_NONE) <> nil) then Exit; {Do not lock}
      
      Result:=True;
     end
    else if APartitionId <> APartition.PartitionId then
     begin
      {Accept Modify Partition}
      {Check Extended}
      if APartition.Extended then Exit;
      
      {Nothing}
     end
    else if APartitionId = APartition.PartitionId then
     begin
      {Accept Activate Partition}
      {Check Primary}
      if not APartition.Primary then Exit;
      
      {Check Type}
      case APartitionId of
       pidBeOSNative:begin
         Result:=True;
        end;
      end;
     end;
   end;
 finally  
  ReaderUnlock;
 end; 
end;

{==============================================================================}
{==============================================================================}
{TBEFSFileSystem}
constructor TBEFSFileSystem.Create(ADriver:TFileSysDriver;AVolume:TDiskVolume;ADrive:TDiskDrive);
begin
 {}
 inherited Create(ADriver,AVolume,ADrive);
 FReadOnly:=False;
 FLongNames:=True;
 FDataStreams:=False;
 FReparsePoints:=False;
 FCaseSensitive:=True;
 //To Do 
end;

{==============================================================================}

destructor TBEFSFileSystem.Destroy;
begin
 {}
 //To Do 
 inherited Destroy;
end;

{==============================================================================}
{==============================================================================}
{Initialization Functions}
procedure BEFSInit;
var
 Recognizer:TBEFSRecognizer;
begin
 {}
 {Check Initialized}
 if BEFSInitialized then Exit;
 
 {Check Driver}
 if FileSysDriver = nil then Exit;
 
 {Create BEFS Recognizer}
 if FILESYS_BEFS_ENABLED then
  begin
   Recognizer:=TBEFSRecognizer.Create(FileSysDriver);
   Recognizer.AllowDrive:=FILESYS_DRIVES_ENABLED;
   Recognizer.AllowDefault:=BEFS_DEFAULT;
  end;
 
 BEFSInitialized:=True;
end;

{==============================================================================}

procedure BEFSQuit;
var
 NextRecognizer:TRecognizer;
 CurrentRecognizer:TRecognizer;
 NextFileSystem:TFileSystem;
 CurrentFileSystem:TFileSystem;
begin
 {}
 {Check Initialized}
 if not BEFSInitialized then Exit;
 
 {Check Driver}
 if FileSysDriver = nil then Exit;
 
 {Terminate FileSystems}
 NextFileSystem:=FileSysDriver.GetFileSystemByNext(nil,True,False,FILESYS_LOCK_READ); 
 while NextFileSystem <> nil do
  begin
   CurrentFileSystem:=NextFileSystem;
   NextFileSystem:=FileSysDriver.GetFileSystemByNext(CurrentFileSystem,True,False,FILESYS_LOCK_READ); 
   
   if CurrentFileSystem is TBEFSFileSystem then
    begin
     {Convert FileSystem}
     CurrentFileSystem.ReaderConvert;
    
     {FileSysDriver.RemoveFileSystem(CurrentFileSystem);} {Done by Destroy}
     CurrentFileSystem.DismountFileSystem;
     CurrentFileSystem.Free;
    end
   else
    begin
     {Unlock FileSystem}
     CurrentFileSystem.ReaderUnlock;
    end;    
  end;

 {Terminate Recognizer}
 NextRecognizer:=FileSysDriver.GetRecognizerByNext(nil,True,False,FILESYS_LOCK_READ); 
 while NextRecognizer <> nil do
  begin
   CurrentRecognizer:=NextRecognizer;
   NextRecognizer:=FileSysDriver.GetRecognizerByNext(CurrentRecognizer,True,False,FILESYS_LOCK_READ);
   
   if CurrentRecognizer is TBEFSRecognizer then
    begin
     {Convert Recognizer}
     CurrentRecognizer.ReaderConvert;

     {FileSysDriver.RemoveRecognizer(CurrentRecognizer);} {Done by Destroy}
     CurrentRecognizer.Free;
    end
   else
    begin
     {Unlock Recognizer}
     CurrentRecognizer.ReaderUnlock;
    end;    
  end;
 
 BEFSInitialized:=False;
end;

{==============================================================================}
{==============================================================================}
{BEFS Functions}

{==============================================================================}
{==============================================================================}
{BEFS Helper Functions}

{==============================================================================}
{==============================================================================}

initialization
 BEFSInit;

{==============================================================================}
 
finalization
 BEFSQuit;

{==============================================================================}
{==============================================================================}

end.


