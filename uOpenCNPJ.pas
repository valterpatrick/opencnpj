{ ****************************************************************************** }
{ Biblioteca para pesquisa de CNPJ utilizando o provedor OpenCNPJ }
{ }
{ Direitos Autorais Reservados (c) 2025 Valter Patrick Silva Ferreira }
{ }
{ Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor }
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT) }
{ }
{ ****************************************************************************** }

{ ******************************************************************************
  |* Histórico
  |*
  |* 20/09/2025: Valter Patrick Silva Ferreira
  |*  - Criação e distribuição da Primeira Versão
  ****************************************************************************** }

unit uOpenCNPJ;

interface

uses System.Classes, System.SysUtils, System.JSON, IdException, Math, StrUtils, DateUtils,
  REST.Client, REST.Types, System.NetEncoding, System.Generics.Collections, System.Diagnostics;

type
  TQSA = record
    nome_socio: String;
    cnpj_cpf_socio: String;
    qualificacao_socio: String;
    data_entrada_sociedade: TDateTime;
    identificador_socio: String;
    faixa_etaria: String;
  end;

  TListaQSA = array of TQSA;

  TTelefone = record
    ddd: String;
    numero: String;
    is_fax: Boolean;
  end;

  TListaTelefone = array of TTelefone;

  TListaCNAESecundario = array of String;

  TEmpresa = record
    cnpj: String;
    razao_social: String;
    nome_fantasia: String;
    situacao_cadastral: String;
    data_situacao_cadastral: TDateTime;
    matriz_filial: String;
    data_inicio_atividade: TDateTime;
    cnae_principal: String;
    cnaes_secundarios: TListaCNAESecundario;
    natureza_juridica: String;
    logradouro: String;
    numero: String;
    complemento: String;
    bairro: String;
    cep: String;
    uf: String;
    municipio: String;
    email: String;
    telefones: TListaTelefone;
    capital_social: String;
    porte_empresa: String;
    opcao_simples: String;
    data_opcao_simples: TDateTime;
    opcao_mei: String;
    data_opcao_mei: TDateTime;
    qsa: TListaQSA;
  end;

  TResposta = record
    StatusCode: Integer;
    StatusText: String;
    Content: String;
  end;

  TOpenCNPJ = class
  private
    FURLBase: String;
    FGerarLog: Boolean;
    FCaminhoLog: string;
    function RemoveCaracters(S: String): String;
    function Get(Parametro: String): TResposta;
    procedure Log(Texto: String);
    function ParseJSONToEmpresa(const AJSON: string): TEmpresa;
    function JsonStrToDate(vObj: TJsonObject; vCampo: String): TDateTime;
    function ClearEmpresa: TEmpresa;
  public
    constructor Create(AGerarLog: Boolean = False; ACaminhoLog: String = '');
    property GerarLog: Boolean read FGerarLog write FGerarLog;
    property CaminhoLog: string read FCaminhoLog write FCaminhoLog;
    function PesquisaCNPJ(cnpj: String): TEmpresa;
  end;

implementation

{ TOpenCNPJ }

function TOpenCNPJ.ClearEmpresa: TEmpresa;
begin
  Result.cnpj := '';
  Result.razao_social := '';
  Result.nome_fantasia := '';
  Result.situacao_cadastral := '';
  Result.data_situacao_cadastral := 0;
  Result.matriz_filial := '';
  Result.data_inicio_atividade := 0;
  Result.cnae_principal := '';
  SetLength(Result.cnaes_secundarios, 0);
  Result.natureza_juridica := '';
  Result.logradouro := '';
  Result.numero := '';
  Result.complemento := '';
  Result.bairro := '';
  Result.cep := '';
  Result.uf := '';
  Result.municipio := '';
  Result.email := '';
  SetLength(Result.telefones, 0);
  Result.capital_social := '';
  Result.porte_empresa := '';
  Result.opcao_simples := '';
  Result.data_opcao_simples := 0;
  Result.opcao_mei := '';
  Result.data_opcao_mei := 0;
  SetLength(Result.qsa, 0);
end;

constructor TOpenCNPJ.Create(AGerarLog: Boolean = False; ACaminhoLog: String = '');
begin
  FURLBase := 'https://api.opencnpj.org/';
  FGerarLog := AGerarLog;
  FCaminhoLog := ACaminhoLog.Trim;
  Log('#TOpenCNPJ.Create# URLBase: ' + FURLBase + '; GerarLog: ' + IfThen(FGerarLog, 'Sim', 'Não') + '; CaminhoLog: ' + FCaminhoLog);
