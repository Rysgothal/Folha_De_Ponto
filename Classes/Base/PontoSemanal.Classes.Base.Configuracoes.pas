unit PontoSemanal.Classes.Base.Configuracoes;

interface

type
  TDistribuicaoHorario = class
  private
    FDiaUtil: Integer;
    FDiaNaoUtil: Integer;
  public
    property DiaUtil: Integer read FDiaUtil write FDiaUtil;
    property DiaNaoUtil: Integer read FDiaNaoUtil write FDiaNaoUtil;
  end;

  TConfiguracao = class
  private
    FMaxJornadaSemanal: string;
    FMaxJornadaDiaria: string;
    FSomenteDiaUtil: Boolean;
    FDistribuicaoHorario: TDistribuicaoHorario;
    FTempoIntervaloAlmoco: string;
    FMaxIntervaloAlmoco: string;
  public
    property MaxJornadaSemanal: string read FMaxJornadaSemanal write FMaxJornadaSemanal;
    property MaxJornadaDiaria: string read FMaxJornadaDiaria write FMaxJornadaDiaria;
    property MaxIntervaloAlmoco: string read FMaxIntervaloAlmoco write FMaxIntervaloAlmoco;
    property TrabalhaSomenteDiaUtil: Boolean read FSomenteDiaUtil write FSomenteDiaUtil;
    property DistribuicaoHorario: TDistribuicaoHorario read FDistribuicaoHorario write FDistribuicaoHorario;
    property TempoIntervaloAlmoco: string read FTempoIntervaloAlmoco write FTempoIntervaloAlmoco;
  end;

implementation

end.
