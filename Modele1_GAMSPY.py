#!/usr/bin/python3
#BISSMILLAH
# Modèle Economie fermée, sans gouvernement ni Epargne. C'est modèle avec un seul bien à la production et à la consommation.

import gamspy

# Définition des ensembles et des paramètres

# Offre totale de travail
LS = 7000
# Offre totale de capital
KS = 3000

# Calibrage
KD0 = KS
LD0 = LS
INC0 = LS * W0 + KS * R0
C0 = INC0 / P0
Y0 = C0
alpha = (R0 * KD0) / (P0 * Y0)
A = Y0 / ((KD0 ** alpha) * (LD0 ** (1 - alpha)))
leonO = LD0 - LS

# Définition des variables

# Production nationale en volume
Y = gamspy.Variable("Y")
# Demande de capital
KD = gamspy.Variable("KD")
# Demande de travail
LD = gamspy.Variable("LD")
# Prix de l'output
P = gamspy.Variable("P")
# Revenu National
INC = gamspy.Variable("INC")
# Rémunération du travail
W = gamspy.Variable("W")
# Rémunération du capital
R = gamspy.Variable("R")
# Consommation finale
C = gamspy.Variable("C")
# Leon
leon = gamspy.Variable("leon")

# Initialisation des variables

Y.set_initial_value(Y0)
KD.set_initial_value(KD0)
LD.set_initial_value(LD0)
INC.set_initial_value(INC0)
W.set_initial_value(W0)
R.set_initial_value(R0)
C.set_initial_value(C0)
P.set_initial_value(P0)
leon.set_initial_value(leonO)

# Définition des équations

Eq_Y = gamspy.Equation(Y == A * (KD ** alpha) * (LD ** (1 - alpha)))
Eq_LD = gamspy.Equation(W * LD == (1 - alpha) * P * Y)
Eq_KD = gamspy.Equation(R * KD == alpha * P * Y)
Eq_INC = gamspy.Equation(INC == W * LS + R * KS)
Eq_C = gamspy.Equation(P * C == INC)
Eq_P = gamspy.Equation(Y == C)
Eq_W = gamspy.Equation(LD - leon == LS)
Eq_R = gamspy.Equation(KD == KS)

# Résolution du modèle

model = gamspy.Model("model_egc")
model.add_equation(Eq_Y)
model.add_equation(Eq_LD)
model.add_equation(Eq_KD)
model.add_equation(Eq_INC)
model.add_equation(Eq_C)
model.add_equation(Eq_P)
model.add_equation(Eq_W)
model.add_equation(Eq_R)
model.solve()

# Calcul des résultats

GDPgrowth = 100 * ((Y.get_value() / Y0) - 1)
Pgrowth = 100 * ((P.get_value() / P0) - 1)
Rgrowth = 100 * ((R.get_value() / R0) - 1)
leon = leon.get_value()

# Affichage des résultats

print(f"Taux de croissance du PIB : {GDPgrowth:.2f} %")
print(f"Taux de croissance du prix de l'output : {Pgrowth:.2f} %")
print(f"Taux de croissance de la rémunération du capital : {Rgrowth:.2f} %")
print(f"Leon : {leon:.2f}")
