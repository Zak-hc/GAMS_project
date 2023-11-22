$ontext
 ***** Désagrégation du travail, CES dans la production et LES dans la consommation + taxes sur les facteurs **** 
$offtext

set i /
agr      agriculture
ind      industrie
serv     service
/
;

alias(i,j)  ;

parameters
alpha_k(i)       coefficient de la fonction de demande de bien de capital cobb douglass
a(i)             parametre d echelle pour valeur ajoutee dans secteur i
fx(i)            parametre d echelle pour demande par le reste du monde pour les exportations
fm(i)            parametre d echelle pour offre par le reste du monde d'importations
psi_va(i)        coefficient leontief valeur ajoutee  production
psi_ic(i)        coefficient leontief consommation intermediaire production
psi_ijc(i,j)     coefficient leontief consommation intermediaire
gamma(i)         coefficient utilite fonction les
cmin(i)          parametre de consommation minimale
alpha_g(i)       coefficient de la cobb-douglas fonction consommation du Gouvernement
mps              propension marginale a epargner du menage representatif
a_x(i)           parametre de part pour exportations w-r local supply
a_xd(i)          parametre de part pour ventes du bien local aux consommateurs locaux
a_d(i)           parametre de part pour demande de bien local p-r demande totale
a_m(i)           parametre de part pour biens importes p-r demande totale
a_l(i)           parametre de part pour la demande de travail non qualifie
a_te(i)          parametre de part pour la demande de terre
a_q(i)           parametre de part pour la demande de facteur composite
a_skld(j)        parametre de part pour la demande de travail qualifie
a_kd(j)          parametre de part pour la demande de capital

*variables exogenes
******offre de facteurs
ls               offre totale de travail non qualifie
ks               offre totale de capital
lands            offre totale de terre
skls             offre totale de travail qualifie

******transferts
remittances      transferts unilateraux du reste du monde aux menages
transf_g_hh      transferts du gouvernement aux menages
transf_rm_g      transfert unilateral du reste du monde au gouvernement

******taux de taxation
tm(i)            tarif a l'importation sur le bien i
te(i)            taxe a l'exportation sur le bien i
indirect_tax(i)  taux de taxation indirecte dans secteur i
itr              taux de taxation du revenu du consommateur representatif
tva(i)           taux de tva

*valeur initiale des variables
kd0(i)           valeurs initiales de demande de capital par le secteur i
ld0(i)           valeurs initiales de demande de travail non qualifie par le secteur i
skld0            valeurs initiales de demande de travail qualifie par le secteur i
y0(i)            valeurs initiales de production du secteur i
pq0(j)           valeurs initiales du prix du facteur composite
q0(j)            valeurs initiales de la demande de facteur composite par le secteur i
rland0           valeurs initiales de remuneration de la terre
land0(j)         valeurs initiales de demande de terre
p0(i)            valeurs initiales de prix a la consommation du bien i
py0(i)           valeurs initiales de prix a la production du bien i
va0(i)           valeurs initiales de la valeur ajoutee dans secteur i
pva0(i)          valeurs initiales de prix composite de la valeur ajoutee dans secteur i
cij0(i,j)        valeurs initiales de consommation intermediaire de bien i par le secteur j
ic0(i)           valeurs initiales de la consommation intermediaire totale dans secteur i
pic0(i)          valeurs initiales de prix composite de la consommation intermediaire totale dans secteur i
inc0             valeurs initiales du revenu du consommateur representatif
disp_inc0        revenu initial disponible
budg_exp0        valeur initiale des depenses publiques
w0               valeur initiale de la remuneration du travail non qualifie
ws0              valeur initiale de la remuneration du travail qualifie
r0               valeur initiale de la remuneration du capital
c0(i)            Valeurs initiales de la consommation finale de bien i
u0               valeur initiale de l'utilite du consommateur representatif
cg0(i)           valeurs initiales de consommation publique de bien i
ck0              valeurs initales de la demande de bien i pour investissement prive
tradesold0       valeur initiale du solde exterieur
curr_acc0        valeur initial du compte courant
e0               valeur initiale du taux de change
savings0         valeur initiale de l'epargne du consommateur representatif
inv0             valeur initiale de l'investissement des entreprises
pubsold0         valeur initiale du solde publique
pm0(i)           valeurs initiales des prix a l'importation
px0(i)           valeurs initiales des prix a l'exportation
pwm0(i)          valeurs initiales du prix mondial des importations
pwx0(i)          valeurs initiales du prix mondial des exportations
x0(i)            valeurs initiales des quantites exportees
xd0(i)           valeurs initiales des quantites offertes par les producteurs locaux sur le marche local
pd0(i)           valeurs initiales du prix domestique des biens locaux
demtot0(i)       valeurs initiales de l'absorption
pdemtot0(i)      valeurs initiales du prix composite de l'absorption
d0(i)            valeurs initiales de quantites demandees de biens locaux par les consommateurs locaux
m0(i)            valeurs initiales des quantites importees
leon0            valeur initiale du leon

