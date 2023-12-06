$ontext
Introduction de l'Hypothèse de P. Armington (1969), sur la base de l'exercice 6



$offtext

Set i /
Agr      Agriculture
Ind      Industrie
Serv     Service
/
;

alias(i,j)  ;

Parameters
alpha_k(i)       Coefficient de la fonction de demande de bien de capital Cobb Douglass
a(i)             Parametre d echelle pour Valeur Ajoutee dans secteur i
fx(i)            Parametre d echelle pour demande by the RoW for exports
fm(i)            Parametre d echelle poursupply by the RoW of imports
psi_va(i)        Coefficient Leontief Valeur Ajoutee  production
psi_ic(i)        Coefficient Leontief Consommation Intermediaire Production
psi_ijc(i,j)     Coefficient Leontief Consommation Intermediaire
alpha(i)         Coefficient Cobb-Douglas Production
gamma(i)         Coefficient Cobb-Douglas Utilite
alpha_g(i)       Coefficient de la Cobb-Douglas fonction consommation du Gouvernement
mps              Propension marginale a epargner du menage representatif
a_x(i)           Parametre de part pour exportations w-r local supply
a_xd(i)          Parametre de part pour ventes du bien local aux consommateurs locaux
a_d(i)           Parametre de part pour demande de bien local p-r demande totale
a_m(i)           Parametre de part pour biens importes p-r demande totale

*variables exogenes
ls               Offre totale de travail
ks               Offre totale de capital
tm(i)            Tarif a l'importation sur le bien i
indirect_tax(i)  Taux de taxation indirecte dans secteur i
itr              Taux de taxation du revenu du consommateur representatif

*valeur initiale des variables
kd0(i)           Valeurs initiales de Demande de capital par le secteur i
ld0(i)           Valeurs initiales de Demande de travail par le secteur i
y0(i)            Valeurs initiales de Production du secteur i
p0(i)            Valeurs initiales de prix a la consommation du bien i
py0(i)           Valeurs initiales de prix a la production du bien i
va0(i)           Valeurs initiales de la Valeur Ajoutee dans secteur i
pva0(i)          Valeurs initiales de Prix Composite de la Valeur Ajoutee dans secteur i
cij0(i,j)        Valeurs initiales de Consommation Intermediaire de bien i par le secteur j
ic0(i)           Valeurs initiales de la Consommation Intermediaire totale dans secteur i
pic0(i)          Valeurs initiales de Prix Composite de la Consommation Intermediaire totale dans secteur i
inc0             Valeurs initiales du revenu du consommateur representatif
disp_inc0        Revenu initial disponible
budg_exp0        Valeur initiale des depenses publiques
w0               Valeur initiale de la remuneration du travail
r0               Valeur initiale de la remuneration du Capital
c0(i)            Valeurs initiales de la consommation finale de bien i
u0               Valeur initiale de l'Utilite du consommateur representatif
indtax(i)        Recettes initiales de la taxation indirecte dans secteur i
income_tax       Recettes initiales taxe directe sur le revenu
cg0(i)           Valeurs initiales de Consommation Publique de bien i
ck0              Valeurs initales de la demande de bien i pour investissement prive
tradesold0       Valeur initiale du solde exterieur
e0               Valeur initiale du taux de change
savings0         Valeur initiale de l'epargne du consommateur representatif
inv0             Valeur initiale de l'investissement des entreprises
pubsold0         Valeur initiale du solde publique
pm0(i)           Valeurs initiales des prix a l'importation
px0(i)           Valeurs initiales des prix a l'exportation
pwm0(i)          Valeurs initiales du prix mondial des importations
pwx0(i)          Valeurs initiales du prix mondial des exportations
x0(i)            Valeurs initiales des quantites exportees
xd0(i)           Valeurs initiales des quantites offertes par les producteurs locaux sur le marche local
pd0(i)           Valeurs initiales du prix domestique des biens locaux
demtot0(i)       Valeurs initiales de l'absorption
pdemtot0(i)      Valeurs initiales du prix composite de l'absorption
d0(i)            Valeurs initiales de quantites demandees de biens locaux par les consommateurs locaux
m0(i)            Valeurs initiales des quantites importees
leon0            Valeur initiale du leon
;

