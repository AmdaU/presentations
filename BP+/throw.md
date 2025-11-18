# BP+ (Bosonique Pauli +)


## Intro

But: pouvoir simuler efficacement des codes concatené 

Expliquer c'est quoi un code concatené

But du but: Les code concatené c'est prometteur mais il y a beaucoup de chose qu'on se sait pas encore sur eux: quels codes utiliser? mutimodes? Fidelité? Comment mesurer? 

BP+ à été developpé avec sBs (gkps donc) à l'eprit (ici concatené avec code de surface) mais l'idée reste générale et applicable à d'autre système.


Les cavité c'est plus dur à simuler que les TLS parce que il y a des degrée de liberté d'erreur supplémentaires. Ne pas prendre ces degreés de liberté supplémentaire en compte peut mener à des erreur imporantes. Ces erreurs ne sont pas capturés par des simulations Clifford.


BP+ vise a rester efficacement simulable  mais en capturant toujours les caractéristiques importantes de oscillateur.


BP+ accompli cela en définissant une base


Inspirations:
1) Les transmons qui ne sont pas de simples TLS -> pas Clifford -> Pauli + -> variable supplémentaire qui indique si dans $L$ ou $?$
2) Décomposition des GKP en une base. Similaire à une base de Zak mais pour energie finie


Montrer la structure de leur code de surface 


## BP+ 

$$\mathcal{H}_L \otimes \mathcal{H}_E \approx \mathcal{H}_L \otimes \mathcal{H}_{Ec}  $$ 


1) On considère le sous-espace d'erreur comme classique (Pas de corrélations)

2) Le cannal sur le sous-espace logique est un canal pauli


## Décomposition de l'espace des erreurs

$$\mathcal{R}=\left\{\hat{\rho} \in \mathcal{L}\left(\mathcal{H}_B\right): \hat{\rho}=\sum_e|e\rangle\langle e| \otimes \hat{\rho}_e^{(L)}, \hat{\rho}_e^{(L)} \in \mathcal{L}\left(\mathcal{H}_L\right)\right\} .$$ 

Négliger les cohérence fonctionne bien avec sBs car la correction dépends très peu de ces cohérences. 

Choisir une bonne base de $\ket{e}$ pour construire $\mathcal{R}$ est évidemment important. En choisissant une mauvaise base on pourrait avoir arbitraire mènent  beaucoup de poids sur les cohérence. 

## PTM+ channel

On peut approximer n'importe quel canal par puisque $\mathcal{P}_{\mathcal{R}}$ et CPTP

$$\mathcal{C}_{\rm PTM+} = \mathcal{P}_{\mathcal{R}} \circ \mathcal{P}\circ\mathcal{P}_{\mathcal{R}}$$ 

## BP+ channels

PTM+ a un cout exponentiel en nombre de modes. On passe donc à BP+ par *Pauli twirling*. Cela veut simplement dire qu'on approxime le channel comme un channel de Pauli. 

## Simlation 

----

## Base sBs

Tenseur sBs -> K $\implies K^\dag$ crée une erreur