****autres parametres
indtax(i)        recettes initiales de la taxation indirecte dans secteur i
income_tax       recettes initiales taxe directe sur le revenu
;

* matrice de comptabilite sociale
table mcs(*,*)
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

parameter importcoll(i)  collecte initiale de droits de douane sur les importations usd mios
/
agr      0
ind      300
serv     0
/;

parameter tvacoll(i)  collecte initiale de tva usd Mios
/
agr      50
ind      140
serv     90
/;

parameter exportcoll(i)  collecte initiale de taxes a l'export usd Mios
/
agr      15
ind      45
serv     0
/;

parameter sigmax(i)      elasticite de la demande par le reste du monde d'exportations p-r au prix mondial
/
agr      3
ind      3
serv     3
/;

parameter sigmam(i)      elasticite de l'offre par le reste du monde d'importations p-r au prix mondial
/
agr      3
ind      3
serv     3
/;

parameter sigma_cet(i)   elasticite de substitution dans la cet ventes domestiques vs exportations
/
agr      3
ind      3
serv     3
/;

parameter sigma_arm(i)   elasticite de substitution (armington) ces demande locale pour les biens locaux vs demande locale de biens importes
/
agr      3
ind      3
serv     3
/;

parameter sigma_va(i)    elasticite de substitution terre - travail non qualifie - facteur composite
/
agr      1.1
ind      1.1
serv     1.1
/;

parameter sigma_cap(j)    elasticite de substitution travail qualifie - capital
/
agr      0.6
ind      0.6
serv     0.6
/;

parameter les_cmin(i)   parametre pour le calcul des consommations minimales - fonction utilite les
/
agr      0.8
ind      0.6
serv     0.2
/;

*** Entree de donnees
kd0(i)           = mcs('kd',i)  ;
ld0(i)           = mcs('ld',i) ;
skld0(i)         = mcs('skld',i) ;
land0(i)         = mcs('land',i) ;
cg0(i)           = mcs(i,'gvt') ;
y0(i)            = mcs('total',i) - mcs('rm',i)
                 - importcoll(i) - exportcoll(i) - tvacoll(i);
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

*** calibrage
ls                       = sum(i,ld0(i)) ;
skls                     = sum(i,skld0(i)) ;
ks                       = sum(i,kd0(i)) ;
lands                    = sum(i,land0(i)) ;
indirect_tax(i)          = indtax(i)/(p0(i)*y0(i)-indtax(i)) ;
ic0(j)                   = sum[i,p0(i)*cij0(i,j)]/pic0(j) ;
va0(i)                   = [rland0*land0(i) + w0*ld0(i)
                           + r0*kd0(i)+ ws0*skld0(i) + tvacoll(i)] / pva0(i) ;
py0(i)                   = [pva0(i)*va0(i)  + pic0(i)*ic0(i) ]/y0(i)  ;
xd0(i)                   = [py0(i) *y0(i) - px0(i)*x0(i) ]/pd0(i) ;
d0(i)                    = xd0(i) ;
pdemtot0(i)              = P0(i)/(1+indirect_tax(i)) ;
demtot0(i)               = C0(i) + CG0(i) + ck0(i) + sum(j,CIJ0(i,j));
pm0(i)                   = [pdemtot0(i)*demtot0(i)-pd0(i)*d0(i)]/m0(i);
tva(i)                   = pva0(i)*va0(i)/[r0*kd0(i)+w0*ld0(i)
                         + ws0*skld0(i)+rland0*land0(i)] - 1 ;
q0(j)                    = [r0*(1+tva(j))*kd0(j)+ ws0*(1+tva(j))*skld0(j)]/pq0(j);
a_l(i)                   = (ld0(i)/va0(i))*[pva0(i)/(w0*(1+tva(i)))]**(-sigma_va(i)) ;
a_te(i)                  = (land0(i)/va0(i))*[pva0(i)/(rland0*(1+tva(i)))]**(-sigma_va(i)) ;
a_q(i)                   = (q0(i)/va0(i))*[pva0(i)/pq0(i)]**(-sigma_va(i)) ;
a_skld(i)                = (skld0(i)/q0(i))*[pq0(i)/(ws0*(1+tva(i)))]**(-sigma_cap(i)) ;
a_kd(i)                  = (kd0(i)/q0(i))*[pq0(i)/(r0*(1+tva(i)))]**(-sigma_cap(i));
inc0                     = w0*ls + ws0*skls + r0*ks + rland0*lands + e0*remittances ;
itr                      = income_tax/inc0 ;
disp_inc0                = (1-itr)*inc0 + transf_G_hh ;
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
pubsold0                 = transf_rm_g + itr*inc0 + sum(i,indirect_tax(i)*pdemtot0(i)*demtot0(i))
                         + sum[i,tm(i)*e0*pwm0(i)*m0(i)] + sum[i,te(i)*px0(i)*x0(i)]
                         + sum[i,tva(i)*(r0*kd0(i)+w0*ld0(i)+ws0*skld0(i)+rland0*land0(i))]
                         - budg_exp0 - transf_g_hh ;
