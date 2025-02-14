unit MainCode;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, System.SysUtils,
  Vcl.StdCtrls, Vcl.Controls, Vcl.ExtCtrls, Vcl.Forms, XSuperObject, Vcl.Dialogs;

type
  TMainFrm = class(TForm)
    MWebHook: TPanel;
    SWebHook: TPanel;
    pixConfigWebhook: TButton;
    pixListWebhook: TButton;
    MCharges: TPanel;
    SCharges: TPanel;
    pixListCharges: TButton;
    pixCreateImmediateCharge: TButton;
    pixUpdateCharge: TButton;
    MPix: TPanel;
    SPix: TPanel;
    MLoc: TPanel;
    SLoc: TPanel;
    SGetv2Loc_id_QrCode: TButton;
    SGetv2Loc_id: TButton;
    pixListLocation: TButton;
    imgPanel: TPanel;
    QrCodeImg: TImage;
    pixCreateCharge: TButton;
    pixDetailCharge: TButton;
    pixCreateLocation: TButton;
    SDelv2Loc_id_txid: TButton;
    pixGetWebhook: TButton;
    pixDeleteWebhook: TButton;
    pixListReceived: TButton;
    pixSend: TButton;
    pixDetail: TButton;
    pixDevolutionGet: TButton;
    pixDevolution: TButton;
    MKeyPix: TPanel;
    MAccount: TPanel;
    SKeyPix: TPanel;
    SAccount: TPanel;
    MemoResponse: TMemo;
    SGetV2GnConfig: TButton;
    SGetV2GnSaldo: TButton;
    SPutV2GnConfig: TButton;
    gnListEvp: TButton;
    gnCreateEvp: TButton;
    gnDeleteEvp: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    txtClientId: TEdit;
    txtClientSecret: TEdit;
    SPostOauthToken: TButton;
    MOAuth: TPanel;
    Label2: TLabel;
    CheckBoxSandbox: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    txtCertFile: TEdit;
    txtKeyFile: TEdit;
    selecionaOpenDialog: TOpenDialog;
    btnCleanQRCode: TButton;
    procedure pixListChargesClick(Sender: TObject);
    procedure pixCreateImmediateChargeClick(Sender: TObject);
    procedure pixUpdateChargeClick(Sender: TObject);
    procedure SPostOauthTokenClick(Sender: TObject);
    procedure SPostOauthTokenMouseLeave(Sender: TObject);
    procedure MWebHookClick(Sender: TObject);
    procedure SWebHookMouseLeave(Sender: TObject);
    procedure MChargesClick(Sender: TObject);
    procedure SChargesMouseLeave(Sender: TObject);
    procedure pixListWebhookClick(Sender: TObject);
    procedure SPixMouseLeave(Sender: TObject);
    procedure pixSendClick(Sender: TObject);
    procedure SLocMouseLeave(Sender: TObject);
    procedure SGetv2Loc_id_QrCodeClick(Sender: TObject);
    procedure MLocClick(Sender: TObject);
    procedure MPixClick(Sender: TObject);
    procedure SGetv2Loc_idClick(Sender: TObject);
    procedure pixListLocationClick(Sender: TObject);
    procedure pixCreateChargeClick(Sender: TObject);
    procedure pixDetailChargeClick(Sender: TObject);
    procedure pixCreateLocationClick(Sender: TObject);
    procedure SDelv2Loc_id_txidClick(Sender: TObject);
    procedure pixConfigWebhookClick(Sender: TObject);
    procedure pixGetWebhookClick(Sender: TObject);
    procedure pixDeleteWebhookClick(Sender: TObject);
    procedure pixListReceivedClick(Sender: TObject);
    procedure pixDetailClick(Sender: TObject);
    procedure pixDevolutionGetClick(Sender: TObject);
    procedure pixDevolutionClick(Sender: TObject);
    procedure MKeyPixClick(Sender: TObject);
    procedure SKeyPixMouseLeave(Sender: TObject);
    procedure MAccountClick(Sender: TObject);
    procedure SAccountMouseLeave(Sender: TObject);
    procedure SGetV2GnConfigClick(Sender: TObject);
    procedure SGetV2GnSaldoClick(Sender: TObject);
    procedure SPutV2GnConfigClick(Sender: TObject);
    procedure gnListEvpClick(Sender: TObject);
    procedure gnCreateEvpClick(Sender: TObject);
    procedure gnDeleteEvpClick(Sender: TObject);
    procedure txtCertFileDblClick(Sender: TObject);
    procedure txtKeyFileDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCleanQRCodeClick(Sender: TObject);
  private
    function GetClientID: String;
    function GetClientSecret: String;
    function GetEnviroment: String;
    function GetCertFile: String;
    function GetKeyFile: String;
  public
    property ClientID: String read GetClientID;
    property ClientSecret: String read GetClientSecret;
    property Enviroment : String read GetEnviroment;
    property CertFilePem : String read GetCertFile;
    property KeyFilePem : String read GetKeyFile;
    procedure CleanQrCodeImage;
  end;

