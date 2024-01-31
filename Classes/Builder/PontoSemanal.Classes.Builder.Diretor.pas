unit PontoSemanal.Classes.Builder.Diretor;

interface

uses
  PontoSemanal.Interfaces.Builder.FolhaDePonto;

type
  TDiretor = class
  public
    procedure Construir(pConstrutor: IConstrutor);
  end;

implementation

{ TDiretor }

procedure TDiretor.Construir(pConstrutor: IConstrutor);
begin
  pConstrutor.ConstruirCabecalho;
  pConstrutor.ConstruirHorarios;
  pConstrutor.ConstruirSaldoDeHoras;
  pConstrutor.ConstruirRodape;
end;

end.
