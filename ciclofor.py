import re
import os

tokens = {}


def fullmatch(regex, cad):
    return bool(re.fullmatch(regex, cad))

# tokens
tokens['for'] = '(for)'
tokens['ceroomasesp'] = '( )*'
tokens['unoomasesp'] = '( )+'
tokens['identificador'] = '[a-zA-Z]([0-9]|[a-zA-Z])*'
tokens['entero'] = '[0-9]+'
tokens['unoomaseol'] = '(\n)+'
tokens['parentesisinicio'] = '\('
tokens['parentesisfin'] = '\)'
tokens['puntoycoma'] = ';'
tokens['signocomparacion'] = '(\<|\>|<=|>=|!=|==)'
tokens['signop'] = '(\+|\-|\*|/)'
tokens['llaveinicio'] = '\{'
tokens['llavefin'] = '\}'

# reglas intermedias
midrules = {}
midrules['identoint'] = f'({tokens["entero"]}|{tokens["identificador"]})'
midrules['']

# reglas avanzadas
rules = {}
rules['operacion'] = (midrules['identoint'], tokens['ceroomasesp'], )