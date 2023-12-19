unit PontoSemanal.Frames.HorarioDiaUtil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls;

type
  TfrmHorariosDiaUtil = class(TFrame)
    lbeEntrada: TLabeledEdit;
    edtSaldoHora: TEdit;
    lblDesempenho: TLabel;
    edtTotalHora: TEdit;
    lblTotalHora: TLabel;
    lbeSaidaAlmoco: TLabeledEdit;
    lbeRetornoAlmoco: TLabeledEdit;
    lbeSaidaFinal: TLabeledEdit;
    bvlDivisorTotalHoras: TBevel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
