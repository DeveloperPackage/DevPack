#include "environment.iss"

#define MyAppName "DevPack"
#define MyAppVersion "1.0.3"
#define MyAppPublisher "DevPack Project"
#define MyAppURL "https://github.com/DeveloperPackage/DevPack/releases/latest"
#define MyAppExeName "qtcreator.exe"

[Setup]
ChangesEnvironment=true
AppId={{1EFDBBB2-915F-4817-A88C-50D557F55FB7}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName=C:\{#MyAppName}
DisableProgramGroupPage=yes
; Remove the following line to run in administrative install mode (install for all users.)
;PrivilegesRequired=lowest
OutputBaseFilename=devpack-x64-{#MyAppVersion}
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "armenian"; MessagesFile: "compiler:Languages\Armenian.isl"
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"
Name: "bulgarian"; MessagesFile: "compiler:Languages\Bulgarian.isl"
Name: "catalan"; MessagesFile: "compiler:Languages\Catalan.isl"
Name: "corsican"; MessagesFile: "compiler:Languages\Corsican.isl"
Name: "czech"; MessagesFile: "compiler:Languages\Czech.isl"
Name: "danish"; MessagesFile: "compiler:Languages\Danish.isl"
Name: "dutch"; MessagesFile: "compiler:Languages\Dutch.isl"
Name: "finnish"; MessagesFile: "compiler:Languages\Finnish.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "hebrew"; MessagesFile: "compiler:Languages\Hebrew.isl"
Name: "hungarian"; MessagesFile: "compiler:Languages\Hungarian.isl"
Name: "icelandic"; MessagesFile: "compiler:Languages\Icelandic.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"
Name: "japanese"; MessagesFile: "compiler:Languages\Japanese.isl"
Name: "norwegian"; MessagesFile: "compiler:Languages\Norwegian.isl"
Name: "polish"; MessagesFile: "compiler:Languages\Polish.isl"
Name: "portuguese"; MessagesFile: "compiler:Languages\Portuguese.isl"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "slovak"; MessagesFile: "compiler:Languages\Slovak.isl"
Name: "slovenian"; MessagesFile: "compiler:Languages\Slovenian.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"
Name: "turkish"; MessagesFile: "compiler:Languages\Turkish.isl"
Name: "ukrainian"; MessagesFile: "compiler:Languages\Ukrainian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\ProgramData\.software\mingw-winlibs\*"; DestDir: "{app}\mingw-winlibs"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\ProgramData\.software\qt-creator\*"; DestDir: "{app}\qt-creator"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\ProgramData\.software\boost\*"; DestDir: "{app}\boost"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\ProgramData\.software\wxWidgets\include\*"; DestDir: "{app}\wxWidgets\include"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\ProgramData\.software\wxWidgets\lib\*"; DestDir: "{app}\wxWidgets\lib"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "samples\*"; DestDir: "{app}\samples\*"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "VC_redist.x64.exe"; DestDir: {tmp}; Flags: deleteafterinstall

[Run]
Filename: {tmp}\VC_redist.x64.exe; \
    Parameters: "/q /passive /Q:a /c:""msiexec /q /i vcredist.msi"""; \
    StatusMsg: "Installing VC++ Redistributables..."

[Icons]
Name: "{autoprograms}\QtCreator"; Filename: "{app}\qt-creator\bin\{#MyAppExeName}"
Name: "{autodesktop}\QtCreator"; Filename: "{app}\qt-creator\bin\{#MyAppExeName}"; Tasks: desktopicon

;[Run]
;Filename: "{app}\qt-creator\bin\{#MyAppExeName}"; Description: "{cm:LaunchProgram,QtCreator}"; Flags: nowait postinstall skipifsilent

[Code]
procedure CurStepChanged(CurStep: TSetupStep);
begin
    if CurStep = ssPostInstall 
     then
      begin
       EnvAddPath(ExpandConstant('{app}') +'\mingw-winlibs\bin');
       EnvSetDevPack(ExpandConstant('{app}'));
      end;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
    if CurUninstallStep = usPostUninstall
    then EnvRemovePath(ExpandConstant('{app}') +'\mingw-winlibs\bin');
end;
