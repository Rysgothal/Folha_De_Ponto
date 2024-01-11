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
  pConstrutor.ConstruirDadosFuncionario;
  pConstrutor.ConstruirTituloHorarios;
  pConstrutor.ConstruirHorarioSegunda;
  pConstrutor.ConstruirHorarioTerca;
  pConstrutor.ConstruirHorarioQuarta;
  pConstrutor.ConstruirHorarioQuinta;
  pConstrutor.ConstruirHorarioSexta;
  pConstrutor.ConstruirHorarioSabado;
  pConstrutor.ConstruirSaldoDeHoras;
  pConstrutor.ConstruirRodape;
end;

end.
