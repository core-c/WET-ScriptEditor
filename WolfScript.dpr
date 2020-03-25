program WolfScript;

uses
  Forms,
  Unit1 in 'Unit1.pas' {fEditor},
  uConst in 'uConst.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfEditor, fEditor);
  Application.Run;
end.
