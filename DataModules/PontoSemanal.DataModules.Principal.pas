unit PontoSemanal.DataModules.Principal;

interface

uses
  System.SysUtils, System.Classes, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.Controls, Vcl.Dialogs;

type
  TdtmPrincipal = class(TDataModule)
    SalvarArquivo: TSaveDialog;
    CarregarArquivo: TOpenDialog;
    imglistIcones: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmPrincipal: TdtmPrincipal;

implementation

{$R *.dfm}

end.
