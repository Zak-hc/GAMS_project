$ontext
Modele EGC : MEGC_Exercice 5 + ROW (fermeture: 
$offtext

Set i /
Agr      Agriculture
Ind      Industrie
Serv     Service
/
;

alias(i,j)  ;


Parameters
LS               Offre totale de travail en Mds USD
KS               Offre totale de capital en Mds USD
KD0(i)           valeurs initiales de la demande de capital par le secteur i en Mds USD
LD0(i)           valeurs initiales de la demande de travail par le secteur i en Mds USD
Y0(i)            valeurs initiales de la production du secteur i en Mds USD
P0(i)            valeurs initiales du prix a la consommation du bien i
PY0(i)           valeurs initiales du prix a la production du bien i
VA0(i)           valeurs initiales de la valeur ajoutee dans le secteur i en Mds USD
PVA0(i)          valeurs initiales du prix composite de la valeur ajoutee dans le secteur i
IC0(i)           valeurs initiales de la consommation intermediaire totale dans le secteur i en Mds USD
CIJ0(i,j)        valeurs initiales de la consommation intermediaire de bien i par le secteur j  en Mds USD
PIC0(i)          valeurs initiales du prix composite de la consommation intermediaire totale dans le secteur i
INC0             valeur initiale du revenu brut (avant impot) du consommateur representatif en Mds USD
DISP_INC0        valeur initiale du revenu net (apres impot) du consommateur representatif en Mds USD
BUDG_EXP0        valeur initiale des depenses publiques en Mds USD
W0               valeur initiale de la remuneration du travail
R0               valeur initiale de la remuneration du capital
C0(i)            valeurs initiales de la consommation finale de bien i en Mds USD
U0               valeur initiale de l'utilite du consommateur representatif
INDTAX(i)        recettes issues des taxes indirectes dans le secteur i en Mds USD
INCOME_TAX       recette de l'impot sur le revenu des menages en Mds USD
CG0(i)           depense publique en biens du secteur i
indirect_tax(i)  taux de taxe indirecte dans le secteur i
itr              taux de taxe directe du menage representatif
leon0            valeur initiale du leon
mps              propension marginale a epargner du consommateur representatif
savings0         valeur initiale de l'epargne du consommateur representatif USD Mios
ck0              valeurs initiales de la depense de capital en biens i
inv0             valeur initiale de l'investissement des entreprises
pubsold0         valeur initiale de solde public USD Mios
tradesold0       solde commercial initial USD Mios
ed0(i)           valeurs initiales des demandes excedentaires  USD Mios
pe0(i)           prix mondial du bien i
e0               taux de change initial - unites de monnaie etrangere par unite de monnaie nationale
tm(i)            droit de douane sur importation du bien i

psi_VA(i)        coefficient Leontieff valeur ajoutee - production
psi_IC(i)        coefficient Leontieff consommation intermediaire - production
psi_IJC(i,j)     coefficient Leontieff consommation intermediaire
alpha(i)         elasticite de la valeur ajoutee du capital dans le secteur i
gamma(i)         part du bien i dans la depense totale du consommateur representatif
alpha_g(i)       part du bien i dans la depense publique totale
alpha_k(i)       part du bien i dans la depense en capital totale
A(i)             productivite totale des facteurs dans le secteur i
f(i)             parametre d'echelle offre mondiale d'importations
;

* Matrice de comptabilité sociale
Table MCS(*,*)
         LD        KD      Men   Gvt     Agr     Ind        Serv         Acc     RM      Total
LD                                       1100    1700       4150                         6950
KD                                       250     1800       550                          2600
Men      6950      2600                                                                  9550
Gvt                        1400          150     1320       280                          3150
Agr                        1700  400     1100    900        1100         200             5400
Ind                        1200  900     2200    3150       3300         800             11550
Serv                       3400  2750    850     2250       1100         100             10450
Acc                        1850  -900                                            150     1100
RM                                       -250    430        -30                          150
Total    6950      2600    9550  3150    5400    11550      10450        1100    150
;

parameter importcoll(i)  collecte initiale de recettes sur importations USD Mios
/
Agr      0
Ind      300
Serv     0
/;

parameter sigma(i)  elasticite de l'offre mondiale d'importations au prix mondial
/
Agr      -3
Ind      3
Serv     -3
/;
*entree des donnees
KD0(i)           = MCS('KD',i)  ;
LD0(i)           = MCS('LD',i)  ;
CG0(i)           = MCS(i,'Gvt')  ;
Y0(i)            = MCS('Total',i) - MCS('RM',i) - importcoll(i) ;
ck0(i)           = MCS(i,'Acc')  ;
INDTAX(i)        = MCS('Gvt',i) - importcoll(i)  ;
C0(i)            = MCS(i,'Men') ;
INCOME_TAX       = MCS('Gvt','Men') ;
savings0         = MCS('Acc','Men') ;
CIJ0(i,j)        = MCS(i,j) ;
ed0(i)           = MCS('RM',i) + importcoll(i)  ;

*** normalisation
P0(i)            = 1 ;
R0               = 1 ;
W0               = 1 ;
PVA0(i)          = 1 ;
PIC0(i)          = 1 ;
e0               = 1 ;

*** calibrage
LS                       = sum(i,LD0(i)) ;
KS                       = sum(i,KD0(i)) ;
indirect_tax(i)          = INDTAX(i)/(P0(i)*Y0(i)-INDTAX(i)) ;
PY0(i)                   = P0(i)/(1+indirect_tax(i)) ;
IC0(j)                   = sum[i,P0(i)*CIJ0(i,j)]/PIC0(j) ;
VA0(i)                   = [PY0(i)*Y0(i) - PIC0(i)*IC0(i)]/PVA0(i)     ;
alpha(i)                 = R0*KD0(i)/[PVA0(i)*VA0(i)] ;
A(i)                     = VA0(i)/{[LD0(i)**(1-alpha(i))]*[KD0(i)**alpha(i)]};
INC0                     = W0*LS + R0*KS ;
itr                      = INCOME_TAX/INC0 ;
DISP_INC0                = (1-itr)*INC0 ;
BUDG_EXP0                = sum(i,P0(i)*CG0(i)) ;
alpha_g(i)               = P0(i)*CG0(i)/BUDG_EXP0 ;
tm(i)$(ed0(i)>0)         = importcoll(i)/[p0(i)*ed0(i)-importcoll(i)] ;
tm(i)$(ed0(i)<0)         = 0 ;
pe0(i)                   = p0(i)/[e0*(1+tm(i)) ] ;
f(i)                     = ed0(i) /[pe0(i)**sigma(i)]  ;
tradesold0               = e0*sum[i,pe0(i)*(-ed0(i))]  ;
psi_VA(i)                = VA0(i)/Y0(i) ;
psi_IC(i)                = IC0(i)/Y0(i) ;
psi_IJC(i,j)             = CIJ0(i,j)/IC0(j) ;
inv0                     = sum(i,p0(i)*ck0(i)) ;
alpha_k(i)               = ck0(i)/inv0 ;
mps                      = savings0/DISP_INC0 ;
gamma(i)                 = P0(i)*C0(i)/[(1-mps)*DISP_INC0] ;
U0                       = prod[i,C0(i)**gamma(i)] ;
pubsold0                 = itr*INC0 + sum(i,indirect_tax(i)*PY0(i)*Y0(i))
                         + sum[i$(ed0(i)>0),tm(i)*e0*pe0(i)*ed0(i)] - BUDG_EXP0 ;
leon0                    = savings0 - inv0 + pubsold0 - tradesold0;
display U0, C0
$exit

*** definition des variables
variables
KD(i)           demande de capital par le secteur i
LD(i)           demande de travail par le secteur i
Y(i)            production du secteur i
P(i)            prix du bien i
VA(i)           valeur ajoutee dans le secteur i
PVA(i)          prix composite de la valeur ajoutee dans le secteur i
IC(i)           consommation intermediaire totale du secteur i
PIC(i)          prix composite de la consommation intermediaire totale dans le secteur i
CIJ(i,j)        consommation intermediaire de bien i par le secteur j
INC             revenu du consommateur representatif
W               remuneration du travail
R               remuneration du capital
C(i)            consommation finale de bien i
U               utilite du consommateur representatif
inv             investissement des entreprises
ck(i)           depense en capital en bien i
PY(i)           Prix producteur du bien i
DISP_INC        revenu net (apres impot) du menage representatif
BUDG_EXP        depense publique totale
CG(i)           depense publique en bien i
savings         epargne du consommateur representatif USD Mios
pubsold         solde public USD Mios
leon            leon
tradesold       solde commercial USD Mios
ed(i)           demande excedentaire de bien i
pe(i)           prix mondial du bien i
e               taux de change
;

*** initialisation des variables
Y.l(i)           = Y0(i) ;
KD.l(i)          = KD0(i) ;
LD.l(i)          = LD0(i);
VA.l(i)          = VA0(i) ;
PVA.l(i)         = PVA0(i) ;
IC.l(i)          = IC0(i) ;
CIJ.l(i,j)       = CIJ0(i,j) ;
PIC.l(i)         = PIC0(i) ;
C.l(i)           = C0(i) ;
INC.l            = INC0 ;
W.l              = W0 ;
R.l              = R0 ;
U.l              = U0 ;
P.l(i)           = P0(i) ;
PY.l(i)          = PY0(i) ;
DISP_INC.l       = DISP_INC0 ;
BUDG_EXP.l       = BUDG_EXP0 ;
inv.l            = inv0 ;
ck.l(i)          = ck0(i) ;
CG.l(i)          = CG0(i) ;
savings.l        = savings0 ;
pubsold.l        = pubsold0 ;
tradesold.l      = tradesold0 ;
ed.l(i)          = ed0(i) ;
pe.l(i)          = pe0(i) ;
e.l              = e0 ;
leon.l           = leon0 ;

*** definition des equations
equations
EQ_PY(i)         equation de prix producteur
EQ_P(i)          equation de equilibre sur le marche du bien i
EQ_pe(i)         equation du prix mondial du bien i
Eq_VA(i)         equation de valeur ajoutee dans le secteur i
Eq_IC(i)         equation de consommation intermediaire totale du secteur i
Eq_Y(i)          equation de production dans le secteur i
Eq_PVA(i)        equation de prix composite de la valeur ajoutee dans le secteur i
Eq_KD(i)         equation de demande de capital par le secteur i
Eq_LD(i)         equation de demande de travail par le secteur i
Eq_PIC(j)        equation de prix composite de la consommation intermediaire totale dans le secteur j
Eq_IJC(i,j)      equation de consommation intermediaire de bien i par le secteur j
EQ_INC           equation de formation du revenu
Eq_DISP_INC      equation de revenu disponible
Eq_Savings       equation d epargne du menage representatif
EQ_C(i)          equation de consommation finale de bien i
EQ_U             equation de utilite du consommateur representatif
Eq_CK(i)         equation de depense en capital en bien i
Eq_BUDG_EXP      equation de budget public
Eq_CG(i)         equation de depense publique dans chaque secteur
EQ_W             equation de equilibre sur le marche du travail
EQ_R             equation de equilibre sur le marche du capital
EQ_ed(i)         equation de demande execedentaire du bien i
EQ_macro         equilibre macroeconomique
EQ_tradesold     equation du solde commercial
;

*** bloc prix
EQ_PY(i)..       PY(i)*(1+indirect_tax(i)) =e= P(i) ;
EQ_P(i)..        p(i) =e= e*pe(i)*[1+tm(i)]  ;
EQ_Pe(i)..       ED(i) =e= f(i)*(pe(i)**sigma(i))  ;

*** bloc production
*** Leontieff 1er niveau
Eq_VA(i)..       VA(i)  =e= psi_VA(i)*Y(i) ;
Eq_IC(i)..       IC(i)  =e= psi_IC(i)*Y(i) ;
Eq_Y(i)..        PY(i)*Y(i) =e= PVA(i)*VA(i)+PIC(i)*IC(i) ;

*** Cobb Douglas 2eme niveau
Eq_PVA(i)..      VA(i) =e= A(i)*[KD(i)**alpha(i)]*[LD(i)**(1-alpha(i))];
Eq_KD(i)..       alpha(i)*PVA(i)*VA(i) =e= R*KD(i) ;
Eq_LD(i)..       [1-alpha(i)]*PVA(i)*VA(i) =e= W*LD(i) ;

*** Leontieff 2eme niveau
Eq_PIC(j)..      PIC(j)*IC(j) =e= sum[i,P(i)*CIJ(i,j)] ;
Eq_IJC(i,j)..    CIJ(i,j) =e= psi_IJC(i,j)*IC(j) ;

*** bloc revenu
EQ_INC..         INC =e= W*LS + R*KS ;
Eq_DISP_INC..    DISP_INC =e= (1-itr)*INC ;
Eq_Savings..     savings =e= mps*DISP_INC ;

*** bloc demande
*****menages
EQ_C(i)..        gamma(i)*(1-mps)*DISP_INC =e= P(i)*C(i) ;
EQ_U..           U =e= prod[i,C(i)**gamma(i)] ;

*****entreprises
Eq_CK(i)..       p(i)*ck(i) =e= alpha_k(i)*inv ;

*** bloc gouvernement
Eq_BUDG_EXP..   itr*INC + sum(i,indirect_tax(i)*PY(i)*Y(i))
                 + sum[i$(ED0(i)>0),tm(i)*e*pe(i)*ED(i)] - BUDG_EXP =e= pubsold ;
Eq_CG(i)..      p(i)*CG(i) =e= alpha_g(i)*BUDG_EXP ;

*** bloc equilibre de marche
EQ_W..          LS =e= sum(i,LD(i)) ;
EQ_R..          KS =e= sum(i,KD(i)) ;
EQ_ED(i)..      C(i) + sum[j,CIJ(i,j)] + CK(i) + CG(i) + (-ED(i)) =e= Y(i) ;

*** equilibre macroeconomique
EQ_macro..       savings - inv + pubsold =e= tradesold + Leon;
EQ_tradesold..   tradesold =e= e*sum[i,pe(i)*(-ed(i))]  ;

***modele
model macro_prod /all/ ;

*** numeraire
P.fx('Agr')      = P0('Agr') ;

***bouclage
pubsold.fx       = pubsold0 ;
e.fx             = e0;
*** resolution sans choc
solve macro_prod using cns ;

*** choc
Parameter
LS_              parametre buffet pour l'offre de travail
KS_              parametre buffet pour l'offre de capital
A_(i)            parametre buffet pour la productivite totale des facteurs dans le secteur i
itr_             parametre buffet pour le taux de taxation du revenu du menage representatif
indirect_tax_(i) parametre buffet pour le taux de taxation indirecte a la consommation
tm_(i)           parametre buffet pour le taux de taxation des importations;

KS_              = KS ;
LS_              = LS ;
A_(i)           = A(i) ;
itr_             = itr ;
indirect_tax_(i) = indirect_tax(i) ;
tm_(i)=tm(i);

indirect_tax(i) = indirect_tax(i)*0.9 ;

solve macro_prod using cns ;

*** resultats
Parameter
RategrowthY(i)                   taux de croissance de la production du bien i
RategrowthW                      taux de croissance de la remuneration du travail
RategrowthR                      taux de croissance de la remuneration du capital
RategrowthP                      taux de croissance du prix a la consommation
RategrowthINC                    taux de croissance du revenu national
RategrowthC(i)                   taux de croissance de la consommation de bien i
PIndC                            indice des prix a la consommation ;

RategrowthY(i)   = 100*((Y.l(i)/Y0(i)) -1) ;
RategrowthC(i)   = 100*((C.l(i)/C0(i)) -1) ;
RategrowthW      = 100*((W.l/W0) -1) ;
RategrowthR      = 100*((R.l/R0) -1) ;
RategrowthP(i)   = 100*((P.l(i)/P0(i)) -1) ;
RategrowthINC    = 100*((INC.l/INC0) -1) ;
PIndC            = sqrt{sum[i,P.l(i)*C0(i)]
                   /sum[i,P0(i)*C0(i)]
                   *sum[i,P.l(i)*C.l(i)]
                   /sum[i,P0(i)*C.l(i)]} ;

*** affichage des resultats
display RategrowthY, RategrowthW, RategrowthR, RategrowthP, RategrowthINC, RategrowthC, PIndC ;
