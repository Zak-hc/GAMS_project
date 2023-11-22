$ontext
Modele EGC : Etat + S (ménages) + I (des entreprises) (fermeture:   S + PubSold = Inv)
$offtext

Set i /
Agr      Agriculture
Ind      Industrie
Serv     Service
/
;

alias(i,j)  ;

* DEFINITION DES PARAMETRES
** Paramètres des équations du modèle
Parameters
alpha(i)         Elasticité de la production au capital
A(i)             Productivite totale des facteurs
psi_VA(i)        Coefficient Leontief valeur ajoutee - production
psi_IC(i)        Coefficient Leontieff consommation intermediaire - production
psi_IJC(i,j)     Coefficient Leontieff consommation intermediaire
gamma(i)         Part du bien i dans la depense totale du consommateur representatif
alpha_g(i)       Part du bien i dans le budget total du gouvernement
alpha_k(i)       Part du bien i dans les depenses total en capital des entreprises
mps              Propension marginale a epargner du consommateur representatif

** Variables à la période de référence
LS               Offre totale de travail
KS               Offre totale de capital
KD0(i)           Valeur initiale de la demande de capital par le secteur i
LD0(i)           Valeur initiale de la demande de travail par le secteur i
Y0(i)            Valeur initiale de la production du secteur i
INC0             Valeur initiale du revenu du consommateur representatif
W0               Valeur initiale de la remuneration du travail
R0               Valeur initiale de la remuneration du capital
C0(i)            Valeur initiale de la consommation finale de bien i
VA0(i)           Valeur initiale de la valeur ajoutee dans le secteur i
PVA0(i)          Valeur initiale du prix composite de la valeur ajoutee dans le secteur i
IC0(i)           Valeur initiale de la consommation intermediaire totale dans le secteur i
PIC0(i)          Valeur initiale du prix composite de la consommation intermediaire totale dans le secteur i
CIJ0(i,j)        Valeur initiale de la consommation intermediaire de bien i par le secteur j
U0               Valeur initiale de l'utilite du consommateur representatif
P0(i)            Valeur initiale du prix a la consommation du bien i
PY0(i)           Valeur initiale du prix a la production du bien i
DISP_INC0        Valeur initiale du revenu net (apres impot) du consommateur representatif
BUDG_EXP0        valeur initiale des depenses publiques
INDTAX(i)        Recettes issues des taxes indirectes dans le secteur i
DIRTAX           Recettes issues des taxes directes sur le revenu des ménages
CG0(i)           Depense publique en biens du secteur i
CK0(i)           Depense de capital des entreprises en biens du secteur i
indirect_tax(i)  Taux de taxe indirecte dans le secteur i
itr              Taux de taxe directe du menage representatif
savings0         Valeur initiale de l'epargne du consommateur representatif
INV0             Valeur initiale de l'investissement total
pubsold0         Valeur initiale de solde public
;


Table MCS(*,*)
        LD    KD    Men   Gvt    Agr    Ind     Serv   Inv    TOT
LD                              1300   1900     4000         7200
KD                               200   2100      500         2800
Men   7200  2800                                            10000
Gvt                3000          150   1020      280         4450
Agr                1700   400   1000   1000     1000    50   5150
Ind                1200  1500   2010   3510     3000   800  12020
Serv               3400  2300    490   2490     1000   100   9780
Solde               700   250                                 950
Tot   7200  2800  10000  4450   5150  12020     9780   950
;

** Correspondance entre les données de la MCS et les variables
LD0(i)    = MCS('LD',i);
KD0(i)    = MCS('KD',i);
CIJ0(i,j) = MCS(i,j);
INDTAX(i) = MCS('GVT',i);
DIRTAX    = MCS('GVT','MEN');
C0(i)     = MCS(i,'MEN');
CG0(i)    = MCS(i,'GVT');
Y0(i)     = MCS('TOT',i);
savings0  = MCS('Solde','MEN');
pubsold0  = MCS('Solde','Gvt');
CK0(i)    = MCS(i,'INV');

** Normalisation des prix
P0(i)    = 1 ;
R0        = 1 ;
W0        = 1 ;
PVA0(i)   = 1 ;
PIC0(i)   = 1 ;

* CALIBRAGE
LD0(i)       = LD0(i)/W0;
KD0(i)       = KD0(i)/R0;

indirect_tax(i)   = INDTAX(i)/[P0(i)*Y0(i)-INDTAX(i)];
PY0(i)            = P0(i)/[1+indirect_tax(i)];

