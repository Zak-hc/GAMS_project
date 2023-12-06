$ontext
Modele EGC avec gouvernement  : Modélisation de la taxation


$offtext

***Definition des ensembles et des parametres
Set i /
Agr      Agriculture
Ind      Industrie
Serv     Services
/
;

alias(i,j)  ;

Parameters
alpha(i)         Elasticite de la production au capital
A(i)             Productivite totale des facteurs
psi_VA(i)        Coefficient Leontief valeur ajoutee - production
psi_IC(i)        Coefficient Leontieff consommation intermediaire - production
psi_IJC(i,j)     Coefficient Leontieff consommation intermediaire
gamma(i)         Part du bien i dans la depense totale du consommateur representatif
alpha_g(i)       Part du bien i dans le budget total du gouvernement

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
indirect_tax(i)  Taux de taxe indirecte dans le secteur i
itr              Taux de taxe directe du menage representatif
;

Table MCS(*,*)
        LD    KD    Men   Gvt    Agr    Ind     Serv       TOT
LD                              1300   1900     4000      7200
KD                               200   2100      500      2800
Men   7200  2800                                         10000
Gvt                3700          100    220      180      4200
Agr                1700   400   1000   1000     1000      5100
Ind                1200  1500   2010   3510     3000     11220
Serv               3400  2300    490   2490     1000      9680
Tot   7200  2800  10000  4200   5100  11220     9680
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

** Normalisation des prix
P0(i)     = 1 ;
R0        = 1 ;
W0        = 1 ;
PVA0(i)   = 1 ;
PIC0(i)   = 1 ;

* CALIBRAGE
LD0(i)       = LD0(i)/W0;
KD0(i)       = KD0(i)/R0;

indirect_tax(i)          = INDTAX(i)/[P0(i)*Y0(i)-INDTAX(i)];
PY0(i)                    = P0(i)/[1+indirect_tax(i)];

LS           = sum(i,LD0(i));
KS           = sum(i,KD0(i));
VA0(i)       = [W0*LD0(i)+R0*KD0(i)]/PVA0(i);
alpha(i)     = R0*KD0(i)/[PVA0(i)*VA0(i)];
A(i)         = VA0(i)/{[LD0(i)**(1-alpha(i))]*[KD0(i)**alpha(i)]};
IC0(j)       = sum[i,P0(i)*CIJ0(i,j)]/PIC0(j);
psi_VA(i)    = VA0(i)/Y0(i);
psi_IC(i)    = IC0(i)/Y0(i);
psi_IJC(i,j) = CIJ0(i,j)/IC0(j);
INC0         = W0*LS+R0*KS;
itr          = DIRTAX/INC0 ;
DISP_INC0    = (1-itr)*INC0 ;
gamma(i)     = P0(i)*C0(i)/DISP_INC0 ;
U0           = prod[i,C0(i)**gamma(i)] ;
BUDG_EXP0    = sum(i,P0(i)*CG0(i)) ;
alpha_g(i)   = P0(i)*CG0(i)/BUDG_EXP0 ;

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
PY(i)           Prix producteur du bien i
DISP_INC        revenu net (apres impot) du menage representatif
BUDG_EXP        depense publique totale
CG(i)           depense publique en bien i
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
CG.l(i)          = CG0(i) ;
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
Eq_BUDG_EXP      equation de budget public
Eq_CG(i)         equation de depense publique dans chaque secteur
EQ_W             equation de equilibre sur le marche du travail
EQ_R             equation de equilibre sur le marche du capital
EQ_P(i)          equation de equilibre sur le marche du bien i
;


*** bloc prix
EQ_PY(i)..       PY(i)*(1+indirect_tax(i)) =e= P(i) ;

*** bloc production
*** Leontieff 1er niveai
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

*** bloc demande
EQ_C(i)..        gamma(i)*DISP_INC =e= P(i)*C(i) ;
EQ_U..           U =e= prod[i,C(i)**gamma(i)] ;

*** bloc gouvernement
Eq_BUDG_EXP..   itr*INC + sum(i,indirect_tax(i)*PY(i)*Y(i)) =e= BUDG_EXP  ;
Eq_CG(i)..      p(i)*CG(i) =e= alpha_g(i)*BUDG_EXP ;

*** equilibre de marche

EQ_W..          LS =e= sum(i,LD(i)) + Leon;
EQ_R..          KS =e= sum(i,KD(i)) ;
EQ_P(i)..       C(i) + sum[j,CIJ(i,j)] + CG(i) =e= Y(i) ;

model macro_prod /all/ ;

*** numeraire
P.fx('Agr') = P0('Agr') ;
*LS = LS*1.2;
*KS = KS*1.5;
*A('SER') = A('SER')*1.2;
*itr = itr*2;
*** resolution sans choc
solve macro_prod using cns ;
Parameter
RategrowthY(i)                   taux de croissance de la production du bien i
RategrowthW                      taux de croissance de la remuneration du travail
RategrowthR                      taux de croissance de la remuneration du capital
RategrowthP                      taux de croissance du prix a la consommation
RategrowthINC                    taux de croissance du revenu national
RategrowthC(i)                   taux de croissance de la consommation de bien i
;
RategrowthY(i)   = 100*((Y.l(i)/Y0(i)) -1) ;
RategrowthC(i)   = 100*((C.l(i)/C0(i)) -1) ;
RategrowthW      = 100*((W.l/W0) -1) ;
RategrowthR      = 100*((R.l/R0) -1) ;
RategrowthP(i)   = 100*((P.l(i)/P0(i)) -1) ;
RategrowthINC    = 100*((INC.l/INC0) -1) ;

display RategrowthY, RategrowthW, RategrowthR, RategrowthP, RategrowthINC, RategrowthC;