inv0                     = sum(i,p0(i)*ck0(i)) ;
alpha_k(i)               = p0(i)*ck0(i)/inv0 ;
mps                      = savings0/disp_inc0 ;

cmin(i)                  = les_cmin(i)*c0(i) ;

gamma(i)                 = p0(i)*[c0(i) - cmin(i)]/[(1-mps)*disp_inc0 - sum(j,p0(j)*cmin(j))] ;
u0                       = prod[i,(c0(i) - cmin(i))**gamma(i)] ;
curr_acc0                = tradesold0 + e0*remittances + transf_rm_g ;
leon0                    = savings0 - inv0 + pubsold0 - curr_acc0;

*declaration des variables
variables
p(i)            prix a la consommation du bien i
pm(i)           prix a l'importation bien i
px(i)           prix a l'exportation bien i
pwm(i)          prix mondial des importations de bien i
pwx(i)          prix mondial des exportations de bien i
va(i)           valeur ajoutee dans secteur i
ic(i)           consommation Intermediaire totale dans secteur i
y(i)            production dans secteur i
q(j)            demande de facteur composite dans le secteur j
land(j)         demande de terre dans le secteur j
skld(j)         demande de travail qualifie dans le secteur j
pva(i)          prix composite de la valeur ajoutee dans secteur i
kd(i)           demande de capital par le secteur i
ld(i)           demande de travail par le secteur i
pic(i)          prix composite de la consommation intermediaire totale dans secteur i
cij(i,j)        consommation intermediaire de bien i par le secteur j
py(i)           prix d'offre bien i
x(i)            exports de biens i
xd(i)           ventes locales de bien i
inc             revenu du menage representatif
disp_inc        revenu disponible
savings         epargne du menage representatif
c(i)            consommation finale de bien i par le menage representatif
u               utilite du menage representatif
ck(i)           demande de bien i pour investissement
budg_exp        depenses publiques totales
cg(i)           consommation publique de bien i
pq(j)           prix du facteur composite dans le secteur j
ws              remuneration du facteur qualifie
rland           remuneration de la terre
w               remuneration du travail
r               remuneration du capital
pd(i)           prix domestique du bien local
demtot(i)       absorption de bien i (demande totale par agents nationaux)
pdemtot(i)      prix composite de la demande totale par agents nationaux de bien i
d(i)            demande locale pour les biens locaux
m(i)            importations
inv             investissement prive
tradesold       solde exterieur
curr_acc        compte courant
pubsold         solde public
e               taux de change
leon            leon ;

*** initialisation des variables
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
u.l                      = u0 ;
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
e.l                      = e0 ;
leon.l                   = leon0 ;

*declaration des equations
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
eq_inc           formation du revenu
eq_disp_inc      revenu disponible
eq_savings       epargne privee
eq_c(i)          consommation du bien i
eq_u             utilite du consommateur representatif
eq_ck(i)         demande de bien i pour investissement
eq_budg_exp      solde public - depenses publiques
eq_cg(i)         conosmmation publique de bien i
eq_w             equilibre sur le marche du travail non qualifie
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
;

*modele
*** bloc prix
eq_p(i)..        pdemtot(i)*(1+indirect_tax(i)) =e= p(i) ;
eq_pm(i)..       pm(i) =e= e*pwm(i)*[1+tm(i)]  ;
eq_px(i)..       px(i)*(1+te(i))=e= e*pwx(i) ;
eq_pwx(i)..      x(i) =e= fx(i)*pwx(i)**(-sigmax(i))  ;
eq_pwm(i)..      m(i) =e= fm(i)*pwm(i)**sigmam(i)  ;

*** bloc production
*** Leontieff 1st niveau
eq_va(i)..       va(i)  =e= psi_va(i)*y(i) ;
eq_ic(i)..       ic(i)  =e= psi_ic(i)*y(i) ;
eq_y(i)..        py(i)*y(i) =e= pva(i)*va(i)+pic(i)*ic(i) ;

