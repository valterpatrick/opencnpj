object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'OpenCNPJ'
  ClientHeight = 871
  ClientWidth = 634
  Color = clBtnFace
  Constraints.MaxHeight = 900
  Constraints.MaxWidth = 640
  Constraints.MinHeight = 900
  Constraints.MinWidth = 640
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PanelRetornoAPI: TPanel
    Left = 16
    Top = 112
    Width = 600
    Height = 753
    TabOrder = 0
    object Label24: TLabel
      Left = 98
      Top = 16
      Width = 24
      Height = 13
      Alignment = taRightJustify
      Caption = 'cnpj:'
    end
    object Label25: TLabel
      Left = 59
      Top = 43
      Width = 63
      Height = 13
      Alignment = taRightJustify
      Caption = 'razao_social:'
    end
    object Label26: TLabel
      Left = 47
      Top = 70
      Width = 75
      Height = 13
      Alignment = taRightJustify
      Caption = 'nome_fantasia:'
    end
    object Label27: TLabel
      Left = 28
      Top = 97
      Width = 94
      Height = 13
      Alignment = taRightJustify
      Caption = 'situacao_cadastral:'
    end
    object Label28: TLabel
      Left = 280
      Top = 97
      Width = 122
      Height = 13
      Alignment = taRightJustify
      Caption = 'data_situacao_cadastral:'
    end
    object Label29: TLabel
      Left = 65
      Top = 124
      Width = 57
      Height = 13
      Alignment = taRightJustify
      Caption = 'matriz_filial:'
    end
    object Label30: TLabel
      Left = 297
      Top = 124
      Width = 105
      Height = 13
      Alignment = taRightJustify
      Caption = 'data_inicio_atividade:'
    end
    object Label31: TLabel
      Left = 50
      Top = 151
      Width = 72
      Height = 13
      Alignment = taRightJustify
      Caption = 'cnae_principal:'
    end
    object Label32: TLabel
      Left = 35
      Top = 256
      Width = 87
      Height = 13
      Alignment = taRightJustify
      Caption = 'natureza_juridica:'
    end
    object Label33: TLabel
      Left = 66
      Top = 283
      Width = 56
      Height = 13
      Alignment = taRightJustify
      Caption = 'logradouro:'
    end
    object Label34: TLabel
      Left = 82
      Top = 310
      Width = 40
      Height = 13
      Alignment = taRightJustify
      Caption = 'numero:'
    end
    object Label35: TLabel
      Left = 55
      Top = 337
      Width = 67
      Height = 13
      Alignment = taRightJustify
      Caption = 'complemento:'
    end
    object Label36: TLabel
      Left = 90
      Top = 364
      Width = 32
      Height = 13
      Alignment = taRightJustify
      Caption = 'bairro:'
    end
    object Label37: TLabel
      Left = 101
      Top = 391
      Width = 21
      Height = 13
      Alignment = taRightJustify
      Caption = 'cep:'
    end
    object Label38: TLabel
      Left = 388
      Top = 391
      Width = 14
      Height = 13
      Alignment = taRightJustify
      Caption = 'uf:'
    end
    object Label39: TLabel
      Left = 75
      Top = 418
      Width = 47
      Height = 13
      Alignment = taRightJustify
      Caption = 'municipio:'
    end
    object Label40: TLabel
      Left = 94
      Top = 445
      Width = 28
      Height = 13
      Alignment = taRightJustify
      Caption = 'email:'
    end
    object Label41: TLabel
      Left = 55
      Top = 550
      Width = 67
      Height = 13
      Alignment = taRightJustify
      Caption = 'capital_social:'
    end
    object Label42: TLabel
      Left = 45
      Top = 577
      Width = 77
      Height = 13
      Alignment = taRightJustify
      Caption = 'porte_empresa:'
    end
    object Label43: TLabel
      Left = 49
      Top = 604
      Width = 73
      Height = 13
      Alignment = taRightJustify
      Caption = 'opcao_simples:'
    end
    object Label44: TLabel
      Left = 301
      Top = 604
      Width = 101
      Height = 13
      Alignment = taRightJustify
      Caption = 'data_opcao_simples:'
    end
    object Label45: TLabel
      Left = 67
      Top = 631
      Width = 55
      Height = 13
      Alignment = taRightJustify
      Caption = 'opcao_mei:'
    end
    object Label46: TLabel
      Left = 319
      Top = 631
      Width = 83
      Height = 13
      Alignment = taRightJustify
      Caption = 'data_opcao_mei:'
    end
    object Label1: TLabel
      Left = 27
      Top = 175
      Width = 95
      Height = 13
      Alignment = taRightJustify
      Caption = 'cnaes_secundarios:'
    end
    object Label2: TLabel
      Left = 97
      Top = 655
      Width = 25
      Height = 13
      Alignment = taRightJustify
      Caption = 'QSA:'
    end
    object Label3: TLabel
      Left = 73
      Top = 469
      Width = 49
      Height = 13
      Alignment = taRightJustify
      Caption = 'telefones:'
    end
    object Edt_cnpj: TEdit
      Left = 128
      Top = 13
      Width = 120
      Height = 21
      TabOrder = 0
    end
    object Edt_razao_social: TEdit
      Left = 128
      Top = 40
      Width = 400
      Height = 21
      TabOrder = 1
    end
    object Edt_nome_fantasia: TEdit
      Left = 128
      Top = 67
      Width = 400
      Height = 21
      TabOrder = 2
    end
    object Edt_situacao_cadastral: TEdit
      Left = 128
      Top = 94
      Width = 120
      Height = 21
      TabOrder = 3
    end
    object Edt_data_situacao_cadastral: TEdit
      Left = 408
      Top = 94
      Width = 120
      Height = 21
      TabOrder = 4
    end
    object Edt_matriz_filial: TEdit
      Left = 128
      Top = 121
      Width = 120
      Height = 21
      TabOrder = 5
    end
    object Edt_data_inicio_atividade: TEdit
      Left = 408
      Top = 121
      Width = 120
      Height = 21
      TabOrder = 6
    end
    object Edt_cnae_principal: TEdit
      Left = 128
      Top = 148
      Width = 120
      Height = 21
      TabOrder = 7
    end
    object Edt_natureza_juridica: TEdit
      Left = 128
      Top = 253
      Width = 400
      Height = 21
      TabOrder = 9
    end
    object Edt_logradouro: TEdit
      Left = 128
      Top = 280
      Width = 400
      Height = 21
      TabOrder = 10
    end
    object Edt_numero: TEdit
      Left = 128
      Top = 307
      Width = 120
      Height = 21
      TabOrder = 11
    end
    object Edt_complemento: TEdit
      Left = 128
      Top = 334
      Width = 400
      Height = 21
      TabOrder = 12
    end
    object Edt_bairro: TEdit
      Left = 128
      Top = 361
      Width = 400
      Height = 21
      TabOrder = 13
    end
    object Edt_cep: TEdit
      Left = 128
      Top = 388
      Width = 120
      Height = 21
      TabOrder = 14
    end
    object Edt_uf: TEdit
      Left = 408
      Top = 388
      Width = 120
      Height = 21
      TabOrder = 15
    end
    object Edt_municipio: TEdit
      Left = 128
      Top = 415
      Width = 400
      Height = 21
      TabOrder = 16
    end
    object Edt_email: TEdit
      Left = 128
      Top = 442
      Width = 400
      Height = 21
      TabOrder = 17
    end
    object Edt_capital_social: TEdit
      Left = 128
      Top = 547
      Width = 120
      Height = 21
      TabOrder = 19
    end
    object Edt_porte_empresa: TEdit
      Left = 128
      Top = 574
      Width = 400
      Height = 21
      TabOrder = 20
    end
    object Edt_opcao_simples: TEdit
      Left = 128
      Top = 601
      Width = 120
      Height = 21
      TabOrder = 21
    end
    object Edt_data_opcao_simples: TEdit
      Left = 408
      Top = 601
      Width = 120
      Height = 21
      TabOrder = 22
    end
    object Edt_opcao_mei: TEdit
      Left = 128
      Top = 628
      Width = 120
      Height = 21
      TabOrder = 23
    end
    object Edt_data_opcao_mei: TEdit
      Left = 408
      Top = 628
      Width = 120
      Height = 21
      TabOrder = 24
    end
    object DBGrid_cnaes_secundarios: TDBGrid
      Left = 128
      Top = 175
      Width = 400
      Height = 72
      DataSource = DS_cnaes_secundarios
      TabOrder = 8
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'cnae'
          Width = 350
          Visible = True
        end>
    end
    object DBGrid_QSA: TDBGrid
      Left = 128
      Top = 655
      Width = 400
      Height = 72
      DataSource = DS_QSA
      TabOrder = 25
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'nome_socio'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cnpj_cpf_socio'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'qualificacao_socio'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'data_entrada_sociedade'
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'identificador_socio'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'faixa_etaria'
          Width = 150
          Visible = True
        end>
    end
    object DBGrid_telefones: TDBGrid
      Left = 128
      Top = 469
      Width = 400
      Height = 72
      DataSource = DS_telefones
      TabOrder = 18
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'ddd'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'numero'
          Width = 250
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'is_fax'
          Width = 50
          Visible = True
        end>
    end
  end
  object PanelConfigPesquisa: TPanel
    Left = 16
    Top = 10
    Width = 600
    Height = 96
    TabOrder = 1
    object Label4: TLabel
      Left = 98
      Top = 16
      Width = 24
      Height = 13
      Alignment = taRightJustify
      Caption = 'cnpj:'
    end
    object Label5: TLabel
      Left = 74
      Top = 42
      Width = 51
      Height = 13
      Alignment = taRightJustify
      Caption = 'Gerar Log:'
    end
    object Label6: TLabel
      Left = 57
      Top = 69
      Width = 65
      Height = 13
      Alignment = taRightJustify
      Caption = 'Caminho Log:'
    end
    object Edt_CNPJ_Pesquisa: TEdit
      Left = 128
      Top = 12
      Width = 319
      Height = 21
      TabOrder = 0
    end
    object BtnPesquisar: TBitBtn
      Left = 453
      Top = 12
      Width = 75
      Height = 21
      Caption = 'Pesquisar'
      TabOrder = 1
      OnClick = BtnPesquisarClick
    end
    object Cmb_GerarLog: TComboBox
      Left = 128
      Top = 39
      Width = 120
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 2
      Text = 'Sim'
      Items.Strings = (
        'Sim'
        'N'#227'o')
    end
    object Edt_CaminhoLog: TEdit
      Left = 128
      Top = 66
      Width = 400
      Height = 21
      TabOrder = 3
    end
  end
  object CDS_cnaes_secundarios: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 192
    Top = 288
    object CDS_cnaes_secundarioscnae: TStringField
      FieldName = 'cnae'
      Size = 10
    end
  end
  object CDS_telefones: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 264
    Top = 584
    object CDS_telefonesddd: TStringField
      FieldName = 'ddd'
      Size = 5
    end
    object CDS_telefonesnumero: TStringField
      FieldName = 'numero'
      Size = 15
    end
    object CDS_telefonesis_fax: TBooleanField
      FieldName = 'is_fax'
    end
  end
  object CDS_QSA: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 768
    object CDS_QSAnome_socio: TStringField
      FieldName = 'nome_socio'
      Size = 255
    end
    object CDS_QSAcnpj_cpf_socio: TStringField
      FieldName = 'cnpj_cpf_socio'
    end
    object CDS_QSAqualificacao_socio: TStringField
      FieldName = 'qualificacao_socio'
      Size = 255
    end
    object CDS_QSAdata_entrada_sociedade: TDateField
      FieldName = 'data_entrada_sociedade'
    end
    object CDS_QSAidentificador_socio: TStringField
      FieldName = 'identificador_socio'
    end
    object CDS_QSAfaixa_etaria: TStringField
      FieldName = 'faixa_etaria'
    end
  end
  object DS_cnaes_secundarios: TDataSource
    DataSet = CDS_cnaes_secundarios
    Left = 312
    Top = 288
  end
  object DS_telefones: TDataSource
    DataSet = CDS_telefones
    Left = 176
    Top = 584
  end
  object DS_QSA: TDataSource
    DataSet = CDS_QSA
    Left = 168
    Top = 768
  end
end
