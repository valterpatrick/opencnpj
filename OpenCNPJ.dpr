program OpenCNPJ;

uses
  Vcl.Forms,
  uFrmPrincipal in 'uFrmPrincipal.pas' {FrmPrincipal},
  uOpenCNPJ in 'uOpenCNPJ.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.

