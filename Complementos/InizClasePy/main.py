from saludar import Saludo
from pprint import pprint

class_name = 'Saludo'
param = 'Alber'

m = globals()[class_name](param)
m.saludar()

pprint(globals())