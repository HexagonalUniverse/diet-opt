#	--------------------------------------------------------------------------------------------------------------------------
#	Introdução à Otimização - BCC 342, 25.2
#	Autores:	Hebert Luiz Madeira Pascoal, 
#			Victor Xavier Costa
#	Data: 19/02/2026
#	
#	Artigo de referência:
#	https://www.scielo.br/j/pope/a/PSbGK4NMqmp96s6zdYrm4xF/?lang=en
#	--------------------------------------------------------------------------------------------------------------------------


# --------------
# Parâmetros
# --------------

# Conjunto de N comidas.
param N;
set Comidas := 1..N; # a.k.a., J.

# Energia.
param Calorias 		{j in Comidas};
param MaxCalorias;
param MinCalorias;

# Orgânicos.
param Carboidratos	{j in Comidas};
param Lipideos		{j in Comidas};
param Proteinas		{j in Comidas};
param Fibras		{j in Comidas};

# Inorgânicos.
param Sodio			{j in Comidas};
param Calcio		{j in Comidas};
param Magnesio		{j in Comidas};
param Fosforo		{j in Comidas};
param Ferro			{j in Comidas};
param Zinco			{j in Comidas};

param MaxSodio;
param MinCalcio;
param MinMagnesio;
param MinFosforo;
param MinFerro;
param MinZinco;

param Penalidade{j in Comidas} integer;
param PenalidadeMaxima;

# Percentual carbo-lipídeos.
param alpha;


# -----------
# Variáveis
# -----------

# Quantidade de cada comida.
var X{j in Comidas} >= 0;

# Energia (Calorias) E' = E^T X
var cal;
s.t. cal_def:
	cal = sum{j in Comidas} Calorias[j] * X[j];

# Carboidratos... f1 = C^T X
var carb;
s.t. carb_def:
	carb = sum{j in Comidas} Carboidratos[j] * X[j];

# Lipídeos f2 = L^T X
var lip;
s.t. lip_def:
	lip = sum{j in Comidas} Lipideos[j] * X[j];

# Proteínas P' = P^T X
var prot;
s.t. prot_def:
	prot = sum{j in Comidas} Proteinas[j] * X[j];

# Fíbras F' = F^T X
var fib;
s.t. fib_def:
	fib = sum{j in Comidas} Fibras[j] * X[j];

param MinCarbo;
param MaxLip;
param MinProteinas;
param MaxProteinas;
param MinFibras;

# Sódio, Cálcio, Magnésio, Fósforo, Ferro e Zinco...
var sodium;		s.t. sod_def:	sodium		= sum{j in Comidas} Sodio[j]	* X[j];
var calcium;	s.t. calc_def:	calcium		= sum{j in Comidas} Calcio[j]	* X[j];
var magnesium;	s.t. mag_def:	magnesium	= sum{j in Comidas} Magnesio[j]	* X[j];
var phosphorus;	s.t. phos_def:	phosphorus	= sum{j in Comidas} Fosforo[j]	* X[j];
var iron;	s.t. iron_def:		iron		= sum{j in Comidas} Ferro[j]	* X[j];
var zinc;	s.t. zinc_def:		zinc		= sum{j in Comidas} Zinco[j]	* X[j];

# Penalidade.
var penalty;
s.t. penalty_def:
	penalty = sum{j in Comidas} Penalidade[j] * X[j];


# -------------------------
# Objetivo e restrições
# -------------------------

minimize F: 
	alpha * carb + (1 - alpha) * lip;

subject to rest_MinCalorias:	cal		>= MinCalorias;
subject to rest_MaxCalorias:	cal		<= MaxCalorias;

# Restrições de orgânicos
subject to rest_MinCarbo:		carb	>= MinCarbo;
subject to rest_MaxLip:			lip		<= MaxLip;
subject to rest_MinProteinas:	prot	>= MinProteinas;
subject to rest_MaxProteinas:	prot	<= MaxProteinas;
subject to rest_MinFibras:		fib		>= MinFibras;

# Restrições de minerais
subject to rest_MaxSodio:		sodium		<= MaxSodio;
subject to rest_MinCalcio:		calcium		>= MinCalcio;
subject to rest_MinMagnesio:	magnesium	>= MinMagnesio;
subject to rest_MinFosforo:		phosphorus	>= MinFosforo;
subject to rest_MinFerro:		iron		>= MinFerro;
subject to rest_MinZinco:		zinc		>= MinZinco;

# Restrição de penalidade de comida.
subject to rest_Penalidade:
	penalty <= PenalidadeMaxima;



solve;
display X;
display carb, lip, F;






# ----------------
# Dados fictícios
# ----------------
data;


param N := 5;

param Calorias :=
1 250
2 180
3 320
4 150
5 400 ;

param Carboidratos :=
1 30
2 15
3 50
4 20
5 60 ;

param Lipideos :=
1 10
2 5
3 8
4 3
5 20 ;

param Proteinas :=
1 12
2 8
3 20
4 5
5 25 ;

param Fibras :=
1 4
2 3
3 6
4 2
5 7 ;

param Sodio :=
1 200
2 150
3 300
4 100
5 500 ;

param Calcio :=
1 100
2 80
3 120
4 60
5 150 ;

param Magnesio :=
1 40
2 30
3 50
4 20
5 60 ;

param Fosforo :=
1 90
2 70
3 110
4 50
5 140 ;

param Ferro :=
1 5
2 3
3 6
4 2
5 8 ;

param Zinco :=
1 2
2 1
3 3
4 1
5 4 ;

param MaxSodio := 1500;
param MinCalcio := 500;
param MinMagnesio := 200;
param MinFosforo := 400;
param MinFerro := 18;
param MinZinco := 10;

param alpha := 0.6;
param PenalidadeMaxima := 100;

param Penalidade :=
1  2
2  1
3  4
4  1
5  5 ;

param MinCarbo := 250;
param MaxLip := 120;
param MinProteinas := 70;
param MaxProteinas := 200;
param MinFibras := 25;
param MinCalorias := 2000;
param MaxCalorias := 2800;


end;   0.000000000e+00 inf =   4.871e+02 (4)





