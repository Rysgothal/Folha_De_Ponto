unit PontoSemanal.Helpers.Exceptions;

interface

uses
  System.SysUtils;

type
  EDataInvalida = class(Exception);
  EDataUltrapassada = class(Exception);
  EDataAlemDosDiasAtuais = class(Exception);

implementation

end.
