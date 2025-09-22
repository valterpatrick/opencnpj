unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, MidasLib, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.Buttons, Datasnap.DBClient, uOpenCNPJ;

type
  TFrmPrincipal = class(TForm)
    PanelRetornoAPI: TPanel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Edt_cnpj: TEdit;
    Edt_razao_social: TEdit;
    Edt_nome_fantasia: TEdit;
    Edt_situacao_cadastral: TEdit;
    Edt_data_situacao_cadastral: TEdit;
    Edt_matriz_filial: TEdit;
    Edt_data_inicio_atividade: TEdit;
    Edt_cnae_principal: TEdit;
    Edt_natureza_juridica: TEdit;
    Edt_logradouro: TEdit;
    Edt_numero: TEdit;
    Edt_complemento: TEdit;
    Edt_bairro: TEdit;
    Edt_cep: TEdit;
    Edt_uf: TEdit;
    Edt_municipio: TEdit;
    Edt_email: TEdit;
    Edt_capital_social: TEdit;
    Edt_porte_empresa: TEdit;
    Edt_opcao_simples: TEdit;
    Edt_data_opcao_simples: TEdit;
    Edt_opcao_mei: TEdit;
    Edt_data_opcao_mei: TEdit;
    DBGrid_cnaes_secundarios: TDBGrid;
    Label1: TLabel;
    DBGrid_QSA: TDBGrid;
    Label2: TLabel;
    DBGrid_telefones: TDBGrid;
    Label3: TLabel;
    PanelConfigPesquisa: TPanel;
    Edt_CNPJ_Pesquisa: TEdit;
    BtnPesquisar: TBitBtn;
    Cmb_GerarLog: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edt_CaminhoLog: TEdit;
    CDS_cnaes_secundarios: TClientDataSet;
    CDS_telefones: TClientDataSet;
    CDS_QSA: TClientDataSet;
    CDS_cnaes_secundarioscnae: TStringField;
    CDS_telefonesddd: TStringField;
    CDS_telefonesnumero: TStringField;
    CDS_telefonesis_fax: TBooleanField;
    CDS_QSAnome_socio: TStringField;
    CDS_QSAcnpj_cpf_socio: TStringField;
    CDS_QSAqualificacao_socio: TStringField;
    CDS_QSAdata_entrada_sociedade: TDateField;
    CDS_QSAidentificador_socio: TStringField;
    CDS_QSAfaixa_etaria: TStringField;
    DS_cnaes_secundarios: TDataSource;
    DS_telefones: TDataSource;
    DS_QSA: TDataSource;
    procedure BtnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    OpenCNPJ: TOpenCNPJ;
    procedure InstanciaCDS;
    procedure Add_CDS_cnaes_secundarios(cnae: String);
    procedure Add_CDS_telefones(ddd, numero: String; is_fax: Boolean);
    procedure Add_CDS_QSA(nome_socio, cnpj_cpf_socio, qualificacao_socio: String; data_entrada_sociedade: TDate; identificador_socio, faixa_etaria: String);
    procedure LimparCampos;
  public
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}


procedure TFrmPrincipal.Add_CDS_cnaes_secundarios(cnae: String);
begin
  if not CDS_cnaes_secundarios.Active then
    Exit;

  CDS_cnaes_secundarios.Append;
  CDS_cnaes_secundarioscnae.AsString := Copy(cnae, 1, CDS_cnaes_secundarioscnae.Size);
  CDS_cnaes_secundarios.Post;
end;

procedure TFrmPrincipal.Add_CDS_QSA(nome_socio, cnpj_cpf_socio, qualificacao_socio: String; data_entrada_sociedade: TDate; identificador_socio, faixa_etaria: String);
begin
  if not CDS_QSA.Active then
    Exit;

  CDS_QSA.Append;
  CDS_QSAnome_socio.AsString := Copy(nome_socio, 1, CDS_QSAnome_socio.Size);
  CDS_QSAcnpj_cpf_socio.AsString := Copy(cnpj_cpf_socio, 1, CDS_QSAcnpj_cpf_socio.Size);
  CDS_QSAqualificacao_socio.AsString := Copy(qualificacao_socio, 1, CDS_QSAqualificacao_socio.Size);
  CDS_QSAdata_entrada_sociedade.AsDateTime := data_entrada_sociedade;
  CDS_QSAidentificador_socio.AsString := Copy(identificador_socio, 1, CDS_QSAidentificador_socio.Size);
  CDS_QSAfaixa_etaria.AsString := Copy(faixa_etaria, 1, CDS_QSAfaixa_etaria.Size);
  CDS_QSA.Post;
end;

procedure TFrmPrincipal.Add_CDS_telefones(ddd, numero: String; is_fax: Boolean);
begin
  if not CDS_telefones.Active then
    Exit;

  CDS_telefones.Append;
  CDS_telefonesddd.AsString := Copy(ddd, 1, CDS_telefonesddd.Size);
  CDS_telefonesnumero.AsString := Copy(numero, 1, CDS_telefonesnumero.Size);
  CDS_telefonesis_fax.Value := is_fax;
  CDS_telefones.Post;
end;

