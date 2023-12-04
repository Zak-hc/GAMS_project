$ontext
Modèle Economie fermée, sans gouvernement ni Epargne. C'est modèle avec un seul bien à la production
et à la consommation.

$offtext

***Definition des parametres
Parameters
LS            Offre totale de travail
KS            Offre totale de capital
KD0           Valeur initiale de la demande de capital
LD0           Valeur initiale de la demande de travail
Y0            Valeur initiale de la Production
P0            Valeur initiale du prix de l'output
INC0          Valeur initiale du revenu du consommateur representatif
W0            Valeur initiale de la remuneration du travail
R0            Valeur initiale de la remuneration du capital
C0            Valeur initiale de la consommation finale
leonO         Valeur initiale du Leon
alpha         Elasticite de la production au capital
A             Productivite totale des facteurs
;

*** Donnees initiales en provenance de la matrice de comptabilite sociale
LS = 7000;
KS = 3000;

** Normalisation des prix
P0 = 1 ;
R0 = 1 ;
W0 = 1 ;

***Calibrage
KD0      = KS ;
LD0      = LS ;
INC0     = W0*LS + R0*KS ;
C0       = INC0/P0 ;
Y0       = C0 ;
alpha    = (R0*KD0)/(P0*Y0) ;
A        = Y0/((KD0**alpha)*(LD0**(1-alpha)));
leonO    = LD0 - LS ;
display  alpha , leonO ;

*** Definition des variables
variables
Y        Production nationale en volume
KD       Demande de capital
LD       Demande de travail
P        Prix de l'output
INC      Revenu National
W        Remuneration du travail
R        Remuneration du capital
C        Consommation finale
leon     Leon
;

*** Initialisation des variables
Y.l      = Y0 ;
KD.l     = KD0 ;
LD.l     = LD0;
INC.l    = INC0 ;
W.l      = W0 ;
R.l      = R0 ;
C.l      = C0 ;
P.l      = P0 ;
leon.l   = leonO ;

*** Definition des equations
equations
Eq_Y             production
Eq_LD            part du travail dans le PIB
Eq_KD            part du capital dans le PIB
Eq_INC           formation du revenu
Eq_C             budget du consommateur
Eq_P             equilibre sur le marche des biens
Eq_W             equilibre sur le marche du travail
Eq_R             equilibre sur le marche du capital
;

Eq_Y..           Y =e= A*(KD**alpha)*(LD**(1-alpha)) ;
Eq_LD..          W*LD =e= (1-alpha)*P*Y ;
Eq_KD..          R*KD =e= alpha*P*Y ;
Eq_INC..         INC =e= W*LS + R*KS ;
Eq_C..           P*C =e= INC ;
Eq_P..           Y =e= C ;
Eq_W..           LD - leon =e= LS  ;
Eq_R..           KD =e= KS ;

*** Definition du modele / Premiere resolution / choc
model macro /all/ ;

*Numeraire
W.fx = W0 ;

*Resolution sans choc
solve macro using cns ;

*choc  : augmentation de 10 pour cent de l'offre de travail
Parameter
LS_      parametre buffet pour stocker l'offre de travail initiale;

LS_      = LS ;
LS       = LS*1.1 ;

solve macro using cns ;

*** Resultats
Parameter
GDPgrowth        Taux de croissance du PIB
Pgrowth          Taux de croissance du prix de l'output
Rgrowth          Taux de croissance de la remuneration du capital
;

GDPgrowth        = 100*((Y.l/Y0) -1) ;
Pgrowth          = 100*((P.l/P0) -1) ;
Rgrowth          = 100*((R.l/R0) -1) ;

*** Affichage des resultats
display GDPgrowth, Pgrowth, Rgrowth, leon.l
;

