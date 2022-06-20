

class Coche:
    def __init__(self, marca, modelo):
        self.marca = marca
        self.modelo = modelo
        self.arrancado = False
    
    def arrancar(self):
        self.arrancado = True
        print("El", self.marca, self.modelo, "se ha arrancado")
        
    def arrancar(self):
        self.arrancado = False
        print("El", self.marca, self.modelo, "se ha parado")
        
laguna = Coche("Ranalt", "Laguna")
tesla = Coche("Tesla", "Model 3")

print(type(laguna))
print(type(tesla))

print(laguna.marca, laguna.modelo)
print(tesla.marca, tesla.modelo)