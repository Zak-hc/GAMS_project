$ontext
Modele EGC inspiré de Bouet 2017

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
LS       Offre totale de travail
KS       Offre totale de capital
;

Parameters
KD0(i)           valeurs initiales de la demande de capital par le secteur i
LD0(i)           valeurs initiales de la demande de travail par le secteur i
Y0(i)            valeurs initiales de la production du secteur i
P0(i)            valeurs initiales du prix du bien i
VA0(i)           valeurs initiales de la valeur ajoutee dans le secteur i
PVA0(i)          valeurs initiales du prix composite de la valeur ajoutee dans le secteur i
IC0(i)           valeurs initiales de la consommation intermediaire totale dans le secteur i
CIJ0(i,j)        valeurs initiales de la consommation intermediaire de bien i par le secteur j
PIC0(i)          valeurs initiales du prix composite de la consommation intermediaire totale dans le secteur i
INC0             valeur initiale du revenu du consommateur representatif
W0               valeur initiale de la remuneration du travail
R0               valeur initiale de la remuneration du capital
C0(i)            valeurs initiales de la consommation finale de bien i
U0               valeur initiale de l'utilite du consommateur representatif
leonO            valeur initiale du leon

psi_VA(i)                coefficient Leontieff valeur ajoutee - production
psi_IC(i)                coefficient Leontieff consommation intermediaire - production
psi_IJC(i,j)             coefficient Leontieff consommation intermediaire
alpha(i)                 elasticite de la valeur ajoutee du capital dans le secteur i
gamma(i)                 part du bien i dans la depense totale du consommateur representatif
A(i)                     productivite totale des facteurs dans le secteur i
;

* DONNEES
** La MCS
Table MCS(*,*)
        LD    KD    Men     Agr    Ind     Serv       TOT
LD                         1000   2000     4000      7000
KD                          500   2000      500      3000
Men   7000  3000                                    10000
Agr                2000    1000   1000     1000      5000
Ind                2500    2000   3500     3000     11000
Serv               5500     500   2500     1000      9500
Tot   7000  3000  10000    5000  11000     9500
;

** Correspondance entre les données de la MCS et les variables
LD0(i)   = MCS('LD',i);
KD0(i)   = MCS('KD',i);
CIJ0(i,j)= MCS(i,j);

*** normalisation
P0(i)    = 1 ;
R0       = 1 ;
W0       = 1 ;
PVA0(i)  = 1 ;
PIC0(i)  = 1 ;

*** calibrage
LS                       = sum(i,LD0(i)) ;
KS                       = sum(i,KD0(i)) ;
VA0(i)                   = [W0*LD0(i)+ R0*KD0(i)] / PVA0(i) ;
alpha(i)                 = R0*KD0(i)/[PVA0(i)*VA0(i)] ;
A(i)                     = VA0(i)/{[LD0(i)**(1-alpha(i))]*[KD0(i)**alpha(i)]};
INC0                     = W0*LS + R0*KS ;
IC0(j)                   = sum[i,P0(i)*CIJ0(i,j)]/PIC0(j) ;
Y0(i)                    = [PVA0(i)*VA0(i)+PIC0(i)*IC0(i)]/P0(i) ;
C0(i)                    = Y0(i) - sum[j,CIJ0(i,j)] ;
psi_VA(i)                = VA0(i)/Y0(i) ;
psi_IC(i)                = IC0(i)/Y0(i);
psi_IJC(i,j)             = CIJ0(i,j)/IC0(j) ;
gamma(i)                 = P0(i)*C0(i)/INC0 ;
U0                       = prod[i,C0(i)**gamma(i)] ;
leonO                    = 0 ;
display U0 , Ls, alpha ;
*$exit
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
leon.l           = leonO ;

*** definition des equations
equations
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
EQ_C(i)          equation de consommation finale de bien i
EQ_U             equation de utilite du consommateur representatif
EQ_W             equation de equilibre sur le marche du travail
EQ_R             equation de equilibre sur le marche du capital
EQ_P(i)          equation de equilibre sur le marche du bien i
;


*** bloc production
*** Leontieff 1er niveau
Eq_VA(i)..       VA(i)  =e= psi_VA(i)*Y(i) ;
Eq_IC(i)..       IC(i)  =e= psi_IC(i)*Y(i) ;
Eq_Y(i)..        P(i)*Y(i) =e= PVA(i)*VA(i)+PIC(i)*IC(i) ;

*** Cobb Douglas 2eme niveau
Eq_PVA(i)..      VA(i) =e= A(i)*[KD(i)**alpha(i)]*[LD(i)**(1-alpha(i))];
Eq_KD(i)..       alpha(i)*PVA(i)*VA(i) =e= R*KD(i) ;
Eq_LD(i)..       [1-alpha(i)]*PVA(i)*VA(i) =e= W*LD(i) ;

*** Leontieff 2eme niveau
Eq_PIC(j)..      PIC(j)*IC(j) =e= sum[i,P(i)*CIJ(i,j)] ;
Eq_IJC(i,j)..    CIJ(i,j) =e= psi_IJC(i,j)*IC(j) ;

*** bloc revenu
EQ_INC..         INC =e= W*LS + R*KS ;

*** bloc demande
EQ_C(i)..        gamma(i)*INC =e= P(i)*C(i) ;
EQ_U..           U =e= prod[i,C(i)**gamma(i)] ;

*** equilibre de marche
EQ_W..           LS =e= sum(i,LD(i)) + Leon;
EQ_R..           KS =e= sum(i,KD(i)) ;
EQ_P(i)..        C(i) + sum[j,CIJ(i,j)] =e= Y(i) ;

model macro_prod /all/ ;

*** numeraire
P.fx('Agr') = P0('Agr') ;

*** resolution sans choc
solve macro_prod using cns ;

$exit
*** choc
Parameter
LS_              parametre buffet pour l'offre de travail
KS_              parametre buffet pour l'offre de capital
A_(i)            parametre buffet pour la productivite totale des facteurs dans le secteur i ;

KS_              = KS ;
LS_              = LS ;
A_(i)            = A(i) ;

*LS = 1.1*LS_ ;
KS = 1.1*KS_ ;
*A('Ind')=1.1*A('Ind') ;

solve macro_prod using cns ;

*** resultats
Parameter
RategrowthY(i)                   taux de croissance de la production du bien i
RategrowthW                      taux de croissance de la remuneration du travail
RategrowthR                      taux de croissance de la remuneration du capital
RategrowthP                      taux de croissance du prix de l'output
RategrowthINC                    taux de croissance du revenu national
RategrowthC(i)                   taux de croissance de la consommation de bien i
PIndC                            indice des prix a la consommation ;

RategrowthY(i)   = 100*((Y.l(i)/Y0(i)) -1) ;
RategrowthC(i)   = 100*((C.l(i)/C0(i)) -1) ;
RategrowthW      = 100*((W.l/W0) -1) ;
RategrowthR      = 100*((R.l/R0) -1) ;
RategrowthP(i)   = 100*((P.l(i)/P0(i)) -1) ;
RategrowthINC    = 100*((INC.l/INC0) -1) ;
PIndC            = 100*sqrt{sum[i,P.l(i)*C0(i)]
                   /sum[i,P0(i)*C0(i)]
                   *sum[i,P.l(i)*C.l(i)]
                   /sum[i,P0(i)*C.l(i)]} ;

*** affichage des resultats
display RategrowthY, RategrowthW, RategrowthR, RategrowthP, RategrowthINC, RategrowthC, PIndC ;
