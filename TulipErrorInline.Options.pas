{*******************************************************}
{                                                       }
{             TULIP ERROR INLINE PLUGIN                 }
{                                                       }
{               Samer Assil - 2026                      }
{                                                       }
{              samerassil@gmail.com                     }
{          https://github.com/SAMERASSIL                }
{                                                       }
{*******************************************************}

unit TulipErrorInline.Options;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.win.Registry, ToolsAPI,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TTulipErrorInlineFrame = class(TFrame)
    GroupBox1: TGroupBox;
    cbxErrorFontColor: TColorBox;
    cbErrorEnabled: TCheckBox;
    label1: TLabel;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    cbxWarningFontColor: TColorBox;
    cbWarningEnabled: TCheckBox;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    cbxHintFontColor: TColorBox;
    cbHintEnabled: TCheckBox;
    procedure cbxErrorFontColorChange(Sender: TObject);
    procedure cbxWarningFontColorChange(Sender: TObject);
    procedure cbxHintFontColorChange(Sender: TObject);
    procedure cbErrorEnabledClick(Sender: TObject);
    procedure cbWarningEnabledClick(Sender: TObject);
    procedure cbHintEnabledClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure SaveSettings;
    procedure LoadSettings;
  end;


type
  TInfoRec = Record
    Color: TColor;
    Enabled: Boolean;
  End;

  TTulipErrorInlineAddInOptions = class(TInterfacedObject, INTAAddInOptions)
  private
    FFrame: TTulipErrorInlineFrame;
  public
    function GetArea: string;
    function GetCaption: string;
    function GetFrameClass: TCustomFrameClass;
    procedure FrameCreated(AFrame: TCustomFrame);
    procedure DialogClosed(Accepted: Boolean);
    function ValidateContents: Boolean;
    function GetHelpContext: Integer;
    function IncludeInIDEInsight: Boolean;
  end;

var
  ErrorInlineOptionsIndex: INTAAddInOptions = nil;

  ErrorInfo: TInfoRec;
  WarningInfo: TInfoRec;
  HintInfo: TInfoRec;

procedure Register;
procedure UnRegister;

implementation

{$R *.dfm}

uses TulipErrorInline.consts;

{ TTulipErrorInlineFrame }

procedure TTulipErrorInlineFrame.cbErrorEnabledClick(Sender: TObject);
begin
  ErrorInfo.enabled := cbErrorEnabled.checked;
end;

procedure TTulipErrorInlineFrame.cbHintEnabledClick(Sender: TObject);
begin
  HintInfo.enabled := cbHintEnabled.checked;
end;

procedure TTulipErrorInlineFrame.cbWarningEnabledClick(Sender: TObject);
begin
  WarningInfo.enabled := cbWarningEnabled.checked;
end;

procedure TTulipErrorInlineFrame.cbxErrorFontColorChange(Sender: TObject);
begin
  ErrorInfo.color := cbxErrorFontColor.Selected;
end;

procedure TTulipErrorInlineFrame.cbxHintFontColorChange(Sender: TObject);
begin
  HintInfo.Color := cbxHintFontColor.Selected;
end;

procedure TTulipErrorInlineFrame.cbxWarningFontColorChange(Sender: TObject);
begin
  WarningInfo.color := cbxWarningFontColor.Selected;
end;

procedure TTulipErrorInlineFrame.LoadSettings;
var
  Reg: TRegistry;
begin
  // Errors
  ErrorInfo.color := clred;
  ErrorInfo.Enabled := True;
  //Warning
  WarningInfo.color := $004080FF;
  WarningInfo.Enabled := true;
  //Hint
  HintInfo.Color := $00FF8000;
  HintInfo.Enabled := true;

  Reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKeyReadOnly(REG_KEY) then
    begin
      // Error
      if Reg.ValueExists(FONT_COLOR_ERROR) then
        ErrorInfo.Color := TColor(Reg.ReadInteger(FONT_COLOR_ERROR));
      if Reg.ValueExists(ENABLED_ERROR) then
        ErrorInfo.Enabled := Reg.ReadBool(ENABLED_ERROR);
      // Warning
      if Reg.ValueExists(FONT_COLOR_WARNING) then
        WarningInfo.Color := TColor(Reg.ReadInteger(FONT_COLOR_WARNING));
      if Reg.ValueExists(ENABLED_WARNING) then
        WarningInfo.Enabled := Reg.ReadBool(ENABLED_WARNING);
      // Hint
      if Reg.ValueExists(FONT_COLOR_HINT) then
        HintInfo.Color := TColor(Reg.ReadInteger(FONT_COLOR_HINT));
      if Reg.ValueExists(ENABLED_HINT) then
        HintInfo.Enabled := Reg.ReadBool(ENABLED_HINT);

      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TTulipErrorInlineFrame.SaveSettings;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create(KEY_WRITE);
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey(REG_KEY, True) then
    begin
      Reg.WriteInteger( FONT_COLOR_ERROR, Integer(ErrorInfo.Color));
      Reg.WriteBool( ENABLED_ERROR, ErrorInfo.Enabled);

      Reg.WriteInteger(FONT_COLOR_WARNING, Integer(WarningInfo.Color));
      Reg.WriteBool( ENABLED_WARNING, WarningInfo.Enabled);

      Reg.WriteInteger(FONT_COLOR_HINT, Integer(HintInfo.Color));
      Reg.WriteBool( ENABLED_HINT, HintInfo.Enabled);

      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

{ TTulipErrorInlineAddInOptions }

procedure TTulipErrorInlineAddInOptions.DialogClosed(Accepted: Boolean);
begin
// If the user clicked "OK" (Accepted = True), tell our frame to save!
  if Accepted then
    FFrame.SaveSettings;
  FFrame := nil;
end;

procedure TTulipErrorInlineAddInOptions.FrameCreated(AFrame: TCustomFrame);
begin
  FFrame := TTulipErrorInlineFrame(AFrame);
  try
  if Assigned(FFrame) then
    begin
    FFrame.LoadSettings;
    FFrame.cbxErrorFontColor.Selected := ErrorInfo.Color;
    FFrame.cbErrorEnabled.checked := ErrorInfo.enabled;

    FFrame.cbxWarningFontColor.Selected := WarningInfo.Color;
    FFrame.cbWarningEnabled.checked := WarningInfo.enabled;

    FFrame.cbxHintFontColor.Selected := HintInfo.Color;
    FFrame.cbHintEnabled.checked := HintInfo.enabled;

    end;
  finally

  end;
end;

function TTulipErrorInlineAddInOptions.GetArea: string;
begin
  Result := '';
end;

function TTulipErrorInlineAddInOptions.GetCaption: string;
begin
  result := 'Tulip Error Inline';
end;

function TTulipErrorInlineAddInOptions.GetFrameClass: TCustomFrameClass;
begin
  result := TTulipErrorInlineFrame;
end;

function TTulipErrorInlineAddInOptions.GetHelpContext: Integer;
begin
  result := 0;
end;

function TTulipErrorInlineAddInOptions.IncludeInIDEInsight: Boolean;
begin
  result := true;
end;

function TTulipErrorInlineAddInOptions.ValidateContents: Boolean;
begin
  result := true;
end;


procedure Register;
var
  EnvironmentOptions: INTAEnvironmentOptionsServices;
begin
  if Supports(BorlandIDEServices, INTAEnvironmentOptionsServices, EnvironmentOptions) then
  begin
  if ErrorInlineOptionsIndex = nil then
    begin
    ErrorInlineOptionsIndex := TTulipErrorInlineAddInOptions.Create;
    EnvironmentOptions.RegisterAddInOptions(ErrorInlineOptionsIndex);
    end;
  end;
end;


procedure UnRegister;
var
  EnvironmentOptions: INTAEnvironmentOptionsServices;
begin
  if (ErrorInlineOptionsIndex <> nil) and
     Supports(BorlandIDEServices, INTAEnvironmentOptionsServices, EnvironmentOptions) then
  begin
    EnvironmentOptions.UnregisterAddInOptions(ErrorInlineOptionsIndex);
    ErrorInlineOptionsIndex := nil;
  end;

end;

initialization;
finalization
  UnRegister;

end.