var
  MainFrm : TMainFrm;

implementation

{$R *.dfm}

uses
  Connections, IdHTTP, ChargesEndpoints, LocEndpoints, WebhookEndpoints,
  PixEndpoints, AccountEndpoints, KeyPixEndpoints, AuthenticationEndpoints;

procedure TMainFrm.MKeyPixClick(Sender: TObject);
begin
  SKeyPix.Visible := not SKeyPix.Visible;
end;

procedure TMainFrm.MChargesClick(Sender: TObject);
begin
  SCharges.Visible := not SCharges.Visible;
end;

procedure TMainFrm.MAccountClick(Sender: TObject);
begin
  SAccount.Visible := not SAccount.Visible;
end;

procedure TMainFrm.MLocClick(Sender: TObject);
begin
  SLoc.Visible := not SLoc.Visible;
end;

procedure TMainFrm.MPixClick(Sender: TObject);
begin
  SPix.Visible := not SPix.Visible;
end;

procedure TMainFrm.MWebHookClick(Sender: TObject);
begin
  SWebHook.Visible := not SWebHook.Visible;
end;

procedure TMainFrm.SPostOauthTokenMouseLeave(Sender: TObject);
begin
  SPostOauthToken.Visible := False;
end;

procedure TMainFrm.SKeyPixMouseLeave(Sender: TObject);
begin
  SKeyPix.Visible := False;
end;

procedure TMainFrm.SChargesMouseLeave(Sender: TObject);
begin
  SCharges.Visible := False;
end;

procedure TMainFrm.SAccountMouseLeave(Sender: TObject);
begin
  SAccount.Visible := False;
end;

procedure TMainFrm.SWebHookMouseLeave(Sender: TObject);
begin
  SWebHook.Visible := False;
end;

procedure TMainFrm.txtCertFileDblClick(Sender: TObject);
begin
  txtCertFile.Text := GetCertFile;
end;

procedure TMainFrm.txtKeyFileDblClick(Sender: TObject);
begin
  txtKeyFile.Text := GetKeyFile;
end;

procedure TMainFrm.SPixMouseLeave(Sender: TObject);
begin
  SPix.Visible := False;
end;

procedure TMainFrm.SLocMouseLeave(Sender: TObject);
begin
  SLoc.Visible := False;
end;

///EndPoints OAuth
procedure TMainFrm.SPostOauthTokenClick(Sender: TObject);
begin
  AuthenticationEndpoints.OauthToken;
end;

///Endpoints Cobranšas
procedure TMainFrm.pixListChargesClick(Sender: TObject);
begin
  ChargesEndpoints.PixListCharges;
end;

procedure TMainFrm.pixDetailChargeClick(Sender: TObject);
begin
  ChargesEndpoints.PixDetailCharge;
end;

procedure TMainFrm.pixCreateChargeClick(Sender: TObject);
begin
  ChargesEndpoints.PixCreateCharge;
end;

procedure TMainFrm.pixUpdateChargeClick(Sender: TObject);
begin
  ChargesEndpoints.PixUpdateCharge;
end;

procedure TMainFrm.pixCreateImmediateChargeClick(Sender: TObject);
begin
  ChargesEndpoints.PixCreateImmediateCharge;
end;

///EndPoints Conta
procedure TMainFrm.SGetV2GnConfigClick(Sender: TObject);
begin
  AccountEndpoints.GNDetailSettings;
end;

