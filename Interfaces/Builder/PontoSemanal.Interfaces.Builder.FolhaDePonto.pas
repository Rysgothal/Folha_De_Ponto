unit PontoSemanal.Interfaces.Builder.FolhaDePonto;

interface

uses
  System.Classes;

type
  IConstrutor = interface
    procedure ConstruirCabecalho;
//    procedure ConstruirDadosFuncionario;
//    procedure ConstruirTituloHorarios;
    procedure ConstruirHorarios;
//    procedure ConstruirHorarioSegunda;
//    procedure ConstruirHorarioTerca;
//    procedure ConstruirHorarioQuarta;
//    procedure ConstruirHorarioQuinta;
//    procedure ConstruirHorarioSexta;
//    procedure ConstruirHorarioSabado;
    procedure ConstruirSaldoDeHoras;
    procedure ConstruirRodape;
    function GetFolhaDePonto: TStringList;
  end;

implementation

end.