procedure TFrmPrincipal.BtnPesquisarClick(Sender: TObject);
var
  Empresa: TEmpresa;

  procedure preencheCampos;
  var
    I: Integer;
  begin
    Edt_cnpj.Text := Empresa.cnpj.Trim;
    Edt_razao_social.Text := Empresa.razao_social.Trim;
    Edt_nome_fantasia.Text := Empresa.nome_fantasia.Trim;
    Edt_situacao_cadastral.Text := Empresa.situacao_cadastral.Trim;
    Edt_data_situacao_cadastral.Text := FormatDateTime('dd/mm/yyyy', Empresa.data_situacao_cadastral);
    Edt_matriz_filial.Text := Empresa.matriz_filial.Trim;
    Edt_data_inicio_atividade.Text := FormatDateTime('dd/mm/yyyy', Empresa.data_inicio_atividade);
    Edt_cnae_principal.Text := Empresa.cnae_principal.Trim;
    Edt_natureza_juridica.Text := Empresa.natureza_juridica.Trim;
    Edt_logradouro.Text := Empresa.logradouro.Trim;
    Edt_numero.Text := Empresa.numero.Trim;
    Edt_complemento.Text := Empresa.complemento.Trim;
    Edt_bairro.Text := Empresa.bairro.Trim;
    Edt_cep.Text := Empresa.cep.Trim;
    Edt_uf.Text := Empresa.uf.Trim;
    Edt_municipio.Text := Empresa.municipio.Trim;
    Edt_email.Text := Empresa.email.Trim;
    Edt_capital_social.Text := Empresa.capital_social.Trim;
    Edt_porte_empresa.Text := Empresa.porte_empresa.Trim;
    Edt_opcao_simples.Text := Empresa.opcao_simples.Trim;
    Edt_data_opcao_simples.Text := FormatDateTime('dd/mm/yyyy', Empresa.data_opcao_simples);
    Edt_opcao_mei.Text := Empresa.opcao_mei.Trim;
    Edt_data_opcao_mei.Text := FormatDateTime('dd/mm/yyyy', Empresa.data_opcao_mei);

    if Length(Empresa.cnaes_secundarios) > 0 then
    begin
      for I := 0 to Length(Empresa.cnaes_secundarios) - 1 do
        Add_CDS_cnaes_secundarios(Empresa.cnaes_secundarios[I]);
    end;

    if Length(Empresa.telefones) > 0 then
    begin
      for I := 0 to Length(Empresa.telefones) - 1 do
        Add_CDS_telefones(Empresa.telefones[I].ddd, Empresa.telefones[I].numero, Empresa.telefones[I].is_fax);
    end;

    if Length(Empresa.qsa) > 0 then
    begin
      for I := 0 to Length(Empresa.qsa) - 1 do
        Add_CDS_QSA(Empresa.qsa[I].nome_socio, Empresa.qsa[I].cnpj_cpf_socio, Empresa.qsa[I].qualificacao_socio, Empresa.qsa[I].data_entrada_sociedade,
          Empresa.qsa[I].identificador_socio, Empresa.qsa[I].faixa_etaria);
    end;
  end;

begin
  if Trim(Edt_CNPJ_Pesquisa.Text) = '' then
    raise Exception.Create('Informe o CNPJ no campo de pesquisa e clique em Pesquisar.');

  LimparCampos;
  OpenCNPJ := TOpenCNPJ.Create(Cmb_GerarLog.ItemIndex = 0, Edt_CaminhoLog.Text);
  try
    Empresa := OpenCNPJ.PesquisaCNPJ(Edt_CNPJ_Pesquisa.Text);
    if (Empresa.razao_social.Trim = '') then
    begin
      Application.MessageBox(PWideChar('Não foi encontrado dados para este CNPJ: ' + Edt_CNPJ_Pesquisa.Text + '.'), 'Aviso', MB_ICONWARNING + MB_OK);
      Exit;
    end;
    preencheCampos;
    Application.MessageBox('Pesquisa realizada com sucesso.', 'Informação', MB_ICONINFORMATION + MB_OK);
  finally
    OpenCNPJ.Free;
  end;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  Cmb_GerarLog.ItemIndex := 0;
  Edt_CaminhoLog.Text := ExtractFileDir(Application.ExeName) + '\Logs';
end;

procedure TFrmPrincipal.InstanciaCDS;
begin
  if CDS_cnaes_secundarios.Active then
  begin
    CDS_cnaes_secundarios.EmptyDataSet;
    CDS_cnaes_secundarios.Close;
  end;
  CDS_cnaes_secundarios.CreateDataSet;

  if CDS_telefones.Active then
  begin
    CDS_telefones.EmptyDataSet;
    CDS_telefones.Close;
  end;
  CDS_telefones.CreateDataSet;

  if CDS_QSA.Active then
  begin
    CDS_QSA.EmptyDataSet;
    CDS_QSA.Close;
  end;
  CDS_QSA.CreateDataSet;
end;

procedure TFrmPrincipal.LimparCampos;
begin
  Edt_cnpj.Text := '';
  Edt_razao_social.Text := '';
  Edt_nome_fantasia.Text := '';
  Edt_situacao_cadastral.Text := '';
  Edt_data_situacao_cadastral.Text := '';
  Edt_matriz_filial.Text := '';
  Edt_data_inicio_atividade.Text := '';
  Edt_cnae_principal.Text := '';
  Edt_natureza_juridica.Text := '';
  Edt_logradouro.Text := '';
  Edt_numero.Text := '';
  Edt_complemento.Text := '';
  Edt_bairro.Text := '';
  Edt_cep.Text := '';
  Edt_uf.Text := '';
  Edt_municipio.Text := '';
  Edt_email.Text := '';
  Edt_capital_social.Text := '';
  Edt_porte_empresa.Text := '';
  Edt_opcao_simples.Text := '';
  Edt_data_opcao_simples.Text := '';
  Edt_opcao_mei.Text := '';
  Edt_data_opcao_mei.Text := '';
  InstanciaCDS;
end;

end.