*** CES 2eme niveau
eq_pva(i)..          pva(i)*va(i) =e= w*(1+tva(i))*ld(i)
                     + pq(i)*q(i) + [rland*(1+tva(i))*land(i)]$land0(i);
eq_ld(i)..           ld(i) =e= a_l(i)*va(i)*[pva(i)/(w*(1+tva(i)))]**sigma_va(i);
eq_te(i)$land0(i)..  land(i)=e= a_te(i)*va(i)*[pva(i)/(rland*(1+tva(i)))]**sigma_va(i);
eq_q(i)..            q(i) =e= a_q(i)*va(i)*[pva(i)/pq(i)]**sigma_va(i);

*** CES 3eme niveau
eq_skld(j)..     skld(j) =e= a_skld(j)*q(j)*[pq(j)/(ws*(1+tva(j)))]**sigma_cap(j);
eq_kd(j)..       kd(j) =e= a_kd(j)*q(j)*[pq(j)/(r*(1+tva(j)))]**sigma_cap(j);
eq_pq(j)..       pq(j)*q(j) =e= r*(1+tva(j))*kd(j)+ ws*(1+tva(j))*skld(j);

*** Leontieff 2nd niveau
eq_pic(j)..      pic(j)*ic(j) =e= sum[i,p(i)*cij(i,j)] ;
eq_cij(i,j)..    cij(i,j) =e= psi_ijc(i,j)*ic(j) ;

*** bloc CET
eq_py(i)..       py(i)*y(i) =e= px(i)*x(i) + pd(i)*xd(i)  ;
eq_x(i)..        x(i) =e= a_x(i)*y(i)*(px(i)/py(i))**sigma_cet(i) ;
eq_xd(i)..       xd(i) =e= a_xd(i)*y(i)*(pd(i)/py(i))**sigma_cet(i) ;

*** bloc revenu
eq_inc..         inc =e= w*ls + ws*skls + r*ks + rland*lands + e*remittances ;
eq_disp_inc..    disp_inc =e= (1-itr)*inc + transf_g_hh ;
eq_savings..     savings =e= mps*disp_inc ;

*** bloc demande
*****menages
eq_c(i)..        p(i)*[c(i) - cmin(i)] =e= gamma(i)*[(1-mps)*disp_inc -sum(j,p(j)*cmin(j))]  ;
eq_u..           u =e= prod[i,(c(i) - cmin(i))**gamma(i)] ;

*****entreprises
eq_ck(i)..       p(i)*ck(i) =e= alpha_k(i)*inv ;

*** bloc gouvernement
eq_budg_exp..    e*transf_rm_g + itr*inc + sum(i,indirect_tax(i)*pdemtot(i)*demtot(i))
                 + sum[i,tm(i)*e*pwm(i)*m(i)] + sum[i,te(i)*px(i)*x(i)]
                 + sum[i,(r*kd(i)+w*ld(i)+ws*skld(i)+(rland*land(i))$land0(i))*tva(i)]
                 - budg_exp - transf_g_hh
                 =e= pubsold ;
eq_cg(i)..       p(i)*cg(i) =e= alpha_g(i)*budg_exp ;

*** bloc equilibre de marche
eq_w..          ls =e= sum(i,ld(i))+ leon ;
eq_ws..         skls =e= sum(i,skld(i)) ;
eq_rland..      lands =e= sum(i$land0(i),land(i)) ;
eq_r..          ks =e= sum(i,kd(i)) ;
eq_pd(i)..      xd(i) =e= d(i)  ;

***bloc demande armington
eq_demtot(i)..      c(i) + sum[j,cij(i,j)] + ck(i) + cg(i) =e= demtot(i) ;
eq_pdemtot(i)..     pdemtot(i)*demtot(i) =e= pd(i)*d(i) + pm(i)*m(i) ;
eq_d(i)..           d(i) =e= a_d(i)*demtot(i)*(pdemtot(i)/pd(i))**sigma_arm(i) ;
eq_m(i)..           m(i) =e= a_m(i)*demtot(i)*(pdemtot(i)/pm(i))**sigma_arm(i) ;

*** equilibre macroeconomique
eq_macro..       savings - inv + pubsold =e= curr_acc ;

*** solde exterieur
eq_tradesold..       tradesold =e= e*sum[i,pwx(i)*x(i) - pwm(i)*m(i)]  ;
eq_curr_acc..        curr_acc =e= tradesold + e*remittances + e*transf_rm_g ;

***declaration du modele
model macro_prod /all/ ;

***numeraire
pd.fx('agr')      = pd0('agr') ;

***bouclage public
pubsold.fx       = pubsold0 ;

***bouclage exterieur
e.fx             = e0;


*** resolution du modele sans choc
solve macro_prod using cns ;


