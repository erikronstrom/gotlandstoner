# gotlandstoner
Digitalisering av Gotlandstoner, August Fredins samling av visor och låtar från Gotland.

Digitaliseringen gjordes av Erik Ronström och Clara Andermo i olika omgångar mellan ca 1998 och 2004.

Korrekturläsning och -lyssning har gjorts av Fredrik Lönngren, Erik Ronström, Jan Lundqvist, Clara Andermo och Owe Ronström, främst mellan 2008 och 2009.

##Riktlinjer för korrekturläsning av Gotlandstoner
Erik Ronström 2008-01-09, rev 2016-08-03

###Utgångspunkt och målsättning
Nya utgåvor av Gotlandstoner kan komma att bygga på det digitaliserade materialet, men digitaliseringsarbetet ska inte ses som en del av produktionen av en hemsida eller en ny utgåva.

*Målet är att skapa en digital kopia av Gotlandstoner i abc-format, så lik originalet som möjligt.*

###Tryckfel
Målsättningen ovan innebär att all information i originalboken, text som musik, ska överföras
så exakt som möjligt. *Detta gäller även sådant som vi kan uppfatta som uppenbara tryckfel!*

Däremot ska de rättelser som finns införda i slutet av originalboken tas med i den digitala
versionen.

### Stavning och avstavning
Enligt ovan ska stavning bibehållas och inte moderniseras eller liknande. Interpunktion ska inte heller ändras.

Bindestreck som är en följd av avstavning ska tas bort, däremot inte bindestreck som är en del
av själva ordet (i förekommande fall).

### Abc‐formatet
Abc-formatet har både fördelar och begränsningar. Viss information går inte att överföra från en tryckt notbok till en abc-fil. Åt andra hållet kräver abc-formatet information
som inte entydigt går att utläsa ur notskrift utan en viss subjektiv tolkning (t ex tonart – är det
C-dur eller A-moll?).

I de allra flesta fall är detta dock inget problem, och överföringen är entydig. Nedan finns särskilda saker att tänka på.

#### Låtbeskrivningar
Då abc har många olika fält för meta-information har vi valt att använda tre stycken: `S` (källhänvisning, ”source”), `N` (anmärkningar, ”notes”) samt `H` (historia, anekdoter etc).

Vi använder dem så att `S` betecknar kompositör, vem låten är efter, geografiskt ursprung eller liknande. `H` används för historier och anekdoter kring låten. Allt annat faller under `N`, vanligtvis är det sådant som spelsätt, omstämning, låtens spridning etc.

**Observera** att undantag gäller för omstämningar, se avsnittet ”Omstämning” nedan!

Om texten innehåller information av flera slag ska den delas upp på flera fält. Interpunktionen ska bibehållas, så att man får tillbaka originaltexten om man konkatenerar ihop alla S-, N-, och H-fält i angiven ordning.

I vissa fall är låtens titel inte satt som rubrik, utan som en del av låtbeskrivningen. Om titeln är först i beskrivningen bör den flyttas till T. I detta fall tas eventuella skiljetecken efter titeln bort.

**Exempel:**

Av Laurin d. ä., uppt. efter klockare Laugren, Alva.

    S:Av Laurin d. ä., uppt. efter klockare Laugren, Alva.
    
Uppt. efter föresjungning av Helena Mårtensson i Burs; en vanlig polska, som dansas, då man sjunger nedanskrivna täxt.

	S:Uppt. efter föresjungning av Helena Mårtensson i Burs;
	N:en vanlig polska, som dansas, då man sjunger nedanskrivna täxt.

Prästmarschen, efter »Florsen» i Burs. Då prästen kom till bröllopsgården, möttes han av
spelmännen, som »spelte in» honom med denna marsch.

	T:Prästmarschen
	S:efter »Florsen» i Burs.
	H:Då prästen kom till bröllopsgården, möttes han av spelmännen, \
	som »spelte in» honom med denna marsch.

