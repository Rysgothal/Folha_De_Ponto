unit PontoSemanal.Classes.Base.Configuracoes;

interface

type
//  TDistribuicaoHorario = class
//  private
//    FDiaUtil: Integer;
//    FDiaNaoUtil: Integer;
//  public
//    property DiaUtil: Integer read FDiaUtil write FDiaUtil;
//    property DiaNaoUtil: Integer read FDiaNaoUtil write FDiaNaoUtil;
//  end;
//
//  TConfiguracao = class
//  private
//    FMaxJornadaDiaria: string;
//    FSomenteDiaUtil: Boolean;
//    FDistribuicaoHorario: TDistribuicaoHorario;
//    FTempoIntervaloAlmoco: string;
//    FMaxIntervaloAlmoco: string;
//  public
//    property MaxJornadaDiaria: string read FMaxJornadaDiaria write FMaxJornadaDiaria;
//    property MaxIntervaloAlmoco: string read FMaxIntervaloAlmoco write FMaxIntervaloAlmoco;
//    property TrabalhaSomenteDiaUtil: Boolean read FSomenteDiaUtil write FSomenteDiaUtil;
//    property DistribuicaoHorario: TDistribuicaoHorario read FDistribuicaoHorario write FDistribuicaoHorario;
//    property TempoIntervaloAlmoco: string read FTempoIntervaloAlmoco write FTempoIntervaloAlmoco;
//  end;

  TConfiguracao = class
  private
    FPossuiAlmocoSabado: Boolean;
    FAutoCompletar: Boolean;
    FMaxJornadaSemanalLei: string;
  public
    constructor Create;
    property PossuiAlmocoSabado: Boolean read FPossuiAlmocoSabado write FPossuiAlmocoSabado;
    property AutoCompletar: Boolean read FAutoCompletar write FAutoCompletar;
    property MaxJornadaSemanalLei: string read FMaxJornadaSemanalLei write FMaxJornadaSemanalLei;
  end;

implementation

{ TConfiguracao }

constructor TConfiguracao.Create;
begin
  FPossuiAlmocoSabado := False;
  FAutoCompletar := False;
  FMaxJornadaSemanalLei := '44';
end;

end.