LS           = sum(i,LD0(i));
KS           = sum(i,KD0(i));
VA0(i)       = [W0*LD0(i)+R0*KD0(i)]/PVA0(i);
alpha(i)     = R0*KD0(i)/[PVA0(i)*VA0(i)];
A(i)         = VA0(i)/{[LD0(i)**(1-alpha(i))]*[KD0(i)**alpha(i)]};
IC0(j)       = sum[i,P0(i)*CIJ0(i,j)]/PIC0(j);
psi_VA(i)    = VA0(i)/Y0(i);
psi_IC(i)    = IC0(i)/Y0(i);
psi_IJC(i,j) = CIJ0(i,j)/IC0(j);
INC0         = W0*LS +R0*KS;
itr          = DIRTAX/INC0 ;
DISP_INC0    = (1-itr)*INC0 ;
mps          = savings0/DISP_INC0;
gamma(i)     = P0(i)*C0(i)/(DISP_INC0*(1-mps));
U0           = prod[i,C0(i)**gamma(i)] ;
BUDG_EXP0    = sum(i,P0(i)*CG0(i)) ;
alpha_g(i)   = P0(i)*CG0(i)/BUDG_EXP0 ;
INV0         = sum(i,P0(i)*CK0(i)) ;
alpha_k(i)   = P0(i)*CK0(i)/INV0;

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
leon.l           = 0 ;

*** definition des equations
equations
EQ_PY(i)         equation de prix producteur
Eq_VA(i)         equation de valeur ajoutee dans le secteur i
Eq_IC(i)         equation de consommation intermediaire totale du secteur i
Eq_Y(i)          equation de production dans le secteur i
Eq_PVA(i)        equation de prix composite de la valeur ajoutee dans le secteur i
Eq_KD(i)         equation de demande de capital par le secteur i
Eq_LD(i)         equation de demande de travail par le secteur i
Eq_PIC(j)        equation de prix composite de la consommation intermediaire totale dans le secteur j
Eq_IC(j)         equation de consommation intermediaire totale dans le secteur j
Eq_IJC(i,j)      equation de consommation intermediaire de bien i par le secteur j
EQ_INC           equation de formation du revenu
Eq_DISP_INC      equation de revenu disponible
EQ_C(i)          equation de consommation finale de bien i
EQ_U             equation de utilite du consommateur representatif
Eq_CK(i)         equation de depense en capital en bien i
Eq_BUDG_EXP      equation de budget public
Eq_CG(i)         equation de depense publique dans chaque secteur
EQ_W             equation de equilibre sur le marche du travail
EQ_R             equation de equilibre sur le marche du capital
EQ_P(i)          equation de equilibre sur le marche du bien i
Eq_Savings       equation d'epargne des menages
EQ_macro         equilibre macroeconomique
;

*** bloc prix
EQ_PY(i)..       PY(i)*(1+indirect_tax(i)) =e= P(i) ;

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
Eq_BUDG_EXP..   itr*INC + sum(i,indirect_tax(i)*PY(i)*Y(i)) - BUDG_EXP =e= pubsold  ;
Eq_CG(i)..      p(i)*CG(i) =e= alpha_g(i)*BUDG_EXP ;

*** bloc equilibre de marche
EQ_W..          LS =e= sum(i,LD(i)) ;
EQ_R..          KS =e= sum(i,KD(i)) ;
EQ_P(i)..       C(i) + sum[j,CIJ(i,j)] + CG(i) + ck(i) =e= Y(i) ;

*** equilibre macroeconomique
EQ_macro..      savings - inv + pubsold =e= Leon;

***modele
model macro_prod /all/ ;

*** numeraire
P.fx('Agr')      = P0('Agr') ;

***bouclage budgetaire
pubsold.fx       = pubsold0 ;
*inv.fx           = inv0 ;
*savings.fx        = savings0;

*** resolution sans choc
solve macro_prod using cns ;

*** choc
Parameter
LS_              parametre buffet pour l'offre de travail
KS_              parametre buffet pour l'offre de capital
A_(i)            parametre buffet pour la productivite totale des facteurs dans le secteur i
itr_             parametre buffet pour le taux de taxation du revenu du menage representatif
indirect_tax_(i) parametre buffet pour le taux de taxation indirecte a la consommation
;

KS_              = KS ;
LS_              = LS ;
A_(i)            = A(i) ;
itr_             = itr ;
indirect_tax_(i) = indirect_tax(i) ;


*LS = 1.1*LS_ ;
*KS = 1.1*KS_ ;
A('Ind')=1.1*A('Ind') ;
*itr = itr*0.9 ;
*indirect_tax(i) = indirect_tax(i)*0.9 ;

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