* Matrice de Comptabilite Sociale
Table mcs(*,*)
         LD        KD      Men   Gvt     Agr     Ind        Serv         Acc     RM      Total
LD                                       1100    1700       4150                         6950
KD                                       250     1800       550                          2600
Men      6950      2600                                                                  9550
Gvt                        1400          150     1320       280                          3150
Agr                        1700  400     1120    930        1100         200     350     5800
Ind                        1200  900     2200    3120       3300         800     30      11550
Serv                       3400  2750    830     2250       1100         140     100     10570
Acc                        1850  -900                                            190     1140
RM                                       150     430        90                           670
Total    6950      2600    9550  3150    5800    11550      10570        1140    670
;

parameter importcoll(i)  Collecte initiale de droits de douane sur les importations USD Mios
/
Agr      0
Ind      300
Serv     0
/;

parameter sigmax(i)      Elasticite de la demande par le RM d'exportations p-r au prix mondial
/
Agr      3
Ind      3
Serv     3
/;

parameter sigmam(i)      Elasticite de l'offre par le RM d'importations p-r au prix mondial
/
Agr      3
Ind      3
Serv     3
/;

parameter sigma_cet(i)   Elasticite de substitution dans la CET ventes domestiques vs exportations
/
Agr      3
Ind      3
Serv     3
/;

parameter sigma_arm(i)   Elasticite de substitution (Armington) CES demande locale pour les biens locaux vs demande locale de biens importes
/
Agr      3
Ind      3
Serv     3
/;

*** Entree de donnees
kd0(i)           = mcs('KD',i)  ;
ld0(i)           = mcs('LD',i)  ;
cg0(i)           = mcs(i,'Gvt')  ;
y0(i)            = mcs('Total',i) - mcs('RM',i) - importcoll(i) ;
ck0(i)           = mcs(i,'Acc')  ;
indtax(i)        = mcs('Gvt',i) - importcoll(i)  ;
c0(i)            = mcs(i,'Men')   ;
income_tax       = mcs('Gvt','Men') ;
savings0         = mcs('Acc','Men') ;
cij0(i,j)        = mcs(i,j) ;
m0(i)            = mcs('RM',i) + importcoll(i)  ;
x0(i)            = mcs(i,'RM') ;

*** Normalisation
pd0(i)           = 1 ;
pm0(i)           = 1 ;
px0(i)           = 1 ;
pva0(i)          = 1 ;
pic0(i)          = 1 ;
p0(i)            = 1 ;
r0               = 1 ;
w0               = 1 ;
e0               = 1 ;

