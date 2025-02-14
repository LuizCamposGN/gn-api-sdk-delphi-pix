unit KeyPixEndpoints;

interface

uses
  Classes, Connections, IdHTTP, XSuperObject, IdGlobal, Vcl.Dialogs, System.SysUtils, Forms,
  MainCode, ViewDetail, ViewCreateImmediateCharge;

Procedure GnListEvp;
Procedure GnCreateEvp;
Procedure GnDeleteEvp;

implementation

threadvar
  HttpClient: TIdHTTP;
  AccessToken, ObjResult : iSuperObject;
  JsonToSend: TMemoryStream;

procedure GnListEvp;
var
  sResponse: string;
begin
  try
    AccessToken := Connections.OauthToken;
    HttpClient := Connections.SetupClient;

    HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);
    sResponse := HttpClient.Get( MainCode.MainFrm.Enviroment + '/v2/gn/evp');

    MainCode.MainFrm.MemoResponse.text := sresponse;

  except
    on E: Exception do
    begin
      ShowMessage('Erro na Requisi�o GET /v2/gn/evp '#13#10#13#10 + e.Message);
    end;
  end;
end;

procedure GnCreateEvp;
Const
  Body = '{}';
var
  sResponse: string;
begin
  try
    AccessToken := Connections.OauthToken;
    HttpClient := Connections.SetupClient;

    HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

    JsonToSend := TMemoryStream.Create;
    WriteStringToStream(JsonToSend, Body, IndyTextEncoding_UTF8);
    JsonToSend.Position := 0;

    sResponse := HttpClient.Post( MainCode.MainFrm.Enviroment + '/v2/gn/evp', JsonToSend);

    MainCode.MainFrm.MemoResponse.text := sresponse;

  except
    on E: Exception do
    begin
      ShowMessage('Erro na Requisi�o POST /v2/gn/evp '#13#10#13#10 + e.Message);
    end;
  end;
end;

procedure GnDeleteEvp;
var
  sResponse: string;
  Modal    : TViewDetail;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewDetail, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := Connections.OauthToken;
        HttpClient := Connections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        sResponse := HttpClient.Delete(MainCode.MainFrm.Enviroment + '/v2/gn/evp/'+ Modal.Identifier);

        MainCode.MainFrm.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na requisi��o DELETE /v2/gn/evp '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;


end.