end;

function TOpenCNPJ.Get(Parametro: String): TResposta;
var
  RestClient: TRESTClient;
  RestRequest: TRESTRequest;
  Stopwatch: TStopwatch;
  ElapsedMS: Int64;
begin
  Log('#TOpenCNPJ.Get# Realizando requisição: ' + Parametro);
  RestClient := TRESTClient.Create(FURLBase);
  RestRequest := TRESTRequest.Create(nil);
  RestRequest.Client := RestClient;
  RestRequest.Method := rmGET;
  RestClient.BaseURL := FURLBase;
  RestClient.Accept := RestRequest.Accept;
  RestClient.AcceptCharset := RestRequest.AcceptCharset;
  RestClient.RaiseExceptionOn500 := False;
  RestRequest.Resource := Parametro;
  Stopwatch := TStopwatch.StartNew; // inicia cronômetro
  try
    try
      RestRequest.Execute;
      Stopwatch.Stop;
      ElapsedMS := Stopwatch.ElapsedMilliseconds; // tempo gasto em ms
    except
      on E: Exception do
      begin
        Stopwatch.Stop;
        ElapsedMS := Stopwatch.ElapsedMilliseconds; // tempo gasto em ms
        Log('#TOpenCNPJ.Get# Erro. StatusCode: ' + RestRequest.Response.StatusCode.ToString + '; StatusText: ' + RestRequest.Response.StatusText + '. Mensagem' + E.Message);
      end;
    end;
  finally
    Log('#TOpenCNPJ.PesquisaCNPJ# StatusCode: ' + RestRequest.Response.StatusCode.ToString + '; StatusText: ' + RestRequest.Response.StatusText +
    '; Content' + RestRequest.Response.Content + '; Tempo(ms): ' + ElapsedMS.ToString);
    Result.StatusCode := RestRequest.Response.StatusCode;
    Result.StatusText := RestRequest.Response.StatusText;
    Result.Content := RestRequest.Response.Content;
    RestClient.Free;
    RestRequest.Free;
  end;
end;

procedure TOpenCNPJ.Log(Texto: String);
var
  F: TextFile;
  FileName: String;