*** Calibrage
ls                       = sum(i,ld0(i)) ;
ks                       = sum(i,kd0(i)) ;
indirect_tax(i)          = indtax(i)/(p0(i)*y0(i)-indtax(i)) ;
ic0(j)                   = sum[i,p0(i)*cij0(i,j)]/pic0(j) ;
va0(i)                   = [w0*ld0(i) + r0*kd0(i)]/pva0(i)     ;
py0(i)                   = [pva0(i)*va0(i)  + pic0(i)*ic0(i) ]/y0(i)  ;
xd0(i)                   = [py0(i) *y0(i) - px0(i)*x0(i) ]/pd0(i) ;
d0(i)                    = xd0(i) ;
pdemtot0(i)              = P0(i)/(1+indirect_tax(i)) ;
demtot0(i)               = C0(i) + CG0(i) + ck0(i) + sum(j,CIJ0(i,j));
pm0(i)                   = [pdemtot0(i)*demtot0(i)-pd0(i)*d0(i)]/m0(i);
alpha(i)                 = r0*kd0(i)/[pva0(i)*va0(i)] ;
a(i)                     = va0(i)/{[ld0(i)**(1-alpha(i))]*[kd0(i)**alpha(i)]};
inc0                     = w0*ls + r0*ks ;
itr                      = income_tax/inc0 ;
disp_inc0                = (1-itr)*inc0 ;
budg_exp0                = sum(i,p0(i)*cg0(i)) ;
alpha_g(i)               = p0(i)*cg0(i)/budg_exp0 ;
a_x(i)                   = [x0(i)/y0(i)]*(px0(i)/py0(i))**(-sigma_cet(i)) ;
a_xd(i)                  = [xd0(i)/y0(i)]*(pd0(i)/py0(i))**(-sigma_cet(i)) ;
a_d(i)                   = [d0(i)/demtot0(i)]*(pdemtot0(i)/pd0(i))**(-sigma_arm(i)) ;
a_m(i)                   = [m0(i)/demtot0(i)]*(pdemtot0(i)/pm0(i))**(-sigma_arm(i)) ;
tm(i)                    = importcoll(i)/[pm0(i)*m0(i)-importcoll(i)] ;
pwm0(i)                  = pm0(i)/[e0*(1+tm(i)) ] ;
pwx0(i)                  = px0(i) ;
fx(i)                    = x0(i)/[pwx0(i)**(-sigmax(i))]  ;
fm(i)                    = m0(i)/[pwm0(i)**sigmam(i)]  ;
tradesold0               = e0*sum[i,pwx0(i)*x0(i) - pwm0(i)*m0(i)]  ;
psi_va(i)                = va0(i)/y0(i) ;
psi_ic(i)                = ic0(i)/y0(i) ;
psi_ijc(i,j)             = cij0(i,j)/ic0(j) ;
pubsold0                 = itr*inc0 + sum(i,indirect_tax(i)*pdemtot0(i)*demtot0(i))
                         + sum[i,tm(i)*e0*pwm0(i)*m0(i)] - budg_exp0 ;
inv0                     = sum(i,p0(i)*ck0(i)) ;
alpha_k(i)               = p0(i)*ck0(i)/inv0 ;
mps                      = savings0/disp_inc0 ;
gamma(i)                 = p0(i)*c0(i)/[(1-mps)*disp_inc0] ;
u0                       = prod[i,c0(i)**gamma(i)] ;
leon0                    = savings0 - inv0 + pubsold0 - tradesold0;

*declaration des variables
Variables
p(i)            Prix a la Consommation du bien i
pm(i)           Prix a l'Importation bien i
px(i)           Prix a l'Exportation bien i
pwm(i)          Prix mondial des importations de bien i
pwx(i)          Prix mondial des exportations de bien i
va(i)           Valeur ajoutee dans secteur i
ic(i)           Consommation Intermediaire totale dans secteur i
y(i)            Production dans secteur i
pva(i)          Prix Composite de la Valeur ajoutee dans secteur i
kd(i)           Demande de capital par le secteur i
ld(i)           Demande de travail par le secteur i
pic(i)          Prix Composite de la Consommation Intermediaire totale dans secteur i
cij(i,j)        Consommation Intermediaire de bien i par le secteur j
py(i)           Prix d'Offre bien i
x(i)            Exports de biens i
xd(i)           Ventes locales de bien i
inc             Revenu du menage representatif
disp_inc        Revenu disponible
savings         Epargne du menage representatif
c(i)            Consommation finale de bien i par le menage representatif
u               Utilite du menage representatif
ck(i)           Demande de bien i pour investissement
budg_exp        Depenses publiques totales
cg(i)           Consommation publique de bien i
w               Remuneration du travail
r               Remuneration du Capital
pd(i)           Prix domestique du bien local
demtot(i)       Absorption de bien i (demande totale par agents nationaux)
pdemtot(i)      Prix Cpmposite de la demande totale par agents nationaux de bien i
d(i)            Demande locale pour les biens locaux
m(i)            Importations
inv             Investissement prive
tradesold       Solde Exterieur
pubsold         Solde public
e               Taux de change
leon            Leon ;

