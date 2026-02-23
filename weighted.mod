#	--------------------------------------------------------------------------------------------------------------------------
#	Introdução à Otimização - BCC 342, 25.2
#	Autores:	Hebert Luiz Madeira Pascoal, 
#				Victor Xavier Costa
#	Data: 19/02/2026
#	
#	Modelo baseado em peso.
#
#	Artigo de referência:
#	https://www.scielo.br/j/pope/a/PSbGK4NMqmp96s6zdYrm4xF/?lang=en
#	--------------------------------------------------------------------------------------------------------------------------

# ----------
# Parâmetros
# ----------

# Conjunto de N comidas.
param N;
set Comidas := 1..N; # a.k.a., J.

# Energia.
param Calorias 		{ j in Comidas };
param MaxCalorias;
param MinCalorias;

# Orgânicos.
param Carboidratos	{ j in Comidas };
param Lipideos		{ j in Comidas };
param Proteinas		{ j in Comidas };
param Fibras		{ j in Comidas };

# Inorgânicos.
param Sodio			{ j in Comidas };
param Calcio		{ j in Comidas };
param Magnesio		{ j in Comidas };
param Fosforo		{ j in Comidas };
param Ferro			{ j in Comidas };
param Zinco			{ j in Comidas };

param MaxSodio;
param MinCalcio;
param MinMagnesio;
param MinFosforo;
param MinFerro;
param MinZinco;

param Penalidade{ j in Comidas } integer;
param PenalidadeMaxima;

# Percentual carbo-lipídeos.
param alpha;



# ---------
# Variáveis
# ---------

# Quantidade de cada comida.
var X{ j in Comidas } >= 0, integer;

# Energia (Calorias) E' = E^T X
var cal;
s.t. cal_def:
	cal = sum{ j in Comidas } Calorias[j] * X[j];

# Carboidratos... f1 = C^T X
var carb;
s.t. carb_def:
	carb = sum{ j in Comidas } Carboidratos[j] * X[j];

# Lipídeos f2 = L^T X
var lip;
s.t. lip_def:
	lip = sum{ j in Comidas } Lipideos[j] * X[j];

# Proteínas P' = P^T X
var prot;
s.t. prot_def:
	prot = sum{ j in Comidas } Proteinas[j] * X[j];

# Fíbras F' = F^T X
var fib;
s.t. fib_def:
	fib = sum{ j in Comidas } Fibras[j] * X[j];

param MinCarbo;
param MaxLip;
param MinProteinas;
param MaxProteinas;
param MinFibras;

# Sódio, Cálcio, Magnésio, Fósforo, Ferro e Zinco...
var sodium;		s.t. sod_def:	sodium		= sum{ j in Comidas } Sodio[j]		* X[j];
var calcium;	s.t. calc_def:	calcium		= sum{ j in Comidas } Calcio[j]		* X[j];
var magnesium;	s.t. mag_def:	magnesium	= sum{ j in Comidas } Magnesio[j]	* X[j];
var phosphorus;	s.t. phos_def:	phosphorus	= sum{ j in Comidas } Fosforo[j]	* X[j];
var iron;	s.t. iron_def:		iron		= sum{ j in Comidas } Ferro[j]		* X[j];
var zinc;	s.t. zinc_def:		zinc		= sum{ j in Comidas } Zinco[j]		* X[j];

# Penalidade.
var penalty { j in Comidas };
s.t. penalty_def { j in Comidas }:
	penalty[j] = Penalidade[j] * X[j];


#
#
#

# ---------------------
# Objetivo e restrições
# ---------------------

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
subject to rest_Penalidade { j in Comidas }:
	penalty[j] <= PenalidadeMaxima;


solve;
display X;
display carb, lip, F;


end;   0.000000000e+00 inf =   4.871e+02 (4)





