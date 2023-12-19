unit PontoSemanal.Helpers.Exceptions;

interface

uses
  System.SysUtils;

type
  { Data de Admissão }
  EDataInvalida = class(Exception);
  EDataUltrapassada = class(Exception);
  EDataAlemDosDiasAtuais = class(Exception);

  { Horas Jornada Semanal }
  EJornadaSemanalInvalida = class(Exception);
  EJornadaSemanalNaoPermitidaLei = class(Exception);

  { Intervalo de Almoço }
  EIntervaloAlmocoInvalido = class(Exception);

implementation

end.