*** Initialisation des variables
p.l(i)           = p0(i) ;
pm.l(i)          = pm0(i) ;
px.l(i)          = px0(i) ;
pwm.l(i)         = pwm0(i) ;
pwx.l(i)         = pwx0(i) ;
va.l(i)          = va0(i) ;
ic.l(i)          = ic0(i) ;
y.l(i)           = y0(i) ;
pva.l(i)         = pva0(i) ;
kd.l(i)          = kd0(i) ;
ld.l(i)          = ld0(i);
pic.l(i)         = pic0(i) ;
cij.l(i,j)       = cij0(i,j) ;
py.l(i)          = py0(i) ;
x.l(i)           = x0(i) ;
xd.l(i)          = xd0(i) ;
inc.l            = inc0 ;
disp_inc.l       = disp_inc0 ;
savings.l        = savings0 ;
c.l(i)           = c0(i) ;
u.l              = u0 ;
ck.l(i)          = ck0(i) ;
budg_exp.l       = budg_exp0 ;
cg.l(i)          = cg0(i) ;
w.l              = w0 ;
r.l              = r0 ;
pd.l(i)          = pd0(i) ;
demtot.l(i)      = demtot0(i) ;
pdemtot.l(i)     = pdemtot0(i) ;
d.l(i)           = d0(i) ;
m.l(i)           = m0(i) ;
inv.l            = inv0 ;
tradesold.l      = tradesold0 ;
pubsold.l        = pubsold0 ;
e.l              = e0 ;
leon.l           = leon0 ;

*Declaration des equations
equations
eq_p(i)          Relation prix producteur prix consommateur
eq_pm(i)         Relation prix a l'import prix mondial
eq_px(i)         Relation prix a l'export prix mondial
eq_pwx(i)        Demande d'exportation par le reste du monde
eq_pwm(i)        Offre d'importation par le reste du monde
eq_va(i)         Valeur Ajoutee dans secteur i - Leontief
eq_ic(i)         Demande totale de Consommation Intermediaire dans secteur i - Leontief
eq_y(i)          Production dans secteur i
eq_pva(i)        Prix composite Valeur Ajoutee dans secteur i
eq_kd(i)         Demande de capital par le secteur i
eq_ld(i)         Demande de travail par le secteur i
eq_pic(j)        Prix Composite Consommation Intermediaire dans secteur j
eq_cij(i,j)      Demande de Consommation Intermediaire de bien i par secteur j
eq_py(i)         Prix Composite de l'offre
eq_x(i)          CET exportation
eq_xd(i)         CET ventes locales
eq_inc           Formation du revenu
eq_disp_inc      Revenu Disponible
eq_savings       Epargne privee
eq_c(i)          Consommation du bien i
eq_u             Utilite du consommateur representatif
eq_ck(i)         Demande de bien i pour investissement
eq_budg_exp      Solde public - depenses publiques
eq_cg(i)         Conosmmation publique de bien i
eq_w             Equilibre sur le marche du travail
eq_r             Equilibre sur le marche du capital
eq_pd            Equilibre sur le marche local du bien i
eq_demtot(i)     Absorption
eq_pdemtot(i)    Prix Composite de Absorption
eq_d(i)          Demande Armington pour biens locaux
eq_m(i)          Demande Armington pour importations
eq_macro         Equilibre Macroeconomique
eq_tradesold     Solde Exterieur
;

*MODELE
*** bloc prix
eq_p(i)..        pdemtot(i)*(1+indirect_tax(i)) =e= p(i) ;
eq_pm(i)..       pm(i) =e= e*pwm(i)*[1+tm(i)]  ;
eq_px(i)..       px(i) =e= e*pwx(i) ;
eq_pwx(i)..      x(i) =e= fx(i)*pwx(i)**(-sigmax(i))  ;
eq_pwm(i)..      m(i) =e= fm(i)*pwm(i)**sigmam(i)  ;

