import time

vet = [81]

for i in range(81) :
    vet.append(81-i)

#print (vet)

def buble():
    pivo = 0
    vet_aux = []

    while pivo < 81:
        if vet[pivo] > vet[pivo+1]:
            #print(vet[pivo],vet[pivo+1])
            vet_aux = vet[pivo+1]
            #print(vet_aux)
            vet[pivo+1] = vet[pivo]
            vet[pivo] = vet_aux
            pivo = 0
        else:
            pivo = pivo + 1 

# verifica o tempo de resposta da função soma1
ini = time.time()
buble()
fim = time.time()

#print (vet)
print (fim-ini)
