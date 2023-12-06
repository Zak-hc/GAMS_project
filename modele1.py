#!/usr/bin/python3
#Bissmilah 
import numpy as np

# Définition des ensembles et des paramètres

# Ensemble des secteurs
sectors = ['Agr', 'Ind', 'Serv']

# Paramètres

# Offre totale de travail
LS = 10000
# Offre totale de capital
KS = 10000

# Paramètres du choc

# Augmentation de l'offre de travail
LS_ = LS
# Augmentation de l'offre de capital
KS_ = KS
# Augmentation de la productivité totale des facteurs dans le secteur industriel
A_Ind = A_Ind * 1.1

# Données de la MCS

data = np.array([
    [1000, 2000, 4000, 7000],
    [500, 2000, 500, 3000],
    [7000, 3000, 0, 0]
])

# Initialisations des variables

Y = data[:, 0]
P = np.ones(3)
VA = Y / P
PVA = VA / np.sum(VA)
IC = data[:, 1:-1]
PIC = np.ones(3)
C = Y - IC
INC = LS * W + KS * R
U = np.prod(C**gamma)

# Calcul des variables

for i in sectors:
    Y[i] = PVA[i] * VA[i] + PIC[i] * IC[i]
    VA[i] = A[i] * KD[i]**alpha[i] * LD[i]**(1 - alpha[i])
    KD[i] = alpha[i] * PVA[i] * VA[i] / R
    LD[i] = (1 - alpha[i]) * PVA[i] * VA[i] / W
    C[i] = gamma[i] * INC / P[i]

# Résolution du modèle

res = np.linalg.lstsq(
    np.array([Y, C, VA, IC, KD, LD, PIC, P]),
    np.array([LS, W, R, INC, U]),
    rcond=-np.inf
)[0]

# Calcul des résultats

growth_Y = 100 * (res[0] / Y0 - 1)
growth_C = 100 * (res[2] / C0 - 1)
growth_W = 100 * (res[1] / W0 - 1)
growth_R = 100 * (res[3] / R0 - 1)
growth_P = 100 * (res[4] / P0 - 1)
growth_INC = 100 * (res[5] / INC0 - 1)

# Affichage des résultats

print(f'Taux de croissance de la production : {growth_Y[0]:.2f} %')
print(f'Taux de croissance de la consommation : {growth_C[0]:.2f} %')
print(f'Taux de croissance de la rémunération du travail : {growth_W[0]:.2f} %')
print(f'Taux de croissance de la rémunération du capital : {growth_R[0]:.2f} %')
print(f'Taux de croissance du prix de l\'output : {growth_P[0]:.2f} %')
print(f'Taux de croissance du revenu national : {growth_INC[0]:.2f} %')
