program ProjetoSiedos;

uses
  Vcl.Forms,
  Visao.RelatorioClientes in 'Visao.RelatorioClientes.pas' {frmPrincipal},
  Modelo.RelatorioClientes in 'Modelo.RelatorioClientes.pas' {dmRelatorioClientes: TDataModule},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
