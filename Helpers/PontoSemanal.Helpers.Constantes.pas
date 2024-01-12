unit PontoSemanal.Helpers.Constantes;

interface

type
  TConstantes = class abstract
  public
    const REGEX_CODIGO_FUNCIONARIO = '(C�digo|Codigo)\W{0,}(\d{0,7})';
    const REGEX_NOME_FUNCIONARIO = '(Funcion�rio|Funcionario)\W{0,}(.*)\R';
    const REGEX_ADMISSAO_FUNCIONARIO = '(Admiss�o|Admissao)\W{0,}(\d{2}[\/]\d{2}[\/]\d{4})';
    const REGEX_JORNADA_FUNCIONARIO = '(Jornada\sSemanal)\W{0,}(\d{0,3})';
    const REGEX_INTERVALO_FUNCIONARIO = '(Intervalo\sAlmo�o)\W{0,}(\d{2}[\:]\d{2})';
    const HASH_SALTING = '3175634@0733b$66�723464335&d5d5*b5d5�d~2d5b2d3d5b';

    const REGEX_HORARIOS = '(Segunda|Ter�a|Quarta|Sexta|Quinta)\D{0,}?\W{0,}?([0,1][0-9]:[0-5][0-9]|[2][0-3]:[0-5][0' +
      '-9])\W{0,}?([0,1][0-9]:[0-5][0-9]|[2][0-3]:[0-5][0-9])\W{0,}?([0,1][0-9]:[0-5][0-9]|[2][0-3]:[0-5][0-9])\W{0,' +
      '}?([0,1][0-9]:[0-5][0-9]|[2][0-3]:[0-5][0{0,}([0,1][0-9]:[0-5][0-9]|[2][0-3]:[0-5][0-9])|(S�bado|Sabado)\D{0,' +
      '}?\W{0,}([0,1][0-9]:[0-5][0-9]|[2][0-3]:[0-5][0-9])\W{0,}([0,1][0-9]:[0-5][0-9]|[2][0-3]:[0-5][0-9])';
    end;

implementation

end.