procedure TMainFrm.SGetV2GnSaldoClick(Sender: TObject);
begin
  AccountEndpoints.GnDetailBalance;
end;

procedure TMainFrm.SPutV2GnConfigClick(Sender: TObject);
begin
  AccountEndpoints.GnUpdateSettings;
end;

//// Endpoints ChavePix
procedure TMainFrm.gnListEvpClick(Sender: TObject);
begin
  KeyPixEndpoints.GnListEvp;
end;

procedure TMainFrm.gnCreateEvpClick(Sender: TObject);
begin
  KeyPixEndpoints.GnCreateEvp;
end;

procedure TMainFrm.gnDeleteEvpClick(Sender: TObject);
begin
  KeyPixEndpoints.GnDeleteEvp;
end;

///Endpoints Pix
procedure TMainFrm.pixListReceivedClick(Sender: TObject);
begin
  PixEndpoints.PixListReceived;
end;

procedure TMainFrm.pixDetailClick(Sender: TObject);
begin
  PixEndpoints.PixDetail;
end;

procedure TMainFrm.pixDevolutionGetClick(Sender: TObject);
begin
  PixEndpoints.PixDevolutionGet;
end;

procedure TMainFrm.pixDevolutionClick(Sender: TObject);
begin
  PixEndpoints.PixDevolution;
end;

procedure TMainFrm.pixSendClick(Sender: TObject);
begin
  PixEndpoints.PixSend;
end;

///Endpoints Webhook
procedure TMainFrm.pixListWebhookClick(Sender: TObject);
begin
  WebhookEndpoints.PixListWebhook;
end;

procedure TMainFrm.pixGetWebhookClick(Sender: TObject);
begin
  WebhookEndpoints.PixGetWebhook;
end;

procedure TMainFrm.pixConfigWebhookClick(Sender: TObject);
begin
  WebhookEndpoints.PixConfigWebhook;
end;

procedure TMainFrm.pixDeleteWebhookClick(Sender: TObject);
begin
  WebhookEndpoints.PixDeleteWebhook;
end;

///Endpoints Loc
procedure TMainFrm.pixListLocationClick(Sender: TObject);
begin
  LocEndpoints.PixListLocation;
end;

procedure TMainFrm.SGetv2Loc_idClick(Sender: TObject);
begin
  LocEndpoints.PixDetailLocation;
end;

procedure TMainFrm.SGetv2Loc_id_QrCodeClick(Sender: TObject);
begin
  LocEndpoints.PixGenerateQRCode;
end;

procedure TMainFrm.pixCreateLocationClick(Sender: TObject);
begin
  LocEndpoints.PixCreateLocation;
end;

procedure TMainFrm.SDelv2Loc_id_txidClick(Sender: TObject);
begin
  LocEndpoints.PixUnsetTxid;
end;

//Encapsulando Credenciais
function TMainFrm.GetClientSecret: String;
begin
  Result := txtClientSecret.Text;
end;

function TMainFrm.GetClientID: String;
begin
  Result := txtClientID.Text;
end;

function TMainFrm.GetEnviroment: String;
begin
  if CheckBoxSandbox.Checked then
    Result := 'https://api-pix-h.gerencianet.com.br'
  else
    Result := 'https://api-pix.gerencianet.com.br';
end;

procedure TMainFrm.btnCleanQRCodeClick(Sender: TObject);
begin
  CleanQrCodeImage;
end;

procedure TMainFrm.CleanQrCodeImage;
begin
  QrCodeImg.Picture := nil;
end;

procedure TMainFrm.FormCreate(Sender: TObject);
begin
  MainFrm.Position := poScreenCenter;
  MemoResponse.Text := '';
end;

function TMainFrm.GetCertFile: String;
begin
  if not FileExists(txtCertFile.Text) then
  begin
    selecionaOpenDialog.Execute;
    txtCertFile.Text := selecionaOpenDialog.FileName;
  end;

  Result := txtCertFile.Text;

end;

function TMainFrm.GetKeyFile: String;
begin
  if not FileExists(txtKeyFile.Text) then
  begin
    selecionaOpenDialog.Execute;
    txtKeyFile.Text := selecionaOpenDialog.FileName;
  end;

  Result := txtKeyFile.Text;
end;

end.
