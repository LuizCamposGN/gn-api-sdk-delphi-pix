unit ViewUpdateCharge;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BodyChargesClass, XSuperObject, System.Generics.Collections;

type
  TViewUpdateCharge = class(TForm)
    GroupBox3: TGroupBox;
    txtIdent: TEdit;
    Label1: TLabel;
    gbDevedor: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    txtName: TEdit;
    txtCpf: TEdit;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    txtExpiration: TEdit;
    gbValor: TGroupBox;
    Label5: TLabel;
    txtValue: TEdit;
    GroupBox2: TGroupBox;
    txtKey: TEdit;
    GroupBox4: TGroupBox;
    txtPayerRequest: TEdit;
    btnConfirmRequest: TButton;
    btnCancelRequest: TButton;
    GroupBox5: TGroupBox;
    txtAddInfoName: TEdit;
    txtAddInfoValue: TEdit;
    Label7: TLabel;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelRequestClick(Sender: TObject);
    procedure btnConfirmRequestClick(Sender: TObject);
  private
    function GetIdent: String;
    function GetBody : String;
  public
    property Identifier: String read GetIdent;
    property Body: String read GetBody;
    procedure ClearRequestfields;
  end;

implementation

{$R *.dfm}

procedure TViewUpdateCharge.btnCancelRequestClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TViewUpdateCharge.btnConfirmRequestClick(Sender: TObject);
begin

  if txtIdent.Text = EmptyStr then
  begin
    MessageDlg('O identificador n�o pode ser vazio', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtIdent.CanFocus then
      txtIdent.SetFocus;
  end
  else if ((txtCpf.Text = EmptyStr) and (txtName.Text <> EmptyStr)) then
  begin
    MessageDlg('Necess�rio voc� preencher todos os dados do Devedor', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtCpf.CanFocus then
      txtCpf.SetFocus;
  end
  else if ((txtCpf.Text <> EmptyStr) and (txtName.Text = EmptyStr)) then
  begin
    MessageDlg('Necess�rio voc� preencher todos os dados do Devedor', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtName.CanFocus then
      txtName.SetFocus;
  end
  else if ((txtAddInfoName.Text = EmptyStr) and (txtAddInfoValue.Text <> EmptyStr)) then
  begin
    MessageDlg('Necess�rio voc� preencher todos os dados da Informa��es Adicionais', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtAddInfoName.CanFocus then
      txtAddInfoName.SetFocus;
  end
  else if ((txtAddInfoName.Text <> EmptyStr) and (txtAddInfoValue.Text = EmptyStr)) then
  begin
    MessageDlg('Necess�rio voc� preencher todos os dados da Informa��es Adicionais', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtAddInfoValue.CanFocus then
      txtAddInfoValue.SetFocus;
  end
  else
    ModalResult := mrOk;
end;

procedure TViewUpdateCharge.FormCreate(Sender: TObject);
begin
  Self.Position := poScreenCenter;
end;

function TViewUpdateCharge.GetIdent: String;
begin
  Result := txtIdent.Text;
end;

function TViewUpdateCharge.GetBody: String;
var
  ClassPixUpdate  : TBodyCobClass;
  FCalendar       : TCalendar;
  FDebtor         : TDebtor;
  FValue          : TValue;
  FAddInfo        : TAddInfo;
  BodyRequest     : ISuperObject;
begin
  ClassPixUpdate := TBodyCobClass.Create;
  FAddInfo := TAddInfo.Create;

  if txtExpiration.Text = EmptyStr then
    FCalendar.expiration := 0
  else
    FCalendar.expiration := StrToInt(txtExpiration.Text);

  ClassPixUpdate.Calendar := FCalendar;

  FDebtor.cpf := txtCpf.Text;
  FDebtor.name := txtName.Text;
  ClassPixUpdate.Debtor := FDebtor;

  FValue.original := txtValue.Text;
  ClassPixUpdate.Value := FValue;

  ClassPixUpdate.Key := txtKey.Text;
  ClassPixUpdate.PayerRequest := txtPayerRequest.Text;

  if (txtAddInfoName.Text <> EmptyStr) and (txtAddInfoName.Text <> EmptyStr) then
  begin
    ClassPixUpdate.ListAddInfo := TObjectList<TAddInfo>.Create();
    FAddInfo.name  := txtAddInfoName.Text;
    FAddInfo.value := txtAddInfoValue.Text;
    ClassPixUpdate.AddItem(FAddInfo);
  end;

  BodyRequest := SO(ClassPixUpdate.AsJSON(False, False));

  if ClassPixUpdate.Calendar.expiration = 0 then
    BodyRequest.Remove('calendario');

  if ClassPixUpdate.Status = NOT_INFO then
    BodyRequest.Remove('status');

  if (ClassPixUpdate.Debtor.cpf = EmptyStr) and (ClassPixUpdate.Debtor.name = EmptyStr) then
    BodyRequest.Remove('devedor');

  if ClassPixUpdate.Value.original = EmptyStr then
    BodyRequest.Remove('valor');

  if ClassPixUpdate.PayerRequest = EmptyStr then
    BodyRequest.Remove('solicitacaoPagador');

  if ClassPixUpdate.Key = EmptyStr then
    BodyRequest.Remove('chave');

  if not Assigned(ClassPixUpdate.ListAddInfo) then
    BodyRequest.Remove('infoAdicionais');

  Result := BodyRequest.AsJSON;
end;

procedure TViewUpdateCharge.ClearRequestfields;
begin
  txtExpiration.Text := '3600';
  txtName.Text := '';
  txtCpf.Text := '';
  txtValue.Text := '';
  txtKey.Text := '';
  txtPayerRequest.Text := '';
  txtIdent.Text := '';
end;

end.