begin
  if not FGerarLog or (FCaminhoLog.Trim = '') then
    Exit;

  try
    if not ForceDirectories(FCaminhoLog + '\' + FormatDateTime('yyyy', Date) + '\' + FormatDateTime('MM', Date)) then
      Exit;

    FileName := FCaminhoLog + '\' + FormatDateTime('yyyy', Date) + '\' + FormatDateTime('MM', Date) + '\' + FormatDateTime('dd', Date) + '.log';
    AssignFile(F, FileName);
    if FileExists(FileName) then
      Append(F)
    else
      Rewrite(F);
    Writeln(F, FormatDateTime('dd/MM/yyyy hh:mm:ss.zzz', Now) + ' => ' + Texto);
    Flush(F);
    CloseFile(F);
  except
  end;
end;

function TOpenCNPJ.PesquisaCNPJ(cnpj: String): TEmpresa;
var
  resp: TResposta;
begin
  Result := ClearEmpresa;
  try
    resp := Get(RemoveCaracters(cnpj.Trim));
    if resp.StatusCode = 200 then
      Result := ParseJSONToEmpresa(resp.Content)
    else
      Log('#TOpenCNPJ.PesquisaCNPJ# Não foi possível obter retorno da requisição. StatusCode: ' + resp.StatusCode.ToString + '; StatusText: ' + resp.StatusText.Trim);
  except
    on E: Exception do
    begin
      if (resp.Content.Trim <> '') then
        Log('#TOpenCNPJ.PesquisaCNPJ# CNPJ: ' + cnpj.Trim + '; StatusCode: ' + resp.StatusCode.ToString + '; Content: ' +
          resp.Content + '; Mensagem Erro: ' + E.Message)
      else
        Log('#TOpenCNPJ.PesquisaCNPJ# CNPJ: ' + cnpj.Trim + '; Mensagem Erro: ' + E.Message);
      raise Exception(E.Message);
    end;
  end;
end;

function TOpenCNPJ.RemoveCaracters(S: String): String;
const
  Str = '.,-*/()[]{}!@#$%¨&=_<>;:\|';
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(S) do
  begin
    if Pos(S[I], Str) = 0 then
      Result := Result + S[I];
  end;
end;

function TOpenCNPJ.JsonStrToDate(vObj: TJsonObject; vCampo: String): TDateTime;
var
  valor: String;
begin
  vObj.TryGetValue<String>(vCampo, valor);
  TryISO8601ToDate(valor, Result, False);
end;

function TOpenCNPJ.ParseJSONToEmpresa(const AJSON: string): TEmpresa;
var
  JSONObject: TJsonObject;
  JArr: TJSONArray;
  I: Integer;
  JObj: TJsonObject;
begin
  JSONObject := TJsonObject.ParseJSONValue(AJSON) as TJsonObject;
  Result := ClearEmpresa;
  try
    JSONObject.TryGetValue<string>('cnpj', Result.cnpj);
    JSONObject.TryGetValue<string>('razao_social', Result.razao_social);
    JSONObject.TryGetValue<string>('nome_fantasia', Result.nome_fantasia);
    JSONObject.TryGetValue<string>('situacao_cadastral', Result.situacao_cadastral);
    Result.data_situacao_cadastral := JsonStrToDate(JSONObject, 'data_situacao_cadastral');
    JSONObject.TryGetValue<string>('matriz_filial', Result.matriz_filial);
    Result.data_inicio_atividade := JsonStrToDate(JSONObject, 'data_inicio_atividade');
    JSONObject.TryGetValue<string>('cnae_principal', Result.cnae_principal);

    // cnaes_secundarios
    JArr := JSONObject.GetValue<TJSONArray>('cnaes_secundarios');
    if Assigned(JArr) then
    begin
      SetLength(Result.cnaes_secundarios, JArr.Count);
      for I := 0 to JArr.Count - 1 do
        Result.cnaes_secundarios[I] := JArr.Items[I].Value;
    end;

    JSONObject.TryGetValue<string>('natureza_juridica', Result.natureza_juridica);
    JSONObject.TryGetValue<string>('logradouro', Result.logradouro);
    JSONObject.TryGetValue<string>('numero', Result.numero);
    JSONObject.TryGetValue<string>('complemento', Result.complemento);
    JSONObject.TryGetValue<string>('bairro', Result.bairro);
    JSONObject.TryGetValue<string>('cep', Result.cep);
    JSONObject.TryGetValue<string>('uf', Result.uf);
    JSONObject.TryGetValue<string>('municipio', Result.municipio);
    JSONObject.TryGetValue<string>('email', Result.email);

    // telefones
    JArr := JSONObject.GetValue<TJSONArray>('telefones');
    if Assigned(JArr) then
    begin
      SetLength(Result.telefones, JArr.Count);
      for I := 0 to JArr.Count - 1 do
      begin
        JObj := JArr.Items[I] as TJsonObject;
        JObj.TryGetValue<string>('ddd', Result.telefones[I].ddd);
        JObj.TryGetValue<string>('numero', Result.telefones[I].numero);
        JObj.TryGetValue<Boolean>('is_fax', Result.telefones[I].is_fax);
      end;
    end;

    JSONObject.TryGetValue<string>('capital_social', Result.capital_social);
    JSONObject.TryGetValue<string>('porte_empresa', Result.porte_empresa);
    JSONObject.TryGetValue<string>('opcao_simples', Result.opcao_simples);
    Result.data_opcao_simples := JsonStrToDate(JSONObject, 'data_opcao_simples');
    JSONObject.TryGetValue<string>('opcao_mei', Result.opcao_mei);
    Result.data_opcao_mei := JsonStrToDate(JSONObject, 'data_opcao_mei');

    // QSA (pegando o primeiro do array)
    JArr := JSONObject.GetValue<TJSONArray>('QSA');
    if Assigned(JArr) and (JArr.Count > 0) then
    begin
      SetLength(Result.qsa, JArr.Count);
      for I := 0 to JArr.Count - 1 do
      begin
        JObj := JArr.Items[0] as TJsonObject;
        JObj.TryGetValue<string>('nome_socio', Result.qsa[I].nome_socio);
        JObj.TryGetValue<string>('cnpj_cpf_socio', Result.qsa[I].cnpj_cpf_socio);
        JObj.TryGetValue<string>('qualificacao_socio', Result.qsa[I].qualificacao_socio);
        Result.qsa[I].data_entrada_sociedade := JsonStrToDate(JObj, 'data_entrada_sociedade');
        JObj.TryGetValue<string>('identificador_socio', Result.qsa[I].identificador_socio);
        JObj.TryGetValue<string>('faixa_etaria', Result.qsa[I].faixa_etaria);
      end;
    end;

  finally
    JSONObject.Free;
  end;
end;

end.
