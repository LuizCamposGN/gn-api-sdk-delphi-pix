unit ViewCreateCharge;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BodyChargesClass, XSuperJSON, XSuperObject, System.JSON;

type
  TViewCreateCharge = class(TForm)
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

procedure TViewCreateCharge.btnCancelRequestClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TViewCreateCharge.btnConfirmRequestClick(Sender: TObject);
begin

  if txtIdent.Text = EmptyStr then
  begin
    MessageDlg('O identificador n�o pode ser vazio', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtIdent.CanFocus then
      txtIdent.SetFocus;
  end
  else if txtExpiration.Text = EmptyStr then
  begin
    MessageDlg('Necess�rio informar um tempo para a cobran�a', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtExpiration.CanFocus then
      txtExpiration.SetFocus;
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
  else if txtValue.Text = EmptyStr then
  begin
    MessageDlg('Necess�rio informar um valor para a cobran�a', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtValue.CanFocus then
      txtValue.SetFocus;
  end
  else if txtKey.Text = EmptyStr then
  begin
    MessageDlg('A chave n�o pode ser vazia', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtKey.CanFocus then
      txtKey.SetFocus;
  end
  else
    ModalResult := mrOk;

end;

procedure TViewCreateCharge.FormCreate(Sender: TObject);
begin
  Self.Position := poScreenCenter;
end;

function TViewCreateCharge.GetIdent: String;
begin
  Result := txtIdent.Text;
end;

function TViewCreateCharge.GetBody: String;
var
  ClassPixCreate     : TBodyCobClass;
  FCalendar          : TCalendar;
  FDebtor            : TDebtor;
  FValue             : TValue;
  BodyRequest        : ISuperObject;
begin
  ClassPixCreate := TBodyCobClass.Create;

  FCalendar.expiration := StrToInt(txtExpiration.Text);
  ClassPixCreate.Calendar := FCalendar;

  FDebtor.cpf := txtCpf.Text;
  FDebtor.name := txtName.Text;
  ClassPixCreate.Debtor := FDebtor;

  FValue.original := txtValue.Text;
  ClassPixCreate.Value := FValue;

  ClassPixCreate.Key := txtKey.Text;
  ClassPixCreate.PayerRequest := txtPayerRequest.Text;

  BodyRequest := SO(ClassPixCreate.AsJSON(False, False));

  if (ClassPixCreate.Debtor.cpf = EmptyStr) or (ClassPixCreate.Debtor.name = EmptyStr) then
    BodyRequest.Remove('devedor');

  if ClassPixCreate.PayerRequest = EmptyStr then
    BodyRequest.Remove('solicitacaoPagador');

  BodyRequest.Remove('status');
  BodyRequest.Remove('infoAdicionais');

  Result := BodyRequest.AsJSON;
end;

procedure TViewCreateCharge.ClearRequestfields;
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
