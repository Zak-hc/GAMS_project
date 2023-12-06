$ontext
modele equilibre general calculable antoine bouet 2020

Closures (public and foreign + desagragation of H + unemployement

$offtext

*************************************************************************
* choix du bouclage public
*************************************************************************
parameter public_closure parametre de bouclage public ;
*************************************************************************
* si public_closure = 0, les depenses publiques s'ajustent pour que le solde public reste constant
* si public_closure = 1, le solde public s'ajuste pour que les depenses publiques restent constantes
* si public_closure = 2, un impot supplementaire au taux de delta_itr est preleve sur le revenu du menage representatif pour que le solde public et les depenses publiques restent constantes
* si public_closure = 3, une taxe supplementaire au taux de delta_indirect_tax est prelevee sur la consommation pour que le solde public et les depenses publiques restent constantes
* il suffit de rendre operante une seule de ces 4 lignes
*************************************************************************

*public_closure           = 0;
*public_closure           = 1;
*public_closure           = 2;
public_closure           = 3;

*************************************************************************
* choix du bouclage extérieur
*************************************************************************

parameter foreign_closure parametre de bouclage extérieur ;
*************************************************************************
* si foreign_closure = 1; le compte courant est fixe et le taux de change est variable
* si foreign_closure = 2; le compte courant est variable et le taux de change est fixe
* il suffit de rendre operante une seule de ces 2 lignes
*************************************************************************

foreign_closure           = 1;
*foreign_closure           = 2;

*************************************************************************
* ensembles, sous ensembles et parametres
*************************************************************************
* ensembles et sous ensembles
set i secteurs de l'economie
/
agr      agriculture
ind      industrie
serv     service
/
;

set not_agr(i) secteurs non agricoles
/
ind      industrie
serv     service
/
;

set h ménages
/Urban1*Urban4, Rural1*Rural4/
;

set f    facteurs de production /
unsk     travail non qualifie
skl      travail qualifie
capital  capital
land     terre /
;

alias(i,j)  ;
alias(h,hh) ;
*************************************************************************
* parametres
*************************************************************************
parameters
*paramètres techniques du modèle
alpha_k(i)       coefficient de la fonction de demande de bien de capital cobb douglass
fx(i)            parametre d echelle pour demande par le reste du monde pour les exportations
fm(i)            parametre d echelle pour offre par le reste du monde d'importations
psi_va(i)        coefficient leontief valeur ajoutee  production
psi_ic(i)        coefficient leontief consommation intermediaire production
psi_ijc(i,j)     coefficient leontief consommation intermediaire
gamma(h,i)       coefficient utilite fonction les
cmin(h,i)        parametre de consommation minimale
alpha_g(i)       coefficient de la cobb-douglas fonction consommation du gouvernement
mps(h)           propension marginale a epargner du menage representatif
a_x(i)           parametre de part pour exportations contre offre locale
a_xd(i)          parametre de part pour ventes du bien local aux consommateurs locaux
a_d(i)           parametre de part pour demande de bien local contre demande totale
a_m(i)           parametre de part pour biens importes contre demande totale
a_l(i)           parametre de part pour la demande de travail non qualifie
a_te(i)          parametre de part pour la demande de terre
a_q(i)           parametre de part pour la demande de facteur composite
a_skld(j)        parametre de part pour la demande de travail qualifie
a_kd(j)          parametre de part pour la demande de capital
k_wc             parametre de taille de la courbe de salaire

*variables exogenes
****** progres technique
a(i)             parametre d echelle pour valeur ajoutee dans secteur i

******offre de facteurs
ls               offre totale de travail non qualifie - usd mlns
ks               offre totale de capital - usd mlns
lands            offre totale de terre - usd mlns
skls             offre totale de travail qualifie - usd mlns

******transferts
remittances      transferts unilateraux du reste du monde aux menages - usd mlns
transf_g_hh      transferts du gouvernement aux menages - usd mlns
transf_rm_g      transfert unilateral du reste du monde au gouvernement - usd mlns

******taux de taxation
tm(i)            tarif a l'importation sur le bien i
te(i)            taxe a l'exportation sur le bien i
indirect_tax(i)  taux de taxation indirecte dans secteur i
itr              taux de taxation du revenu du consommateur representatif
tva(i)           taux de tva

*valeur initiale des variables
kd0(i)           demande initiale de capital en volume par le secteur i
ld0(i)           demande initiale de travail non qualifie en volume par le secteur i
skld0            demande initiale de travail qualifie en volume par le secteur i
unemp0           chômage initial des qualifiés
y0(i)            production initiale du secteur i en volume
pq0(j)           valeurs initiales du prix du facteur composite - usd
q0(j)            valeurs initiales de la demande de facteur composite par le secteur i
rland0           valeurs initiales de remuneration de la terre - usd
land0(j)         valeurs initiales de demande de terre
p0(i)            valeurs initiales de prix a la consommation du bien i - usd
py0(i)           valeurs initiales de prix a la production du bien i - usd
va0(i)           valeur ajoutee initiale en volume dans secteur i
pva0(i)          valeurs initiales de prix composite de la valeur ajoutee dans secteur i - usd
cij0(i,j)        consommation intermediaire initiale de bien i par le secteur j en volume - usd mlns
ic0(i)           consommation intermediaire totale initiale dans secteur i en volume - usd mlns
pic0(i)          valeurs initiales de prix composite de la consommation intermediaire totale dans secteur i - usd
inc0             valeur initiale du revenu du consommateur representatif - usd mlns
disp_inc0        revenu initial disponible - usd mlns
budg_exp0        valeur initiale des depenses publiques - usd mlns
w0               valeur initiale de la remuneration du travail non qualifie - usd
ws0              valeur initiale de la remuneration du travail qualifie - usd
r0               valeur initiale de la remuneration du capital - usd
c0(i)            consommation finale initiale en volume de bien i
u0(h)            utilite initiale du consommateur representatif
cg0(i)           consommation publique initiale en volume de bien i
ck0(i)           demande initiale en volume de bien i pour investissement prive
tradesold0       valeur initiale du solde exterieur - usd mlns
curr_acc0        valeur initial du compte courant - usd mlns
e0               valeur initiale du taux de change - usd per unit of foreign currency
savings0         valeur initiale de l'epargne du consommateur representatif - usd mlns
inv0             valeur initiale de l'investissement des entreprises - usd mlns
pubsold0         valeur initiale du solde public - usd mlns
pm0(i)           valeurs initiales des prix a l'importation - usd
px0(i)           valeurs initiales des prix a l'exportation - usd
pwm0(i)          valeurs initiales du prix mondial des importations - units of foreign currency
pwx0(i)          valeurs initiales du prix mondial des exportations - units of foreign currency
x0(i)            quantites initiales exportees
xd0(i)           quantites initiales offertes par les producteurs locaux sur le marche local
pd0(i)           valeurs initiales du prix domestique des biens locaux
demtot0(i)       absorption initiale en volume
pdemtot0(i)      valeurs initiales des prix composites de l'absorption
d0(i)            quantites initiales demandees en volume de biens locaux par les consommateurs locaux
m0(i)            quantites initiales importees
pindc0           valeur initiale de l'indice prix consommation
inch0(h)         valeur initiale du revenu primaire du menage representatif h
disp_inch0(h)    valeur initiale du revenu disponible du menage representatif h
savingsh0(h)     valeur initiale de l'épargne du menage representatif h
ch0(h,i)         valeur initiale de la consommation finale du bien i par le ménage representatif h
leon0            valeur initiale du leon

****autres parametres
indtax(i)        recettes initiales de la taxation indirecte dans secteur i - usd mlns
income_tax       recettes initiales taxe directe sur le revenu - usd mlns
income_tax_h(h)  taxes directes payées par un ménage représentatif h
;

* matrice de comptabilite sociale
table mcs(*,*)  elements de la matrice de comptabilite sociale - usd mlns
         land    ld        skld  kd      men   gvt     agr     ind        serv         acc     rm      total
land                                                   600     0          0                            600
ld                                                     450     1560       4060                         6070
skld                                                   200     900        300                          1400
kd                                                     50      900        250                          1200
men      600     6070      1400  1200          100                                             500     9870
gvt                                      1400          215     1505       370                  50      3540
agr                                      1700  450     1120    930        1100         200     315     5815
ind                                      1200  1000    2200    3120       3300         745     30      11595
serv                                     3400  2790    830     2250       1100         100     100     10570
acc                                      2170  -800                                            -325    1045
rm                                                     150     430        90                           670
total    600     6070      1400  1200    9870  3540    5815    11595      10570        1045    670
;

****autres parametres
skls = 1800 ;

parameter importcoll(i)          collecte initiale de droits de douane sur les importations usd mlns
/
agr      50
ind      50
serv     10
/;

parameter tvacoll(i)             collecte initiale de tva usd Mios
/
agr      50
ind      140
serv     90
/;

parameter exportcoll(i)          collecte initiale de taxes a l'export usd Mios
/
agr      15
ind      45
serv     0
/;

parameter les_cmin(i)            parametre pour le calcul des consommations minimales - fonction utilite les
/
agr      0.8
ind      0.6
serv     0.2
/;

****elasticites
parameter sigmax(i)              elasticite de la demande par le reste du monde d'exportations p-r au prix mondial
/
agr      3
ind      3
serv     3
/;

parameter sigmam(i)              elasticite de l'offre par le reste du monde d'importations p-r au prix mondial
/
agr      3
ind      3
serv     3
/;

parameter sigma_cet(i)           elasticite de substitution dans la cet ventes domestiques vs exportations
/
agr      3
ind      3
serv     3
/;

parameter sigma_arm(i)           elasticite de substitution (armington) ces demande locale pour les biens locaux vs demande locale de biens importes
/
agr      3
ind      3
serv     3
/;

parameter sigma_va(i)            elasticite de substitution terre - travail non qualifie - facteur composite
/
agr      1.1
ind      1.1
serv     1.1
/;

parameter sigma_cap(j)           elasticite de substitution travail qualifie - capital
/
agr      0.6
ind      0.6
serv     0.6
/;

**** paramètres liés à la désagrégation des ménages
parameter nh(h)            nombre de menages de categorie h
/
Urban1        604740
Urban2        271422
Urban3        135711
Urban4        45237
Rural1        949977
Rural2        2307087
Rural3        588081
Rural4        135711
/
;

parameter share_r(h)       part des transferts de l'etranger recus par les menages de categorie h
/
Urban1        4.5
Urban2        2.3
Urban3        12.5
Urban4        13.8
Rural1        8.5
Rural2        21.5
Rural3        29.3
Rural4        7.6
/
;
share_r(h)=share_r(h)/100;

parameter share_t(h)       part des transferts du gouvernement recus par les menages de categorie h
/
Urban1        4.5
Urban2        2.3
Urban3        11.8
Urban4        13.1
Rural1        6.9
Rural2        31.5
Rural3        24.3
Rural4        5.6
/
;
share_t(h)=share_t(h)/100;

Table share_f(h,f) répartition du revenu entre les catégories de ménages (pourcentage de la catégorie de revenu des facteurs)
                 unsk    skl     capital land
Urban1           14      0.4     0.4     0.1
Urban2           8       9.5     6       0.8
Urban3           7.6     16.5    7.8     1
Urban4           3.5     31.2    7.9     0.2
Rural1           13.5    3       5.1     5.1
Rural2           41      21      41.4    42.8
Rural3           9       10.4    20.8    32.8
Rural4           3.4     8       10.6    17.2
;
share_f(h,f)=share_f(h,f)/100;

Table share_c(h,i) part de la consommation de chaque catégorie de ménage dans la consommation totale
                 agr     ind     serv
Urban1           15.2    14.7    11.2
Urban2           8.4     7.6     8.9
Urban3           6       8.6     11.2
Urban4           1       6.8     10.5
Rural1           17      15.2    10.9
Rural2           40      28.6    25.3
Rural3           9       13.4    15.8
Rural4           3.4     5.1     6.2
;
share_c(h,i)=share_c(h,i)/100;

parameter share_it(h) part de chaque catégorie de ménage dans les impots sur le revenu
/
Urban1          0.028571429
Urban2          0.053571429
Urban3          0.171428571
Urban4          0.264285714
Rural1          0.019285714
Rural2          0.171428571
Rural3          0.150000000
Rural4          0.141428572
  / ;

kd0(i)           = mcs('kd',i)  ;
ld0(i)           = mcs('ld',i) ;
skld0(i)         = mcs('skld',i) ;
land0(i)         = mcs('land',i) ;
cg0(i)           = mcs(i,'gvt') ;
y0(i)            = mcs('total',i) - mcs('rm',i) - importcoll(i) - exportcoll(i) - tvacoll(i);
ck0(i)           = mcs(i,'acc') ;
indtax(i)        = mcs('gvt',i) - importcoll(i) - exportcoll(i) - tvacoll(i) ;
c0(i)            = mcs(i,'men') ;
income_tax       = mcs('gvt','men') ;
savings0         = mcs('acc','men') ;
cij0(i,j)        = mcs(i,j) ;
m0(i)            = mcs('rm',i) + importcoll(i)  ;
x0(i)            = mcs(i,'rm') ;
remittances      = mcs('men','rm') ;
transf_g_hh      = mcs('men','gvt') ;
transf_rm_g      = mcs('gvt','rm') ;

*** normalisation
pd0(i)           = 1 ;
pm0(i)           = 1 ;
px0(i)           = 1 ;
pva0(i)          = 1 ;
pq0(j)           = 1 ;
pic0(i)          = 1 ;
p0(i)            = 1 ;
r0               = 1 ;
w0               = 1 ;
ws0              = 1 ;
rland0           = 1 ;
e0               = 1 ;

*************************************************************************
* calibrage
*************************************************************************
ch0(h,i)                 = share_c(h,i)*c0(i)/nh(h) ;
unemp0                   = skls - sum(i,skld0(i)) ;
ls                       = sum(i,ld0(i)) ;
ks                       = sum(i,kd0(i)) ;
lands                    = sum(i,land0(i)) ;
indirect_tax(i)          = indtax(i)/(p0(i)*y0(i)-indtax(i)) ;
ic0(j)                   = sum[i,p0(i)*cij0(i,j)]/pic0(j) ;
va0(i)                   = [rland0*land0(i) + w0*ld0(i) + r0*kd0(i)+ ws0*skld0(i) + tvacoll(i)] / pva0(i) ;
py0(i)                   = [pva0(i)*va0(i) + pic0(i)*ic0(i) ]/y0(i)  ;
xd0(i)                   = [py0(i) *y0(i) - px0(i)*x0(i) ]/pd0(i) ;
d0(i)                    = xd0(i) ;
pdemtot0(i)              = p0(i)/(1+indirect_tax(i)) ;
demtot0(i)               = c0(i) + cg0(i) + ck0(i) + sum(j,cij0(i,j));
pm0(i)                   = [pdemtot0(i)*demtot0(i)-pd0(i)*d0(i)]/m0(i);
tva(i)                   = pva0(i)*va0(i)/[r0*kd0(i)+w0*ld0(i) + ws0*skld0(i)+rland0*land0(i)] - 1 ;
q0(j)                    = [r0*(1+tva(j))*kd0(j)+ ws0*(1+tva(j))*skld0(j)]/pq0(j);
a_l(i)                   = (ld0(i)/va0(i))*[pva0(i)/(w0*(1+tva(i)))]**(-sigma_va(i)) ;
a_te(i)                  = (land0(i)/va0(i))*[pva0(i)/(rland0*(1+tva(i)))]**(-sigma_va(i)) ;
a_q(i)                   = (q0(i)/va0(i))*[pva0(i)/pq0(i)]**(-sigma_va(i)) ;
a_skld(i)                = (skld0(i)/q0(i))*[pq0(i)/(ws0*(1+tva(i)))]**(-sigma_cap(i)) ;
a_kd(i)                  = (kd0(i)/q0(i))*[pq0(i)/(r0*(1+tva(i)))]**(-sigma_cap(i));
inch0(h)                 = [share_f(h,'unsk')*w0*ls + share_f(h,'skl')*ws0*sum(i,skld0(i))  + share_f(h,'capital')*r0*ks + share_f(h,'land')*rland0*lands + share_r(h)*e0*remittances]/nh(h) ;
inc0                     = sum(h,nh(h)*inch0(h)) ;
income_tax_h(h)          = income_tax*share_it(h)/nh(h) ;
itr(h)                   = income_tax_h(h)/inch0(h) ;
disp_inch0(h)            = [(1-itr(h))*nh(h)*inch0(h) + share_t(h)*transf_g_hh]/nh(h) ;
disp_inc0                = sum(h,nh(h)*disp_inch0(h)) ;
budg_exp0                = sum(i,p0(i)*cg0(i)) ;
alpha_g(i)               = p0(i)*cg0(i)/budg_exp0 ;
a_x(i)                   = [x0(i)/y0(i)]*(px0(i)/py0(i))**(-sigma_cet(i)) ;
a_xd(i)                  = [xd0(i)/y0(i)]*(pd0(i)/py0(i))**(-sigma_cet(i)) ;
a_d(i)                   = [d0(i)/demtot0(i)]*(pdemtot0(i)/pd0(i))**(-sigma_arm(i)) ;
a_m(i)                   = [m0(i)/demtot0(i)]*(pdemtot0(i)/pm0(i))**(-sigma_arm(i)) ;
tm(i)                    = importcoll(i)/[pm0(i)*m0(i)-importcoll(i)] ;
te(i)                    = exportcoll(i)/[px0(i)*x0(i)] ;
pwm0(i)                  = pm0(i)/[e0*(1+tm(i)) ] ;
pwx0(i)                  = px0(i)*(1+te(i))/e0 ;
fx(i)                    = x0(i)/[pwx0(i)**(-sigmax(i))]  ;
fm(i)                    = m0(i)/[pwm0(i)**sigmam(i)]  ;
tradesold0               = e0*sum[i,pwx0(i)*x0(i) - pwm0(i)*m0(i)]  ;
psi_va(i)                = va0(i)/y0(i) ;
psi_ic(i)                = ic0(i)/y0(i) ;
psi_ijc(i,j)             = cij0(i,j)/ic0(j) ;
pubsold0                 = transf_rm_g + sum[h,itr(h)*nh(h)*inch0(h)] + sum(i,indirect_tax(i)*pdemtot0(i)*demtot0(i))
                         + sum[i,tm(i)*e0*pwm0(i)*m0(i)] + sum[i,te(i)*px0(i)*x0(i)]
                         + sum[i,tva(i)*(r0*kd0(i)+w0*ld0(i)+ws0*skld0(i)+rland0*land0(i))]
                         - budg_exp0 - transf_g_hh ;
inv0                     = sum(i,p0(i)*ck0(i)) ;
alpha_k(i)               = p0(i)*ck0(i)/inv0 ;
savingsh0(h)             = disp_inch0(h)  - sum(i,p0(i)*ch0(h,i)) ;
mps(h)                   = savingsh0(h) /disp_inch0(h)  ;
cmin(h,i)                = les_cmin(i)*ch0(h,i) ;
gamma(h,i)               = p0(i)*[ch0(h,i) - cmin(h,i)]/[[1-mps(h)]*disp_inch0(h) - sum(j,p0(j)*cmin(h,j))] ;
u0(h)                    = prod[i,(ch0(h,i) - cmin(h,i))**gamma(h,i)] ;
curr_acc0                = tradesold0 + e0*remittances + transf_rm_g ;
pindc0                   = 1 ;
k_wc                     = (ws0/pindc0)/[unemp0**(-0.1)]  ;
leon0                    = savings0 - inv0 + pubsold0 - curr_acc0;

*************************************************************************
* variables
*************************************************************************
* declaration des variables
variables
p(i)                     prix a la consommation du bien i - usd
pm(i)                    prix a l'importation bien i - usd
px(i)                    prix a l'exportation bien i - usd
pwm(i)                   prix mondial des importations de bien i - units of foreign currency
pwx(i)                   prix mondial des exportations de bien i - units of foreign currency
va(i)                    valeur ajoutee dans secteur i en volume
ic(i)                    consommation intermediaire totale dans secteur i en volume
y(i)                     production dans secteur i en volume
q(j)                     demande de facteur composite dans le secteur j en volume
land(j)                  demande de terre dans le secteur j en volume
skld(j)                  demande de travail qualifie dans le secteur j en volume
pva(i)                   prix composite de la valeur ajoutee dans secteur i - usd
kd(i)                    demande de capital par le secteur i en volume
ld(i)                    demande de travail par le secteur i en volume
pic(i)                   prix composite de la consommation intermediaire totale dans secteur i - usd
cij(i,j)                 consommation intermediaire de bien i par le secteur j en volume
py(i)                    prix d'offre bien i - usd
x(i)                     exports de biens i en volume
xd(i)                    ventes locales de bien i en volume
inc                      revenu primaire total des menages - usd mlns
inch(h)                  revenu primaire total du menage représentatif h - usd mlns
disp_inc                 revenu disponible total des menages - usd mlns
disp_inch(h)             revenu disponible total du menage représentatif h - usd mlns
savings                  epargne totale des menages - usd mlns
savingsh(h)              epargne du menage h - usd mlns
c(i)                     consommation finale totale de bien i par les menages en volume
ch(h,i)                  consommation finale de bien i par le menage h en volume
u(h)                     utilite du menage h
ck(i)                    demande de bien i pour investissement en volume
budg_exp                 depenses publiques totales - usd mlns
cg(i)                    consommation publique de bien i en volume
pq(j)                    prix du facteur composite dans le secteur j - usd
ws                       remuneration du facteur qualifie - usd
rland                    remuneration de la terre - usd
w                        remuneration du travail - usd
r                        remuneration du capital - usd
pd(i)                    prix domestique du bien local - usd
demtot(i)                absorption de bien i (demande totale par agents nationaux) en volume
pdemtot(i)               prix composite de la demande totale par agents nationaux de bien i - usd
d(i)                     demande locale pour les biens locaux en volume
m(i)                     importations en volume
inv                      investissement prive - usd mlns
tradesold                solde exterieur - usd mlns
curr_acc                 compte courant - usd mlns
pubsold                  solde public - usd mlns
delta_itr                impot supplementaire sur le revenu des menages pour le bouclage public
delta_indirect_tax       taxe supplementaire sur le consommation pour le bouclage public
e                        taux de change - usd per unit of foreign currency
pindc                    indice prix consommation
unemp                    chômage des qualifiés
leon                     leon
;

* initialisation des variables
p.l(i)                   = p0(i) ;
pm.l(i)                  = pm0(i) ;
px.l(i)                  = px0(i) ;
pwm.l(i)                 = pwm0(i) ;
pwx.l(i)                 = pwx0(i) ;
va.l(i)                  = va0(i) ;
ic.l(i)                  = ic0(i) ;
y.l(i)                   = y0(i) ;
pq.l(j)                  = pq0(j) ;
q.l(j)                   = q0(j) ;
land.l(j)$land0(j)       = land0(j) ;
pva.l(i)                 = pva0(i) ;
kd.l(i)                  = kd0(i) ;
ld.l(i)                  = ld0(i);
skld.l(i)                = skld0(i) ;
pic.l(i)                 = pic0(i) ;
cij.l(i,j)               = cij0(i,j) ;
py.l(i)                  = py0(i) ;
x.l(i)                   = x0(i) ;
xd.l(i)                  = xd0(i) ;
inc.l                    = inc0 ;
disp_inc.l               = disp_inc0 ;
savings.l                = savings0 ;
c.l(i)                   = c0(i) ;
u.l(h)                   = u0(h) ;
ck.l(i)                  = ck0(i) ;
budg_exp.l               = budg_exp0 ;
cg.l(i)                  = cg0(i) ;
w.l                      = w0 ;
ws.l                     = ws0 ;
rland.l                  = rland0 ;
r.l                      = r0 ;
pq.l(i)                  = pq0(i) ;
pd.l(i)                  = pd0(i) ;
demtot.l(i)              = demtot0(i) ;
pdemtot.l(i)             = pdemtot0(i) ;
d.l(i)                   = d0(i) ;
m.l(i)                   = m0(i) ;
inv.l                    = inv0 ;
tradesold.l              = tradesold0 ;
curr_acc.l               = curr_acc0 ;
pubsold.l                = pubsold0 ;
delta_itr.l              = 0 ;
delta_indirect_tax.l     = 0 ;
e.l                      = e0 ;
unemp.l                  = unemp0 ;
pindc.l                  = pindc0 ;
leon.l                   = leon0 ;
inch.l(h)                = inch0(h) ;
disp_inch.l(h)           = disp_inch0(h) ;
savingsh.l(h)            = savingsh0(h) ;
ch.l(h,i)                = ch0(h,i) ;

*************************************************************************
* limites inférieures
*************************************************************************
p.lo(i)                   = 0 ;
pm.lo(i)                  = 0 ;
px.lo(i)                  = 0 ;
pwm.lo(i)                 = 0 ;
pwx.lo(i)                 = 0 ;
va.lo(i)                  = 0 ;
ic.lo(i)                  = 0 ;
y.lo(i)                   = 0 ;
pq.lo(j)                  = 0 ;
q.lo(j)                   = 0 ;
land.lo(j)$land0(j)       = 0 ;
pva.lo(i)                 = 0 ;
kd.lo(i)                  = 0 ;
ld.lo(i)                  = 0;
skld.lo(i)                = 0 ;
pic.lo(i)                 = 0 ;
cij.lo(i,j)               = 0 ;
py.lo(i)                  = 0 ;
x.lo(i)                   = 0 ;
xd.lo(i)                  = 0 ;
inc.lo                    = 0 ;
disp_inc.lo               = 0 ;
savings.lo                = 0 ;
c.lo(i)                   = 0 ;
u.lo(h)                   = 0;
ck.lo(i)                  = 0 ;
budg_exp.lo               = 0 ;
cg.lo(i)                  = 0 ;
w.lo                      = 0 ;
ws.lo                     = 0 ;
rland.lo                  = 0 ;
r.lo                      = 0 ;
pq.lo(i)                  = 0 ;
pd.lo(i)                  = 0 ;
demtot.lo(i)              = 0 ;
pdemtot.lo(i)             = 0 ;
d.lo(i)                   = 0 ;
m.lo(i)                   = 0 ;
inv.lo                    = 0 ;
delta_itr.lo              = 0 ;
delta_indirect_tax.lo     = 0 ;
e.lo                      = 0 ;
unemp.lo                  = 0 ;
pindc.lo                  = 0 ;
inch.lo(h)                = 0 ;
disp_inch.lo(h)           = 0 ;
savingsh.lo(h)            = 0 ;
ch.lo(h,i)                = 0 ;

*************************************************************************
* equations
*************************************************************************
* declaration des equations
equations
eq_p(i)          relation prix producteur prix consommateur
eq_pm(i)         relation prix a l'import prix mondial
eq_px(i)         relation prix a l'export prix mondial
eq_pwx(i)        demande d'exportation par le reste du monde
eq_pwm(i)        offre d'importation par le reste du monde
eq_va(i)         valeur ajoutee dans secteur i - leontief
eq_ic(i)         demande totale de consommation intermediaire dans secteur i - leontief
eq_y(i)          production dans secteur i
eq_te(i)         demande de terre dans le secteur i
eq_q(i)          demande de facteur composite dans le secteur i
eq_skld(j)       demande de travail qualifie dans le secteur i
eq_pq(j)         prix du facteur composite dans le secteur j
eq_pva(i)        prix composite valeur ajoutee dans secteur i
eq_kd(i)         demande de capital par le secteur i
eq_ld(i)         demande de travail par le secteur i
eq_pic(j)        prix composite consommation intermediaire dans secteur j
eq_cij(i,j)      demande de consommation intermediaire de bien i par secteur j
eq_py(i)         prix composite de l'offre
eq_x(i)          fonction cet exportation
eq_xd(i)         fonction cet ventes locales
eq_inc           formation du revenu primaire total des ménages
eq_inch(h)       formation du revenu primaire du ménage h
eq_disp_inc      revenu disponible total des ménages
eq_disp_inch(h)  revenu disponible du ménage h
eq_savings       epargne privee totale des ménages
eq_savingsh(h)   epargne privee du ménage h
eq_c(i)          consommation finale totale du bien i par les ménages
eq_ch(i,h)       consommation finale du bien i par le ménage h
eq_u(h)          utilite du consommateur h
eq_ck(i)         demande de bien i pour investissement
eq_pub_budg      solde public - depenses publiques
eq_cg(i)         conosmmation publique de bien i
eq_w             equilibre sur le marche du travail non qualifie
eq_unemp         courbe de salaire (relation décroissante chomage salaires qualifiés)
eq_r             equilibre sur le marche du capital
eq_ws            equilibre sur le marche du travail qualifie
eq_rland         equilibre sur le marche de la terre
eq_pd            equilibre sur le marche local du bien i
eq_demtot(i)     absorption
eq_pdemtot(i)    prix composite de absorption
eq_d(i)          demande armington pour biens locaux
eq_m(i)          demande armington pour importations
eq_macro         equilibre macroeconomique
eq_tradesold     solde exterieur
eq_curr_acc      compte courant
eq_pindc         indice des prix
;

*definition des equations
*** bloc prix
eq_p(i)..                pdemtot(i)*(1+indirect_tax(i)+delta_indirect_tax$(public_closure=3)) =e= p(i) ;
eq_pm(i)..               pm(i) =e= e*pwm(i)*[1+tm(i)]  ;
eq_px(i)..               px(i)*(1+te(i))=e= e*pwx(i) ;
eq_pwx(i)..              x(i) =e= fx(i)*pwx(i)**(-sigmax(i))  ;
eq_pwm(i)..              m(i) =e= fm(i)*pwm(i)**sigmam(i)  ;

*** bloc production
*** leontieff 1st niveau
eq_va(i)..               va(i)  =e= psi_va(i)*y(i) ;
eq_ic(i)..               ic(i)  =e= psi_ic(i)*y(i) ;
eq_y(i)..                py(i)*y(i) =e= pva(i)*va(i)+pic(i)*ic(i) ;

*** constant elasticity of substitution 2eme niveau
eq_pva(i)..              pva(i)*va(i) =e= w*(1+tva(i))*ld(i)
                                          + pq(i)*q(i) + [rland*(1+tva(i))*land(i)]$land0(i);
eq_ld(i)..               ld(i) =e= a_l(i)*va(i)*[pva(i)/(w*(1+tva(i)))]**sigma_va(i);
eq_te(i)$land0(i)..      land(i)=e= a_te(i)*va(i)*[pva(i)/(rland*(1+tva(i)))]**sigma_va(i);
eq_q(i)..                q(i) =e= a_q(i)*va(i)*[pva(i)/pq(i)]**sigma_va(i);

*** constant elasticity of substitution 3eme niveau
eq_skld(j)..             skld(j) =e= a_skld(j)*q(j)*[pq(j)/(ws*(1+tva(j)))]**sigma_cap(j);
eq_kd(j)..               kd(j) =e= a_kd(j)*q(j)*[pq(j)/(r*(1+tva(j)))]**sigma_cap(j);
eq_pq(j)..               pq(j)*q(j) =e= r*(1+tva(j))*kd(j)+ ws*(1+tva(j))*skld(j);

*** leontieff 2nd niveau
eq_pic(j)..              pic(j)*ic(j) =e= sum[i,p(i)*cij(i,j)] ;
eq_cij(i,j)..            cij(i,j) =e= psi_ijc(i,j)*ic(j) ;

*** bloc constant elasticity of transformation
eq_py(i)..               py(i)*y(i) =e= px(i)*x(i) + pd(i)*xd(i)  ;
eq_x(i)..                x(i) =e= a_x(i)*y(i)*(px(i)/py(i))**sigma_cet(i) ;
eq_xd(i)..               xd(i) =e= a_xd(i)*y(i)*(pd(i)/py(i))**sigma_cet(i) ;

*** bloc revenu
eq_inc..                 inc =e= sum(h,nh(h)*inch(h)) ;
eq_inch(h)..             nh(h)*inch(h) =e= share_f(h,'unsk')*w*ls + share_f(h,'skl')*ws*sum(i,skld(i)) + share_f(h,'capital')*r*ks
                                           + share_f(h,'land')*rland*lands + share_r(h)*e*remittances ;
eq_disp_inc..            disp_inc =e= sum(h,nh(h)*disp_inch(h)) ;
eq_disp_inch(h)..        nh(h)*disp_inch(h) =e= (1-itr(h)-delta_itr$(public_closure=2))*nh(h)*inch(h) + share_t(h)*transf_g_hh ;
eq_savings..             savings =e= sum(h,nh(h)*savingsh(h)) ;
eq_savingsh(h)..         savingsh(h) =e= mps(h)*disp_inch(h) ;

*** bloc demande
*****menages
eq_ch(i,h)..             p(i)*[ch(h,i) - cmin(h,i)] =e= gamma(h,i)*[(1-mps(h))*disp_inch(h) -sum(j,p(j)*cmin(h,j))]  ;
eq_u(h)..                u(h) =e= prod[i,(ch(h,i) - cmin(h,i))**gamma(h,i)] ;
eq_c(i)..                c(i) =e= sum(h$ch0(h,i),nh(h)*ch(h,i)) ;
*****entreprises
eq_ck(i)..               p(i)*ck(i) =e= alpha_k(i)*inv ;

*** bloc gouvernement
eq_pub_budg..            pubsold =e= e*transf_rm_g + sum[h,(itr(h)+delta_itr$(public_closure=2))*nh(h)*inch(h)]
                                     + sum(i,(indirect_tax(i)+delta_indirect_tax$(public_closure=3))*pdemtot(i)*demtot(i))
                                     + sum[i,tm(i)*e*pwm(i)*m(i)] + sum[i,te(i)*px(i)*x(i)]
                                     + sum[i,(r*kd(i)+w*ld(i)+ws*skld(i)+(rland*land(i))$land0(i))*tva(i)]
                                     - budg_exp - transf_g_hh  ;
eq_cg(i)..               p(i)*cg(i) =e= alpha_g(i)*budg_exp ;

*** bloc equilibre de marche
eq_unemp..               unemp =e= skls-sum(i,skld(i)) ;
eq_ws..                  ws =e= pindc*k_wc*[unemp**(-0.1)]  ;
eq_w..                   ls =e= sum(i,ld(i)) ;
eq_rland..               lands =e= sum(i$land0(i),land(i)) ;
eq_r..                   ks =e= sum(i,kd(i))  ;
eq_pd(i)..               xd(i) =e= d(i)  ;

***bloc demande armington
eq_demtot(i)..           c(i) + sum[j,cij(i,j)] + ck(i) + cg(i) =e= demtot(i) ;
eq_pdemtot(i)..          pdemtot(i)*demtot(i) =e= pd(i)*d(i) + pm(i)*m(i) ;
eq_d(i)..                d(i) =e= a_d(i)*demtot(i)*(pdemtot(i)/pd(i))**sigma_arm(i) ;
eq_m(i)..                m(i) =e= a_m(i)*demtot(i)*(pdemtot(i)/pm(i))**sigma_arm(i) ;

*** equilibre macroeconomique
eq_macro..               savings - inv + pubsold =e= curr_acc + leon  ;

*** solde exterieur
eq_tradesold..           tradesold =e= e*sum[i,pwx(i)*x(i) - pwm(i)*m(i)]  ;
eq_curr_acc..            curr_acc =e= tradesold + e*remittances + e*transf_rm_g ;

*** indice des prix a la consommation
eq_pindc..               pindc*sqrt{sum[i,p0(i)*c0(i)]*sum[i,p0(i)*c(i)]}
                                 =e= sqrt{sum[i,p(i)*c0(i)]*sum[i,p(i)*c(i)]};

*******************************************************************************
*** modele
*******************************************************************************
model macro_prod /all/ ;

*******************************************************************************
***numeraire
*******************************************************************************
pindc.fx          = pindc0 ;

*******************************************************************************
* bouclages
*******************************************************************************
***bouclage public
budg_exp.fx$public_closure                                                               = budg_exp0 ;
pubsold.fx$((public_closure=0) or (public_closure=2) or (public_closure=3))              = pubsold0 ;
delta_itr.fx$((public_closure=0) or (public_closure=1) or (public_closure=3))            = 0 ;
delta_indirect_tax.fx$((public_closure=0) or (public_closure=1) or (public_closure=2))   = 0 ;

***bouclage exterieur
curr_acc.fx$(foreign_closure=1)          = curr_acc0 ;
e.fx$(foreign_closure=2)                 = e0;

*******************************************************************************
*** resolution du modele sans choc
*******************************************************************************
solve macro_prod using cns ;

*******************************************************************************
* choc
*******************************************************************************
*** enregistrement des variables exogenes initiales
parameter
transf_g_hh_     parametre buffet transferts gvt menages
remittances_     parametre buffet transferts unilateraux RM menages
tva_(i)          parametre buffet taux de tva
tm_(i)           parametre buffet droit de douane
;

transf_g_hh_             = transf_g_hh ;
remittances_             = remittances ;
tva_(i)                  = tva(i) ;
tm_(i)                   = tm(i) ;

*** choc
*transf_g_hh = transf_g_hh + 100;
*remittances = remittances + 100;
*tva(i)$not_agr(i) = tva(i) + 0.02 ;
*tm(i) = tm(i)/2 ;
*tm(i) = 0 ;
skls=skls*0.2

solve macro_prod using cns ;

*******************************************************************************
* resultats
*******************************************************************************
parameter
rategrowthy(i)                   taux de croissance de production du bien i - pct
rategrowthw                      taux de croissance de remuneration du travail - pct
rategrowthws                     taux de croissance de remuneration du travail qualifie - pct
rategrowthr                      taux de croissance de remuneration du capital - pct
rategrowthrland                  taux de croissance de remuneration de la terre - pct
rategrowthp                      taux de croissance des prix consommateurs - pct
rategrowthe                      taux de croissance du taux de change - pct
rategrowthinc                    taux de croissance du revenu primaire total des ménages - pct
rategrowthc(i)                   taux de croissance de consommation du bien i - pct
rategrowthimp(i)                 taux de croissance des importations du bien i - pct
rategrowthexp(i)                 taux de croissance des exportations du bien i - pct
gdp_rate                         indice produit interieur brut
;

rategrowthy(i)           = 100*((y.l(i)/y0(i)) -1) ;
rategrowthc(i)           = 100*((c.l(i)/c0(i)) -1) ;
rategrowthw              = 100*((w.l/w0) -1) ;
rategrowthws             = 100*((ws.l/ws0) -1) ;
rategrowthr              = 100*((r.l/r0) -1) ;
rategrowthrland          = 100*((rland.l/rland0) -1) ;
rategrowthp(i)           = 100*((p.l(i)/p0(i)) -1) ;
rategrowthinc            = 100*((inc.l/inc0) -1) ;
rategrowthimp(i)         = 100*((m.l(i)/m0(i)) -1) ;
rategrowthexp(i)         = 100*((x.l(i)/x0(i)) -1) ;
gdp_rate                 = 100*{sqrt{sum[i,va.l(i)*pva0(i)]
                                 /sum[i,va0(i)*pva0(i)]
                                 *sum[i,va.l(i)*pva.l(i)]
                                 /sum[i,va0(i)*pva.l(i)]} - 1};

* Affichage
Display rategrowthy, rategrowthc, rategrowthw, rategrowthws, rategrowthr,
        rategrowthrland, rategrowthp,
        rategrowthinc, rategrowthimp, rategrowthexp, unemp.l ;

************************************************************************
* Calcul du degre d'ouverture
************************************************************************
parameter
degree_openness0         degre d'ouverture initial - pct
degree_openness          degre d'ouverture final - pct
;

degree_openness0         = 100*{e0*sum[i,pwx0(i)*x0(i) + pwm0(i)*m0(i)]/2}/sum[i,va0(i)*pva0(i)]  ;
degree_openness          = 100*{e.l*sum[i,pwx.l(i)*x.l(i) + pwm.l(i)*m.l(i)]/2}/sum[i,va.l(i)*pva.l(i)]  ;

************************************************************************
* analyse de bien-etre
************************************************************************
*declaration de parametres necessaires pour le modele de variation equivalente
parameter
p_final                          prix a la consommation apres le choc
u_final(h)                       utilite du consommateur representatif h apres le choc
disp_inch_final(h)               revenu du consommateur representatif apres le choc
;
p_final(i)               = p.l(i) ;
u_final(h)               = u.l(h) ;
disp_inch_final(h)       = disp_inch.l(h) ;

************************************************************************
* variation equivalente - j.r. hicks
************************************************************************
*fixation de la variable de prix a la consommation aux valeurs initiales
*et de l'utilite a sa valeur finale
p.fx(i)          = p0(i) ;
u.fx(h)          = u_final(h) ;

*definitin et resolution du modele de variation equivalente
model ev /eq_ch, eq_u/;
solve ev using cns ;

*resultats
parameter
equ_var(h)          variation equivalente de hicks - somme a donner a l'agent representatif pour compenser exactement le choc (aux prix initiaux il atteindrait la meme utilite finale) - usd mlns
rate_equ_var(h)     taux de variation de son bien-etre - pct
;

equ_var(h)                  = disp_inch.l(h) - disp_inch0(h) ;
rate_equ_var(h)             = 100*(equ_var(h)/disp_inch0(h)) ;
************************************************************************


************************************************************************
* variation compensatrice - j.r. hicks
************************************************************************
*fixation de la variable de prix a la consommation aux valeurs finales
*et de l'utilite a sa valeur initiale
p.fx(i) = p_final(i) ;
u.fx(h) = u0(h) ;

*definitin et resolution du modele de variation equivalente
model cv /eq_ch, eq_u/;
solve cv using cns ;

*resultats
parameter
comp_var(h)         variation compensatrice de hicks - somme a donner a l'agent representatif pour compenser exactement le choc (aux prix finals il atteindrait l'utilite initiale) - usd mlns
rate_comp_var(h)    taux de variation de son bien-etre - pct
;

comp_var(h)                 = disp_inch_final(h) - disp_inch.l(h) ;
rate_comp_var(h)            = 100*(comp_var(h)/disp_inch0(h)) ;
************************************************************************

 parameter
growth_inch(h);
  growth_inch(h)    =  100*((inch.l(h)/inch0(h))-1)      ;

display  growth_inch, comp_var ,rate_comp_var ,equ_var  ,rate_equ_var   ;

