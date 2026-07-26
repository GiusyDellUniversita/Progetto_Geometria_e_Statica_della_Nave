# Progetto_Geometria_e_Statica_della_Nave

### Esercitazione di gruppo per Esame di Geometria e Stabilità Statica della Nave
Si consideri la geometria di nave che vi è stata assegnata e sia dd l’immersione di
progetto assegnata (che trovate nel file `geom.xls`).

**A)** Si determinino le seguenti grandezze di progetto:
- Dislocamento di volume, $\nabla_\text{D}$
- Spinta di Archimede all'equilibrio, $\text{S}$
- Larghezza massima, $\text{B}_\text{max}$
- Lunghezza tra le perpendicolari, $\text{L}_\text{pp}$

Nel caso in cui le grandezze siano assegnate nel file dato, verificare i valori e stimare
l’errore.

Immaginando ora una variazione di draft tra 0.5 $\text{d}_d$ e 1.5 $\text{d}_d$ si determinino le carene diritte nel suddetto intervallo, per una variazione di 0.07 $\text{d}_d$.

**B)** Si consideri ora un dislocamento di volume pari a $\nabla_\text{N} = 1.25 \cdot \nabla_\text{D}$. Si determini, per il nuovo dislocamento (direttamente da un qualsiasi software di idrostatica):
- Immersione
- Spinta di Archimede all'equilibrio, $\text{S}$
- Peso della carena all’equilibrio
- Coordinate del centro di carena
- Larghezza massima, $\text{B}_\text{max}$
- Area di Galleggiamento
- Coordinate del centro della figura di galleggiamento
- $\text{BM}$

Si confrontino i valori calcolati da un qualsiasi software di idrostatica (per es: MaxSurf)
con quelli che si ottengono dalla interpolazione lineare a partire dalle carene diritte.

**C)** Per il nuovo valore del dislocamento $\nabla_\text{N}$ si determini la tabella delle semi-larghezze al piano di galleggiamento (si prendano 20 ordinate). Si calcoli quindi, utilizzando il
metodo di integrazione i) ai trapezi e ii) di Simpson, le seguenti quantità (si può sviluppare un algoritmo in Matlab o Python):
- Area di galleggiamento
- $\text{BM}$
- Le coordinate del centro di carena a partire dall’integrazione delle curve di Bonjean

Si confrontino i valori cosi determinati con quelli calcolati al punto `B)` Sempre per lo stesso dislocamento $\nabla_\text{N}$

**D)** Determinare $\text{GM}$ supponendo $\text{KG} = 0.9 \cdot \text{draft}$.

**E)** Determinare quindi la curva del $\text{GZ}$ con il metodo:

a) Esatto (direttamente da un qualsiasi software di idrostatica)

b) Approssimato con la formula del galleggiante cilindrico

c) Approssimato con il metodo metacentrico

**F)** Determinare la variazione di GM nel caso in cui si considera una cassa parallelepipeda con acqua all’interno gasolio (densità = 870 kg/m3) con

$l_T = \frac{B_{max}}{2} \quad b_T = \frac{B_{max}}{3} \quad h_T = \frac{Draft}{3}$

posto in posizione simmetrica sulla linea di mezzeria.

**F)** Supponendo ora di spostare un peso a bordo, pari a $dP = \frac{1}{200} \Delta_N (t)$ per un braccio corrispondente a Bmax (all’immersione considerata), si determini:

i) L’angolo di sbandamento di equilibrio

ii) Il momento raddrizzante all’equilibrio

iii) Verificare le ipotesi del teorema di Eulero

**G)** Si ripeta il problema precedente considerando la variazione di un peso a bordo pari a $dP = \frac{1}{60} \nabla_N (t)$

**H)** Si consideri ora di applicare un momento ribaltante con la seguente legge

$0.3 M_0 (1 + sin(2\Phi)),$

essendo M0 il momento statico in G). Si determini l’angolo di sbandamento dinamico,
partendo da un angolo iniziale di 0° e di -10°.

**I)** Si consideri ora che la nave, al dislocamento considerato, abbia un raggio di inerzia
pari a $\text{r}_{xx} = 0.3 \cdot B_{max}$. Si determini il periodo naturale di rollio assumendo un contributo del momento di inerzia aggiunto pari al 20% del contributo di inerzia ordinario della nave.

**L)** Si verifichi infine la stabilità intatta di nave integra secondo il criterio generale di
stabilità (`ex-IMO Res.A.167`) ed il criterio meteorologico. Si assuma un angolo di allagamento progressivo pari a 45° . Per il criterio generale di stabilità si soddisfino i soli criteri a)-b)-c)-d)-e)- f)