#### Kompositör
Om en kompositör finns angiven i låtbeskrivningen ska denna kopieras till C-fältet. Kopiera namnet som det står, lägg inte till information. ()Om du vet t ex att L. i L. Lagergren står för Lars, kan detta anges i en kommentar till låten)

**Exempel:**

Av L. Lagergren, Likmide i Hemse, uppt. av samlaren såsom Lagergren spelat den.

	C:L. Lagergren
	S:Av L. Lagergren, Likmide i Hemse, uppt. av samlaren såsom \
	Lagergren spelat den.

Efter »Florsen» i Burs, som komponerat den.

	C:»Florsen» i Burs
	S:Efter »Florsen» i Burs, som komponerat den.

#### Geografiskt ursprung
Om en plats eller socken omnämns i låtbeskrivningen ska denna kopieras till O-fältet. Annars anges bara ”Gotland”. Denna princip är möjligen tvivelaktig, eftersom inget säger att en låt ”kommer från” Dalhem bara för att den återfanns i en notbok där. Det är dock lättare att ta bort denna information i efterhand än att lägga till den igen, så vi skjuter på beslutet till senare.

**Exempel:**

Efter »Florsen» i Burs.

	O:Gotland, Burs
	
Ur en handskriven notbok, tillhörig skolläraren S. P. Dalström, Hejde.

	O:Gotland, Hejde

#### Bisseringar
Då abc saknar symboler för bisseringar ska sådana passager istället skrivas ut två gånger. Inga kommentarer behöver göras för detta.

#### Reprisering
Många av låtarna i Gotlandstoner har en felaktig eller tvetydig reprisering, vanligt är t ex

	|: musik musik |1 halvslut :|2 helslut :|
	
Detta ska inte korrigeras, utan skrivas in som den står. Det är lätt att korrigera detta vid senare tillfälle, t ex gör MIDI-generatorn det automatiskt.

#### Balkning
Balkningen ska följa originalet, även där denna är inkonsekvent eller i allmänhet ful. Det är lätt att senare göra en ny automatisk ombalkning om man vill ha tydligare noter.

#### Förtecken
Tillfälliga förtecken ska enbart anges på de ställen där de står i originalet. Detta innebär normalt inga problem, då reglerna för tillfälliga förtecken är desamma i notskrift som i abc.

Det finns en bugg i MIDI-generatorn som gör att den ibland spelar fel intonation, fastän det är korrekt i abc-filen. Detta ska inte tas hänsyn till, men kan vara bra att känna till.

#### Ackord
Ackord ska skrivas med tonlängd och eventuella artikulationstecken utanför klamrarna:

	L[G,Ec]4
	
När arbetet med digitaliseringen inleddes 1999 fanns bara standardiserad abc i en mycket
primitiv version. Då var man tvungen att skriva

	[G,4E4Lc4]
	
En del låtar kan fortfarande innehålla denna gamla
ackordnotation och behöver därför uppdateras.

#### Omstämning
Vissa låtar har spelats på omstämd fiol. Ibland anges stämningen i låtbeskrivningen (t ex ”gsträngen
stämmes i a”), ibland anges omstämningen som noter före låtens första takt. I det förra fallet anges bara denna text i N-fältet, precis som den står:

	N:g-strängen stämmes i a

I det senare fallet läggs stämningen till som ett separat N-fält, efter de ordinarie låtbeskrivningsfälten. Man skriver då ”Stämning: ” följt av tonerna i fallande tonhöjdsordning, skilda av mellanslag:

	N:Stämning: e A D D,

Enligt gammal tradition är vissa av de omstämda låtarna noterade för att en fiolspelare van att spela efter noter ska kunna spela sina vanliga grepp, s.k. [*scordatura*](https://en.wikipedia.org/wiki/Scordatura). De omstämda strängarna är då alltså transponerade. I digitaliseringen gäller dock att *alla låtar ska noteras klingande!* Kommentarer i låtbeskrivningarna som hänvisar till scordatura-notskrift ska helt tas bort för att undvika förvirring.
