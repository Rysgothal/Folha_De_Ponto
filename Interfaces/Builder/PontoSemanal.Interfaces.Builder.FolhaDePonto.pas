unit PontoSemanal.Interfaces.Builder.FolhaDePonto;

interface

uses
  System.Classes;

type
  IConstrutor = interface
    procedure ConstruirCabecalho;
    procedure ConstruirHorarios;
    procedure ConstruirSaldoDeHoras;
    procedure ConstruirRodape;
    function GetFolhaDePonto: TStringList;
  end;

implementation

end.
