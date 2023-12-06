#!/usr/bin/python3
#BISSMILLAH
#Modèle Economie fermée, c'est modèle avec un seul bien à la production et à la consommation,  sans gouvernement ni Epargne (ts le revenu est bien consomme).
import numpy as np

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
Y = np.zeros(2)
# Demande de capital
KD = np.zeros(2)
# Demande de travail
LD = np.zeros(2)
# Prix de l'output
P = np.zeros(2)
# Revenu National
INC = np.zeros(2)
# Rémunération du travail
W = np.zeros(2)
# Rémunération du capital
R = np.zeros(2)
# Consommation finale
C = np.zeros(2)
# Leon
leon = np.zeros(2)

# Initialisation des variables

Y[0] = Y0
KD[0] = KD0
LD[0] = LD0
INC[0] = INC0
W[0] = W0
R[0] = R0
C[0] = C0
P[0] = P0
leon[0] = leonO

# Définition des équations

def Eq_Y(Y, KD, LD, alpha, A):
    return Y == A * (KD ** alpha) * (LD ** (1 - alpha))

def Eq_LD(LD, W, P, INC, alpha):
    return W * LD == (1 - alpha) * P * Y

def Eq_KD(KD, R, P, INC, alpha):
    return R * KD == alpha * P * Y

def Eq_INC(INC, W, L, R, K):
    return INC == W * L + R * K

def Eq_C(C, INC, P):
    return P * C == INC

def Eq_P(Y, C):
    return Y == C

def Eq_W(LD, LS, leon):
    return LD - leon == LS

def Eq_R(KD, KS):
    return KD == KS

# Résolution du modèle

Y[1], KD[1], LD[1], INC[1], W[1], R[1], C[1], P[1], leon[1] = \
    np.linalg.lstsq(
        np.array([Eq_Y, Eq_LD, Eq_KD, Eq_INC, Eq_C, Eq_P, Eq_W, Eq_R]),
        np.array([Y0, KD0, LD0, INC0, C0, P0, W0, R0]),
        rcond=-np.inf
    )[0]

# Calcul des résultats

GDPgrowth = 100 * ((Y[1] / Y0) - 1)
Pgrowth = 100 * ((P[1] / P0) - 1)
Rgrowth = 100 * ((R[1] / R0) - 1)

# Affichage des résultats

print(f"Taux de croissance du PIB : {GDPgrowth:.2f} %")
print(f"Taux de croissance du prix de l'output : {Pgrowth:.2f} %")
print(f"Taux de croissance de la rémunération du capital : {Rgrowth:.2f} %")
print(f"Leon : {leon[1]:.2f}")
