unit PontoSemanal.Helpers.Constantes;

interface

uses
  PontoSemanal.Helpers.TiposAuxiliares;

type
  TConstantes = class abstract
  public
    const LINHAS_LAYOUT_DADOS_FUNCIONARIOS: array[0..4] of Integer = (
      Ord(llCodigo), Ord(llFuncionario), Ord(llAdmissao), Ord(llJornada), Ord(llIntervalo)
    );

    const LINHAS_LAYOUT_HORARIOS_SEMANA: array[0..5] of Integer = (
      Ord(llSegunda), Ord(llTerca), Ord(llQuarta), Ord(llQuinta), Ord(llSexta), Ord(llSabado)
    );

    const LINHAS_LAYOUT_SALDO_HORAS_SEMANA: array[0..2] of Integer = (
      Ord(llTotalHorasSemana), Ord(llHorasFaltantes), Ord(llHorasExcedentes)
    );

    const HASH_SALTING = '3175634@0733b$66�723464335&d5d5*b5d5�d~2d5b2d3d5b';
    const REGEX_PEGAR_HASH = '[a-zA-Z0-9]{32}';
    const REGEX_NAO_PALAVRAS = '\W{0,}?';
    const REGEX_NAO_DIGITOS = '\D{0,}?';
    const REGEX_HORARIO_VALIDO = '([0,1][0-9]:[0-5][0-9]|[2][0-3]:[0-5][0-9])';
    const REGEX_SEGUNDA = 'Segunda';
    const REGEX_TERCA = 'Ter[c|�]a';
    const REGEX_QUARTA = 'Quarta';
    const REGEX_QUINTA = 'Quinta';
    const REGEX_SEXTA = 'Sexta';
    const REGEX_SABADO = 'S[a|�]bado';
    const REGEX_CODIGO_FUNCIONARIO = '(C[�|o]digo)\W{0,}(\d{0,7})';
    const REGEX_NOME_FUNCIONARIO = '(Funcion[�|a]rio)\W{0,}(.*)\R';
    const REGEX_ADMISSAO_FUNCIONARIO = '(Admiss[�|a]o)\W{0,}(\d{2}[\/]\d{2}[\/]\d{4})';
    const REGEX_JORNADA_FUNCIONARIO = '(Jornada\sSemanal)\W{0,}(\d{0,3})';
    const REGEX_INTERVALO_FUNCIONARIO = '(Intervalo\s?Almo[�|c]o)\W{0,}(\d{2}[\:]\d{2})';

    const REGEX_FOLHA_HORARIOS_DIA_UTIL = REGEX_NAO_DIGITOS + REGEX_NAO_PALAVRAS + REGEX_HORARIO_VALIDO +
      REGEX_NAO_PALAVRAS + REGEX_HORARIO_VALIDO + REGEX_NAO_PALAVRAS + REGEX_HORARIO_VALIDO + REGEX_NAO_PALAVRAS +
      REGEX_HORARIO_VALIDO + REGEX_NAO_PALAVRAS + REGEX_HORARIO_VALIDO;

    const REGEX_FOLHA_HORARIOS_NAO_UTIL = REGEX_NAO_DIGITOS + REGEX_NAO_PALAVRAS + REGEX_HORARIO_VALIDO +
      REGEX_NAO_PALAVRAS + REGEX_HORARIO_VALIDO;

    const REGEX_SEGUNDA_HORARIOS = REGEX_SEGUNDA + REGEX_FOLHA_HORARIOS_DIA_UTIL;
    const REGEX_TERCA_HORARIOS = REGEX_TERCA + REGEX_FOLHA_HORARIOS_DIA_UTIL;
    const REGEX_QUARTA_HORARIOS = REGEX_QUARTA + REGEX_FOLHA_HORARIOS_DIA_UTIL;
    const REGEX_QUINTA_HORARIOS = REGEX_QUINTA + REGEX_FOLHA_HORARIOS_DIA_UTIL;
    const REGEX_SEXTA_HORARIOS = REGEX_SEXTA + REGEX_FOLHA_HORARIOS_DIA_UTIL;
    const REGEX_SABADO_HORARIOS = REGEX_SABADO + REGEX_FOLHA_HORARIOS_NAO_UTIL;
  end;

implementation

end.
