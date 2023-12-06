#!/usr/bin/python3
#BISSMILLAH
#Modele en equilibre general : trois biens

import numpy as np
import gamspy

# Définition des ensembles et des paramètres

sectors = ["Agr", "Ind", "Serv"]

# Paramètres

LS = 10000
KS = 10000

# Paramètres du choc

LS_ = LS
KS_ = KS
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

# Création du modèle

model = gamspy.Model("model_egc")

# Définition des ensembles et des paramètres

model.set_param("LS", LS)
model.set_param("KS", KS)

# Définition des variables

model.set_var("Y", Y)
model.set_var("P", P)
model.set_var("VA", VA)
model.set_var("PVA", PVA)
model.set_var("IC", IC)
model.set_var("PIC", PIC)
model.set_var("C", C)
model.set_var("INC", INC)
model.set_var("U", U)

# Définition des équations

model.add_equation("Y = PVA * VA + PIC * IC")
model.add_equation("VA = A * KD**alpha * LD**(1 - alpha)")
model.add_equation("KD = alpha * PVA * VA / R")
model.add_equation("LD = (1 - alpha) * PVA * VA / W")
model.add_equation("C = gamma * INC / P")

# Résolution du modèle

model.solve()

# Calcul des résultats

growth_Y = 100 * (model.get_value("Y") / Y0 - 1)
growth_C = 100 * (model.get_value("C") / C0 - 1)
growth_W = 100 * (model.get_value("W") / W0 - 1)
growth_R = 100 * (model.get_value("R") / R0 - 1)
growth_P = 100 * (model.get_value("P") / P0 - 1)
growth_INC = 100 * (model.get_value("INC") / INC0 - 1)

# Affichage des résultats

print(f"Taux de croissance de la production : {growth_Y[0]:.2f} %")
print(f"Taux de croissance de la consommation : {growth_C[0]:.2f} %")
print(f"Taux de croissance de la rémunération du travail : {growth_W[0]:.2f} %")
print(f"Taux de croissance de la rémunération du capital : {growth_R[0]:.2f} %")
print(f"Taux de croissance du prix de l\'output : {growth_P[0]:.2f} %")
print(f"Taux de croissance du revenu national : {growth_INC[0]:.2f} %")