*** bloc production
*** Leontieff 1st niveau
eq_va(i)..       va(i)  =e= psi_va(i)*y(i) ;
eq_ic(i)..       ic(i)  =e= psi_ic(i)*y(i) ;
eq_y(i)..        py(i)*y(i) =e= pva(i)*va(i)+pic(i)*ic(i) ;

*** Cobb Douglas 2nd niveau
eq_pva(i)..      va(i) =e= a(i)*[kd(i)**alpha(i)]*[ld(i)**(1-alpha(i))];
eq_kd(i)..       alpha(i)*pva(i)*va(i) =e= r*kd(i) ;
eq_ld(i)..       [1-alpha(i)]*pva(i)*va(i) =e= w*ld(i) ;

*** Leontieff 2nd niveau
eq_pic(j)..      pic(j)*ic(j) =e= sum[i,p(i)*cij(i,j)] ;
eq_cij(i,j)..    cij(i,j) =e= psi_ijc(i,j)*ic(j) ;

*** bloc CET
eq_py(i)..       py(i)*y(i) =e= px(i)*x(i) + pd(i)*xd(i)  ;
eq_x(i)..        x(i) =e= a_x(i)*y(i)*(px(i)/py(i))**sigma_cet(i) ;
eq_xd(i)..       xd(i) =e= a_xd(i)*y(i)*(pd(i)/py(i))**sigma_cet(i) ;

*** bloc revenu
eq_inc..         inc =e= w*ls + r*ks ;
eq_disp_inc..    disp_inc =e= (1-itr)*inc ;
eq_savings..     savings =e= mps*disp_inc ;

*** bloc demande
*****menages
eq_c(i)..        gamma(i)*(1-mps)*disp_inc =e= p(i)*c(i) ;
eq_u..           u =e= prod[i,c(i)**gamma(i)] ;

*****entreprises
eq_ck(i)..       p(i)*ck(i) =e= alpha_k(i)*inv ;

*** bloc gouvernement
eq_budg_exp..   itr*inc + sum(i,indirect_tax(i)*pdemtot(i)*demtot(i))
                 + sum[i,tm(i)*e*pwm(i)*m(i)] - budg_exp =e= pubsold ;
eq_cg(i)..      p(i)*cg(i) =e= alpha_g(i)*budg_exp ;

*** bloc equilibre de marche
eq_w..          ls =e= sum(i,ld(i))+ leon ;
eq_r..          ks =e= sum(i,kd(i)) ;
eq_pd(i)..      xd(i) =e= d(i)  ;

***bloc demande Armington
eq_demtot(i)..      c(i) + sum[j,cij(i,j)] + ck(i) + cg(i) =e= demtot(i) ;
eq_pdemtot(i)..     pdemtot(i)*demtot(i) =e= pd(i)*d(i) + pm(i)*m(i) ;
eq_d(i)..           d(i) =e= a_d(i)*demtot(i)*(pdemtot(i)/pd(i))**sigma_arm(i) ;
eq_m(i)..           m(i) =e= a_m(i)*demtot(i)*(pdemtot(i)/pm(i))**sigma_arm(i) ;

*** equilibre macroeconomique
eq_macro..       savings - inv + pubsold =e= tradesold ;

*** Solde exterieur
eq_tradesold..   tradesold =e= e*sum[i,pwx(i)*x(i) - pwm(i)*m(i)]  ;

***Declaration du modele
model macro_prod /all/ ;

***Numeraire
pd.fx('Agr')      = pd0('Agr') ;

***Bouclage public
pubsold.fx       = pubsold0 ;

***Bouclage exterieur
e.fx             = e0;

*** Resolution du modele sans choc
solve macro_prod using cns ;
