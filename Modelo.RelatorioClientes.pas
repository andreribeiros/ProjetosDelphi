unit Modelo.RelatorioClientes;

interface

uses
  System.SysUtils, System.Classes, Data.Win.ADODB, ppComm, ppRelatv, ppProd,
  ppClass, ppReport, ppDB, ppDBPipe, ppBands, ppCache, ppDesignLayer,
  ppParameter, Data.DB, ppCtrls, ppVar, ppPrnabl;

type
  TdmRelatorioClientes = class(TDataModule)
    ppReportRelatorio: TppReport;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    dsRelatorio: TDataSource;
    ppDBPipeline1: TppDBPipeline;
    ppDBPipeline1ppField1: TppField;
    ppDBPipeline1ppField2: TppField;
    ppDBPipeline1ppField3: TppField;
    ppDBPipeline1ppField4: TppField;
    ppDBPipeline1ppField5: TppField;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppTitleBand1: TppTitleBand;
    ppLabel1: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppDBText1: TppDBText;
    ppLabel2: TppLabel;
    ppDBText2: TppDBText;
    ppLabel3: TppLabel;
    ppDBText3: TppDBText;
    ppLabel4: TppLabel;
    ppDBText4: TppDBText;
    ppLabel5: TppLabel;
    ppDBText5: TppDBText;
    ppLabel6: TppLabel;
    ppLine1: TppLine;
    ppLine3: TppLine;
    ppLine4: TppLine;
    ppLine5: TppLine;
    ppLine6: TppLine;
    ppLine7: TppLine;
    ppLine8: TppLine;
    ppLine9: TppLine;
    ppLine10: TppLine;
    ppLine11: TppLine;
    ppLine2: TppLine;
    ppLine12: TppLine;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FADODataSet: TADODataSet;
    procedure SetADODataSet(const Value: TADODataSet);
    { Private declarations }
    property ADODataSet: TADODataSet read FADODataSet write SetADODataSet;
  public
    { Public declarations }
    function CriarAdoConnection(const pCaminhoArquivo: string): TADOConnection;
    function CriarAdoDataSet(const pAdoConnection: TADOConnection; const pTabela: string): TADODataSet;
    procedure ImprimirRelatorioClientesSiedos;
  end;

//var
//  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

function TdmRelatorioClientes.CriarAdoConnection(const pCaminhoArquivo: string): TADOConnection;
const
  STRING_CONEXAO_EXCEL_2003 = 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source= %S;Extended Properties=Excel 8.0;Persist Security Info=False';
  STRING_CONEXAO_EXCEL_2007 = 'Provider=Microsoft.ACE.OLEDB.12.0;Data Source= %S; Extended Properties="Excel 12.0 Xml;HDR=YES" ';
  EXTENSAO_EXCEL_2003 = '.XLS';

var
  vStringConexao: string;

begin
  if (AnsiUpperCase(ExtractFileExt(pCaminhoArquivo)) = EXTENSAO_EXCEL_2003) then
  begin
    vStringConexao := STRING_CONEXAO_EXCEL_2003;
  end
  else
  begin
    vStringConexao := STRING_CONEXAO_EXCEL_2007;
  end;

  Result := TADOConnection.Create(Nil);
  try
    Result.ConnectionString := Format(vStringConexao, [pCaminhoArquivo]);
    Result.LoginPrompt      := False;
    Result.Connected        := True;
  except
    on E: Exception do
    begin
      raise Exception.CreateFmt('Erro ao conectar com o arquivo %S.%SC�d Erro: %S',
                                [pCaminhoArquivo, sLineBreak, E.Message]);
    end;
  end;
end;


function TdmRelatorioClientes.CriarAdoDataSet(const pAdoConnection: TADOConnection;const pTabela: string): TADODataSet;
begin
  try
    ADODataSet.Connection  := pAdoConnection;
    ADODataSet.CommandText := pTabela;
    ADODataSet.CommandType := cmdTableDirect;
    ADODataSet.CursorType  := ctStatic;
    ADODataSet.Active      := True;

    Result := ADODataSet;
  except
    on E: Exception do
    begin
      raise Exception.CreateFmt('Erro ao ler a tabela %S.%SC�d Erro: %S',
                                [pTabela, sLineBreak, E.Message]);
    end;
  end;
end;

procedure TdmRelatorioClientes.DataModuleCreate(Sender: TObject);
begin
  ADODataSet := TADODataSet.Create(Nil);
end;

procedure TdmRelatorioClientes.DataModuleDestroy(Sender: TObject);
begin
  ADODataSet.Free;
end;

procedure TdmRelatorioClientes.ImprimirRelatorioClientesSiedos;
begin
  try
    dsRelatorio.DataSet := ADODataSet;
    ppReportRelatorio.PrintReport;
  Except
    on E: Exception do
    begin
      raise Exception.Create('Ocorreu o seguinte erro ao imprimir o relatorio: ' + E.Message);
    end;
  end;
end;

procedure TdmRelatorioClientes.SetADODataSet(const Value: TADODataSet);
begin
  FADODataSet := Value;
end;

end.
