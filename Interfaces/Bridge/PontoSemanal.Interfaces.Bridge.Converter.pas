unit PontoSemanal.Interfaces.Bridge.Converter;

interface

type
  IConverter = interface
    function ParaMinutos(pHorario: string): Integer;
  end;

implementation

end.
