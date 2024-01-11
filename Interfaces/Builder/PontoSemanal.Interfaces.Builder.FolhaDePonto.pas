unit PontoSemanal.Interfaces.Builder.FolhaDePonto;

interface

uses
  System.Classes;

type
  IConstrutor = interface
    procedure ConstruirCabecalho;
    procedure ConstruirDadosFuncionario;
    procedure ConstruirTituloHorarios;
    procedure ConstruirHorarioSegunda;
    procedure ConstruirHorarioTerca;
    procedure ConstruirHorarioQuarta;
    procedure ConstruirHorarioQuinta;
    procedure ConstruirHorarioSexta;
    procedure ConstruirHorarioSabado;
    procedure ConstruirSaldoDeHoras;
    procedure ConstruirRodape;
    procedure ConstruirLinhaDivisaoHorarios;
    function GetFolhaDePonto: TStringList;
  end;

implementation

end.
