unit PontoSemanal.Interfaces.Bridge.Converter;

interface

type
  IConverter = interface
    function ParaMinutos(const pHorario: string): Integer;
  end;

implementation

end.
