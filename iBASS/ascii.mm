/*
 * Copyright (C) 2009 Revolution Software Ltd.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 */

#import "ascii.h"
#include "sky.h"
#include "skydefs.h"



@implementation ascii


NSString *ptASCII[]=
{

//RECYCLING PLANT
// For 'elevator' see ref line 187
	@"A Saída de Emergência está trancada – como é que a abro?", //1000
// See line 1050 I've out-foxed the guard - what now?
	@"Quem me dera que o Joey estivesse comigo – o que devo fazer?", //1001
	@"Como é que faço o elevador funcionar?", //1002
	@"Como é que desço pelo poço do elevador?", //1003
// For 'furnace' see ref line 4221
	@"Como é que saio da sala da fornalha?", //1004


//INDUSTRIAL 1 
// For 'welder' see ref line 8369
	@"Tenho que desactivar o robot soldador. Ajuda!", //1005
	@"Como é que arranjo a armação da máquina de soldar?", //1006
	@"Como é que entro no armazém?", //1007
// For 'storeroom' see ref line 9212/9221
	@"Como é que evito que as coisas que tiro do armazém sejam confiscadas?", //1008
	@"Como é que me livro do homem na sala de energia?", //1009
	@"Como é que restauro a energia?", //1010
// This is a lift elevator - ref 9379
	@"Como é que posso usar aquele elevador?", //1011

//BELLEVUE 1 
// For 'travel agent' see ref line 12698
	@"Como é que consigo um bilhete do agente de viagens?", //1012
// For 'ticket' see ref line 12727
	@"O que faço com este bilhete?", //1013

//INDUSTRIAL 2 
	@"Lamb tem o meu bilhete – e agora?", //1014

//BELLEVUE 2 
// For 'surgery' see ref line 270
	@"Como é que entro na cirurgia?", //1015
	@"Como é que arranjo uma porta Schriebmann?", //1016
// For 'anchor' see ref line 539. Please note that anchor refers to the object, and is also the name of the travel agent. 
	@"Como é que arranjo aquela âncora?", //1017
	@"Tenho a âncora – e agora?", //1018

//INDUSTRIAL 3 
	@"O que faço com este gancho?", //1019
// For 'grappling hook' see ref line 320

//SECURITY CENTRE 
// For 'security HQ' see ref line 9018
	@"Estou no Quartel General da Segurança. E a seguir?", //1020

//LINC 1 
	@"Estou preso no mundo LINC – o que devo fazer?", //1021
	@"Estou num ciberlabirinto – como é que saio daqui?", //1022
	@"Já saí do ciberlabirinto – e agora?", //1023

//SECURITY CENTRE 
	@"Como é que saio do espaço LINC?", //1024

//HYDE PARK 
	@"Cheguei ao nível do solo. O que devo fazer agora?", //1025
// For 'dog buscuits' see ref line 198
	@"Como é arranjo esses biscoitos para cão?", //1026
	@"Como é que passo pelo segurança?", //1027
	@"Estou na catedral – e agora?", //1028
	@"A Anita foi assassinada. O que devo fazer agora?", //1029

//LINC 2 
	@"Tenho o cartão da Anita – talvez ela tenha deixado algumas pistas.", //1030

//HYDE PARK 2 
	@"Li a mensagem da Anita – como é que entro em contacto com o Eduardo?", //1031
	@"Entrei em contacto com o Eduardo. E a seguir?", //1032
// This is a drinking glass
	@"Tenho o copo do Colston, mas porquê?", //1033

//HYDE PARK 3 
	@"Como é que passo para o metropolitano?", //1034
// For 'subway' see ref line 16525
	@"Fiz um buraco na grelha – como é que alargo o buraco?", //1035
	@"Fiz um buraco na grelha – e agora?", //1036
// For 'grill' see ref line 17376

//UNDERWORLD 
	@"Está uma criatura a agarrar-me – como é que evito isto?", //1037
	@"Como é que passo pela porta de metal grande?", //1038
	@"Existe um poço estranho – o que faço com isto?", //1039
	@"O que faço eu neste estranho submundo?", //1040
	@"Como é que passamos pelo andróide no laboratório?", //1041
	@"Matei o andróide. E a seguir?", //1042
// For 'android' see ref line 20607
	@"Anita falou de um vírus – como é que o arranjo?", //1043
// For 'virus' see ref line 24591

//LINC 3 
	@"Voltei ao LINC – como é que arranjo o vírus?", //1044

//UNDERWORLD 
	@"Pobre Joey – como é que o ressuscito? Outra vez!", //1045
	@"Transformei o Joey num andróide. O que faço com ele?", //1046
	@"Já tenho o vírus do LINC – como é que o levo para o mundo real?", //1047
	@"Tenho tecido infectado – e agora?", //1048
// For 'tissue' (biological tissue) see ref line 20633/20634
	@"Encontrei o meu próprio pai – como é que salvo a humanidade?", //1049

//RECYCLING PLANT 1 
	@"Dei a volta ao guarda – e agora?", //1050

//INDUSTRIAL 1 
	@"Estou numa área industrial. O que devo fazer?", //1051
	@"Encontrei uma substância parecida com explosivo plástico – mas e agora?", //1052
// For 'putty' see ref line 168
	@"Atribuí a mim próprio estatuto de segurança especial no LINC – e agora?", //1053
// For 'status' see ref line 89


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//CONTROLS HELP Subjects - should fit with the Text Box constraints specified above
	@"Interface de utilizador e controlos do jogo – ajuda!", //1054
	@"Instruções de Inventário", //1055
	@"Walkthrough do primeiro ecrã", //1056

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//HINT ANSWERS
// No particular constraints on text length - but please not too much longer than English
//------------
	@"Pegue no ferro no topo das escadas à esquerda do cavalete.", //1057
// Reference 4295 for term 'rung', 4177 for 'fire door'
	@"Abra o seu inventário e use o ferro da porta de incêndio para o abrir. Veja “Walkthrough do Primeiro Ecrã” para explicações detalhadas. ", //1058
//1
// Reference 4194 for term used for 'robot shell', 4546 for 'junk'
	@"Examine o lixo no primeiro plano para descobrir a armação de robot.", //1059
// Reference 16586 for term for 'circuit board', 4185 for 'robot shell'
	@"Use a placa de circuitos da armação de robot.", //1060
//2
	@"Examine o robot transportador.", //1061
// Reference 4426, 4337 for transport robot / droid
	@"Fale com Hobbins até lhe poder perguntar sobre o robot transportador – e ele lhe dizer o que há de errado.", //1062
	@"Peça ao Joey para iniciar o robot transportador (antes, poderá ter que falar com ele de forma simpática sobre uma série de assuntos).", //1063
//3
	@"Quando o elevador descer, desça rapidamente pelo poço.", //1064
//4
	@"Examine a tranca da porta.", //1065
	@"Quando o Joey chegar, peça-lhe para abrir a porta.", //1066

//INDUSTRIAL 1 
//5
	@" Tem que \"arranjar trabalho para a chave-inglesa\".", //1067
	@"Encontrou a chave-inglesa na oficina de Hobbins? Caso não tenha, volte à oficina de Hobbins, abra o armário e pegue na chave-inglesa.", //1068
	@"Volte à linha de produção – no compartimento depois do robot soldador verá algumas engrenagens.", //1069
	@"Se ainda não o fez, fale com Anita e depois com Lamb até este ir embora. Depois atire a chave-inglesa para as engrenagens.", //1070
//6
	@"Tire a chave-inglesa das rodas dentadas.", //1071
	@"Use a chave-inglesa no robot soldador.", //1072
	@"Fale com Joey e ofereça-lhe uma nova armação.", //1073
//7
	@"Tente entrar no armazém.", //1074
	@"Diga ao Joey para inspeccionar o armazém. Quando ele disser que encontrou a caixa de fusíveis, diga-lhe para a desactivar.", //1075
//8
	@"Levante a prancha do chão.", //1076
	@"Pegue no explosivo plástico que estava por baixo da prancha. Este é o único objecto que pode guardar depois de ir embora.", //1077
//9
	@"Use a chave-inglesa em cada um dos dois botões por baixo dos tubos à direita.", //1078
	@"Diga ao Joey para pressionar o botão da direita, depois pressione o outro ao mesmo tempo.", //1079
//10
	@"Desligue o interruptor no painel de controlo à esquerda.", //1080
	@"Remova a lâmpada.", //1081
	@"Coloque o explosivo plástico no casquilho.", //1082
	@"Volte a ligar o interruptor.", //1083
	@"Empurre o interruptor da direita para baixo para restaurar a energia do elevador.", //1084
//11
	@"Examine o cadáver de Reich na sala da fornalha para descobrir a sua Identidade.", //1085
	@"Use o cartão de Identificação de Reich na ranhura do elevador.", //1086

//BELLEVUE 1 
//12
	@"Vá até ao apartamento de Reich e levante a almofada para descobrir uma revista de motociclismo.", //1087
	@"Vá ao agente de viagens e pergunte-lhe sobre as viagens.", //1088
	@"Peça a viagem económica.", //1089
	@"Dê-lhe a revista de motociclismo em troca de um bilhete de viagem.", //1090
//13
	@"Dê o bilhete a Lamb para ser convidado para uma viagem à fábrica de tubos.", //1091

//INDUSTRIAL 2 
//14
	@"Pergunte ao Lamb sobre a viagem – ele irá embora quando vir que o tapete transportador parou.", //1092
	@"Fale com Anita.", //1093
	@"Eventualmente, ela oferecer-lhe-á um “jammer” – dê-lhe a identificação de Reich.", //1094
// A jammer is hacking software - see ref 8639
	@"Continue a falar para saber mais coisas sobre a porta Schriebmann.", //1095

//BELLEVUE 2 
//15
	@"Fale com a recepcionista da cirurgia clicando no projector.", //1096
	@"Pergunte por uma porta Schriebmann.", //1097
	@"Peça ao Joey para falar com a recepcionista para poder entrar na cirurgia.", //1098
//16
	@"Fale com Burke até conseguir uma oferta para ajustar uma porta Schriebmann.", //1099
//17
	@"Após a operação, continue a falar com Burke para saber mais sobre a \"política especial\" de Anchor.", //1100
	@"Visite Anchor no escritório da seguradora e mencione o nome de Burke para o fazer sair da sala.", //1101
	@"Peça ao Joey para tirar a âncora da estátua.", //1102
	@"Pegue na âncora depois do Joey derreter o braço da estátua.", //1103
//18
	@"Se não tiver, agora é um bom momento para arranjar o cabo pendurado do nível Industrial.", //1104
	@"Peça ao Joey para cortar o cabo – saia da frente dele.", //1105
	@"Pegue no cabo que caiu para o nível Belle Vue.", //1106
	@"Use a âncora no cabo para criar um gancho.", //1107

//INDUSTRIAL 3 
//19
	@"Vá até à porta de incêndio na fábrica de reciclagem de Hobbins e caminhe pelo peitoril.", //1108
	@"Use o gancho no sinal de segurança na parede oposta. ", //1109

//SECURITY CENTRE 
//20
	@"No Quartel General da Segurança, use o cartão de Identificação na ranhura e sente-se.", //1110

//LINC 1 
//21
// These are all specific software package names - please refer to original text files so they match
	@"Pegue na bola (dados comprimidos) na área 1. ", //1111
	@"Vá directo à área 2 e use abrir (no inventário) na bolsa.", //1112
	@"Receba a surpresa de aniversário (descomprimir). Use descomprimido em dados comprimidos (em inventário). ", //1113
	@"Arranje uma lupa (descodificar) e use-a em report doc e briefing.doc (em inventário).", //1114
//22
// This is describing squares on a 3 * 3 grid
	@"Use a password verde na coluna inferior/ladrilho esquerdo. Use a password vermelha na coluna inferior/ladrilho central.", //1115
	@"Pegue na password verde e use na coluna do meio/ladrilho esquerdo.", //1116
	@"Pegue na password vermelha e use no ladrilho central.", //1117
	@"Pegue na password verde e use na coluna inferior/ladrilho direito.", //1118
//23
	@"Arranje o livro (phoenix.doc).", //1119
	@"Use descodificação no phoenix.doc.", //1120
	@"Pegue no busto (programa phoenix).", //1121
	@"Desligue do LINC.", //1122

//SECURITY CENTRE 
//24
	@"Use o cartão de Identificação no terminal LINC.", //1123
	@"Seleccione “Serviços de Segurança”. Seleccione “ver documentos”", //1124
	@"Leia cada documento. Repare que estes têm que ter sido descodificados no espaço LINC.", //1125
	@"Seleccione “operações especiais”. Seleccione “pedir estatuto especial”.", //1126
	@"Seleccionar “ajuste de ficheiro” para D-LINC Lamb.", //1127

//HYDE PARK 
//25
	@"Fale com Henri, o segurança, para descobrir o patrocínio para o clube.", //1128
	@"Fale com Danielle para voltar a ser convidado para o apartamento dela.", //1129
	@"Volte ao Apartamento de Danielle.", //1130
//26
	@"Vai precisar do vídeo dos gatos do apartamento de Lamb.", //1131
	@"Lamb D-LINC de “ajuste de ficheiro” no terminal LINC e depois fale com ele. ", //1132
	@"Enquanto a Danielle estiver ao telefone, reproduza o vídeo. ", //1133
	@"Quando o cão estiver distraído, pegue nos biscoitos para cão.  ", //1134
//27
	@"Vá até ao baloiço ao pé do lago e use os biscoitos de cão na prancha.", //1135
	@"Quando o cão estiver perto, puxe a corda.  ", //1136
	@"Quando o cão estiver na prancha, liberte a corda.  ", //1137
//28
	@"Explore as trancas no nível inferior – até descobrir a terrível verdade.", //1138
//29
	@"Volte ao reactor na fábrica e vista o fato de radiação.", //1139
	@"Vá ao terminal e abra o reactor. Lá dentro, pegue no cartão de Identificação de Anita.", //1140
	@"Volte atrás pelo edifício da Segurança.", //1141
	@"Entre no LINC usando o cartão de Anita.", //1142

//LINC 2 
//30
	@"Use “cegar” no olho na área 2.", //1143
	@"Use “playback” no projector holográfico (“poço”) para ver a mensagem de Anita.", //1144
	@"Desligue do LINC.", //1145

//HYDE PARK 2 
//31
	@"Volte a Hyde Park. ", //1146
	@"Fale com Vincent para saber coisas sobre o jardineiro.", //1147
	@"Fale com o jardineiro até ele lhe falar no vírus.", //1148
//32
	@"Entre no tribunal para assistir ao julgamento de Hobbins.", //1149
	@"Vá para o clube.", //1150
	@"Seleccione “Você procura, mas não encontra nada” na jukebox.", //1151
	@"Pegue no copo de Colston quando ele não estiver na mesa.  ", //1152
//33
	@"Dê o copo a Burke para tirar impressões digitais.", //1153

//HYDE PARK 3 
//34
	@"Toque na placa para abrir a porta da adega.", //1154
	@"Use a alavanca na caixa grande à esquerda.", //1155
	@"Pegue na tampa e use-a na caixa mais pequena.", //1156
	@"Suba para cima da caixa.", //1157
	@"Use a alavanca na grelha.", //1158
//35
	@"Se não encontrou a tesoura de podar, então vá à barraca no parque.  ", //1159
	@"Olhe para a porta.", //1160
	@"Use o cartão de identificação na tranca.", //1161
	@"Entre na barraca e pegue na tesoura de podar.", //1162
//36
	@"Use a tesoura de podar na grelha.", //1163
	@"Trepe pela grelha.", //1164

//UNDERWORLD 
//37
	@"Use a lâmpada no suporte à esquerda do orifício da criatura.", //1165
//38
	@"Use a alavanca no plástico estaladiço, depois novamente na parede de tijolo para obter um tijolo.", //1166
	@"-", //1167
	@"Use a barra de metal no coágulo na veia.", //1168
	@"Use o tijolo na barra de metal para fazer o buraco no coágulo.", //1169
	@"Espere até o robot médico chegar para reparar a abertura, depois saia pela porta da direita.", //1170
//39
	@"Ponha a tampa no poço usando o terminal junto ao poço.", //1171
	@"Suba para cima da tampa do poço.", //1172
	@"Puxe a barra de retenção da grelha por cima da sua cabeça para soltar a grelha.", //1173
	@"Volte à sala de cima.", //1174
//40
	@"Olhe pelas grelhas para detectar algum perigo iminente.", //1175
	@"Olhe pela primeira grelha que encontre.", //1176
	@"Entre na sala onde o robot médico está a recarregar. ", //1177
	@"Use a placa de circuitos no robot médico.", //1178
//41
	@"Fale com Joey e envie-o para a sala do reservatório.", //1179
	@"Pergunte ao Joey o que ele viu na sala do reservatório.", //1180
	@"Pergunte ao Joey sobre o reservatório.", //1181
	@"Diga ao Joey para abrir a torneira.", //1182
	@"Entre na sala do reservatório e observe o andróide a mergulhar para a sua própria morte.", //1183
//42
	@"Caminhe para a direita dos reservatórios, para a sala do computador. ", //1184
	@"Use o cartão de identificação de Reich no terminal (à esquerda do banco de computadores). ", //1185
	@"Abra a porta de acesso.", //1186
	@"Deixe a sala do computador e veja o Joey ser destruído novamente.", //1187
	@"Pegue no cartão de Gallagher dos seus vestígios.", //1188
//43
	@"Volte à sala do computador.", //1189
	@"Entre no LINC usando o cartão de Gallagher.", //1190
//44
	@"Terá que entrar no LINC usando o cartão de Gallagher. Desista e volte novamente.", //1191
	@"Use cegar no olho na área 1. Vá rapidamente para a área 2 e cegue o olho.", //1192
	@"Pegue no oscilador (diapasão).", //1193
	@"Vá para a sala do Cruzado. Use “cólera divina” para remover o Cruzado.", //1194
	@"Entre na sala cristal. Use o oscilador no cristal.", //1195
	@"Pegue no vírus. Desligue de LINC.", //1196
//45
	@"Vá para a sala do andróide especial. Abra a mesa-de-cabeceira na consola do meio.", //1197
	@"Introduza a placa de circuitos na mesa-de-cabeceira.", //1198
	@"Use o monitor para carregar os dados da placa.", //1199
	@"Corra o programa de arranque do andróide.", //1200
//46
	@"Vá directo à sala com os reservatórios grandes. ", //1201
	@"Peça ao Joey/Ken para colocar a mão no painel da porta.", //1202
	@"Coloque a sua própria mão no painel da porta.", //1203
//47
	@"Vá para o reservatório de amostras de tecido e pegue nas pinças da parede (à direita do tanque).", //1204
	@"Use o cartão de Gallagher (ou qualquer outro que contenha o vírus) na consola para infectar o tecido com o vírus. ", //1205
	@"Remova uma amostra de tecido infectado com as pinças. ", //1206
	@"Coloque a amostra de tecido no reservatório de nitrogénio para congelar. ", //1207
//48
	@"Vá até ao fim dos tubos. Fixe o cabo ao suporte do tubo.", //1208
	@"Use as travessas de metal para descer até ao orifício de alimentação.", //1209
	@"Deite o tecido infectado pelo orifício.", //1210
	@"Use a corda pendurada para balançar até à última sala. ", //1211
//49
	@"Quando o Joey/Ken entrar, diga-lhe para se sentar na cadeira.", //1212

// Missing answers added later

//RECYCLING PLANT 1 
//50
	@"Explore a fábrica. Talvez consiga pôr o Joey a funcionar novamente.", //1213

//INDUSTRIAL 1 
//51
	@"Dê uma vista de olhos – deve haver alguém por ali que o possa ajudar.", //1214
//52
	@"Explore mais – há mais coisas para descobrir.", //1215
	@"Apanhe no elevador para o nível inferior e depois apanhe o próximo elevador para o nível do solo.", //1216

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//User Interface and game controls - Help!  (no constraints on text length on these four lines)
	@"Movimentar-se pelo ambiente", //1217
	@"Penetre num ponto na área do piso e Foster irá para lá – se conseguir. Para abandonar uma área, terá que interagir com o ícone da seta de saída.", //1218
	@"Interagir com o ambiente", //1219
	@"Deslize o seu dedo pelo ecrã do jogo para encontrar áreas de interesse (hotspots). Aparecerão círculos azuis animados sobre os hotspots quando os seus dedos passarem perto deles. Passe o seu dedo por cima do círculo azul e serão exibidos ícones de acção para indicar quais as acções que Foster consegue executar. Para executar essa acção, levante o dedo e toque no ícone específico.", //1220
//1268 Increasing the time before going into sleep mode
//1270 To increase the time before your device goes into sleep mode, go to your iPhone 'Settings', then 'General', then 'Auto-Lock'. Choose the desired time setting.  

	@"LINHA DUMMY", //1221

//Inventory Instructions  (no constraints on text length on these four lines)
	@"O inventário – o que é?", //1222
	@"Itens que Foster apanha vão para o “inventário”.  Bata no ícone arca para ver os itens do inventário. Bata num item para obter uma descrição do mesmo.", //1223
	@"Como usar um item do inventário em objectos e pessoas no fundo", //1224
	@"Abra o inventário e pressione um item durante alguns momentos até que o mesmo apareça por cima do seu dedo. Ao mesmo tempo que continua a pressionar o ecrã, arraste o item sobre um hotspot e liberte-o quando ficar realçado com um contorno azul.", //1225
	@"Combinar itens do inventário", //1226
	@"Por vezes, terá que combinar dois itens do inventário para criar um terceiro item. Para fazer isto, seleccione o primeiro item pressionando-o durante alguns momentos até que apareça por cima do seu dedo. Agora arraste o item para o segundo item – liberte-o quando ambos estiverem realçados com um contorno azul. ", //1227


//First Screen Walkthrough (no constraints on text length on these four lines)
	@"Walkthrough para que Foster abra a porta de incêndio.", //1228
	@"Passe o seu dedo por cima da travessa que se encontra no lado esquerdo do ecrã. Um círculo azul ficará animado por cima da travessa à medida que se aproxima. Quando o seu dedo estiver em cima da travessa, irão aparecer dois ícones – rodas dentadas a girar (interagir) e um olho a piscar (examinar) e a palavra “travessa de metal” aparece no topo do ecrã. Levante o dedo e bata nas rodas dentadas. As rodas dentadas vão piscar e Foster irá caminhar para a travessa de metal e puxá-la. Ele irá automaticamente colocar a travessa de metal no seu inventário – onde surgirá como “Barra de Metal”.", //1229
	@"LINHA APAGADA", //1230
	@"Abra o inventário batendo no ícone da caixa. Pressione o ícone da barra de metal até que apareça por cima do seu dedo com um contorno azul, depois arraste-o para a porta de incêndio até o seu dedo ficar por cima do círculo azul e aparecer “Porta” no topo do ecrã, depois levante o seu dedo. Foster irá agora usar a barra de metal para abrir a porta de incêndio. Foster irá embora automaticamente. Boa sorte!", //1231

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Twitter Stuff

//twitter test message
	@"Enviar mensagem de texto - “Comecei mesmo agora a jogar Beneath a Stell Sky no iPhone/iPod touch! Tenha Cuidado.”", //1232

//twitter info
	@"Existem várias interacções especiais escondidas pelo jogo para descobrir. Configure os seus detalhes do twitter para que Beneath a Steel Sky possa colocar comentários no twitter à medida que as descobrir.", //1233

//tweets
	@"Comecei mesmo agora a jogar Beneath a Stell Sky no iPhone/iPod touch. Tenha Cuidado!", //1234
	@"Tweet enviado!", //1235
	@"Não foi possível enviar tweet - possível problema de ligação.", //1236
	@"Não foi possível enviar tweet – por favor, verifique nome de utilizador / password.", //1237
	@" A andar de um lado para o outro no Beneath a Steel Sky. Acabei de chamar salsicha ao Hobbins – não percebo porque haveria de o querer, mas afinal isto é uma aventura…", //1238
	@" Apanhei o difícil vídeo dos gatos de Lamb no Beneath a Steel Sky. Não confio nem um bocadinho no tipo.", //1239
	@" Escapei aos avanços amorosos de Danielle Piermont no Beneath a Steel Sky. Mergulhei o barulhento do rafeiro dela num lago – ainda bem que sabe nadar.", //1240
	@"Acabei de rebentar um vaso sanguíneo de um computador de segurança no Beneath a Steel Sky. Esta coisa sangra. Nojento!", //1241
	@"Acabei o Beneath a Steel Sky no iPhone/iPod touch e salvei o mundo.", //1242

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// General Messages

//new game alert
	@"Se a qualquer momento precisar de ajuda com os controlos ou quiser dicas então bata no ícone com o ponto de interrogação azul.", //1243

//various misc
	@"Falar", //1244
	@"Legendas ", //1245
	@"Nome de utilizador", //1246
	@"Password", //1247
	@"Não usado", //1248
	@"Sem nome", //1249
	@"Jogo Guardado", //1250
	@"Dados do jogo guardados com êxito", //1251
	@"Guardar Jogo Falhou!", //1252
	@"Dados do jogo NÃO guardados com êxito", //1253
	@"Dica %d de %d", //1254
	@"Ajuda dos controlos e dicas do puzzle.", //1255
	@"OK", //1256
	@"Idioma do Texto", //1257
	@"Nome de utilizador", //1358
	@"Password", //1359

// Tell a friend email:
	@"Uma mensagem de “Beneath a Steel Sky”.", //1260
	@"Ei!", //1261
	@"Estou a jogar a aventura clássica “Beneath a Stell Sky”, modernizada e actualizada exclusivamente para iPhone e iPod touch.", //1262
	@"Considerado em tempos uma das melhores aventuras jamais escritas, o jogo inclui agora novos espantosos filmes animados de Dave Gibbons, co-criador de “Watchmen”, um sistema de ajuda sensível ao contexto, uma nova interface de toque especial, áudio melhorado e – bem, montes de material fixe.", //1253
	@"Como sou uma pessoa maravilhosa e preocupada, queria partilhar isto convosco. Basta clicar neste link para verem mais sobre o jogo. http://www.revolution.co.uk/appstoreBASS", //1264
	@"Dêem uma vista de olhos! Tenha Cuidado.", //1265

	@"Postar no Twitter", //1266

// Added lines in Controls re sleep mode
	@"Aumentar o tempo antes de entrar no modo de suspensão.", //1267
	@"Para aumentar o tempo antes do seu aparelho entrar no modo de suspensão, aceda a “Settings” (Definições) do seu iPhone', seguido de “General” (Geral), e por fim “Auto-Lock” (Bloqueio automático). Escolha o tempo desejado.  ", //1268


// Intro Text
	@"Foster voz em “off”: O velho estava a tentar adivinhar o futuro. A procurar imagens na fogueira…", //1400
	@"Xamã: Oh, vejo o mal…", //1401
	@"Xamã: Mal que vem debaixo da cidade... longe da luz do dia.", //1402
	@"Xamã: Vejo-o a crescer, seguro por baixo de um céu de aço...", //1403
	@"Xamã: A congeminar no escuro…ganhar força.", //1404
	@"Xamã: E agora… oh… agora o mal espalha-se…", //1405
	@"Xamã: Envia tentáculos mortais para a terra acima...", //1406
	@"Xamã: Através da fenda…alcançado este lugar!", //1407
	@"Foster voz em “off”: Já o tinha visto fazê-lo centenas de vezes, mas segui-o.", //1408
	@"Foster voz em “off”: Afinal de contas, ele tinha sido como um pai para mim.", //1409
	@"Foster: E o que quer este mal aqui?", //1410
	@"Xamã: Oh, meu filho. Receio…", //1411
	@"Xamã: Receio que o mal te queira a ti!", //1412
	@"Foster voz em “off”: Isso foi quando o Joey falou…", //1413
	@"Joey: Foster! Os sensores detectam uma fonte de áudio!", //1414
	@"Xamã: O mal! O mal está quase aqui…!", //1415
	@"Foster voz em “off”: Parecia mais um helicóptero do que um demónio.", //1416
	@"Foster voz em “off”: Mas a seguir, todo o inferno está à solta de qualquer maneira…", //1417
	@"Xamã: Corre Foster! Corre! Esconde-te do mal!", //1418
	@"Joey: Foster! (zzzt) H-Ajuda!", //1419
	@"Joey: É melhor (zzzt) tornar o meu (zzzt) próximo movimento corporal (zzzt) mais rápido...", //1420
	@"Foster voz em “off”: Ele era apenas um robot, mas eu gostava do tipinho.", //1421
	@"Foster voz em “off”: Então, tão rapidamente como começou, o tiroteio parou.", //1422
	@"Foster voz em “off”: Houve um momento de silêncio quando o helicóptero cortou os seus rotores, depois...", //1423
	@"Reich: Quem manda aqui que avance…", //1424
	@"Foster voz em “off”: Só um louco teria argumentado com aquele poder de fogo.", //1426
	@"Xamã: ... Sou o líder destas pessoas…", //1427
	@"Xamã: Somos pacíficos…", //1428
	@"Reich: Tragam-no até aqui.", //1429
	@"Soldado: Imediatamente, Comandante Reich.", //1430
	@"Reich: Andamos à procura de alguém…", //1431
	@"Reich: Alguém que não pertence aqui…", //1432
	@"Reich: Que não nasceu nesta lixeira…", //1433
	@"Reich: Que veio da cidade em criança...", //1434
	@"Reich: Queremos levá-lo de volta para casa.", //1435
	@"Foster voz em “off”: A minha mente estava a mil, lembrei-me de onde tinha visto aquele símbolo antes…", //1436
	@"Foster voz em “off”: Foi no dia em que a tribo me encontrou…", //1437
	@"Foster voz em “off”: O dia do acidente…", //1438
	@"Foster voz em “off”: O dia do em que a minha mãe morreu.", //1439

	@"Homem da tribo: Estás bem, rapaz da cidade?", //1440
	@"Xamã: Tens nome, filho?", //1441
	@"Foster: R-Robert.", //1442
	@"Xamã: Ah! Bem-vindo à Fenda, Robert!", //1443
	@"Foster voz em “off”: À medida que me arranjava, o velho homem tinha explicado gentilmente que não havia caminho de volta para a Cidade…", //1445
	@"Foster voz em “off”: E eu já sabia que ele nada podia fazer pela minha mãe.", //1446
	@"Foster voz em “off”: A sua tribo era pobre, mas trataram-me como um deles...", //1447
	@"Foster voz em “off”: Aprendi a sobreviver nos baldios a que eles chamavam a Fenda...", //1448
	@"Foster voz em “off”: E a remexer nas lixeiras da Cidade.", //1449
	@"Foster voz em “off”: À medida que os anos passaram, esqueci a minha vida na Cidade.", //1450
	@"Foster voz em “off”: Descobri novos talentos…", //1451

	@"Joey: Sou teu (zzzt) amigo... chama-me (zzzt) Joey.", //1453
	@"Foster voz em “off”: E tenho um segundo nome.", //1454
	@"Xamã: É assim que te vamos chamar agora que és maior, filho.", //1455
	@"Xamã: Encontrámos-te… adoptámos-te……", //1456
	@"Xamã: Por isso és Robert Foster.", //1457
	@"Reich: …Já perdemos muito tempo!", //1458
	@"Reich: Apontem a saída ou matamos toda a gente…", //1459
	@"Reich: A começar por ti, avô!", //1460
	@"Foster voz em “off”: O velho estava certo, pelo menos uma vez…", //1461
	@"Foster voz em “off”: Era a mim que eles queriam.", //1462
	@"Xamã: Não, meu filho! Não deixes que o mal te apanhe! Foge!", //1463
	@"O scanner de ADN confirma que é ele, senhor.", //1464
	@"Foster voz em “off”: O mal tinha chegado à Fenda, tal como ele dissera.", //1465

	@"Reich: Levem-no.", //1466
	@"Foster voz em “off”: Mas o velho tinha visto porque me queriam?", //1467
	@"Foster voz em “off”: Ou o que iam fazer a seguir?", //1468
	@"Foster voz em “off”: Era demasiado tarde para lhe perguntar.", //1469
	@"Piloto: A abandonar a zona de destruição, Comandante Reich.", //1470
	@"Reich: Certo. Detonar.", //1471
	@"Foster voz em “off”: Demasiado tarde.", //1472

	@"Foster: Seu assassino...", //1473
	@"Reich: Mantenham-no calado.", //1474
	@"Foster voz em “off”: A única coisa que podia fazer era esperar.", //1475
	@"Foster voz em “off”: Tal como numa caçada. Tal como o velho me ensinou.", //1476
	@"Foster voz em “off”: Esperar… e estar preparado.", //1477

	@"Foster voz em “off”: Era madrugada quando chegámos à Cidade.", //1478
	@"Reich: Aterrar no complexo central de Segurança.", //1479
	@"Foster voz em “off”: Uma madrugada que a minha tribo nunca veria.", //1480
	@"Foster voz em “off”: Agora, já não passavam de uma nota no livro de Reich.", //1481
	@"Piloto: Sim, senhor. A bloquear na baliza de aterragem automática.", //1482
	@"Foster voz em “off”: Mas o que era eu? Porquê...", //1483

	@"Piloto: Senhor! O sistema de orientação! Está louco!", //1484
	@"Piloto: Vamos BATER!", //1485
	@"Foster voz em “off”: Talvez obtenha algumas respostas agora.", //1486
	@"Foster voz em “off”: Se sobreviver a outro desastre de helicóptero.", //1487
// Outro Movie text:

	@"Alguns anos mais tarde…", //1490
	@"Num mundo onde todos são livres, o preço da liberdade é a escravidão.", //1491
	@"Tenha Cuidado", //1492

};




NSString *esASCII[]=
{

//RECYCLING PLANT
// For 'elevator' see ref line 187
	@"La salida de incendios está cerrada, ¿qué hago?", //1000
// See line 1050 He noqueado al guardia, ¿y ahora?
	@"Ojalá Joey estuviera aquí, ¿qué hago?", //1001
	@"¿Cómo hago que funcione el ascensor?", //1002
	@"¿Cómo bajo la palanca del ascensor?", //1003
// For 'furnace' see ref line 4221
	@"¿Cómo salgo de la habitación del horno?", //1004


//INDUSTRIAL 1 
// For 'welder' see ref line 8369
	@"Debo desactivar el robot soldador, ¡ayuda!", //1005
	@"¿Cómo me hago con el armazón para Joey?", //1006
	@"¿Cómo podría entrar al almacén?", //1007
// For 'storeroom' see ref line 9212/9221
	@"¿Cómo consigo que no me confisquen lo que cojo del almacén?", //1008
	@"¿Cómo me deshago del hombre de la sala de potencia?", //1009
	@"¿Cómo recupero la corriente?", //1010
// This is a lift elevator - ref 9379
	@"¿Cómo uso el ascensor?", //1011

//BELLEVUE 1 
// For 'travel agent' see ref line 12698
	@"¿Cómo consigo un billete del agente de viajes?", //1012
// For 'ticket' see ref line 12727
	@"¿Qué hago con este billete?", //1013

//INDUSTRIAL 2 
	@"Lamb tiene mi billete, ¿y ahora qué?", //1014

//BELLEVUE 2 
// For 'surgery' see ref line 270
	@"¿Cómo entro en cirugía?", //1015
	@"¿Cómo consigo un puerto Schriebmann?", //1016
// For 'anchor' see ref line 539. Please note that anchor refers to the object, and is also the name of the travel agent. 
	@"¿Cómo consigo el ancla?", //1017
	@"Ya tengo el ancla, ¿y ahora qué?", //1018

//INDUSTRIAL 3 
	@"¿Qué hago con este garfio?", //1019
// For 'grappling hook' see ref line 320

//SECURITY CENTRE 
// For 'security HQ' see ref line 9018
	@"Estoy en el Cuartel Gral. de Seguridad, ¿y ahora?", //1020

//LINC 1 
	@"Estoy atrapado en el mundo LINC, ¿qué hago?", //1021
	@"Estoy en el laberinto cibernético, ¿cómo salgo?", //1022
	@"He salido del laberinto cibernético, ¿y ahora?", //1023

//SECURITY CENTRE 
	@"¿Cómo salgo del espacio LINC?", //1024

//HYDE PARK 
	@"Estoy en el nivel del suelo, ¿qué hago?", //1025
// For 'dog buscuits' see ref line 198
	@"¿Cómo consigo esas galletas de perro?", //1026
	@"¿Cómo evito a ese guardia?", //1027
	@"Estoy en la catedral, ¿y ahora?", //1028
	@"Han asesinado a Anita, ¿qué hago ahora?", //1029

//LINC 2 
	@"Tengo la tarjeta de Anita, ¿tendrá pistas?", //1030

//HYDE PARK 2 
	@"He leído el mensaje de Anita. ¿Cómo contacto con Eduardo?", //1031
	@"He contactado con Eduardo, ¿y ahora qué?", //1032
// This is a drinking glass
	@"Tengo el vaso de Colston, ¿pero por qué?", //1033

//HYDE PARK 3 
	@"¿Cómo cruzo el metro?", //1034
// For 'subway' see ref line 16525
	@"He hecho un agujero en la reja, ¿cómo lo agrando?", //1035
	@"He hecho un agujero en la reja, ¿y ahora?", //1036
// For 'grill' see ref line 17376

//UNDERWORLD 
	@"Una criatura me agarra, ¿cómo la esquivo?", //1037
	@"¿Cómo atravieso la puerta de metal grande?", //1038
	@"Hay un pozo extraño, ¿qué hago?", //1039
	@"¿Qué hago en este extraño inframundo?", //1040
	@"¿Cómo esquivo al androide del laboratorio?", //1041
	@"He acabado con el androide, ¿y ahora?", //1042
// For 'android' see ref line 20607
	@"Anita mencionó un virus, ¿cómo lo consigo?", //1043
// For 'virus' see ref line 24591

//LINC 3 
	@"He vuelto a LINC, ¿cómo consigo el virus?", //1044

//UNDERWORLD 
	@"Pobre Joey, ¿cómo lo resucito? ¡Otra vez!", //1045
	@"He transformado a Joey en androide, ¿y ahora?", //1046
	@"Tengo el virus de LINC, ¿cómo entro en el mundo real?", //1047
	@"Tengo tejido infectado, ¿y ahora qué?", //1048
// For 'tissue' (biological tissue) see ref line 20633/20634
	@"He visto a mi padre, ¿cómo salvo a la humanidad?", //1049

//RECYCLING PLANT 1 
	@"He noqueado al guardia, ¿y ahora?", //1050

//INDUSTRIAL 1 
	@"Estoy en una zona industrial, ¿qué hago?", //1051
	@"He encontrado algo parecido a masilla, ¿y ahora?", //1052
// For 'putty' see ref line 168
	@"Tengo estatus de seguridad especial en LINC, ¿y ahora?", //1053


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//CONTROLS HELP Subjects - should fit with the Text Box constraints specified above
	@"Interfaz de usuario y controles, ¡ayuda!", //1054
	@"Instrucciones del inventario", //1055
	@"Recorrido de la primera pantalla", //1056

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//HINT ANSWERS
// No particular constraints on text length - but please not too much longer than English
//------------
	@"Coge la barra de metal de lo alto de las escaleras, a la izquierda del corredor.", //1057
// Reference 4295 for term 'rung', 4177 for 'fire door'
	@"Abre el inventario y usa la barra de metal en la salida de incendios para abrirla. Consulta la sección 'Recorrido de la primera pantalla' para más información.", //1058
//1
// Reference 4194 for term used for 'robot shell', 4546 for 'junk'
	@"Examina la chatarra del primer plano para descubrir el armazón de robot.", //1059
// Reference 16586 for term for 'circuit board', 4185 for 'robot shell'
	@"Usa el circuito en el armazón de robot.", //1060
//2
	@"Examina el droide transportador.", //1061
// Reference 4426, 4337 for transport robot / droid
	@"Habla con Hobbins hasta que aparezca la opción de preguntarle sobre el droide transportador. Te dirá qué le pasa.", //1062
	@"Pídele a Joey que active el droide transportador (puede que tengas que darle antes un poco de conversación).", //1063
//3
	@"Cuando el ascensor baje, gira con rapidez la palanca.", //1064
//4
	@"Examina la cerradura de la puerta.", //1065
	@"Cuando llegue Joey, pídele que abra la puerta.", //1066

//INDUSTRIAL 1 
//5
	@"Tienes que desbaratar el plan.", //1067
	@"¿Encontraste la llave en el taller de Hobbins? Si no, vuelve a él, abre el armario y cógela.", //1068
	@"Vuelve a la cadena de producción. En la sala tras el robot soldador verás algunos engranajes.", //1069
	@"Si no lo has hecho, habla con Anita y luego con Lamb antes de que se vaya. Luego tira la llave en los engranajes.", //1070
//6
	@"Recupera la llave de los dientes.", //1071
	@"Usa la llave en el robot soldador.", //1072
	@"Habla con Joey, y ofrécele un nuevo armazón.", //1073
//7
	@"Intenta entrar al almacén.", //1074
	@"Dile a Joey que eche un ojo al almacén. Cuando descubra la caja de fusibles, dile que la inutilice.", //1075
//8
	@"Levanta la plancha del suelo.", //1076
	@"Coge la masilla (explosivo plástico) que había bajo la plancha. Es el único objeto que podrás conservar tras marcharte.", //1077
//9
	@"Usa la llave en los dos botones que hay bajo las tuberías de la derecha.", //1078
	@"Dile a Joey que pulse el botón de la derecha y tú pulsa el otro a la vez.", //1079
//10
	@"Apaga el interruptor del panel de control de la izquierda.", //1080
	@"Quita la bombilla.", //1081
	@"Pon la masilla en el hueco que ha quedado.", //1082
	@"Vuelve a encender el interruptor.", //1083
	@"Baja el interruptor derecho para que la corriente llegue de nuevo al ascensor.", //1084
//11
	@"Examina el cadáver de Reich en la sala del horno para coger su tarjeta.", //1085
	@"Usa la tarjeta ID de Reich en la ranura del ascensor.", //1086

//BELLEVUE 1 
//12
	@"Ve al apartamento de Reich y levanta la almohada. Verás una revista de motos.", //1087
	@"Ve al agente de viajes y pregunta sobre los tours.", //1088
	@"Pregunta sobre el económico.", //1089
	@"Dale la revista a cambio de un billete para hacer un tour.", //1090
//13
	@"Dale el billete a Lamb para que te invite a un tour por la fábrica de tuberías.", //1091

//INDUSTRIAL 2 
//14
	@"Pregunta a Lamb sobre el tour, se irá cuando vea que la cinta se ha detenido.", //1092
	@"Habla con Anita.", //1093
	@"Al final te ofrecerá un interferometro. Dale la tarjeta de Reich.", //1094
// A jammer is hacking software - see ref 8639
	@"Conversa un poco más para averiguar cosas sobre el puerto Schriebmann.", //1095

//BELLEVUE 2 
//15
	@"Habla con la recepcionista de cirugía haciendo clic en el proyector.", //1096
	@"Pide un puerto Schriebmann.", //1097
	@"Dile a Joey que hable con la recepcionista para poder entrar en cirugía.", //1098
//16
	@"Habla con Burke hasta que te ofrezca reparar un puerto Schriebmann.", //1099
//17
	@"Tras la operación, sigue hablando con Burke para conocer la 'póliza especial' de Ancla.", //1100
	@"Visita a Ancla en la oficina de seguros y menciona el nombre de Burke para que salga de la sala.", //1101
	@"Pide ayuda a Joey para coger el ancla de la estatua.", //1102
	@"Coge el ancla después de que Joey haya fundido el brazo de la estatua.", //1103
//18
	@"Si no lo tienes, es momento de que cojas el cable que cuelga del nivel industrial.", //1104
	@"Pide a Joey que corte el cable suelto. Quítate de en medio.", //1105
	@"Recuperar el cable que ha caído del nivel Belle Vue.", //1106
	@"Usa el ancla en el cable para fabricar un garfio.", //1107

//INDUSTRIAL 3 
//19
	@"Ve a la salida de incendios de la planta de reciclaje de Hobbins y camina por la cornisa.", //1108
	@"Usa el garfio en la señal de seguridad de la pared de enfrente.", //1109

//SECURITY CENTRE 
//20
	@"En el Cuartel General de Seguridad, usa la tarjeta ID en la ranura y siéntate.", //1110

//LINC 1 
//21
// These are all specific software package names - please refer to original text files so they match
	@"Coge la pelota (datos comprimidos) en la zona 1.", //1111
	@"Ve a la zona 2 y usa 'abrir' (en inventario) en la bolsa de viaje.", //1112
	@"Coge la sorpresa de cumpleaños (descomprimir). Usa 'descomprimir' en los datos comprimidos (en inventario).", //1113
	@"Coge la lupa (decodificar) y úsala en informe.doc y en instrucciones.doc (en inventario).", //1114
//22
// This is describing squares on a 3 * 3 grid
	@"Usa la contraseña verde en la fila de abajo/casilla izquierda. Usa la contraseña roja en la fila de abajo/casilla central.", //1115
	@"Coge la contraseña verde y úsala en la fila central/casilla izquierda.", //1116
	@"Coge la contraseña roja y úsala en la casilla central.", //1117
	@"Coge la contraseña verde y úsala en la fila de abajo/casilla derecha.", //1118
//23
	@"Coge el libro (phoenix.doc).", //1119
	@"Usa 'decodificar' en phoenix.doc.", //1120
	@"Consigue el busto (programa phoenix).", //1121
	@"Desconéctate de LINC.", //1122

//SECURITY CENTRE 
//24
	@"Usa la tarjeta ID en la terminal de LINC.", //1123
	@"Selecciona 'Servicios de Seguridad'. Selecciona 'Ver documentos'.", //1124
	@"Lee los documentos. Deben de haber sido decodificados en espacio LINC.", //1125
	@"Selecciona 'Operaciones especiales'. Selecciona 'Petición de estatus especial'.", //1126
	@"Selecciona 'Modificación del archivo' para D-LINC Lamb.", //1127

//HYDE PARK 
//25
	@"Habla con Henri, quien mantiene el orden, para saber más sobre patrocinios para el club.", //1128
	@"Habla con Danielle para que te invite a su apartamento.", //1129
	@"Vuelve al apartamento de Danielle.", //1130
//26
	@"Necesitarás el vídeo de los gatos del apartamento de Lamb.", //1131
	@"Modifica el archivo de D-LINC Lamb en la terminal de LINC, y luego habla con él.", //1132
	@"Pon el vídeo mientras Danielle está al teléfono.", //1133
	@"Coge las galletas de perro mientras el perro está distraído.", //1134
//27
	@"Ve al columpio junto al lago y usa las galletas de perro en la tabla.", //1135
	@"Tira de la cuerda cuando el perro se acerque.", //1136
	@"Cuando el perro pise la tabla, suelta la cuerda.", //1137
//28
	@"Explora los armarios del nivel inferior hasta descubrir la terrible verdad.", //1138
//29
	@"Vuelve al reactor de la fábrica y ponte el traje antirradiación.", //1139
	@"Ve a la terminal y abre el reactor. Coge la tarjeta ID de Anita de su interior.", //1140
	@"Atraviesa el edificio de Seguridad.", //1141
	@"Entra en LINC con la tarjeta de Anita.", //1142

//LINC 2 
//30
	@"Usa 'cegar' en el globo ocular de la zona 2.", //1143
	@"Usa 'repetición' en el proyector holográfico ('cavidad') para ver el mensaje de Anita.", //1144
	@"Desconéctate de LINC.", //1145

//HYDE PARK 2 
//31
	@"Vuelve a Hyde Park. ", //1146
	@"Habla con Vincent para averiguar cosas sobre el jardinero.", //1147
	@"Habla con el jardinero hasta que te diga algo sobre el virus.", //1148
//32
	@"Entra en la sala para presenciar el juicio a Hobbins.", //1149
	@"Ve al club.", //1150
	@"Selecciona 'Buscas pero no encuentras nada' en la máquina de discos.", //1151
	@"Coge el vaso de Colston cuando se vaya de la mesa.", //1152
//33
	@"Dale el vaso a Burke para que obtenga las huellas dactilares.", //1153

//HYDE PARK 3 
//34
	@"Toca la placa para abrir la puerta de la bodega de vino.", //1154
	@"Usa la barra en la caja grande de la izquierda.", //1155
	@"Coge la tapa y úsala en la caja pequeña.", //1156
	@"Sube a la caja.", //1157
	@"Usa la barra en la rejilla.", //1158
//35
	@"Si no has encontrado las podaderas, ve a la cabaña del parque.", //1159
	@"Mira la puerta.", //1160
	@"Usa la tarjeta ID en la cerradura.", //1161
	@"Entra a la cabaña y coge las podaderas.", //1162
//36
	@"Usa las podaderas en la rejilla.", //1163
	@"Sube por la rendija.", //1164

//UNDERWORLD 
//37
	@"Coloca la bombilla en el casquillo a la izquierda del agujero de la criatura.", //1165
//38
	@"Usa la barra en el yeso deshecho y luego en el enladrillado para conseguir un ladrillo.", //1166
	@"-", //1167
	@"Usa la barra en el coágulo de la vena.", //1168
	@"Usa el ladrillo y la barra para punzar el coágulo.", //1169
	@"Espera a que llegue el robot médico para reparar la punción. Luego sal por la puerta de la derecha.", //1170
//39
	@"Cubre el pozo con la tapa usando la terminal que hay junto al pozo.", //1171
	@"Sube a la tapa del pozo.", //1172
	@"Tira de la barra que bloquea la rejilla que hay sobre tu cabeza para soltar la rejilla.", //1173
	@"Vuelve a la sala de arriba.", //1174
//40
	@"Mira a través de las rejillas para localizar posibles peligros.", //1175
	@"Mira a través de la primera rejilla que te encuentres.", //1176
	@"Ve a la derecha, a la sala donde el robot médico se está recargando.", //1177
	@"Usa el circuito en el robot médico.", //1178
//41
	@"Habla con Joey y envíalo a la sala del tanque.", //1179
	@"Pregúntale a Joey qué ha visto en la sala del tanque.", //1180
	@"Pregunta a Joey acerca del tanque.", //1181
	@"Dile a Joey que abra el grifo.", //1182
	@"Entra en la sala del tanque y observa cómo se ahoga el androide.", //1183
//42
	@"Ve a la derecha de los tanques, a la sala de ordenadores.", //1184
	@"Usa la tarjeta ID de Reich en la terminal (a la izquierda de los ordenadores).", //1185
	@"Abre la puerta de acceso.", //1186
	@"Sal de la sala de ordenadores y observa cómo destruyen a Joey otra vez.", //1187
	@"Coge la tarjeta de Gallagher de sus restos.", //1188
//43
	@"Vuelve a la sala de ordenadores.", //1189
	@"Entra a LINC con la tarjeta de Gallagher.", //1190
//44
	@"Tienes que entrar a LINC con la tarjeta de Gallagher. Sal y vuelve a entrar.", //1191
	@"Usa cegar en un globo ocular de la zona 1. Ve rápidamente a la zona 2 y haz lo mismo.", //1192
	@"Hazte con el oscilador (diapasón).", //1193
	@"Ve a la sala del cruzado. Usa 'cólera divina' para eliminarlo.", //1194
	@"Entra en la sala de cristal. Usa el oscilador en el cristal.", //1195
	@"Hazte con el virus. Desconéctate de LINC.", //1196
//45
	@"Ve a la sala del androide especial. Abre el armario que hay en la consola del centro.", //1197
	@"Introduce el circuito en el armario.", //1198
	@"Usa el monitor para descargar datos del circuito.", //1199
	@"Activa el programa de inicio del androide.", //1200
//46
	@"Ve a la derecha, a la sala de los tanques grandes.", //1201
	@"Pide a Joey/Ken que ponga la mano en el panel de la puerta.", //1202
	@"Pon la mano en el otro panel.", //1203
//47
	@"Ve al tanque de tejidos y coge las pinzas de la pared (a la derecha del tanque).", //1204
	@"Usa la tarjeta de Gallagher (o la tarjeta que contenga el virus) en la consola para infectar el tejido.", //1205
	@"Coge una muestra de tejido infectado con las pinzas.", //1206
	@"Pon la muestra de tejido en el tanque de nitrógeno para congelarla.", //1207
//48
	@"Ve al final de las tuberías. Coloca el cable en el soporte de la tubería.", //1208
	@"Usa los peldaños para bajar al orificio de alimentación.", //1209
	@"Deja caer el tejido infectado por el orificio.", //1210
	@"Usa la cuerda que cuelga para balancearte hasta la última sala.", //1211
//49
	@"Cuando Joey/Ken entre, dile que se siente en la silla.", //1212

// Missing answers added later

//RECYCLING PLANT 1 
//50
	@"Explora la fábrica. Puede que consigas que Joey funcione de nuevo.", //1213

//INDUSTRIAL 1 
//51
	@"Echa un vistazo alrededor, quizá alguien pueda ayudarte.", //1214
//52
	@"Explora un poco más, seguro que hay algo más.", //1215
	@"Lleva el ascensor al nivel de abajo, y luego lleva el siguiente al nivel del suelo.", //1216

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//User Interface and game controls - Help!  (no constraints on text length on these four lines)
	@"Moverse por el entorno", //1217
	@"Toca un punto de la zona y Foster caminará hacia él, si puede. Para salir de una zona, tendrás que interactuar con el icono de la flecha de salida.", //1218
	@"Interactuar con el entorno", //1219
	@"Desliza el dedo por la pantalla de juego para encontrar zonas de interés (puntos calientes). Aparecerán círculos azules animados en los puntos calientes a medida que el dedo sea acerque a ellos. Desliza el dedo sobre un círculo azul y se mostrarán iconos de acción que te indicarán qué acciones puede llevar a cabo Foster. Para ejecutar una acción, levanta el dedo de la pantalla y toca un icono.", //1220
//1268 Aumentar el tiempo antes de pasar al modo de suspensión.
//1270 Para aumentar el tiempo antes de que tu dispositivo entre en modo de suspensión, ve a 'Ajustes', luego a 'General' y a 'Bloqueo automático'. Elige el ajuste deseado.

	@"DUMMY LINE", //1221

//Inventory Instructions  (no constraints on text length on these four lines)
	@"El inventario. ¿Qué es?", //1222
	@"Los objetos que Foster va recogiendo van al 'inventario'. Toca el icono del cofre para ver los objetos que contiene. Toca un objeto para ver su descripción.", //1223
	@"Cómo usar un objeto del inventario en el entorno y en la gente", //1224
	@"Abre el inventario y toca un objeto durante unos instantes hasta que aparezca sobre tu dedo. Arrastra el objeto a un punto caliente y suéltalo cuando se ilumine con un contorno azul.", //1225
	@"Combinar objetos de inventario", //1226
	@"A veces tendrás que combinar dos objetos del inventario para obtener un tercero. Para hacerlo, toca el objeto durante unos instantes hasta que aparezca sobre tu dedo. Luego arrastra el objeto hasta el segundo y suéltalo cuando ambos tengan un contorno azul.", //1227


//First Screen Walkthrough (no constraints on text length on these four lines)
	@"Recorrido para hacer que Foster abra la salida de incendios", //1228
	@"Desliza el dedo sobre la barra, hasta el extremo izquierdo de la pantalla. A medida que te acercas, se mostrará un círculo azul. Cuando el dedo toque la barra, aparecerán dos iconos: engranajes en movimiento (interactuar) y un ojo guiñado (examinar); además aparecerá la palabra 'barra' en la parte superior de la pantalla. Levanta el dedo y toca los engranajes. Éstos brillarán y Foster caminará hacia la barra para tirar de ella. Pondrá la barra en su inventario de forma automática, donde aparecerá como 'barra de metal'.", //1229
	@"LINE DELETED", //1230
	@"Abre el inventario tocando el icono de la caja. Toca el icono de la barra de metal hasta que aparezca encima de tu dedo, luego deslízala a la salida de incendios hasta que el dedo quede por encima del círculo azul y se muestre la palabra 'puerta' en la parte superior de la pantalla. Entonces, levanta el dedo. Foster usará la barra de metal para abrir la salida de incendios. Luego se apartará. ¡Buena suerte!", //1231

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Twitter Stuff

//twitter test message
	@"Enviar mensajes de texto: 'Acabo de empezar Beneath a Steel Sky en el iPhone/iPod touch. Mantente alerta'.", //1232

//twitter info
	@"Hay varias interacciones especiales escondidas en todo el juego. Escribe tus datos de Twitter para que Beneath a Steel Sky pueda publicar en Twitter las que vayas descubriendo.", //1233

//tweets
	@"Acabo de empezar Beneath a Steel Sky en el iPhone/iPod touch. Mantente alerta.", //1234
	@"¡Tweet enviado!", //1235
	@"No se ha podido enviar el tweet, puede haber un problema de conexión.", //1236
	@"No se ha podido enviar el tweet, comprueba el nombre de usuario y la contraseña.", //1237
	@"Ya en Beneath a Steel Sky. Acabo de cogerle el bocata de salchicha a Hobbins... Aunque no sé muy bien por qué... Bueno, a fin de cuentas, esto es una aventura.", //1238
	@"Acabo de coger el vídeo de los gatos de Lamb en Beneath a Steel Sky. No me fío del enano.", //1239
	@"He escapado de los coqueteos de Danielle Piermont en Beneath a Steel Sky. Ha dado con sus huesos en un estanque... Porque sabrá nadar, ¿no?", //1240
	@"He roto un vaso sanguíneo del ordenador de seguridad en Beneath a Steel Sky. ¡Esto sangra! ¡Qué asco!", //1241
	@"Me acabo de pasar Beneath a Steel Sky en iPhone/iPod touch, ¡he salvado el mundo!", //1242

// General Messages

//new game alert
	@"Si necesitas ayuda con los controles o quieres pistas para resolver algún acertijo, toca el signo de interrogación azul.", //1243

//various misc
	@"Diálogo", //1244
	@"Subtítulos", //1245
	@"Nombre de usuario", //1246
	@"Contraseña", //1247
	@"En desuso", //1248
	@"Sin nombre", //1249
	@"Partida guardada", //1250
	@"Datos de juego guardados con éxito", //1251
	@"Error al guardar partida", //1252
	@"Datos de juego NO guardados con éxito", //1253
	@"Pista %d de %d", //1254
	@"Ayuda de controles y pistas de acertijos", //1255
	@"OK", //1256
	@"Idioma del texto", //1257
	@"Nombre de usuario", //1358
	@"Contraseña", //1359

// Tell a friend email:
	@"Mensaje de 'Beneath a Steel Sky'", //1260
	@"¡Hola!", //1261
	@"Estoy jugando al clásico 'Beneath a Steel Sky', renovado y actualizado en exclusiva para iPhone y iPod touch.", //1262
	@"El juego, una vez considerado una de las mejores aventuras jamás escritas, incluye increíbles películas de animación de Dave Gibbons, uno de los creadores de 'Watchmen', un sistema de ayuda intuitivo, una nueva interfaz, un sonido mejorado y... bueno, cantidad de cosas chulas.", //1263
	@"Como soy una persona maja y enrollada, quería compartir esto contigo. Haz clic en este enlace para ver más cosas sobre el juego: http://www.revolution.co.uk/appstoreBASS", //1264
	@"¡Échale un ojo! Mantente alerta.", //1265

	@"Post de Twitter", //1266

// Added lines in Controls re sleep mode
	@"Aumentar el tiempo antes de pasar al modo de suspensión.", //1268
	@"Para aumentar el tiempo antes de que tu dispositivo entre en modo de suspensión, ve a 'Ajustes', luego a 'General' y a 'Bloqueo automático'. Elige el ajuste deseado.", //1270

// Intro Text
	@"Foster Over: El anciano intentaba predecir el futuro. Miraba fotos junto a la hoguera...", //1400
	@"Chamán: Ohhh, veo el mal...", //1401
	@"Chamán: Mal nacido bajo la ciudad... Lejos de la luz del día...", //1402
	@"Chamán: Lo veo crecer, a salvo, bajo un cielo de acero...", //1403
	@"Chamán: Maquinando en la oscuridad... reuniendo fuerzas...", //1404
	@"Chamán: Y ahora... Ohhh... El mal se extiende...", //1405
	@"Chamán: Despliega sus tentáculos en la superficie...", //1406
	@"Chamán: Más allá del Gap... ¡Llega a todas partes!", //1407
	@"Foster Over: Le había visto hacerlo cientos de veces, pero le seguía la corriente.", //1408
	@"Foster Over: Después de todo, había sido como un padre para mí.", //1409
	@"Foster: ¿Pero qué quiere el mal?", //1410
	@"Chamán: Ay, hijo mío. Me temo...", //1411
	@"Chamán: ¡Me temo que te quiere a ti!", //1412
	@"Foster Over: Fue entonces cuando Joey dio la alarma...", //1413
	@"Joey: ¡Foster! ¡Los sensores detectan una fuente de sonido!", //1414
	@"Chamán: ¡El mal! ¡El mal casi ha llegado!", //1415
	@"Foster Over: Sonaba más como un helicóptero que como un demonio...", //1416
	@"Foster Over: Pero entonces, el infierno se desató...", //1417
	@"Chamán: ¡Corre, Foster! ¡Corre! ¡Escóndete!", //1418
	@"Joey: ¡Foster! (zzzt) ¡A-ayuda!", //1419
	@"Joey: La próxima vez (zzzt) haré que mi (zzzt) cuerpo se mueva (zzzt) más rápido...", //1420
	@"Foster Over: Era tan solo un robot, pero bueno, le tenía aprecio...", //1421
	@"Foster Over: Entonces, tan repentinamente como comenzó, el fuego cesó...", //1422
	@"Foster Over: Hubo un momento de silencio cuando el helicóptero paró los rotores, luego...", //1423
	@"Reich: Que se presente ante mí quien esté al cargo...", //1424
	@"Foster Over: Solo un tonto se habría opuesto a esa capacidad de fuego...", //1426
	@"Chamán: ... Yo soy su líder...", //1427
	@"Chamán: Somos pacíficos...", //1428
	@"Reich: Traédmelo.", //1429
	@"Soldier: Ahora mismo, comandante Reich.", //1430
	@"Reich: Buscamos a alguien...", //1431
	@"Reich: Alguien que no es de aquí...", //1432
	@"Reich: Alguien que no nació en este vertedero...", //1433
	@"Reich: Vino de la Ciudad siendo un niño...", //1434
	@"Reich: Y queremos llevarlo de vuelta.", //1435
	@"Foster Over: Mi mente no paraba de trabajar, recordaba dónde había visto ese símbolo...", //1436
	@"Foster Over: Fue el día en que me encontró la tribu...", //1437
	@"Foster Over: El día del accidente...", //1438
	@"Foster Over: El día en que murió mi madre...", //1439

	@"Hombre de la tribu: ¿Estás bien, chico de la Ciudad?", //1440
	@"Chamán: ¿Cómo te llamas, hijo?", //1441
	@"Foster: R-Robert.", //1442
	@"Chamán: ¡Ah! Bienvenido al Gap, Robert.", //1443
	@"Foster Over: Mientras me ayudaba, el anciano me explicó con amabilidad que no había manera de volver a la Ciudad...", //1445
	@"Foster Over: Y yo ya sabía que no él no podría hacer nada por mi madre...", //1446
	@"Foster Over: Su tribu era pobre, pero me trataron como a uno de los suyos...", //1447
	@"Foster Over: Aprendí a sobrevivir en el páramo que llamaban el Gap...", //1448
	@"Foster Over: Y a vivir de los vertederos de la Ciudad.", //1449
	@"Foster Over: A medida que pasaron los años, olvidé mi vida en la Ciudad.", //1450
	@"Foster Over: Y descubrí nuevos talentos...", //1451

	@"Joey: Soy tu (zzzt) amigo... Llámame (zzzt) Joey.", //1453
	@"Foster Over: Y me dieron un apellido.", //1454
	@"Chamán: Así te llamaremos, ahora que tienes edad, hijo.", //1455
	@"Chamán: Nosotros te encontramos, te dimos cobijo...", //1456
	@"Chamán: Te llamaremos Robert Foster.", //1457
	@"Reich: ... ¡Ya basta!", //1458
	@"Reich: ¡Dadnos al chico o acabaremos con todos!", //1459
	@"Reich: Empezando por ti, viejo.", //1460
	@"Foster Over: El anciano tenía razón por una vez...", //1461
	@"Foster Over: Me querían a mí.", //1462
	@"Chamán: ¡No, hijo mío! ¡No permitas que el mal te atrape! ¡Corre!", //1463
	@"El escáner de ADN confirma que es él, señor.", //1464
	@"Foster Over: El mal ha llegado al Gap, tal como él dijo.", //1465

	@"Reich: Cogedlo.", //1466
	@"Foster Over: ¿Pero sabía el anciano por qué me querían?", //1467
	@"Foster Over: ¿O qué pasaría después?", //1468
	@"Foster Over: Era demasiado tarde para preguntarle.", //1469
	@"Piloto: Abandonamos la zona de destrucción, comandante Reich.", //1470
	@"Reich: Bien, activad la detonación.", //1471
	@"Foster Over: Demasiado, demasiado tarde.", //1472

	@"Foster: Por qué asesinas...", //1473
	@"Reich: Haced que se calle.", //1474
	@"Foster Over: Solo podía esperar.", //1475
	@"Foster Over: Como en una cacería, como el anciano me había enseñado.", //1476
	@"Foster Over: Esperar... y estar preparado.", //1477

	@"Foster Over: Amanecía cuando llegamos a la Ciudad.", //1478
	@"Reich: Aterriza en el complejo central de seguridad.", //1479
	@"Foster Over: Mi tribu jamás vería ese amanecer...", //1480
	@"Foster Over: Solo eran una anotación en el cuaderno de Reich...", //1481
	@"Piloto: Sí, señor. Nos dirigimos a la baliza de aterrizaje automática.", //1482
	@"Foster Over: ¿Pero dónde estaba? Por qué...", //1483

	@"Piloto: ¡Señor! ¡El sistema de teledirección se ha vuelto loco!", //1484
	@"Piloto: ¡Vamos a estrellarnos!", //1485
	@"Foster Over: Quizás era momento de obtener respuestas...", //1486
	@"Foster Over: Si conseguía sobrevivir a otro accidente de helicóptero...", //1487
// Outro Movie text:
	@"Unos años más tarde...", //1490
	@"En un mundo donde todos eran libres, el precio de la libertad era la esclavitud.", //1491
	@"Mantente alerta.", //1492
// NEED TO ADD ITUNES STORE TEXT

};




NSString *itASCII[]=
{
	@"La porta antincendio è chiusa: come la apro?", //1000
// See line 1050 I've out-foxed the guard - what now?
	@"Come vorrei che Joey fosse qui: che faccio?", //1001
	@"Come faccio a far funzionare l'ascensore?", //1002
	@"Come scendo nella tromba dell'ascensore?", //1003
// For 'furnace' see ref line 4221
	@"Come faccio a uscire dalla sala della fornace?", //1004


//INDUSTRIAL 1 
// For 'welder' see ref line 8369
	@"Devo disattivare il robot saldatore. Aiuto!", //1005
	@"Come prendo la corazza del saldatore per Joey?", //1006
	@"Come faccio a entrare nel deposito?", //1007
// For 'storeroom' see ref line 9212/9221
	@"Come posso impedire che gli oggetti del deposito siano confiscati?", //1008
	@"Come mi libero dell'uomo nella sala generatori?", //1009
	@"Come faccio a riattivare la corrente?", //1010
// This is a lift elevator - ref 9379
	@"Come faccio a utilizzare l'ascensore?", //1011

//BELLEVUE 1 
// For 'travel agent' see ref line 12698
	@"Come faccio a ottenere un biglietto dall'agente di viaggi?", //1012
// For 'ticket' see ref line 12727
	@"Cosa dovrei farci con il biglietto?", //1013

//INDUSTRIAL 2 
	@"Lamb ha il mio biglietto: e ora che faccio?", //1014

//BELLEVUE 2 
// For 'surgery' see ref line 270
	@"Come faccio a entrare nella clinica?", //1015
	@"Come mi procuro un'interfaccia neuronale?", //1016
// For 'anchor' see ref line 539. Please note that anchor refers to the object, and is also the name of the travel agent. 
	@"Come faccio a mettere le mani su quell'ancora?", //1017
	@"Che faccio ora che ho l'ancora?", //1018

//INDUSTRIAL 3 
	@"Cosa me ne faccio di questo rampino?", //1019
// For 'grappling hook' see ref line 320

//SECURITY CENTRE 
// For 'security HQ' see ref line 9018
	@"Sono nel quartier generale della sicurezza. E ora?", //1020

//LINC 1 
	@"Sono bloccato nel mondo LINC: cosa posso fare?", //1021
	@"Sono in un labirinto cibernetico: come ne esco?", //1022
	@"Sono uscito dal labirinto cibernetico: e adesso?", //1023

//SECURITY CENTRE 
	@"Come faccio a uscire dallo spazio LINC?", //1024

//HYDE PARK 
	@"Sono al livello terra. Ora cosa faccio?", //1025
// For 'dog buscuits' see ref line 198
	@"Come posso procurarmi quei biscottini per cani?", //1026
	@"Come faccio a superare la guardia?", //1027
	@"Sono nella cattedrale: e ora?", //1028
	@"Anita è stata assassinata. Cosa devo fare?", //1029

//LINC 2 
	@"Ho la tessera di Anita: magari ha lasciato degli indizi.", //1030

//HYDE PARK 2 
	@"Ho letto il messaggio di Anita: come faccio a contattare Eduardo?", //1031
	@"Ho contattato Eduardo. Adesso cosa faccio?", //1032
// This is a drinking glass
	@"Ho preso il bicchiere di Colston, ma perché?", //1033

//HYDE PARK 3 
	@"Come faccio ad attraversare la metropolitana?", //1034
// For 'subway' see ref line 16525
	@"Ho fatto un buco nella griglia: come lo allargo?", //1035
	@"Ho fatto un buco nella griglia: e ora?", //1036
// For 'grill' see ref line 17376

//UNDERWORLD 
	@"Una creatura cerca d'afferrarmi: come la evito?", //1037
	@"Come oltrepasso quella porta metallica?", //1038
	@"C'è uno strano antro: cosa faccio?", //1039
	@"Cosa ci faccio in questo strano mondo sotterraneo?", //1040
	@"Come superiamo l'androide nel laboratorio?", //1041
	@"Ho ucciso l'androide. E adesso?", //1042
// For 'android' see ref line 20607
	@"Anita parlava di un virus: come me lo procuro?", //1043
// For 'virus' see ref line 24591

//LINC 3 
	@"Sono tornato in LINC: come mi procuro il virus?", //1044

//UNDERWORLD 
	@"Povero Joey: come lo riporto in vita? Un'altra volta...", //1045
	@"Ho trasformato Joey in un androide. Ora cosa ci faccio con lui?", //1046
	@"Ho preso il virus da LINC: come torno nel mondo reale?", //1047
	@"Una parte di tessuto è infetta: e ora?", //1048
// For 'tissue' (biological tissue) see ref line 20633/20634
	@"Ho incontrato mio padre: come salvo l'umanità?", //1049

//RECYCLING PLANT 1 
	@"Ho ingannato la guardia: e adesso?", //1050

//INDUSTRIAL 1 
	@"Sono nell'area industriale: Cosa posso fare?", //1051
	@"Ho trovato una specie di stucco: e ora?", //1052
// For 'putty' see ref line 168
	@"Mi sono conferito uno status speciale di sicurezza in LINC: e ora?", //1053
// For 'status' see ref line 89


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//CONTROLS HELP Subjects - should fit with the Text Box constraints specified above
	@"Interfaccia utente e comandi di gioco: aiuto!", //1054
	@"Istruzioni per l'inventario", //1055
	@"Guida della prima schermata", //1056

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//HINT ANSWERS
// No particular constraints on text length - but please not too much longer than English
//------------
	@"Prendi la ringhiera in cima alle scale a sinistra dell'incastellatura.", //1057
// Reference 4295 for term 'rung', 4177 for 'fire door'
	@"Apri l'inventario e forza la porta antincendio con la ringhiera. Consulta la Guida della prima schermata per istruzioni dettagliate. ", //1058
//1
// Reference 4194 for term used for 'robot shell', 4546 for 'junk'
	@"Esamina i rottami in primo piano per scoprire la corazza robot.", //1059
// Reference 16586 for term for 'circuit board', 4185 for 'robot shell'
	@"Usa la scheda madre con la corazza robot.", //1060
//2
	@"Esamina il droide trasportatore.", //1061
// Reference 4426, 4337 for transport robot / droid
	@"Parla con Hobbin finché non compare l'opzione per chiedergli del droide trasportatore e lui ti dice perché non funziona.", //1062
	@"Chiedi a Joey di attivare il droide trasportatore (prima può essere necessario chiacchierare un po' in maniera cortese).", //1063
//3
	@"Quando arriva l'ascensore, scendi rapidamente lungo la tromba.", //1064
//4
	@"Esamina la serratura della porta.", //1065
	@"Quando arriva Joey, chiedigli di aprire la porta.", //1066

//INDUSTRIAL 1 
//5
	@"Devi usare un oggetto \"chiave\".", //1067
	@"Hai trovato la chiave inglese nell'officina di Hobbin? Se non l'hai trovata, torna nell'officina, apri l'armadietto e prendila.", //1068
	@"Torna alla catena di montaggio: nella stanza oltre al robot saldatore vedrai degli ingranaggi.", //1069
	@"Se non l'hai ancora fatto, parla con Anita e poi con Lamb finché non se ne va. Quindi, lancia la chiave inglese negli ingranaggi.", //1070
//6
	@"Recupera la chiave inglese dagli ingranaggi.", //1071
	@"Usa la chiave inglese sul robot saldatore.", //1072
	@"Parla con Joey e offrigli una nuova corazza.", //1073
//7
	@"Tenta di entrare nel deposito.", //1074
	@"Di' a Joey di controllare il deposito. Quando ti dirà di aver trovato la scatola dei fusibili, digli di disattivarla.", //1075
//8
	@"Solleva la griglia sul pavimento.", //1076
	@"Raccogli lo stucco (esplosivo al plastico) che era sotto la griglia. È l'unico oggetto che potrai tenere dopo essertene andato.", //1077
//9
	@"Usa la chiave inglese su entrambi i pulsanti sotto le tubature sulla destra.", //1078
	@"Di' a Joey di premere il pulsante destro e premi l'altro contemporaneamente.", //1079
//10
	@"Spegni l'interruttore sul pannello di controllo a sinistra.", //1080
	@"Svita la lampadina.", //1081
	@"Metti lo stucco al posto della lampadina.", //1082
	@"Accendi l'interruttore.", //1083
	@"Abbassa la leva di destra per ridare energia all'ascensore.", //1084
//11
	@"Prendi la tessera ID di Reich dal suo cadavere nella sala della fornace.", //1085
	@"Usa la tessera ID di Reich sul lettore magnetico dell'ascensore.", //1086

//BELLEVUE 1 
//12
	@"Vai nell'appartamento di Reich e solleva il cuscino. Troverai una rivista di moto.", //1087
	@"Vai dall'agente di viaggi e chiedi informazioni sui tour.", //1088
	@"Chiedigli del tour economico.", //1089
	@"Dagli la rivista di moto in cambio di un biglietto per il tour.", //1090
//13
	@"Dai il biglietto a Lamb per essere invitato al tour della fabbrica di tubi.", //1091

//INDUSTRIAL 2 
//14
	@"Chiedi a Lamb del tour: se ne andrà quando vedrà che il nastro trasportatore si è fermato.", //1092
	@"Parla con Anita.", //1093
	@"Alla fine ti offrirà un decodificatore: dalle la tessera ID di Reich.", //1094
// A jammer is hacking software - see ref 8639
	@"Continua a parlare per scoprire dell'interfaccia neuronale.", //1095

//BELLEVUE 2 
//15
	@"Parla con l'infermiera cliccando sul proiettore.", //1096
	@"Chiedi un'interfaccia neuronale.", //1097
	@"Chiedi a Joey di parlare con l'infermiera per essere ammesso alla clinica.", //1098
//16
	@"Parla con Burke finché non ti propone l'impianto di un'interfaccia neuronale.", //1099
//17
	@"Dopo l'operazione, continua a parlare con Burke per scoprire della polizza speciale di Anchor.", //1100
	@"Incontra Anchor nell'ufficio assicurazioni e di' il nome di Burke per farlo uscire dalla stanza.", //1101
	@"Chiedi a Joey di prendere l'ancora dalla statua.", //1102
	@"Raccogli l'ancora dopo che Joey ha fuso il braccio della statua.", //1103
//18
	@"Se non ce l'hai ancora, adesso è un buon momento per prendere il cavo elettrico che pende dal livello Industriale.", //1104
	@"Chiedi a Joey di tagliare il cavo e spostati.", //1105
	@"Recupera il cavo che è caduto sul livello Belle Vue.", //1106
	@"Usa l'ancora con il cavo per creare un rampino.", //1107

//INDUSTRIAL 3 
//19
	@"Vai all'uscita antincendio nell'impianto di riciclaggio di Hobbin ed esci sul davanzale.", //1108
	@"Usa il rampino per agganciare l'insegna della sicurezza sul muro di fronte.", //1109

//SECURITY CENTRE 
//20
	@"Nel quartier generale della sicurezza usa la tessera ID nel lettore e siediti.", //1110

//LINC 1 
//21
// These are all specific software package names - please refer to original text files so they match
	@"Raccogli la palla (dati compressi) nell'area 1.", //1111
	@"Gira a destra verso l'area 2 e usa Apri (nell'inventario) sulla borsa di pelle.", //1112
	@"Prendi il regalo di compleanno (decomprimi). Usa Decomprimi sui dati compressi (nell'inventario).", //1113
	@"Prendi la lente d'ingrandimento (decripta) e usala su report.doc e briefing.doc (nell'inventario).", //1114
//22
// This is describing squares on a 3 * 3 grid
	@"Usa la password verde sulla piastrella di sinistra della fila inferiore. Usa la password rossa sulla piastrella centrale della fila inferiore.", //1115
	@"Raccogli la password verde e usala sulla piastrella sinistra della fila centrale.", //1116
	@"Raccogli la password rossa e usala sulla piastrella centrale.", //1117
	@"Raccogli la password verde e usala sulla piastrella destra della fila inferiore.", //1118
//23
	@"Prendi il libro (phoenix.doc).", //1119
	@"Usa Decripta su phoenix.doc.", //1120
	@"Prendi il busto (phoenix program).", //1121
	@"Disconnettiti da LINC.", //1122

//SECURITY CENTRE 
//24
	@"Usa la tessera ID sul terminale LINC.", //1123
	@"Seleziona Servizi di sicurezza, quindi Vedi documenti.", //1124
	@"Leggi ogni documento. Nota che alcuni devono essere decriptati nello spazio LINC.", //1125
	@"Seleziona Operazioni speciali. Seleziona Richiesta status speciale.", //1126
	@"Seleziona Aggiustamento file per rendere Lamb un D-LINC.", //1127

//HYDE PARK 
//25
	@"Parla con Henri, il buttafuori, e scopri del finanziamento per il club.", //1128
	@"Parla con Danielle per farti invitare nel suo appartamento.", //1129
	@"Torna nell'appartamento di Danielle.", //1130
//26
	@"Ti servirà il video del gatto preso nell'appartamento di Lamb.", //1131
	@"Contatta Lamb tramite D-LINC usando Aggiustamento file sul terminale LINC e poi parla con lui.", //1132
	@" Inserisci la video cassetta mentre Danielle è al telefono.", //1133
	@"Prendi i biscottini per cani mentre il cane è distratto.", //1134
//27
	@"Vai all'altalena vicino al lago e metti i biscottini per cani sull'asse.", //1135
	@"Quando il cane è vicino, tira la corda.", //1136
	@"Quando il cane sale sull'asse, lascia la corda.", //1137
//28
	@"Controlla gli armadietti nel livello inferiore... finché non scopri la terribile verità.", //1138
//29
	@"Torna al reattore nella fabbrica e indossa la tuta antiradiazioni.", //1139
	@"Vai al terminale e apri il reattore. All'interno, raccogli la tessera ID di Anita.", //1140
	@"Torna all'edificio della sicurezza.", //1141
	@"Entra in LINC usando la tessera di Anita.", //1142

//LINC 2 
//30
	@"Usa Occlusore sul bulbo oculare nell'area 2.", //1143
	@"Usa Playback sul proiettore olografico (Pozzo) per vedere il messaggio di Anita.", //1144
	@"Disconnettiti da LINC.", //1145

//HYDE PARK 2 
//31
	@"Torna a Hyde Park. ", //1146
	@"Parla con Vincent per scoprire del giardiniere.", //1147
	@"Parla con il giardiniere finché non ti dice del virus.", //1148
//32
	@"Recati in tribunale per assistere al processo di Hobbin.", //1149
	@"Vai al club.", //1150
	@"Seleziona \"Cerchi, ma non trovi niente...\" sul jukebox.", //1151
	@"Prendi il bicchiere di Colston mentre non è al tavolo.", //1152
//33
	@"Dai il bicchiere a Burke per le impronte digitali.", //1153

//HYDE PARK 3 
//34
	@"Tocca il sensore ottico per aprire la porta della cantina dei vini.", //1154
	@"Usa la sbarra di metallo sulla scatola grande sulla sinistra.", //1155
	@"Prendi il coperchio e usalo sulla scatola più piccola.", //1156
	@"Sali sulla scatola.", //1157
	@"Usa la sbarra di metallo sulla griglia.", //1158
//35
	@"Se non hai trovato le cesoie, vai nel capanno nel parco.", //1159
	@"Guarda la porta.", //1160
	@"Usa la tessera ID con la serratura.", //1161
	@"Entra nel capanno e prendi le cesoie.", //1162
//36
	@"Usa le cesoie sulla griglia.", //1163
	@"Passa attraverso la griglia.", //1164

//UNDERWORLD 
//37
	@"Usa la lampadina nella presa rotonda a sinistra della fenditura.", //1165
//38
	@"Usa la sbarra di metallo sullo stucco sgretolato e poi sulla muratura per ottenere un mattone.", //1166
	@"-", //1167
	@"Usa la sbarra di metallo sul coagulo nella vena.", //1168
	@"Usa il mattone con la sbarra di metallo per forare il coagulo.", //1169
	@"Aspetta finché il robot medico non arriva a prestare le cure, poi esci dalla porta sulla destra.", //1170
//39
	@"Chiudi la calotta sopra l'antro usando il terminale lì vicino.", //1171
	@"Sali sulla copertura dell'antro.", //1172
	@"Tira la sbarra di blocco sulla griglia sopra la tua testa per allentarla.", //1173
	@"Torna nella stanza di sopra.", //1174
//40
	@"Guarda attraverso le griglie per controllare che non ci siano pericoli.", //1175
	@"Guarda attraverso la prima griglia che incontri.", //1176
	@"Vai direttamente nella stanza dove si sta ricaricando il robot medico.", //1177
	@"Usa la scheda madre sul robot medico.", //1178
//41
	@"Parla con Joey e mandalo nella sala dei serbatoi.", //1179
	@"Chiedi a Joey cos'ha visto nella sala dei serbatoi.", //1180
	@"Chiedi a Joey del serbatoio.", //1181
	@"Di' a Joey di aprire il rubinetto.", //1182
	@"Entra nella stanza e guarda morire l'androide.", //1183
//42
	@"Vai a destra dei serbatoi, nella stanza dei computer.", //1184
	@"Usa la tessera ID di Reich con il terminale (a sinistra del banco di computer).", //1185
	@"Apri la porta d'accesso.", //1186
	@"Esci dalla sala dei computer e guarda Joey venire distrutto per l'ennesima volta.", //1187
	@"Prendi la tessera di Gallagher dai suoi resti.", //1188
//43
	@"Torna nella stanza dei computer.", //1189
	@"Entra in LINC usando la tessera di Gallagher.", //1190
//44
	@"Devi entrare in LINC usando la tessera di Gallagher. Esci e poi rientra nuovamente.", //1191
	@"Usa Occlusore sul bulbo oculare nell'area 1. Raggiungi rapidamente l'area 2 e acceca il bulbo oculare.", //1192
	@"Prendi l'oscillatore (diapason).", //1193
	@"Vai nella stanza del Crociato. Usa Ira divina per eliminare il Crociato.", //1194
	@"Entra nella stanza del cristallo. Usa l'oscillatore sul cristallo.", //1195
	@"Prendi il virus. Disconnettiti da LINC.", //1196
//45
	@"Vai nella stanza speciale degli androidi. Apri l'armadietto nella console centrale.", //1197
	@"Inserisci la scheda madre nell'armadietto.", //1198
	@"Usa il monitor per scaricare i dati dalla scheda.", //1199
	@"Esegui il programma di avvio dell'androide.", //1200
//46
	@"Recati nella sala con i serbatoi grandi.", //1201
	@"Chiedi a Joey/Ken di appoggiare la mano sul pannello della porta.", //1202
	@"Appoggia la mano sull'altro pannello.", //1203
//47
	@"Vai al serbatoio di campioni di tessuto e prendi le pinze dal muro (a destra del serbatoio).", //1204
	@"Usa la tessera di Gallagher (o qualunque tessera contenga il virus) sulla console per infettare il tessuto con il virus.", //1205
	@"Prendi un campione di tessuto infetto con le pinze.", //1206
	@"Metti il campione di tessuto nel serbatoio di azoto per congelarlo.", //1207
//48
	@"Arriva alla fine delle tubature. Aggancia il cavo al supporto della tubatura.", //1208
	@"Usa i pioli per scendere nell'orifizio di alimentazione.", //1209
	@"Getta il tessuto infetto nell'orifizio.", //1210
	@"Usa la corda per entrare nell'ultima stanza.", //1211
//49
	@"Quando Joey/Ken entra, digli di sedersi sulla sedia.", //1212

// Missing answers added later

//RECYCLING PLANT 1 
//50
	@"Esplora la fabbrica. Forse riuscirai a rimettere in sesto Joey.", //1213

//INDUSTRIAL 1 
//51
	@"Guardati in giro: ci sarà pure qualcuno che può aiutarti.", //1214
//52
	@"Esplora ancora un po': c'è sicuramente altro da trovare.", //1215
	@"Scendi con l'ascensore al livello inferiore e prendi l'ascensore successivo fino a livello terra.", //1216

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//User Interface and game controls - Help!  (no constraints on text length on these four lines)
	@"Muoversi nell'ambiente di gioco", //1217
	@"Tocca un punto del pavimento e Foster lo raggiungerà, se può. Per lasciare un'area, dovrai interagire con l'icona della freccia d'uscita.", //1218
	@"Interagire con l'ambiente", //1219
	@"Fai scorrere il dito sullo schermo di gioco per trovare i punti d'interazione. Sopra i punti d'interazione comparirà un cerchio blu animato. Fai scorrere il dito sopra il cerchio blu e comparirà un'icona con le azioni che Foster può compiere. Per eseguire l'azione, solleva il dito e tocca l'icona apposita.", //1220
//1268 Increasing the time before going into sleep mode
//1270 To increase the time before your device goes into sleep mode, go to your iPhone 'Settings', then 'General', then 'Auto-Lock'. Choose the desired time setting. 

	@"DUMMY LINE", //1221

//Inventory Instructions  (no constraints on text length on these four lines)
	@"L'inventario: cos'è?", //1222
	@"Gli oggetti che Foster raccoglie finiscono nell'inventario. Tocca l'icona della scatola per vedere gli oggetti nell'inventario. Tocca un oggetto per leggerne la descrizione.", //1223
	@"Come usare un oggetto nell'inventario con oggetti e persone nell'ambiente", //1224
	@"Apri l'inventario e premi su un oggetto finché non compare sopra il dito. Mentre continui a premere sullo schermo, trascina l'oggetto su un punto d'interazione e solleva il dito quando compare un profilo blu intorno all'oggetto.", //1225
	@"Combinare gli oggetti dell'inventario", //1226
	@"Alcune volte sarà necessario combinare due oggetti dell'inventario per crearne un terzo. Per farlo, premi sul primo oggetto per selezionarlo finché non compare sopra il dito. Quindi, trascinalo sul secondo oggetto e solleva il dito quando compare un profilo blu intorno a entrambi.", //1227


//First Screen Walkthrough (no constraints on text length on these four lines)
	@"Guida per far aprire a Foster la porta antincendio", //1228
	@"Fai scorrere il dito sulla ringhiera sul lato sinistro dello schermo. Comparirà un cerchio blu animato sulla ringhiera quando ti avvicini. Una volta toccato con il dito, compariranno due icone: degli ingranaggi che girano (Interagisci) e un occhio (Esamina). Inoltre, la parola Ringhiera comparirà in fondo allo schermo. Solleva il dito e tocca gli ingranaggi: questi lampeggeranno e Foster andrà a prendere la ringhiera. La metterà automaticamente nell'inventario dove apparirà come \"Barra di metallo\".", //1229
	@"LINE DELETED", //1230
	@"Apri l'inventario toccando l'icona della scatola. Premi sull'icona della barra di metallo finché non compare sopra il dito con un profilo blu. Quindi, trascinala sulla porta antincendio finché il dito non è sul cerchio blu e la parola Porta non compare in alto sullo schermo. Solleva il dito. Foster userà la barra di metallo per forzare la porta antincendio e poi uscirà automaticamente. Buona fortuna!", //1231

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Twitter Stuff

//twitter test message
	@"Invia un messaggio: \"Ho appena iniziato a giocare a Beneath a Steel Sky su iPhone/iPod touch! Stai all'erta.\"", //1232

//twitter info
	@"Ci sono diverse interazioni speciali da scoprire sparse in tutto il gioco. Imposta i dettagli di Twitter in modo che Beneath a Steel Sky possa postarli su Twitter quando le scopri.", //1233

//tweets
	@"Ho appena iniziato a giocare a Beneath a Steel Sky su iPhone/iPod touch! Stai all'erta!", //1234
	@"Tweet inviato!", //1235
	@"Impossibile inviare tweet: possibili problemi di connessione.", //1236
	@"Impossibile inviare tweet: controllare nome utente/password.", //1237
	@"Sto scappando in Beneath a Steel Sky. Ho appena rubato la salsiccia liofilizzata di Hobbin. Non so perché la volessi, ma, dopotutto, è un'avventura...", //1238
	@"Ho preso il video sospetto del gatto di Lamb in Beneath a Steel Sky. Non mi fido per niente di quel tipo.", //1239
	@"Sono sfuggito alle avances amorose di Danielle Piermont in Beneath a Steel Sky. Ho buttato il suo cagnaccio in uno stagno... Purtroppo sa nuotare.", //1240
	@"Ho appena fatto scoppiare un vaso sanguigno di un computer della sicurezza in Beneath a Steel Sky. Allora sanguinano davvero. Che schifo!", //1241
	@"Ho appena completato Beneath a Steel Sky su iPhone/iPod touch e ho salvato il mondo!", //1242

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// General Messages

//new game alert
	@"Se ti dovesse servire aiuto con i comandi o volessi suggerimenti sugli enigmi, tocca il punto interrogativo blu.", //1243

//various misc
	@"Dialoghi", //1244
	@"Sottotitoli", //1245
	@"Nome utente", //1246
	@"Password", //1247
	@"Non utilizzato", //1248
	@"Senza nome", //1249
	@"Partita salvata", //1250
	@"Dati di gioco salvati", //1251
	@"Salvataggio partita fallito!", //1252
	@"I dati di gioco NON sono stati salvati", //1253
	@"Suggerimento %d di %d", //1254
	@"Aiuto comandi e suggerimenti enigmi", //1255
	@"OK", //1256
	@"Lingua testi", //1257
	@"Nome utente", //1358
	@"Password", //1359

// Tell a friend email:
	@"Un messaggio da Beneath a Steel Sky", //1260
	@"Ehi!", //1261
	@"Sto giocando all'avventura classica Beneath a Steel Sky, rinnovata e aggiornata con contenuti esclusivi per iPhone e iPod touch.", //1262
	@"Considerata una delle migliori avventure di tutti i tempi, il gioco ora include dei nuovi, fantastici filmati a opera di Dave Gibbons, co-creatore di Watchmen, un sistema d'aiuto integrato al contesto, una nuova interfaccia tattile, audio migliorato e moltissimi contenuti incredibili.", //1263
	@"Essendo una persona magnifica e premurosa, volevo condividere una cosa con te. Clicca sul collegamento per scoprire altre notizie sul gioco: http://www.revolution.co.uk/appstoreBASS", //1264
	@"Non perderlo! Stai all'erta.", //1265

	@"Post con Twitter", //1266

// Added lines in Controls re sleep mode
	@"Posticipare la modalità Sospensione", //1267
	@"Per posticipare la modalità Sospensione di iPhone, vai su Impostazioni, quindi Generale e Blocco automatico. Seleziona l'impostazione di tempo che preferisci. ", //1268

// Intro Text
	@"Narrazione Foster: Il vecchio stava cercando di predire il futuro. Cercava immagini nel fuoco...", //1400
	@"Sciamano: Ohhh, vedo il male...", //1401
	@"Sciamano: Male nato sotto la città... lontano dalla luce del sole.", //1402
	@"Sciamano: Lo vedo crescere, al sicuro, sotto un cielo d'acciaio...", //1403
	@"Sciamano: Trama nell'oscurità... rafforzandosi.", //1404
	@"Sciamano: E ora... ohhh... ora il male dilaga...", //1405
	@"Sciamano: Allunga neri tentacoli sulla terra sopra di lui...", //1406
	@"Sciamano: Attraverso la Radura... tenta di arrivare in questo luogo!", //1407
	@"Narrazione Foster: Gliel'avevo visto fare centinaia di volte, ma lo assecondai.", //1408
	@"Narrazione Foster: Dopotutto, era stato come un padre per me.", //1409
	@"Foster: E cosa vuole il male?", //1410
	@"Sciamano: Oh, figlio mio, temo...", //1411
	@"Sciamano: Temo che voglia te!", //1412
	@"Narrazione Foster: Fu allora che Joey se ne saltò fuori con...", //1413
	@"Joey: Foster! I sensori rilevano una fonte sonora in avvicinamento!", //1414
	@"Sciamano: Il male! Il male è vicino!", //1415
	@"Narrazione Foster: Sembrava più un elicottero che un demone.", //1416
	@"Narrazione Foster: Ma subito dopo, si scatenò comunque l'inferno...", //1417
	@"Sciamano: Corri, Foster! Corri! Nasconditi dal male!", //1418
	@"Joey: Foster! (zzzt) A-Aiuto!", //1419
	@"Joey: Meglio (zzzt) rendere (zzzt) il mio prossimo corpo (zzzt) più veloce...", //1420
	@"Narrazione Foster: Era solo un robot... ma, beh, volevo bene a quel piccoletto.", //1421
	@"Narrazione Foster: Poi, improvvisamente com'erano iniziati, gli spari cessarono.", //1422
	@"Narrazione Foster: Ci fu un momento di silenzio mentre l'elicottero fermava i rotori, e poi...             ", //1423
	@"Reich: La persona che comanda, si faccia avanti...", //1424
	@"Narrazione Foster: Solo uno stupido avrebbe obiettato di fronte a quella potenza di fuoco.", //1426
	@"Sciamano: ...Sono io il capo di questa gente...", //1427
	@"Sciamano: Siamo persone pacifiche...", //1428
	@"Reich: Portatelo qui.", //1429
	@"Soldato: Subito, comandante Reich.", //1430
	@"Reich: Stiamo cercando qualcuno...", //1431
	@"Reich: Qualcuno che non è di queste parti...", //1432
	@"Reich: Che non è nato in questo immondezzaio...", //1433
	@"Reich: Che è arrivato dalla città quand'era bambino...", //1434
	@"Reich: Vogliamo riportarlo a casa.", //1435
	@"Narrazione Foster: Mentre i pensieri mi turbinavano in testa, ricordai dove avevo già visto quel simbolo...", //1436
	@"Narrazione Foster: Era il giorno in cui la tribù mi trovò...", //1437
	@"Narrazione Foster: Il giorno dello schianto...", //1438
	@"Narrazione Foster: Il giorno in cui mia madre morì.", //1439

	@"Uomo della tribù: Stai bene, ragazzo di città?", //1440
	@"Sciamano: Hai un nome, figliolo?", //1441
	@"Foster: R-Robert.", //1442
	@"Sciamano: Ah! Benvenuto nella Radura, Robert!", //1443
	@"Narrazione Foster: Mentre mi curava, il vecchio mi aveva spiegato con dolcezza che non c'era modo di tornare in città...", //1445
	@"Narrazione Foster: E sapevo già che non avrebbe potuto fare nulla per mia madre.", //1446
	@"Narrazione Foster: La tribù era povera, ma mi trattarono come uno di loro...", //1447
	@"Narrazione Foster: Imparai come sopravvivere nella zona che chiamavano la Radura...", //1448
	@"Narrazione Foster: E a cercare ciò di cui avevo bisogno nelle discariche della città.", //1449
	@"Narrazione Foster: Con il passare degli anni, dimenticai la mia vita in città.", //1450
	@"Narrazione Foster: Scoprii nuovi talenti...", //1451

	@"Joey: Sono tuo (zzzt) amico... Chiamami (zzzt) Joey.", //1453
	@"Narrazione Foster: E ricevetti un secondo nome.", //1454
	@"Sciamano: Ora che sei diventato adulto, è così che ti chiameremo, figliolo.", //1455
	@"Sciamano: Ti abbiamo trovato... allevato...", //1456
	@"Sciamano: Quindi ora sei Robert Foster.", //1457
	@"Reich: ...Ho sprecato abbastanza tempo!", //1458
	@"Reich: Dateci il fuggiasco o spareremo a tutti...", //1459
	@"Reich: A partire da te, nonnino!", //1460
	@"Narrazione Foster: Il vecchio aveva indovinato, per una volta...", //1461
	@"Narrazione Foster: Era me che volevano.", //1462
	@"Sciamano: No, figlio mio! Non lasciare che il male ti prenda! Scappa!", //1463
	@"La scansione del DNA conferma che è lui, signore.", //1464
	@"Narrazione Foster: Il male era arrivato nella Radura, proprio come aveva detto.", //1465

	@"Reich: Prendetelo.", //1466
	@"Narrazione Foster: Ma il vecchio aveva visto perché mi cercava?", //1467
	@"Narrazione Foster: O cosa avrebbe fatto dopo?", //1468
	@"Narrazione Foster: Ormai era troppo tardi per chiederglielo.", //1469
	@"Pilota: Abbandoniamo la zona dell'esplosione, comandante Reich.", //1470
	@"Reich: Bene. Detonate.", //1471
	@"Narrazione Foster: Davvero troppo tardi.", //1472

	@"Foster: Perché, assassino...", //1473
	@"Reich: Fatelo stare zitto.", //1474
	@"Narrazione Foster: Non potevo far altro che aspettare.", //1475
	@"Narrazione Foster: Proprio come a caccia. Come mi aveva insegnato il vecchio.", //1476
	@"Narrazione Foster: Aspettare... ed essere pronto.", //1477

	@"Narrazione Foster: Era l'alba quando raggiungemmo la città.", //1478
	@"Reich: Atterrate nel complesso centrale della sicurezza.", //1479
	@"Narrazione Foster: Un'alba che la mia tribù non avrebbe visto.", //1480
	@"Narrazione Foster: Ormai non erano altro che un'annotazione nel libro di Reich.", //1481
	@"Pilota. Signorsì. Aggancio il radiofaro per l'atterraggio automatico.", //1482
	@"Narrazione Foster: Ma cosa rappresentavo? Perché...", //1483

	@"Pilota: Signore! Il sistema di guida! È impazzito!", //1484
	@"Pilota: CI SCHIANTEREMO!", //1485
	@"Narrazione Foster: Forse adesso avrei trovato delle risposte.", //1486
	@"Narrazione Foster: Se fossi sopravvissuto a un altro schianto su un elicottero.", //1487

// Outro Movie text:
	@"Qualche anno dopo...", //1490
	@"In un mondo dove tutti sono liberi, il prezzo della libertà è la schiavitù.", //1491
	@"Stai all'erta!", //1492

};



NSString *deASCII[]=
{
//RECYCLING PLANT
// For 'elevator' see ref line 187
	@"Die Feuertür ist verriegelt – wie öffne ich sie?", //1000
// See line 1050 I've out-foxed the guard - what now?
	@"Wenn Joey doch hier wäre – was mache ich jetzt?", //1001
	@"Wie bringe ich den Lift zum Laufen?", //1002
	@"Wie komme ich in den Liftschacht?", //1003
// For 'furnace' see ref line 4221
	@"Wie komme ich aus dem Schmelzofenraum?", //1004


//INDUSTRIAL 1 
// For 'welder' see ref line 8369
	@"Ich muss den Schweißroboter ausschalten. Hilfe!", //1005
	@"Wie komme ich an die Hülle für Joey?", //1006
	@"Wie komme ich in den Lagerraum?", //1007
// For 'storeroom' see ref line 9212/9221
	@"Was tun, wenn man mir etwas aus dem Lagerraum abnimmt?", //1008
	@"Wie werde ich den Mann im Stromraum los?", //1009
	@"Wie schalte ich den Strom wieder ein?", //1010
// This is a lift elevator - ref 9379
	@"Wie kann ich den Lift verwenden?", //1011

//BELLEVUE 1 
// For 'travel agent' see ref line 12698
	@"Wie kriege ich ein Ticket vom Reiseveranstalter?", //1012
// For 'ticket' see ref line 12727
	@"Was mache ich mit diesem Ticket?", //1013

//INDUSTRIAL 2 
	@"Lamb hat mein Ticket – was jetzt?", //1014

//BELLEVUE 2 
// For 'surgery' see ref line 270
	@"Wie komme ich in die Chirurgie?", //1015
	@"Wie kriege ich einen Schriebmann-Port?", //1016
// For 'anchor' see ref line 539. Please note that anchor refers to the object, and is also the name of the travel agent. 
	@"Wie kriege ich den Anker?", //1017
	@"Ich habe den Anker – was jetzt?", //1018

//INDUSTRIAL 3 
	@"Was mache ich mit diesem Enterhaken?", //1019
// For 'grappling hook' see ref line 320

//SECURITY CENTRE 
// For 'security HQ' see ref line 9018
	@"Ich bin in der Sicherheitszentrale – und jetzt?", //1020

//LINC 1 
	@"Ich stecke in der LINC-Welt fest – was tun?", //1021
	@"Ich bin in einem Cyber-Labyrinth – wie komme ich raus?", //1022
	@"Ich bin durch das Cyber-Labrinth – was jetzt?", //1023

//SECURITY CENTRE 
	@"Wie komme ich aus dem LINC-Raum?", //1024

//HYDE PARK 
	@"Ich bin im Erdgeschoss. Was jetzt?", //1025
// For 'dog buscuits' see ref line 198
	@"Wie komme ich an die Hundekekse?", //1026
	@"Wie komme ich am Wachmann vorbei?", //1027
	@"Ich bin in der Kathedrale – was jetzt?", //1028
	@"Anita wurde ermordet. Was soll ich tun?", //1029

//LINC 2 
	@"Ich habe Anitas Karte – hat sie Hinweise hinterlassen?", //1030

//HYDE PARK 2 
	@"Ich habe Anitas Botschaft gelesen – wie kontaktiere ich Eduardo?", //1031
	@"Ich habe Eduardo kontaktiert. Was jetzt?", //1032
// This is a drinking glass
	@"Ich habe Colstons Glas, aber warum?", //1033

//HYDE PARK 3 
	@"Wie komme ich zur U-Bahn?", //1034
// For 'subway' see ref line 16525
	@"Ich habe ein Loch in das Gitter gemacht – aber es ist zu klein.", //1035
	@"Ich habe ein Loch in das Gitter gemacht – was jetzt?", //1036
// For 'grill' see ref line 17376

//UNDERWORLD 
	@"Irgendeine Kreatur packt mich – wie verhindere ich das?", //1037
	@"Wie komme ich durch die große Metalltür?", //1038
	@"Was mache ich mit dieser seltsamen Grube?", //1039
	@"Was mache ich in dieser seltsamen Unterwelt?", //1040
	@"Wie komme ich an dem Androiden im Labor vorbei?", //1041
	@"Ich habe den Androiden getötet. Was jetzt?", //1042
// For 'android' see ref line 20607
	@"Anita hat etwas von einem Virus erwähnt – wo finde ich ihn?", //1043
// For 'virus' see ref line 24591

//LINC 3 
	@"Ich bin wieder in LINC – wo finde ich den Virus?", //1044

//UNDERWORLD 
	@"Armer Joey – wie belebe ihn wieder? Mal wieder!", //1045
	@"Ich habe Joey in einen Androiden verwandelt. Und jetzt?", //1046
	@"Ich habe den Virus von LINC – wie hole ich ihn in die echte Welt?", //1047
	@"Ich habe infiziertes Gewebe – was jetzt?", //1048
// For 'tissue' (biological tissue) see ref line 20633/20634
	@"Ich habe meinen Vater getroffen – wie rette ich die Menschheit?", //1049

//RECYCLING PLANT 1 
	@"Ich habe den Wachmann überlistet – was jetzt?", //1050

//INDUSTRIAL 1 
	@"Ich bin in einem Industriegebiet. Was soll ich machen?", //1051
	@"Ich habe eine wachsähnliche Substanz gefunden – aber was jetzt?", //1052
// For 'putty' see ref line 168
	@"Ich habe mir auf LINC speziellen Sicherheitsstatus verschafft – was jetzt?", //1053
// For 'status' see ref line 89


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//CONTROLS HELP Subjects - should fit with the Text Box constraints specified above
	@"Benutzeroberfläche und Steuerung – Hilfe!", //1054
	@"Inventar-Anleitung", //1055
	@"Lösung für den ersten Bildschirm", //1056

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//HINT ANSWERS
// No particular constraints on text length - but please not too much longer than English
//------------
	@"Hol dir den Vorsprung, der sich oben bei der Treppe links neben der Brücke befindet.", //1057
// Reference 4295 for term 'rung', 4177 for 'fire door'
	@"Öffne dein Inventar und verwende das Metallstück mit der Feuertür, um sie aufzustemmen. Eine detailliertere Beschreibung findest du in der \"Lösung für den ersten Bildschirm\". ", //1058
//1
// Reference 4194 for term used for 'robot shell', 4546 for 'junk'
	@"Untersuche den Abfall im Vordergrund, um die Roboterhülle zu finden.", //1059
// Reference 16586 for term for 'circuit board', 4185 for 'robot shell'
	@"Verwende die Hauptplatine mit der Roboterhülle.", //1060
//2
	@"Untersuche den Transportroboter.", //1061
// Reference 4426, 4337 for transport robot / droid
	@"Spricht mit Hobbins, bis du ihn nach dem Transportroboter fragen kannst – und er dir sagt, was mit ihm nicht stammt.", //1062
	@"Bitte Joey, den Transportroboter zu aktivieren (unter Umständen musst du dich vorher freundlich mit ihm über die unterschiedlichsten Themen unterhalten).", //1063
//3
	@"Wenn der Lift nach unten fährt, klettere schnell den Schacht hinab.", //1064
//4
	@"Untersuche das Schloss an der Tür.", //1065
	@"Wenn Joey kommt, bitte ihn, die Tür zu öffnen.", //1066

//INDUSTRIAL 1 
//5
	@"Schraubenschlüssel sind äußerst praktische Werkzeuge.", //1067
	@"Hast du in Hobbins' Werkstatt einen Schraubenschlüssel gefunden? Falls nicht, gehe zurück in die Werkstatt, öffne den Schrank und nimm den Schraubenschlüssel.", //1068
	@"Gehe zurück zum Förderband – in dem Raum hinter dem Schweißroboter siehst du einige Zahnräder.", //1069
	@"Wenn du es nicht schon getan hast, sprich mit Anita und dann mit Lamb, bis er geht. Wirf dann den Schraubenschlüssel in die Zahnräder.", //1070
//6
	@"Hole den Schraubenschlüssel aus den Zahnrädern.", //1071
	@"Verwende den Schraubenschlüssel mit dem Schweißroboter.", //1072
	@"Rede mit Joey und biete ihm eine neue Hülle an.", //1073
//7
	@"Versuchen, den Lagerraum zu betreten.", //1074
	@"Sag Joey, er soll den Lagerraum durchsuchen. Wenn er berichtet, dass er den Sicherungskasten gefunden hat, bitte ihn, die Sicherungen herauszunehmen.", //1075
//8
	@"Hebe die Gangway auf dem Boden hoch.", //1076
	@"Hebe das Wachs (Plastiksprengstoff) auf, das unter der Gangway lag. Das ist der einzige Gegenstand, den du behalten kannst, wenn du gehst.", //1077
//9
	@"Verwende den Schraubenschlüssel mit den beiden Knöpfen neben den Rohren auf der rechten Seite.", //1078
	@"Bitte Joey, den rechten Knopf zu drücken und drücke währenddessen den anderen.", //1079
//10
	@"Schalte den Schalter auf dem Kontrollpunkt auf der linken Seite aus.", //1080
	@"Entferne die Glühbirne.", //1081
	@"Klebe das Wachs in die Birnenfassung.", //1082
	@"Schalte den Schalter wieder ein.", //1083
	@"Ziehe den rechten Stromschalter nach unten, um den Lift wieder mit Strom zu versorgen.", //1084
//11
	@"Durchsuche Reichs Leiche im Schmelzofenraum, um seine Ausweiskarte zu erhalten.", //1085
	@"Verwende Reichs Ausweiskarte mit dem Kartenschlitz des Lifts.", //1086

//BELLEVUE 1 
//12
	@"Gehe zu Reichs Wohnung und hebe das Kissen hoch, um eine Motorradzeitschrift zu finden.", //1087
	@"Gehe zum Reiseveranstalter und frage ihn nach den Touren.", //1088
	@"Frage nach der Touristentour.", //1089
	@"Gib ihm deine Motorradzeitschrift im Austausch gegen ein Ticket.", //1090
//13
	@"Gib Lamb das Ticket, um zu einer Tour durch die Rohrfabrik eingeladen zu werden.", //1091

//INDUSTRIAL 2 
//14
	@"Frage Lamb nach der Tour – er geht, wenn er sieht, dass das Förderband angehalten hat.", //1092
	@"Rede mit Anita.", //1093
	@"Sie bietet dir nach einiger Zeit einen \"Jammer\" an – gib ihr Reichs Ausweiskarte.", //1094
// A jammer is hacking software - see ref 8639
	@"Führe die Unterhaltung fort, um von dem Schriebmann-Port zu erfahren.", //1095

//BELLEVUE 2 
//15
	@"Rede mit der Chirurgie-Sekretärin, indem du auf den Projektor klickst.", //1096
	@"Frage nach einem Schriebmann-Port.", //1097
	@"Bitte Joey, mit der Sekretärin zu sprechen, um Zugang zu der Chirurgie zu erhalten.", //1098
//16
	@"Rede mit Burke, bis du das Angebot erhältst, einen Schriebmann-Port zu bekommen.", //1099
//17
	@"Rede nach der Operation weiter mit Burke, um von der \"speziellen Police\" Von Anker zu erfahren.", //1100
	@"Besuche Anker im Versicherungsbüro und erwähne Burkes Namen, um ihn aus dem Zimmer zu schaffen.", //1101
	@"Bitte Joey, den Anker von der Statue zu nehmen.", //1102
	@"Hebe den Anker auf, nachdem Joey den Arm der Statue eingeschmolzen hat.", //1103
//18
	@"Falls du es noch nicht hast, wäre das jetzt ein guter Zeitpunkt, das Kabel zu holen, das im Fabrik-Level hängt.", //1104
	@"Bitte Joey, das lose Kabel abzuschneiden – geh ihm aus dem Weg.", //1105
	@"Hole das Kabel, das in den Belle Vue-Level gefallen ist.", //1106
	@"Verwende den Anker mit dem Kabel, um einen Enterhaken zu bauen.", //1107

//INDUSTRIAL 3 
//19
	@"Gehe zur Feuertür in Hobbins' Recyclinganlage und gehe hinaus auf den Vorsprung.", //1108
	@"Verwende den Enterhaken mit dem Sicherheitsschild an der gegenüberliegenden Wand.", //1109

//SECURITY CENTRE 
//20
	@"Verwende in der Sicherheitszentrale die Ausweiskarte mit dem Schlitz und setze dich.", //1110

//LINC 1 
//21
// These are all specific software package names - please refer to original text files so they match
	@"Hebe den Ball (komprimierte Daten) in Bereich 1 auf.", //1111
	@"Gehe direkt zu Bereich 2 und verwende öffnen (im Inventar) mit der Reisetasche.", //1112
	@"Beschaffe dir die Überraschung (dekomprimieren). Verwende DEKOMPRIMIEREN mit den komprimierten Daten (im Inventar).", //1113
	@"Beschaffe dir das Vergrößerungsglas (entschlüsseln) und verwende es mit bericht.doc und besprechung.doc (im Inventar).", //1114
//22
// This is describing squares on a 3 * 3 grid
	@"Verwende das grüne Passwort in der unteren Reihe / linkes Feld. Verwende das rechte Passwort in der unteren Reihe / mittleres Feld.", //1115
	@"Hebe das grüne Passwort auf und verwende es in der mittleren Reihe / linkes Feld.", //1116
	@"Hebe das rote Passwort auf und verwende es in der mittleren Reihe / mittleres Feld.", //1117
	@"Hebe das grüne Passwort auf und verwende es in der unteren Reihe / rechtes Feld.", //1118
//23
	@"Beschaffe dir das Buch (phoenix.doc).", //1119
	@"Verwende ENTSCHLÜSSELN mit phoenix.doc.", //1120
	@"Beschaffe dir die Büste (Phoenix-Programm).", //1121
	@"Trenne die Verbindung zu LINC.", //1122

//SECURITY CENTRE 
//24
	@"Verwende die Ausweiskarte mit dem LINC-Terminal.", //1123
	@"Wähle \"Sicherheitsdienst.\" Wähle \"Dokumente ansehen\".", //1124
	@"Lies alle Dokumente. Bitte beachte, dass sie vorher im LINC-Raum entschlüsselt werden müssen.", //1125
	@"Wähle \"Besondere Befehle\". Wähle \"Besonderer Statusantrag\".", //1126
	@"Wähle \"Datenänderung\", um Lamb zum D-LINC zu machen.", //1127

//HYDE PARK 
//25
	@"Sprich mit Henri, dem Rausschmeißer, um zu erfahren, wer dich für den Club empfehlen kann.", //1128
	@"Sprich mit Danielle, um in ihre Wohnung eingeladen zu werden.", //1129
	@"Gehe zu Danielles Wohnung.", //1130
//26
	@"Du brauchst das Katzenvideo aus Lambs Wohnung.", //1131
	@"Mache Lamb über Datenänderung im LINC-Terminal zum D-LINC und sprich dann mit ihm.", //1132
	@"Spiele das Video ab, während Danielle telefoniert.", //1133
	@"Hole dir die Hundekekse, während der Hund abgelenkt ist.", //1134
//27
	@"Gehe zur Wippe beim See und verwende die Hundekekse mit dem Brett.", //1135
	@"Wenn der Hund in der Nähe ist, ziehe an dem Seil.", //1136
	@"Wenn der Hund auf das Brett geht, lasse das Seil los.", //1137
//28
	@"Untersuche die Schließfächer in der unteren Ebene – bis du die schreckliche Wahrheit entdeckst.", //1138
//29
	@"Kehre zum Reaktor in der Fabrik zurück und ziehe den Strahlenschutzanzug an.", //1139
	@"Gehe zum Terminal und öffne den Reaktor. Hebe im Reaktor Anitas Ausweiskarte auf.", //1140
	@"Gehe durch das Sicherheitsgebäude wieder zurück.", //1141
	@"Betritt mit Anitas Ausweiskarte LINC.", //1142

//LINC 2 
//30
	@"Verwende \"Blender\" mit dem Augapfel in Bereich 2.", //1143
	@"Verwende \"Playback\" mit dem Hologramm-Projektor (\"Schacht\"), um Anitas Botschaft anzusehen.", //1144
	@"Trenne die Verbindung zu LINC.", //1145

//HYDE PARK 2 
//31
	@"Kehre zum Hyde Park zurück.", //1146
	@"Rede mit Vincent, um von dem Gärtner zu erfahren.", //1147
	@"Rede mit dem Gärtner, bis er dir von dem Virus erzählt.", //1148
//32
	@"Betritt den Gerichtssaal, um Hobbins' Prozess beizuwohnen.", //1149
	@"Gehe zum Club.", //1150
	@"Wähle bei der Musikbox \"Du suchtest, ohne zu finden\".", //1151
	@"Nimm dir Colstons Glas, während er nicht an seinem Tisch ist.", //1152
//33
	@"Gib Burke das Glas, um die Fingerabdrücke abzunehmen.", //1153

//HYDE PARK 3 
//34
	@"Berühre die Platte, um die Tür zum Weinkeller zu öffnen.", //1154
	@"Verwende das Brecheisen mit der großen Kiste auf der linken Seite.", //1155
	@"Nimm dir den Deckel und verwende ihn mit der kleineren Kiste.", //1156
	@"Klettere auf die Kiste.", //1157
	@"Verwende das Brecheisen mit dem Gitter.", //1158
//35
	@"Wenn du die Gartenschere noch nicht gefunden hast, geh zum Schuppen im Park.", //1159
	@"Sieh dir die Tür an.", //1160
	@"Verwende die Ausweiskarte mit dem Schloss.", //1161
	@"Betritt den Schuppen und nimm dir die Gartenschere.", //1162
//36
	@"Verwende die Gartenschere mit dem Gitter.", //1163
	@"Klettere durch das Gitter.", //1164

//UNDERWORLD 
//37
	@"Verwende die Glühbirne mit der Fassung links neben dem Loch der Kreatur.", //1165
//38
	@"Verwende das Brecheisen mit dem bröckeligen Gips und anschließend mit der Backsteinmauer, um einen Backstein zu erhalten.", //1166
	@"-", //1167
	@"Verwende das Brecheisen mit dem Klumpen in der Vene.", //1168
	@"Verwende den Backstein mit dem Brecheisen, um den Klumpen platzen zu lassen.", //1169
	@"Warte, bis der medizinische Roboter kommt, um die Wunde zu reparieren und gehe dann durch die Tür auf der rechten Seite.", //1170
//39
	@"Schließe die Abdeckung über der Mulde über das Terminal neben der Mulde.", //1171
	@"Steige auf die Abdeckung.", //1172
	@"Ziehe an dem Balken über dem Gitter über deinem Kopf, um das Gitter zu lösen.", //1173
	@"Kehre zu dem Raum darüber zurück.", //1174
//40
	@"Sieh durch die Gitter, um bevorstehende Gefahren zu erkennen.", //1175
	@"Sieh durch das erste Gitter, zu dem du kommst.", //1176
	@"Gehe nach rechts zu dem Raum, wo der medizinische Roboter sich auflädt.", //1177
	@"Verwende die Hauptplatine mit dem medizinischen Roboter.", //1178
//41
	@"Rede mit Joey und schicke ihn in den Tankraum.", //1179
	@"Frage Joey, was er im Tankraum gesehen hat.", //1180
	@"Frage Joey nach dem Tank.", //1181
	@"Bitte Joey, den Hahn zu öffnen.", //1182
	@"Betritt den Tankraum und sieh zu, wie der Android in den Tod stürzt.", //1183
//42
	@"Gehe zur rechten Seite der Tanks und betritt den Computerraum.", //1184
	@"Verwende Reichs Ausweichkarte mit dem Terminal (auf der linken Seite der Computerreihe).", //1185
	@"Öffne die Zugangstor.", //1186
	@"Verlasse den Computerraum und sieh zu, wie Joey erneut zerstört wird.", //1187
	@"Nimm dir aus seinen Überresten Gallaghers Karte.", //1188
//43
	@"Kehre zum Computerraum zurück.", //1189
	@"Betrete mit Gallaghers Karte LINC.", //1190
//44
	@"Du musst LINC mit Gallaghers Karte betreten. Verlasse es und kehre wieder zurück.", //1191
	@"Verwende \"Blender\" mit dem Augapfel in Bereich 1. Gehe schnell zu Bereich 2 und blende den Augapfel.", //1192
	@"Hole dir den Oszillator (Stimmgabel).", //1193
	@"Betritt den Kreuzritter-Raum. Verwende \"Göttlicher Zorn\", um den Kreuzritter zu entfernen.", //1194
	@"Betritt den Kristall-Raum. Verwende den Oszillator mit dem Kristall.", //1195
	@"Hole den Virus. Trenne die Verbindung zu LINC.", //1196
//45
	@"Gehe in den speziellen Androiden-Raum. Öffne das Schränkchen in der Mittelkonsole.", //1197
	@"Baue die Hauptplatine in das Schränkchen ein.", //1198
	@"Verwende den Monitor, um die Daten von der Platine herunterzuladen.", //1199
	@"Führe das Androidenstartprogramm aus.", //1200
//46
	@"Gehe nach rechts zu dem Raum mit den großen Tanks.", //1201
	@"Bitte Joey/Ken, seine Hand auf die Platte an der Tür zu legen.", //1202
	@"Lege deine Hand auf die anderen Platte.", //1203
//47
	@"Gehe zum Tank mit Gewebeproben und nimm die Zange von der Wand (gleich rechts neben dem Tank).", //1204
	@"Verwende Gallaghers Karte (oder die Karte mit dem Virus) mit dem Terminal, um das Gewebe mit dem Virus zu infizieren.", //1205
	@"Nimm mit der Zange eine infizierte Gewebeprobe aus dem Tank.", //1206
	@"Lege die Gewebeprobe in den Nitrogentank, um sie einzufrieren.", //1207
//48
	@"Gehe zum Ende der Rohre. Befestige das Kabel an der Rohrhalterung.", //1208
	@"Klettere über die Stufen zur Futteröffnung.", //1209
	@"Wirf das infizierte Bewege in die Öffnung.", //1210
	@"Verwende das hängende Seil, um dich in den letzten Raum zu schwingen.", //1211
//49
	@"Wenn Joey/Ken kommt, bitte ihn, sich in den Stuhl zu setzen.", //1212

// Missing answers added later

//RECYCLING PLANT 1 
//50
	@"Erkunde die Fabrik. Vielleicht kannst du Joey wieder zum Laufen kriegen.", //1213

//INDUSTRIAL 1 
//51
	@"Sieh dich um – irgendwo muss jemand sein, der dir helfen kann.", //1214
//52
	@"Sieh dich noch weiter um – es gibt sicher noch mehr zu finden.", //1215
	@"Fahre mit dem Lift ein Stockwerk nach unten und von dort mit dem nächsten Lift ins Erdgeschoss.", //1216

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//User Interface and game controls - Help!  (no constraints on text length on these four lines)
	@"Bewegung in der Spielwelt", //1217
	@"Tippe einen Punkt auf dem Boden an. Foster begibt sich an diesen Punkt – wenn er kann. Um einen Bereich zu verlassen, musst du mit dem Ausgangspfeil interagieren.", //1218
	@"Interaktion mit der Spielwelt", //1219
	@"Bewege deinen Finger über den Spielbildschirm, um interessante Bereiche (Hotspots) zu finden. Animierte blaue Kreise erscheinen über Hotspots, wenn dein Finger sich ihnen nähert. Bewege deinen Finger über den blauen Kreis, um Aktionssymbole mit den verfügbaren Aktionen anzuzeigen. Um eine Aktion auszuführen, hebe deinen Finger hoch und tippe das entsprechende Symbol an.", //1220
//1268 Increasing the time before going into sleep mode
//1270 To increase the time before your device goes into sleep mode, go to your iPhone 'Settings', then 'General', then 'Auto-Lock'. Choose the desired time setting.  

	@"DUMMY LINE", //1221

//Inventory Instructions  (no constraints on text length on these four lines)
	@"Das Inventar – wie funktioniert es?", //1222
	@"Gegenstände, die Foster aufhebt, werden im \"Inventar\" abgelegt. Tippe die Kiste an, um die Gegenstände im Inventar anzuzeigen. Tippe einen Gegenstand an, um eine Beschreibung davon anzuzeigen.", //1223
	@"Inventargegenstände mit Hintergrundgegenständen und Charakteren verwenden", //1224
	@"Öffne das Inventar und drücke kurz auf einen Gegenstand, bis er über deinem Finger erscheint. Berühre den Bildschirm weiter und ziehe den Gegenstand über einen Hotspot. Lasse ihn los, wenn er blau umrandet ist.", //1225
	@"Inventargegenstände kombinieren", //1226
	@"Manchmal musst du zwei Inventargegenstände kombinieren, um einen neuen Gegenstand zu erschaffen. Wähle dazu den ersten Gegenstand, indem du kurz darauf drückst, bis er über deinem Finger erscheint. Ziehe den Gegenstand jetzt direkt auf den zweiten Gegenstand und lasse los, wenn sie beide blau umrandet sind.", //1227


//First Screen Walkthrough (no constraints on text length on these four lines)
	@"Lösung zur Öffnung der Feuertür", //1228
	@"Bewege deinen Finger über dem Vorsprung auf der linken Seite des Bildschirms. Es erscheint ein blauer Kreis über der Stange, wenn du dich ihm näherst. Wenn dein Finger sich über dem Vorsprung befindet, erscheinen zwei Symbole – Zahnräder (interagieren) und ein Auge (untersuchen) – und das Wort \"Vorsprung\" erscheint am oberen Bildschirmrand. Hebe deinen Finger hoch und tippe die Zahnräder an. Die Zahnräder blinken und Foster geht zu dem Vorsprung und hebt ihn auf. Er legt ihn automatisch in seinem Inventar ab, wo er als \"Metallstück\" erscheint.", //1229
	@"ZEILE GELÖSCHT", //1230
	@"Öffne das Inventar, indem du die Kiste antippst. Drücke kurz auf das Metallstück, bis es blau umrandet über deinem Finger erscheint. Ziehe es zur Feuertür, bis dein Finger über dem blauen Kreis ist und am oberen Bildschirmrand \"Tür\" steht. Hebe dann deinen Finger hoch. Foster hebelt jetzt mit dem Metallstück die Feuertür auf und geht automatisch durch die Tür. Viel Glück.", //1231

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Twitter Stuff

//twitter test message
	@"Testnachricht senden – \"Ich spiele seit kurzem Beneath a Steel Sky auf dem iPhone / iPod touch. Sei wachsam!\"", //1232

//twitter info
	@"Im Spiel sind verschiedene spezielle Interaktionen versteckt, die du entdecken kannst. Richte deine Twitter-Angaben ein, damit Beneath a Steel Sky einen Tweet versendet, wenn du sie entdeckst.", //1233

//tweets
	@"Ich spiele seit kurzem Beneath a Steel Sky auf dem iPhone / iPod touch. Sei wachsam!", //1234
	@"Tweet versendet!", //1235
	@"Tweet konnte nicht versendet werden - möglicher Verbindungsfehler.", //1236
	@"Tweet konnte nicht versendet werden - bitte Benutzername / Passwort überprüfen.", //1237
	@"Auf der Flucht in Beneath a Steel Sky. Habe Hobbins die Wurst geklaut - keine Ahnung, was ich damit soll. Ist ja auch ein Adventure ...", //1238
	@"Habe gerade in Beneath a Steel Sky das Katzenvideo von Lamb an mich genommen. Ich traue dem Typen nicht ...", //1239
	@"Bin den Avancen von Danielle Piermont in Beneath a Steel Sky entkommen. Habe ihren Köter in einen Teich getaucht - er kann schwimmen.", //1240
	@"Habe gerade in Beneath a Steel Sky ein Blutgefäß eines Sicherheitscomputers platzen lassen. Das Ding blutet also. Igitt!", //1241
	@"Habe gerade Beneath a Steel Sky auf dem iPhone / iPod touch durchgespielt und die Welt gerettet!", //1242

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// General Messages

//new game alert
	@"Wenn du Hilfe zur Steuerung brauchst oder einen Tipp zu einem Rätsel willst, tippe dieses blaue Fragezeichen an.", //1243

//various misc
	@"Dialoge", //1244
	@"Untertitel", //1245
	@"Benutzername", //1246
	@"Passwort", //1247
	@"Nicht verwendet", //1248
	@"Unbenannt", //1249
	@"Spiel gespeichert", //1250
	@"Spieldaten erfolgreich gespeichert", //1251
	@"Speichern fehlgeschlagen!", //1252
	@"Spieldaten NICHT gespeichert", //1253
	@"Tipp %d von %d", //1254
	@"Steuerungshilfe und Rätseltipps", //1255
	@"OK", //1256
	@"Textsprache", //1257
	@"Benutzername", //1358
	@"Passwort", //1359

// Tell a friend email:
	@"Eine Nachricht von \"Beneath a Steel Sky\"", //1260
	@"Hey!", //1261
	@"Ich spiele gerade das klassische Adventure \"Beneath a Steel Sky\" in der aktualisierten und verbesserten exklusiven Version für iPhone und iPod touch.", //1262
	@"Das Spiel gilt als eines der besten Adventures aller Zeiten und enthält jetzt coole neue animierte Filme von Dave Gibbons, dem Co-Schöpfer von \"Watchmen\", ein kontextabhängiges Hilfesystem, ein neues Touch-Interface, besseren Ton und – naja, jede Menge cooles Zeug.", //1263
	@"Und weil ich so nett und fürsorglich bin, wollte ich dir von dem Spiel erzählen. Klicke einfach auf diesen Link, um mehr über das Spiel zu erfahren: http://www.revolution.co.uk/appstoreBASS", //1264
	@"Sieh's dir an! Sei wachsam.", //1265

	@"Twitter-Posting", //1266

// Added lines in Controls re sleep mode
	@"Zeit vor Aktivieren des Standby-Modus erhöhen", //1267
	@"Um die Zeit zu erhöhen, bevor dein Gerät den Standby-Modus aktiviert, öffne \"Einstellungen\", dann \"Allgemein\", dann \"Automatische Sperre\" und wähle die gewünschte Einstellung.", //1268

// Intro Text
	@"Foster Over: Der alte Mann wollte die Zukunft vorhersagen. Er hat im Lagerfeuer nach Bildern gesucht ...", //1400
	@"Shaman: Ohhh, ich sehe das Böse!", //1401
	@"Shaman: Das Böse, tief unter der Stadt geboren ... fern vom Tageslicht.", //1402
	@"Shaman: Ich sehe es wachsen, sicher unter einem Himmel aus Stahl ...", //1403
	@"Shaman: Es schmiedet im Dunklen seine Pläne ... sammelt Stärke.", //1404
	@"Shaman: Und jetzt ... ohhh ... jetzt verbreitet sich das Böse ...", //1405
	@"Shaman: Es streckt seine tödlichen Fühler im Land über ihm aus ...", //1406
	@"Shaman: Über den Gap ... und reicht bis hierher, an diesen Ort!", //1407
	@"Foster Over: Ich hatte es schon hundert Mal gesehen, aber ich ließ ihm seinen Spaß.", //1408
	@"Foster Over: Immerhin war er wie ein Vater zu mir gewesen.", //1409
	@"Foster: Und was will dieses Böse hier?", //1410
	@"Shaman: Oh, mein Sohn. Ich fürchte ...", //1411
	@"Shaman: Ich fürchte, das Böse will dich!", //1412
	@"Foster Over: Da meldete Joey sich ...", //1413
	@"Joey: Foster! Sensoren haben eingehende Audioquelle erkannt!", //1414
	@"Shaman: Das Böse! Das Böse ist fast hier ...!", //1415
	@"Foster Over: Es kling eher nach einem Heli als nach einem Dämon ...", //1416
	@"Foster Over: Aber plötzlich brach die Hölle los ...", //1417
	@"Shaman: Lauf, Foster! Lauf! Verstecke dich vor dem Bösen!", //1418
	@"Joey: Foster! (zzzt) H-Hilfe!", //1419
	@"Joey: Mach (zzzt) meinen (zzzt) nächsten Körper (zzzt) schneller ...", //1420
	@"Foster Over: Er war zwar nur ein Roboter, aber ... ich habe den kleinen Kerl geliebt.", //1421
	@"Foster Over: Dann hörten die Schüsse so plötzlich auf, wie sie angefangen hatten.", //1422
	@"Foster Over: Es war einen Moment still, als der Heli seinen Rotor ausschaltete, dann ...    ", //1423
	@"Reich: Wer hier das Sagen hat, soll sich zeigen ...", //1424
	@"Foster Over: Nur ein Idiot hätte nicht gehorcht, bei dieser Feuerkraft.", //1426
	@"Shaman: ... Ich bin der Anführer dieses Volkes ...", //1427
	@"Shaman: Wir sind friedlich ...", //1428
	@"Reich: Bringt ihn her.", //1429
	@"Soldier: Sofort, Commander Reich.", //1430
	@"Reich: Wir suchen jemanden ...", //1431
	@"Reich: Jemanden, der nicht hier hergehört ...", //1432
	@"Reich: Der nicht auf dieser Müllhalde geboren wurde ...", //1433
	@"Reich: Der als Kind aus der Stadt kam ...", //1434
	@"Reich: Wir wollen ihn wieder nach Hause bringen.", //1435
	@"Foster Over: Meine Gedanken überschlagen sich. Ich erinnerte mich, wo ich das Symbol schon einmal gesehen hatte ...", //1436
	@"Foster Over: Es war der Tag, an dem der Stamm mich fand ...", //1437
	@"Foster Over: Der Tag des Unfalls ...", //1438
	@"Foster Over: Der Tag, an dem meine Mutter starb.", //1439

	@"Tribesman: Geht es dir gut, Stadtjunge?", //1440
	@"Shaman: Hast du einen Namen, mein Sohn?", //1441
	@"Foster: R-Robert.", //1442
	@"Shaman: Hah! Willkommen im Gap, Robert!", //1443
	@"Foster Over: Während er mich verarztete, erklärte der alte Mann sanft, dass es keinen Weg zurück in die Stadt gab ...", //1445
	@"Foster Over: Und ich wusste schon, dass er nichts für meine Mutter tun konnte.", //1446
	@"Foster Over: Sein Stamm war arm, aber sie behandelten mich wie einen von ihnen ...", //1447
	@"Foster Over: Ich lernte, in dem Ödland zu überleben, dass sie den Gap nannten ...", //1448
	@"Foster Over: Und auf den Müllhalden der Stadt nach brauchbaren Dingen zu suchen.", //1449
	@"Foster Over: Mit den Jahren vergaß ich mein Leben in der Stadt.", //1450
	@"Foster Over: Ich entdeckte neue Talente ...", //1451

	@"Joey: Ich bin dein (zzzt) Freund ... nenn mich (zzzt) Joey.", //1453
	@"Foster Over: Und bekam einen zweiten Namen.", //1454
	@"Shaman: So werden wir dich nennen, nachdem du nun ein Mann bist, mein Sohn.", //1455
	@"Shaman: Wir haben dich gefunden ... dich aufgezogen ...", //1456
	@"Shaman: Wir nennen dich Robert Foster.", //1457
	@"Reich: ... genug Zeit vergeudet!", //1458
	@"Reich: Gebt die Startbahn frei, sonst erschießen wir euch alle ...", //1459
	@"Reich: Dich zuerst, Opa!", //1460
	@"Foster Over: Dieses Mal hatte der alte Mann Recht gehabt ...", //1461
	@"Foster Over: Ich war es, den sie wollten.", //1462
	@"Shaman: Nein, mein Sohn! Lass nicht zu, dass das Böse dich nimmt! Lauf!", //1463
	@"Soldat: DNA-Scan bestätigt es – er ist es, Sir.", //1464
	@"Foster Over: Das Böse war zum Gap gekommen, genau wie er gesagt hatte.", //1465

	@"Reich: Schnappt ihn euch.", //1466
	@"Foster Over: Aber hatte der alte Mann gesehen, warum es mich wollte?", //1467
	@"Foster Over: Oder was es als nächstes tun würde?", //1468
	@"Foster Over: Nun war es zu spät, ihn zu fragen.", //1469
	@"Pilot: Wir verlassen den Gefahrenbereich, Commander Reich.", //1470
	@"Reich: Gut. Zündung.", //1471
	@"Foster Over: Viel zu spät.", //1472

	@"Foster: Ihr Mörder, ihr verfluchten-", //1473
	@"Reich: Stopft ihm das Maul.", //1474
	@"Foster Over: Ich konnte nur warten.", //1475
	@"Foster Over: Genau wie auf der Jagd. Genau, wie der alte Mann es mir beigebracht hatte.", //1476
	@"Foster Over: Warten ... und bereit sein.", //1477

	@"Foster Over: Es war früher Morgen, als wir die Stadt erreichten.", //1478
	@"Reich: Landen Sie im zentralen Sicherheitsbereich.", //1479
	@"Foster Over: Ein Morgen, den mein Stamm nicht mehr sehen sollte.", //1480
	@"Foster Over: Sie waren nichts weiter als eine Fußnote in Reichs Buch.", //1481
	@"Pilot: Ja, Sir. Docke an automatisches Landesignal an.", //1482
	@"Foster Over: Aber was war ich? Warum wollten-", //1483

	@"Pilot: Sir! Das Lenksystem! Es spielt verrückt!", //1484
	@"Pilot: Wir stürzen ab!!", //1485
	@"Foster Over: Vielleicht würde ich jetzt ein paar Antworten erhalten.", //1486
	@"Foster Over: Falls ich noch einmal einen Hubschrauberabsturz überleben sollte.", //1487

// Outro Movie text:

	@"Einige Jahre später ...", //1490
	@"In einer Welt, in der alle frei waren, ist der Preis für die Freiheit die Sklaverei.", //1491
	@"Sei wachsam!", //1492


};

NSString	*frASCII[]=
{

//RECYCLING PLANT
// For 'elevator' see ref line 187
	@"L'issue est verrouillée. Comment puis-je l'ouvrir?", //1000
// See line 1050 I've out-foxed the guard - what now?
	@"Il me faudrait Joey. Que dois-je faire?", //1001
	@"Comment faire fonctionner cet ascenseur?", //1002
	@"Comment descendre dans la gaine d'ascenseur?", //1003
// For 'furnace' see ref line 4221
	@"Comment sortir de la salle du four?", //1004


//INDUSTRIAL 1 
// For 'welder' see ref line 8369
	@"Je dois désactiver le robot soudeur. A l'aide!", //1005
	@"Comment obtenir la carcasse de robot pour Joey?", //1006
	@"Comment faire pour entrer dans le magasin?", //1007
// For 'storeroom' see ref line 9212/9221
	@"Les objets du magasin me sont confisqués. Comment l'éviter?", //1008
	@"Comment se débarrasser du type dans la salle?", //1009
	@"Comment puis-je rétablir le courant?", //1010
// This is a lift elevator - ref 9379
	@"Comment faire pour utiliser cet ascenseur?", //1011

//BELLEVUE 1 
// For 'travel agent' see ref line 12698
	@"Comment obtenir un billet de l'agent de voyage?", //1012
// For 'ticket' see ref line 12727
	@"Que dois-je faire de ce billet?", //1013

//INDUSTRIAL 2 
	@"Lamb a mon billet. Et maintenant?", //1014

//BELLEVUE 2 
// For 'surgery' see ref line 270
	@"Comment entrer dans la clinique?", //1015
	@"Comment obtenir un port Schriebmann?", //1016
// For 'anchor' see ref line 539. Please note that anchor refers to the object, and is also the name of the travel agent. 
	@"Comment puis-je obtenir cette ancre?", //1017
	@"J'ai l'ancre. Qu'est-ce que je fais maintenant?", //1018

//INDUSTRIAL 3 
	@"Que dois-je faire avec ce grappin?", //1019
// For 'grappling hook' see ref line 320

//SECURITY CENTRE 
// For 'security HQ' see ref line 9018
	@"Je suis dans le Q.G de la Sécurité. Et maintenant?", //1020

//LINC 1 
	@"Je suis prisonnier du monde de LINC. Que dois-je faire?", //1021
	@"Je suis dans un cyber labyrinthe. Comment le traverser?", //1022
	@"J'ai traversé le cyber labyrinthe. Et maintenant?", //1023

//SECURITY CENTRE 
	@"Comment faire pour sortir du LINC-SPACE?", //1024

//HYDE PARK 
	@"J'ai atteint le niveau du sol. Que dois-je faire maintenant?", //1025
// For 'dog buscuits' see ref line 198
	@"Comment obtenir les biscuits pour chien?", //1026
	@"Comment puis-je passer le garde?", //1027
	@"Je suis dans la cathédrale. Et maintenant?", //1028
	@"Anita a été assassinée. Que dois-je faire?", //1029

//LINC 2 
	@"J'ai la carte d'Anita. Aurait-elle laissé des indices?", //1030

//HYDE PARK 2 
	@"J'ai lu le message d'Anita. Comment contacter Eduardo?", //1031
	@"J'ai pris contact avec Eduardo. Et maintenant?", //1032
// This is a drinking glass
	@"J'ai le verre de Colston. Que dois-je en faire?", //1033

//HYDE PARK 3 
	@"Comment faire pour rejoindre le métro?", //1034
// For 'subway' see ref line 16525
	@"Comment puis-je élargir le trou dans la grille?", //1035
	@"J'ai fait un trou dans la grille. Et maintenant?", //1036
// For 'grill' see ref line 17376

//UNDERWORLD 
	@"Il y a une créature qui m'attrape. Comment l'éviter?", //1037
	@"Comment franchir la grosse porte métallique?", //1038
	@"Il y a un puits étrange. Que dois-je faire?", //1039
	@"Qu'est-ce que je fais dans ce monde souterrain?", //1040
	@"Comment passer l'androïde dans le laboratoire?", //1041
	@"J'ai tué l'androïde. Et maintenant?", //1042
// For 'android' see ref line 20607
	@"Anita a parlé d'un virus. Comment le récupérer?", //1043
// For 'virus' see ref line 24591

//LINC 3 
	@"Je suis à nouveau dans LINC. Comment récupérer le virus?", //1044

//UNDERWORLD 
	@"Pauvre Joey... Comment puis-je le ressusciter cette fois?", //1045
	@"J'ai transformé Joey en androïde. Que dois-je en faire?", //1046
	@"J'ai le virus de LINC. Comment l'emporter dans le monde réel?", //1047
	@"J'ai des tissus infectés. Et maintenant?", //1048
// For 'tissue' (biological tissue) see ref line 20633/20634
	@"J'ai rencontré mon père. Comment sauver l'humanité?", //1049

//RECYCLING PLANT 1 
	@"J'ai berné le garde. Et maintenant?", //1050

//INDUSTRIAL 1 
	@"Je suis dans une zone industrielle. Que faire?", //1051
	@"J'ai trouvé une sorte de mastic. Que faut-il en faire?", //1052
// For 'putty' see ref line 168
	@"J'ai obtenu un statut de sécurité spécial dans LINC. Et maintenant?", //1053
// For 'status' see ref line 89


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//CONTROLS HELP Subjects - should fit with the Text Box constraints specified above
	@"Interface utilisateur et commandes de jeu", //1054
	@"Instructions sur l'inventaire", //1055
	@"Guide du premier écran", //1056

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//HINT ANSWERS
// No particular constraints on text length - but please not too much longer than English
//------------
	@"Prenez la barre à gauche de la passerelle en haut de l'escalier.", //1057
// Reference 4295 for term 'rung', 4177 for 'fire door'
	@"Ouvrez votre inventaire, puis utilisez la barre sur l'issue pour forcer la porte. Consultez le \"Guide du premier écran\" pour de plus amples explications.", //1058
//1
// Reference 4194 for term used for 'robot shell', 4546 for 'junk'
	@"Examinez les rebuts au premier plan pour trouver la carcasse de robot.", //1059
// Reference 16586 for term for 'circuit board', 4185 for 'robot shell'
	@"Utilisez le circuit imprimé sur la carcasse de robot.", //1060
//2
	@"Examinez le droïde transporteur.", //1061
// Reference 4426, 4337 for transport robot / droid
	@"Parlez à Hobbins jusqu'à ce que vous puissiez l'interroger sur le droïde transporteur et connaître la cause de sa panne.", //1062
	@"Demandez à Joey de démarrer le droïde transporteur. Il se peut que vous deviez d'abord lui parler gentiment de différents sujets.", //1063
//3
	@"Quand l'ascenseur arrive, descendez rapidement dans la gaine.", //1064
//4
	@"Examinez la serrure de la porte.", //1065
	@"Quand Joey arrive, demandez-lui d'ouvrir la porte.", //1066

//INDUSTRIAL 1 
//5
	@"Vous devez lancer une clef dans les rouages.", //1067
	@"Avez-vous trouvé la clef dans l'atelier de Hobbins? Si ce n'est pas le cas, retournez dans son atelier, ouvrez le placard et prenez la clef.", //1068
	@"Retournez près de la ligne de production. Dans la salle après le robot soudeur, vous verrez des rouages.", //1069
	@"Si ce n'est pas déjà fait, parlez à Anita, puis à Lamb jusqu'à ce qu'il parte. Ensuite, lancez la clef dans les rouages.", //1070
//6
	@"Récupérez la clef dans les rouages.", //1071
	@"Utilisez la clef sur le robot soudeur.", //1072
	@"Parlez à Joey et offrez-lui une nouvelle carcasse.", //1073
//7
	@"Tentez d'entrer dans le magasin.", //1074
	@"Demandez à Joey d'inspecter le magasin. Quand il vous dira qu'il a trouvé la boîte à fusibles, demandez-lui de la désactiver.", //1075
//8
	@"Soulevez la passerelle posée sur le sol.", //1076
	@"Ramassez le mastic (pain de plastic) qui se trouvait sous la passerelle. C'est le seul objet que vous pouvez conserver en partant.", //1077
//9
	@"Utilisez la clef sur chacun des deux boutons sous les tuyaux de droite.", //1078
	@"Dites à Joey d'appuyer sur le bouton de droite et appuyez sur l'autre pendant qu'il s'exécute.", //1079
//10
	@"Appuyez sur l'interrupteur du panneau de contrôle situé à gauche.", //1080
	@"Retirez l'ampoule.", //1081
	@"Mettez le mastic à la place de l'ampoule.", //1082
	@"Appuyez de nouveau sur l'interrupteur.", //1083
	@"Abaissez l'interrupteur de droite pour rétablir le courant de l'ascenseur.", //1084
//11
	@"Examinez le cadavre de Reich dans la salle du four pour obtenir sa carte d'identité.", //1085
	@"Utilisez la carte d'identité de Reich sur la fente de l'ascenseur.", //1086

//BELLEVUE 1 
//12
	@"Allez dans l'appartement de Reich et soulevez l'oreiller pour trouver le magazine de motos.", //1087
	@"Allez voir l'agent de voyage et interrogez-le sur les voyages.", //1088
	@"Interrogez-le sur la visite économique.", //1089
	@"Donnez-lui le magazine de motos en échange d'un billet.", //1090
//13
	@"Donnez le billet à Lamb afin d'être invité à visiter l'usine de tuyaux.", //1091

//INDUSTRIAL 2 
//14
	@"Interrogez Lamb à propos de la visite. Il partira quand il verra que le tapis roulant s'est arrêté.", //1092
	@"Parlez à Anita.", //1093
	@"Elle finira par vous donner un \"brouilleur\". Donnez-lui la carte d'identité de Reich.", //1094
// A jammer is hacking software - see ref 8639
	@"Continuez à parler pour en savoir plus sur le port Schriebmann.", //1095

//BELLEVUE 2 
//15
	@"Cliquez sur le projecteur pour parler à la réceptionniste de la clinique.", //1096
	@"Demandez un port Schriebmann.", //1097
	@"Demandez à Joey de parler à la réceptionniste pour réussir à entrer dans la clinique.", //1098
//16
	@"Parlez à Burke jusqu'à ce qu'il vous propose de vous implanter un port Schriebmann.", //1099
//17
	@"Après l'opération, continuez de parler à Burke pour en savoir plus sur la \"police spéciale\" d'Ancre.", //1100
	@"Allez voir Ancre à son bureau d'assurances et mentionnez le nom de Burke pour lui faire quitter la pièce.", //1101
	@"Demandez à Joey de prendre l'ancre de la statue.", //1102
	@"Ramassez l'ancre une fois que Joey a fait fondre le bras de la statue.", //1103
//18
	@"Si vous ne l'avez pas déjà, allez vous procurer le câble qui pend dans le niveau industriel.", //1104
	@"Demandez à Joey de couper le câble. Ne restez pas sur son chemin.", //1105
	@"Récupérez le câble qui est tombé au niveau Belle Vue.", //1106
	@"Utilisez l'ancre sur le câble pour créer un grappin.", //1107

//INDUSTRIAL 3 
//19
	@"Rendez-vous à l'issue de l'usine de recyclage de Hobbins et sortez sur le rebord.", //1108
	@"Utilisez le grappin sur le panneau de sécurité qui se trouve sur le mur opposé.", //1109

//SECURITY CENTRE 
//20
	@"Dans le Q.G de la Sécurité, utilisez la carte d'identité sur la fente et asseyez-vous.", //1110

//LINC 1 
//21
// These are all specific software package names - please refer to original text files so they match
	@"Prenez la boule (données compactées) dans la zone 1.", //1111
	@"Allez directement à la zone 2 et utilisez \"Ouvrir\" (dans l'inventaire) sur le sac.", //1112
	@"Prenez le cadeau (décompactage). Utilisez \"Décompactage\" sur les données compactées (dans l'inventaire).", //1113
	@"Prenez la loupe (décryptage) et utilisez-la sur rapport.doc et briefing.doc (dans l'inventaire).", //1114
//22
// This is describing squares on a 3 * 3 grid
	@"Utilisez le mot de passe vert sur la case de gauche (ligne inférieure). Utilisez le mot de passe rouge sur la case centrale (ligne inférieure).", //1115
	@"Prenez le mot de passe vert et utilisez-le sur la case de gauche (ligne centrale).", //1116
	@"Prenez le mot de passe rouge et utilisez-le sur la case centrale.", //1117
	@"Prenez le mot de passe vert et utilisez-le sur la case de droite (ligne inférieure).", //1118
//23
	@"Prenez le livre (phoenix.doc).", //1119
	@"Utilisez \"Décryptage\" sur phoenix.doc.", //1120
	@"Prenez le buste (programme phoenix).", //1121
	@"Déconnectez-vous de LINC.", //1122

//SECURITY CENTRE 
//24
	@"Utilisez la carte d'identité sur le terminal LINC.", //1123
	@"Sélectionnez \"Services de sécurité\", puis \"Voir documents\".", //1124
	@"Lisez chaque document (vous devez les avoir décryptés dans le LINC-SPACE).", //1125
	@"Sélectionnez \"Opérations spéciales\", puis \"Demande de statut spécial\".", //1126
	@"Sélectionnez \"Correction du fichier\" pour faire de Lamb un D-LINC.", //1127

//HYDE PARK 
//25
	@"Parlez à Henri, le videur, pour en savoir plus sur le parrainage au club.", //1128
	@"Parlez à Danielle pour qu'elle vous invite dans son appartement.", //1129
	@"Retournez à l'appartement de Danielle.", //1130
//26
	@"Vous aurez besoin de la cassette vidéo sur les chats de l'appartement de Lamb.", //1131
	@"Faites de Lamb un D-LINC en utilisant \"Correction du fichier\" sur le terminal LINC, puis parlez-lui.", //1132
	@"Pendant que Danielle est au téléphone, lancez la lecture de la cassette.", //1133
	@"Pendant que l'attention du chien est détournée, prenez les biscuits pour chien.", //1134
//27
	@"Allez à la balançoire près du lac et utilisez les biscuits pour chien sur la planche.", //1135
	@"Quand le chien se rapproche, tirez sur la corde.", //1136
	@"Quand le chien monte sur la planche, lâchez la corde.", //1137
//28
	@"Examinez les armoires de l'étage inférieur, jusqu'à ce que vous découvriez la terrible vérité.", //1138
//29
	@"Retournez près du réacteur dans l'usine et mettez la combinaison anti-radiations.", //1139
	@"Allez près du terminal et ouvrez le réacteur. A l'intérieur, prenez la carte d'identité d'Anita.", //1140
	@"Traversez le bâtiment de la Sécurité.", //1141
	@"Entrez dans LINC en utilisant la carte d'Anita.", //1142

//LINC 2 
//30
	@"Utilisez \"Aveugler\" sur l'oeil dans la zone 2.", //1143
	@"Utilisez \"Playback\" sur le projecteur holographique (\"puits\") pour voir le message d'Anita.", //1144
	@"Déconnectez-vous de LINC.", //1145

//HYDE PARK 2 
//31
	@"Retournez à Hyde Park.", //1146
	@"Parlez à Vincent pour en savoir plus sur le jardinier.", //1147
	@"Parlez au jardinier jusqu'à ce qu'il vous parle du virus.", //1148
//32
	@"Entrez dans le tribunal pour assister au procès de Hobbins.", //1149
	@"Allez au club.", //1150
	@"Sélectionnez \"Je cherche, mais je ne trouve rien\" sur le jukebox.", //1151
	@"Prenez le verre de Colston pendant qu'il est éloigné de la table.", //1152
//33
	@"Donnez le verre à Burke pour relever les empreintes.", //1153

//HYDE PARK 3 
//34
	@"Touchez la plaque pour ouvrir la porte de la cave.", //1154
	@"Utilisez la barre à mine sur la grande boîte de gauche.", //1155
	@"Prenez le couvercle et utilisez-le sur la plus petite boîte.", //1156
	@"Montez sur la boîte.", //1157
	@"Utilisez la barre à mine sur la grille.", //1158
//35
	@"Si vous n'avez pas encore trouvé le sécateur, allez à la remise dans le parc.", //1159
	@"Regardez la porte.", //1160
	@"Utilisez la carte d'identité sur la serrure.", //1161
	@"Entrez dans la remise et prenez le sécateur.", //1162
//36
	@"Utilisez le sécateur sur la grille.", //1163
	@"Glissez-vous à travers la grille.", //1164

//UNDERWORLD 
//37
	@"Utilisez l'ampoule sur la douille électrique à gauche du trou de la créature.", //1165
//38
	@"Utilisez la barre à mine sur le plâtre friable, puis sur le mur de briques pour obtenir une brique.", //1166
	@"-", //1167
	@"Utilisez la barre à mine sur la cloque de la veine.", //1168
	@"Utilisez la brique sur la barre à mine pour percer la cloque.", //1169
	@"Attendez que le robot médical vienne réparer la veine, puis sortez par la porte de droite.", //1170
//39
	@"Fermez le puits avec le couvercle en utilisant le terminal près du puits.", //1171
	@"Montez sur le couvercle du puits.", //1172
	@"Enlevez la barre qui retient la grille au-dessus de votre tête pour libérer la grille.", //1173
	@"Retournez dans la salle au-dessus.", //1174
//40
	@"Regardez à travers les grilles pour détecter tout danger éventuel.", //1175
	@"Regardez à travers la première grille sur votre chemin.", //1176
	@"Allez directement à la salle dans laquelle le robot médical se recharge.", //1177
	@"Utilisez le circuit imprimé sur le robot médical.", //1178
//41
	@"Parlez à Joey et envoyez-le dans la salle du réservoir.", //1179
	@"Demandez à Joey ce qu'il a vu dans la salle du réservoir.", //1180
	@"Interrogez Joey au sujet du réservoir.", //1181
	@"Dites à Joey d'ouvrir le robinet.", //1182
	@"Entrez dans la salle du réservoir et regardez l'androïde faire une chute mortelle.", //1183
//42
	@"Entrez dans la salle informatique à droite des réservoirs.", //1184
	@"Utilisez la carte d'identité de Reich sur le terminal (à gauche des ordinateurs).", //1185
	@"Ouvrez la porte d'accès.", //1186
	@"Quittez la salle informatique et regardez Joey se faire détruire une nouvelle fois.", //1187
	@"Prenez la carte de Gallagher sur son cadavre.", //1188
//43
	@"Retournez dans la salle informatique.", //1189
	@"Entrez dans LINC en utilisant la carte de Gallagher.", //1190
//44
	@"Vous devez entrer dans LINC en utilisant la carte de Gallagher. Sortez, puis revenez.", //1191
	@"Utilisez \"Aveugler\" sur l'oeil dans la zone 1. Allez rapidement dans la zone 2 et aveuglez l'oeil.", //1192
	@"Prenez l'oscillateur (diapason).", //1193
	@"Allez dans la salle du croisé. Utilisez \"Colère divine\" pour faire disparaître le croisé.", //1194
	@"Entrez dans la salle du cristal. Utilisez l'oscillateur sur le cristal.", //1195
	@"Récupérez le virus. Déconnectez-vous de LINC.", //1196
//45
	@"Allez dans la salle de l'androïde spécial. Ouvrez le placard de la console centrale.", //1197
	@"Insérez le circuit imprimé dans le placard.", //1198
	@"Utilisez le moniteur pour télécharger les données du circuit.", //1199
	@"Exécutez le programme de démarrage de l'androïde.", //1200
//46
	@"Allez directement dans la salle avec les grands réservoirs.", //1201
	@"Demandez à Joey/Ken de placer sa main sur le panneau de la porte.", //1202
	@"Placez votre main sur l'autre panneau.", //1203
//47
	@"Allez au réservoir d'échantillons de tissus et prenez la pince sur le mur (juste à droite du réservoir).", //1204
	@"Utilisez la carte de Gallagher (ou toute autre carte contenant le virus) sur la console pour infecter les tissus avec le virus.", //1205
	@"Récupérez un échantillon de tissus infectés avec la pince.", //1206
	@"Placez l'échantillon de tissus dans la cuve d'azote pour le geler.", //1207
//48
	@"Allez à l'extrémité des tuyaux. Fixez le câble au support de tuyau.", //1208
	@"Utilisez les barreaux pour descendre jusqu'à l'orifice d'alimentation.", //1209
	@"Laissez tomber les tissus infectés dans l'orifice.", //1210
	@"Utilisez la corde qui pend pour vous balancer jusqu'à la salle finale.", //1211
//49
	@"Lorsque Joey/Ken entre, dites-lui de s'asseoir sur la chaise.", //1212

// Missing answers added later

//RECYCLING PLANT 1 
//50
	@"Explorez l'usine. Vous pourrez peut-être réparer Joey.", //1213

//INDUSTRIAL 1 
//51
	@"Explorez les lieux. Quelqu'un doit pouvoir vous aider.", //1214
//52
	@"Poursuivez votre exploration. Vous avez sûrement raté quelque chose.", //1215
	@"Prenez l'ascenseur pour descendre à l'étage inférieur, puis descendez au niveau du sol avec l'ascenseur suivant.", //1216

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//User Interface and game controls - Help!  (no constraints on text length on these four lines)
	@"Se déplacer dans l'environnement", //1217
	@"Touchez un endroit du sol pour que Foster marche jusque là, s'il le peut. Pour quitter une zone, vous devez interagir avec l'icône de la flèche de sortie.", //1218
	@"Interagir avec l'environnement", //1219
	@"Faites glisser votre doigt sur l'écran de jeu pour trouver des points d'intérêt. Des cercles bleus animés apparaissent au-dessus de ces points quand votre doigt s'en approche. Faites glisser votre doigt sur un cercle bleu pour afficher les icônes d'actions indiquant ce que Foster peut faire. Pour effectuer une action, relevez votre doigt, puis touchez l'icône correspondante.", //1220
//1267 Increasing the time before going into sleep mode
//1268To increase the time before your device goes into sleep mode, go to your iPhone 'Settings', then 'General', then 'Auto-Lock'. Choose the desired time setting.  

	@"DUMMY LINE", //1221

//Inventory Instructions  (no constraints on text length on these four lines)
	@"Qu'est-ce que l'inventaire?", //1222
	@"Les objets que Foster ramasse sont placés dans son \"inventaire\". Touchez l'icône représentant un coffre pour afficher les objets de l'inventaire, puis touchez un objet pour en obtenir une description.", //1223
	@"Utiliser un objet de l'inventaire sur un objet ou un personnage de l'environnement", //1224
	@"Ouvrez l'inventaire et appuyez sur un objet jusqu'à ce qu'il apparaisse au-dessus de votre doigt. En continuant d'appuyer sur l'écran, faites glisser l'objet vers un point d'intérêt et relevez votre doigt quand il s'affiche avec un liseré bleu.", //1225
	@"Combiner des objets de l'inventaire", //1226
	@"Vous devrez parfois combiner deux objets de l'inventaire pour en créer un troisième. Pour ce faire, sélectionnez le premier objet en appuyant dessus jusqu'à ce qu'il apparaisse au-dessus de votre doigt, puis faites-le glisser sur le second objet et relevez votre doigt lorsque les deux objets s'affichent avec un liseré bleu.", //1227


//First Screen Walkthrough (no constraints on text length on these four lines)
	@"Guide pour ouvrir l'issue avec Foster", //1228
	@"Faites glisser votre doigt sur la barre située tout à gauche de l'écran. Un cercle bleu s'anime au-dessus de la barre quand votre doigt s'en approche. Une fois votre doigt sur la barre, deux icônes s'affichent : des rouages tournants (interagir) et un oeil clignant (examiner). Le mot \"Barre\" s'affiche également en haut de l'écran. Relevez votre doigt et touchez les rouages. Les rouages clignotent alors et Foster marche jusqu'à la barre pour la prendre. La barre est placée automatiquement dans son inventaire et appelée \"Barre de métal\".", //1229
	@"LIGNE SUPPRIMEE", //1230
	@"Ouvrez l'inventaire en touchant l'icône représentant une boîte. Appuyez sur l'icône de la barre de métal jusqu'à ce qu'elle s'affiche au-dessus de votre doigt avec un liseré bleu, faites-la glisser vers l'issue jusqu'à ce que votre doigt soit sur le cercle bleu et que le mot \"Porte\" s'affiche en haut de l'écran, puis relevez votre doigt. Foster utilise alors la barre de métal pour forcer la porte, puis sort automatiquement. Bonne chance!", //1231

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Twitter Stuff

//twitter test message
	@"Envoyer le message de test : \"Je viens de commencer à jouer à Beneath a Steel Sky sur iPhone / iPod touch. Soyez Vigilants!\"", //1232

//twitter info
	@"Il y a plusieurs interactions spéciales cachées à trouver dans le jeu. Configurez vos détails Twitter pour que Beneath a Steel Sky puisse poster un message sur Twitter quand vous en découvrez une.", //1233

//tweets
	@"Je viens de commencer à jouer à Beneath a Steel Sky sur iPhone / iPod touch. Soyez Vigilants!", //1234
	@"Tweet envoyé!", //1235
	@"Impossible d'envoyer le tweet. Problème de connexion possible.", //1236
	@"Impossible d'envoyer le tweet. Vérifiez le nom d'utilisateur / mot de passe.", //1237
	@"Je suis en fuite dans Beneath a Steel Sky. Je viens de faucher la saucisse de Hobbins. Je ne sais pas trop pourquoi, mais c'est un jeu d'aventure, après tout...", //1238
	@"Je viens de prendre la cassette vidéo sur les chats de Lamb dans Beneath a Steel Sky. Je ne lui fais absolument pas confiance.", //1239
	@"Je viens de me dérober aux avances de Danielle Piermont dans Beneath a Steel Sky. J'ai envoyé son clébard dans un étang. Heureusement qu'il sait nager!", //1240
	@"Je viens de percer la veine d'un ordinateur de sécurité dans Beneath a Steel Sky. Ce truc saigne, c'est dégoûtant!", //1241
	@"Je viens de terminer Beneath a Steel Sky sur iPhone/iPod touch et j'ai sauvé le monde!", //1242

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// General Messages

//new game alert
	@"Si vous avez besoin d'aide avec les commandes ou d'une astuce pour les énigmes, touchez l'icône représentant un point d'interrogation bleu.", //1243

//various misc
	@"Dialogues", //1244
	@"Sous-titres", //1245
	@"Nom d'utilisateur", //1246
	@"Mot de passe", //1247
	@"Non utilisé", //1248
	@"Pas de nom", //1249
	@"Partie sauvegardée", //1250
	@"Les données de jeu ont été sauvegardées", //1251
	@"Echec de la sauvegarde!", //1252
	@"Les données de jeu n'ont pas été sauvegardées.", //1253
	@"Astuce %d sur %d", //1254
	@"Aide sur les commandes et astuces de jeu", //1255
	@"OK", //1256
	@"Langue des textes", //1257
	@"Nom d'utilisateur", //1358
	@"Mot de passe", //1359

// Tell a friend email:
	@"Message de \"Beneath a Steel Sky\"", //1260
	@"Salut!", //1261
	@"Je suis en train de jouer à l'aventure classique \"Beneath a Steel Sky\", améliorée et mise à jour en exclusivité sur iPhone et iPod touch.", //1262
	@"Ce jeu, qui est considéré comme l'une des meilleures aventures jamais écrites, propose de nouvelles séquences animées étonnantes créées par Dave Gibbons, le co-créateur de \"Watchmen\", mais aussi un système d'aide contextuel, une nouvelle interface tactile, des sons améliorés et un tas d'autres trucs super.", //1263
	@"Comme je suis quelqu'un de merveilleux et d'attentionné, j'ai voulu t'en faire profiter. Clique sur le lien suivant pour en savoir plus sur le jeu : http://www.revolution.co.uk/appstoreBASS", //1264
	@"C'est un jeu à ne pas manquer! Et Soyez Vigilants.", //1265

	@"Envoi d'un tweet...", //1266

// Added lines in Controls re sleep mode
	@"Augmenter la durée avant la mise en veille", //1267
	@"Pour augmenter la durée avant que votre appareil ne se mette en veille, ouvrez les \"Réglages\" de votre iPhone, sélectionnez \"Général\", puis \"Verrouillage auto.\" et choisissez la durée souhaitée.", //1268

// Intro Text
	@"Foster (voix off): Le vieil homme tentait de voir l'avenir en cherchant des images dans le feu de camp...", //1400
	@"Chamane: Ohhh, je vois le diable...", //1401
	@"Chamane: Un diable né sous la ville... loin de la lumière du jour.", //1402
	@"Chamane: Je le vois grandir, à l'abri sous un ciel d'acier...", //1403
	@"Chamane: Il complote dans le noir... rassemble ses forces.", //1404
	@"Chamane: Et à présent... ohhh.... à présent, le diable étend son emprise.", //1405
	@"Chamane: Il envoie des antennes mortelles vers le monde du dessus...", //1406
	@"Chamane: A travers le ravin... en direction de cet endroit même!", //1407
	@"Foster (voix off): Je l'avais vu faire ça une bonne centaine de fois, mais je me moquais de lui.", //1408
	@"Foster (voix off): Après tout, il était comme un père pour moi.", //1409
	@"Foster: Et qu'espère-t-il trouver ici, ce diable?", //1410
	@"Chamane: Oh, mon fils. Je crains...", //1411
	@"Chamane: Je crains que le diable ne te cherche, toi!", //1412
	@"Foster (voix off): C'est à ce moment-là que Joey est intervenu...", //1413
	@"Joey: Foster! Les capteurs détectent un signal audio!", //1414
	@"Chamane: Le diable! Le diable est tout proche!", //1415
	@"Foster (voix off): Ca ressemblait plus à un hélico qu'à un démon.", //1416
	@"Foster (voix off): Mais l'instant d'après, l'enfer s'était déchainé sur nous...", //1417
	@"Chamane: Cours, Foster! Cours! Cache-toi du diable!", //1418
	@"Joey: Foster! (zzzt) Au...au secours!", //1419
	@"Joey: Il faudra (zzzt) que mon (zzzt) prochain corps soit (zzzt) plus rapide...", //1420
	@"Foster (voix off): Ce n'était qu'un robot, mais, comment dire, je l'aimais.", //1421
	@"Foster (voix off): Puis, aussi brusquement qu'elle avait commencé, la fusillade cessa.", //1422
	@"Foster (voix off): Il y eut un instant de silence quand l'hélico arrêta ses rotors, puis...", //1423
	@"Reich: Il y a un responsable ici? Si oui, qu'il se montre!", //1424
	@"Foster (voix off): Seul un idiot aurait tenté de discutailler face à une telle puissance de feu.", //1426
	@"Chamane: ... Je suis le chef de ces gens...", //1427
	@"Chamane: Nous sommes pacifiques...", //1428
	@"Reich: Amenez-le ici.", //1429
	@"Soldat: Tout de suite, commandant Reich.", //1430
	@"Reich: Nous cherchons quelqu'un.", //1431
	@"Reich: Quelqu'un qui n'est pas d'ici...", //1432
	@"Reich: Qui n'est pas né dans cette décharge...", //1433
	@"Reich: Qui est arrivé de la ville encore enfant...", //1434
	@"Reich: Nous voulons le ramener chez lui.", //1435
	@"Foster (voix off): En un éclair, je me rappelai où j'avais déjà vu ce symbole...", //1436
	@"Foster (voix off): C'était le jour où la tribu m'avait trouvé...", //1437
	@"Foster (voix off): Le jour du crash...", //1438
	@"Foster (voix off): Le jour où ma mère est morte.", //1439

	@"Membre de la tribu: Tu vas bien, petit?", //1440
	@"Chamane: Tu as un nom, fils?", //1441
	@"Foster: R-Robert.", //1442
	@"Chamane: Ah! Bienvenue au Ravin, Robert!", //1443
	@"Foster (voix off): Tout en me soignant, le vieil homme m'expliqua gentiment qu'il n'y avait aucun moyen de retourner en ville...", //1445
	@"Foster (voix off): Et je savais déjà qu'il ne pouvait plus rien pour ma mère.", //1446
	@"Foster (voix off): Sa tribu était pauvre, mais ses membres me traitèrent comme l'un des leurs.", //1447
	@"Foster (voix off): J'appris à survivre dans les étendues désertes qu'on appelle le Ravin...", //1448
	@"Foster (voix off): Et à fouiller dans les détritus de la ville.", //1449
	@"Foster (voix off): Les années passant, j'oubliai mon ancienne vie de citadin.", //1450
	@"Foster (voix off): Et je me découvris de nouveaux talents...", //1451

	@"Joey: Je suis ton (zzzt) ami... tu peux m'appeler (zzzt) Joey.", //1453
	@"Foster (voix off): Et j'obtins un nom de famille.", //1454
	@"Chamane: C'est ainsi que nous t'appellerons maintenant que tu es adulte, fils.", //1455
	@"Chamane: Nous t'avons trouvé... et adopté...", //1456
	@"Chamane: Alors tu porteras notre nom. Robert Foster.", //1457
	@"Reich: ... J'ai assez perdu de temps!", //1458
	@"Reich: Donnez-nous le fugitif ou nous tuons tout le monde...", //1459
	@"Reich: En commençant par toi, grand-père!", //1460
	@"Foster (voix off): Le vieil homme avait raison pour une fois...", //1461
	@"Foster (voix off): C'était moi qu'ils voulaient.", //1462
	@"Chamane: Non, mon fils! Ne laisse pas le diable t'emmener! Cours!", //1463
	@"Soldat: L'analyse ADN confirme que c'est lui, chef.", //1464
	@"Foster (voix off): Le diable était arrivé au Ravin, comme il l'avait dit.", //1465

	@"Reich: Attrapez-le.", //1466
	@"Foster (voix off): Mais le vieil homme avait-il vu pourquoi il me voulait?", //1467
	@"Foster (voix off): Ou ce qu'il ferait ensuite?", //1468
	@"Foster (voix off): Il était trop tard pour le lui demander.", //1469
	@"Pilote: On quitte la zone de destruction, commandant Reich.", //1470
	@"Reich: Bien. Déclenchez l'explosion.", //1471
	@"Foster (voix off): Beaucoup trop tard.", //1472

	@"Foster: Sale assassin...", //1473
	@"Reich: Faites-le taire.", //1474
	@"Foster (voix off): Il ne me restait plus qu'à attendre...", //1475
	@"Foster (voix off): Comme à la chasse. Comme le vieil homme me l'avait appris.", //1476
	@"Foster (voix off): Attendre... et être prêt.", //1477

	@"Foster (voix off): L'aube pointait quand nous atteignîmes la ville.", //1478
	@"Reich: Posez-vous dans le complexe central de la Sécurité.", //1479
	@"Foster (voix off): Une aube que ma tribu ne verrait jamais.", //1480
	@"Foster (voix off): Ils n'étaient rien de plus qu'un détail pour Reich.", //1481
	@"Pilote: Bien, chef. Verrouillage de la balise d'atterrissage automatique.", //1482
	@"Foster (voix off): Mais qu'étais-je, moi? Pourquoi...", //1483

	@"Pilote: Chef! Le système de guidage! Il ne répond plus!", //1484
	@"Pilote: On va S'ECRASER!", //1485
	@"Foster (voix off): J'allais peut-être pouvoir obtenir des réponses.", //1486
	@"Foster (voix off): Si je survivais à un autre crash d'hélico.", //1487

// Outro Movie text:

	@"Quelques années plus tard…", //1490
	@"Dans un monde où chacun est libre, le prix de la liberté est l'esclavage.", //1491
	@"Soyez Vigilants...", //1492
};


NSString	*ukASCII[]=
{
//RECYCLING PLANT
// For 'elevator' see ref line 187
	@"The Firedoor is locked – how do I open it?", //1000
// See line 1050 I've out-foxed the guard - what now?
	@"I do wish that Joey was with me – what should I do?", //1001
	@"How do I get that elevator working?", //1002
	@"How do I get down the elevator shaft?", //1003
// For 'furnace' see ref line 4221
	@"How do I get out of the furnace room?", //1004


//INDUSTRIAL 1 
// For 'welder' see ref line 8369
	@"I need to de-activate the welder robot. Help!", //1005
	@"How do I get the welder shell for Joey?", //1006
	@"How can I get into the storeroom?", //1007
// For 'storeroom' see ref line 9212/9221
	@"How can I stop things I get from the storeroom being confiscated?", //1008
	@"How can I get rid of the man in the power room?", //1009
	@"How can I restore power?", //1010
// This is a lift elevator - ref 9379
	@"How can I use that elevator?", //1011

//BELLEVUE 1 
// For 'travel agent' see ref line 12698
	@"How do I get a ticket from the travel agent?", //1012
// For 'ticket' see ref line 12727
	@"What should I do with this ticket?", //1013

//INDUSTRIAL 2 
	@"Lamb has my ticket – what now?", //1014

//BELLEVUE 2 
// For 'surgery' see ref line 270
	@"How do I get into the surgery?", //1015
	@"How do I get a Schriebmann port?", //1016
// For 'anchor' see ref line 539. Please note that anchor refers to the object, and is also the name of the travel agent. 
	@"How can I get that anchor?", //1017
	@"I’ve got the anchor – what now?", //1018

//INDUSTRIAL 3 
	@"What do I do with this grappling hook?", //1019
// For 'grappling hook' see ref line 320

//SECURITY CENTRE 
// For 'security HQ' see ref line 9018
	@"I’m in the security HQ. What next?", //1020

//LINC 1 
	@"I’m stuck in the LINC world – what should I do?", //1021
	@"I’m in a cyber maze – how do I get through it?", //1022
	@"I’m through the cyber maze – what now?", //1023

//SECURITY CENTRE 
	@"How do I get out of LINC space?", //1024

//HYDE PARK 
	@"I’ve got to ground level. What should I do now?", //1025
// For 'dog buscuits' see ref line 198
	@"How do I get those dog biscuits?", //1026
	@"How do I get past the security man?", //1027
	@"I’m in the cathedral – what now?", //1028
	@"Anita’s been murdered. What should I do?", //1029

//LINC 2 
	@"I’ve got Anita’s card – maybe she left some clues?", //1030

//HYDE PARK 2 
	@"I’ve read Anita’s message – how do I make contact with Eduardo?", //1031
	@"I’ve made contact with Eduardo. What now?", //1032
// This is a drinking glass
	@"I’ve got Colston’s glass, but why?", //1033

//HYDE PARK 3 
	@"How do get through to the subway?", //1034
// For 'subway' see ref line 16525
	@"I’ve made a hole in the grill – how do I enlarge the hole?", //1035
	@"I’ve made a hole in the grill – what now?", //1036
// For 'grill' see ref line 17376

//UNDERWORLD 
	@"There’s a creature that grabs me – how can I avoid it?", //1037
	@"How do I get through the big metal door?", //1038
	@"There’s a strange pit – what do I do with it?", //1039
	@"What do I do in this strange underworld?", //1040
	@"How can we get past the android in the lab?", //1041
	@"I killed the android. What next?", //1042
// For 'android' see ref line 20607
	@"Anita mentioned a virus – how do I get it?", //1043
// For 'virus' see ref line 24591

//LINC 3 
	@"I'm back in LINC – how do I get the virus?", //1044

//UNDERWORLD 
	@"Poor old Joey – how do I get resurrect him? Again!", //1045
	@"I’ve turned Joey into an android. What I do with him?", //1046
	@"I’ve got the virus from LINC – how do I get it into the real world?", //1047
	@"I’ve got some infected tissue – what now?", //1048
// For 'tissue' (biological tissue) see ref line 20633/20634
	@"I’ve met my own father – how do I save humanity?", //1049

//RECYCLING PLANT 1 
	@"I've out-foxed the guard - what now?", //1050

//INDUSTRIAL 1 
	@"I'm in an industrial area. What should I do?", //1051
	@"I've found some putty-like substance - but what now?", //1052
// For 'putty' see ref line 168
	@"I've given myself special security status on LINC - now what?", //1053
// For 'status' see ref line 89


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//CONTROLS HELP Subjects - should fit with the Text Box constraints specified above
	@"User interface and game controls – help!", //1054
	@"Inventory Instructions", //1055
	@"First screen walkthrough", //1056

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//HINT ANSWERS
// No particular constraints on text length - but please not too much longer than English
//------------
	@"Get the rung from the top of the stairs on the left of the gantry.", //1057
// Reference 4295 for term 'rung', 4177 for 'fire door'
	@"Open your inventory and use the rung on the fire door to lever it open. See the 'First Screen Walkthrough' for detailed explanation. ", //1058
//1
// Reference 4194 for term used for 'robot shell', 4546 for 'junk'
	@"Examine the junk in the foreground to reveal the robot shell.", //1059
// Reference 16586 for term for 'circuit board', 4185 for 'robot shell'
	@"Use the circuit board on the robot shell.", //1060
//2
	@"Examine the transport droid.", //1061
// Reference 4426, 4337 for transport robot / droid
	@"Talk to Hobbins until you get option to ask him about the transport droid – and he tells you what’s wrong with it.", //1062
	@"Ask Joey to start the transport droid (you may need to talk nicely to him about a range of subjects beforehand).", //1063
//3
	@"When the elevator descends, quickly climb down the shaft.", //1064
//4
	@"Examine the lock on the door.", //1065
	@"When Joey arrives, ask him to open the door.", //1066

//INDUSTRIAL 1 
//5
	@"You need to ‘throw a wrench in the works’.", //1067
	@"Did you find the wrench in Hobbins’s workshop? If not, then return to Hobbins’s workshop, open the cupboard and take the wrench.", //1068
	@"Return to the production line – in the room beyond the welder robot you will see some gears.", //1069
	@"If you haven’t done so, talk to Anita and then Lamb until he leaves. Then throw the wrench into the gears.", //1070
//6
	@"Retrieve the wrench from the cogs.", //1071
	@"Use the wrench on the welder robot.", //1072
	@"Talk to Joey, and offer him a new shell.", //1073
//7
	@"Attempt to enter the storeroom.", //1074
	@"Tell Joey to check out the storeroom. When he reports that he has found the fusebox, tell him to disable the fuse box.", //1075
//8
	@"Lift the gangway on the floor.", //1076
	@"Pick up the putty (plastic explosive) which was under the gangway. This is the only object that you can keep after leaving.", //1077
//9
	@"Use the wrench on each of the two buttons beneath the pipes on the right.", //1078
	@"Tell Joey to press the right hand button, then press the other as he does so.", //1079
//10
	@"Turn off the switch on the control panel on the left.", //1080
	@"Remove the light bulb.", //1081
	@"Put the putty in the light fitting.", //1082
	@"Turn the switch back on.", //1083
	@"Pull the right hand power switch down to restore power to the lift.", //1084
//11
	@"Examine Reich’s corpse in the furnace room to get his ID.", //1085
	@"Use Reich’s ID card on the lift slot.", //1086

//BELLEVUE 1 
//12
	@"Go to Reich’s apartment and lift the pillow to reveal a motorbiking magazine.", //1087
	@"Go to the travel agent and ask him about the tours.", //1088
	@"Ask for the economy tour.", //1089
	@"Give him the motorbiking magazine in return for a tour ticket.", //1090
//13
	@"Give the ticket to Lamb to be invited on a tour of the pipe factory.", //1091

//INDUSTRIAL 2 
//14
	@"Ask Lamb about the tour – he will leave when he sees that the conveyor has stopped.", //1092
	@"Talk to Anita.", //1093
	@"She will eventually offer you a “jammer” – give her Reich’s ID.", //1094
// A jammer is hacking software - see ref 8639
	@"Talk further to learn about the Schriebmann port.", //1095

//BELLEVUE 2 
//15
	@"Talk to the surgery receptionist by clicking on the projector.", //1096
	@"Ask for a Schriebmann port.", //1097
	@"Ask Joey to talk to the receptionist to gain admittance to the surgery.", //1098
//16
	@"Talk to Burke until you get an offer to fit a Schriebmann port.", //1099
//17
	@"After the operation, keep talking to Burke to learn about Anchor’s “special policy”.", //1100
	@"Visit Anchor in the insurance office and mention Burke’s name to get him out of the room.", //1101
	@"Ask Joey to get the anchor from the statue.", //1102
	@"Pick up the anchor after Joey has melted the statue’s arm.", //1103
//18
	@"If you don’t have it, now would be a good time to get the cable hanging from the Industrial level.", //1104
	@"Ask Joey to cut the loose cable - get out of his way.", //1105
	@"Retrieve the cable which has fallen onto the Belle Vue level.", //1106
	@"Use the anchor on the cable to create a grappling hook.", //1107

//INDUSTRIAL 3 
//19
	@"Go to the fire door in Hobbins's recycling plant and walk out on the ledge.", //1108
	@"Use the grappling hook on the security sign on the opposite wall.", //1109

//SECURITY CENTRE 
//20
	@"In the Security HQ, use the ID card on the slot and sit down.", //1110

//LINC 1 
//21
// These are all specific software package names - please refer to original text files so they match
	@"Pick up the ball (compressed data) in area 1.", //1111
	@"Go right to area 2 and use open (in inventory) on the carpet bag.", //1112
	@"Get the birthday surprise (decompress). Use decompress on compressed data (in inventory).", //1113
	@"Get magnifying glass (decrypt) and use it on report.doc and briefing.doc (in inventory).", //1114
//22
// This is describing squares on a 3 * 3 grid
	@"Use green password on lower row / left tile. Use red password on lower row / centre tile.", //1115
	@"Pick up the green password and use on middle row / left tile.", //1116
	@"Pick up the red password and use on central tile.", //1117
	@"Pick up the green password and use on lower row / right tile.", //1118
//23
	@"Get book (phoenix.doc).", //1119
	@"Use decrypt on phoenix.doc.", //1120
	@"Get bust (phoenix program).", //1121
	@"Disconnect from LINC.", //1122

//SECURITY CENTRE 
//24
	@"Use ID card on LINC terminal.", //1123
	@"Select “Security services”. Select “view documents”", //1124
	@"Read each document. Note that they need to have been decrypted in LINC space.", //1125
	@"Select “special operations”. Select “special status request”.", //1126
	@"Select “file adjustment” to D-LINC Lamb.", //1127

//HYDE PARK 
//25
	@"Talk to Henri, the bouncer, to find out about sponsorship for the club.", //1128
	@"Talk to Danielle to be invited back to her apartment.", //1129
	@"Go back to Danielle’s Apartment.", //1130
//26
	@"You will need the cat video from Lamb’s apartment.", //1131
	@"D-LINC Lamb from “file adjustment” on the LINC terminal, and then talk to him.", //1132
	@"While Danielle is on the phone, play the video.", //1133
	@"While the dog is distracted, get the dog biscuits.", //1134
//27
	@"Go to the see-saw by the lake and use the dog biscuits on the plank.", //1135
	@"When the dog is nearby, pull the rope.", //1136
	@"When the dog gets onto the plank, release the rope.", //1137
//28
	@"Explore the lockers in the lower level - until you discover the terrible truth.", //1138
//29
	@"Return to the reactor in the factory and put on the radiation suit.", //1139
	@"Go to the terminal and open the reactor. Inside, pick up Anita’s ID card.", //1140
	@"Go back through the Security building.", //1141
	@"Enter LINC using Anita’s card.", //1142

//LINC 2 
//30
	@"Use “blind” on the eyeball in area 2.", //1143
	@"Use “playback” on the holographic projector (“well”) to view Anita’s message.", //1144
	@"Disconnect from LINC.", //1145

//HYDE PARK 2 
//31
	@"Return to Hyde Park. ", //1146
	@"Talk to Vincent to find out about the gardener.", //1147
	@"Talk to the gardener until he tells you about the virus.", //1148
//32
	@"Walk into the courtroom to witness Hobbins’s trial.", //1149
	@"Go to the club.", //1150
	@"Select “You search, but find nothing” on jukebox.", //1151
	@"Get Colston’s glass while he is away from the table.", //1152
//33
	@"Give the glass to Burke to get fingerprints.", //1153

//HYDE PARK 3 
//34
	@"Touch the plate to open the door to the wine cellar.", //1154
	@"Use the crowbar on the large box on the left.", //1155
	@"Get the lid and use it on the smaller box.", //1156
	@"Climb on top of the box.", //1157
	@"Use the crowbar on the grill.", //1158
//35
	@"If you haven’t found the secateurs then go to the shed in the park.", //1159
	@"Look at the door.", //1160
	@"Use the ID card on the lock.", //1161
	@"Enter the shed and get the secateurs.", //1162
//36
	@"Use the secateurs on the grill.", //1163
	@"Climb through the grill.", //1164

//UNDERWORLD 
//37
	@"Use the light bulb on the light socket to the left of the creature’s hole.", //1165
//38
	@"Use the crowbar on the crumbling plaster, then again on the brickwork to obtain a brick.", //1166
	@"-", //1167
	@"Use the crowbar on the clot in the vein.", //1168
	@"Use the brick on the crowbar to puncture the clot.", //1169
	@"Wait until the medical robot comes to repair the puncture, then exit through the door to the right.", //1170
//39
	@"Close the cover over the pit using the terminal beside the pit.", //1171
	@"Climb on top of the pit cover.", //1172
	@"Pull the retaining bar on the grill above your head to loosen the grill.", //1173
	@"Return to the room above.", //1174
//40
	@"Look through the grills to warn of any impending danger.", //1175
	@"Look through the first grill that you encounter.", //1176
	@"Walk right to the room where the medical robot is recharging.", //1177
	@"Use the circuit board on the medical robot.", //1178
//41
	@"Talk to Joey and send him into the tank room.", //1179
	@"Ask Joey what he saw in the tank room.", //1180
	@"Ask Joey about the tank.", //1181
	@"Tell Joey to open the tap.", //1182
	@"Enter the tank room and watch the android plunge to his death.", //1183
//42
	@"Walk to the right of the tanks, into the computer room.", //1184
	@"Use Reich’s ID card on the terminal (to the left of the bank of computers).", //1185
	@"Open the access door.", //1186
	@"Leave the computer room and watch Joey get destroyed again.", //1187
	@"Take Gallagher’s card from his remains.", //1188
//43
	@"Return to the computer room.", //1189
	@"Enter LINC using Gallagher’s card.", //1190
//44
	@"You need to enter LINC using Gallagher’s card. Drop out, then return again.", //1191
	@"Use blind on the eyeball in area 1. Quickly go to area 2 and blind the eyeball.", //1192
	@"Get the oscillator (tuning fork).", //1193
	@"Go to the Crusader room. Use “divine wrath” to remove the Crusader.", //1194
	@"Enter the crystal room. Use the oscillator on the crystal.", //1195
	@"Get the virus. Disconnect from LINC.", //1196
//45
	@"Go to the special android room. Open the cabinet on the middle console.", //1197
	@"Insert the circuit board in the cabinet.", //1198
	@"Use the monitor to download the data from the board.", //1199
	@"Run the android start-up program.", //1200
//46
	@"Go right to the room with the large tanks.", //1201
	@"Ask Joey/Ken to put his hand on the door panel.", //1202
	@"Put your own hand on the other panel.", //1203
//47
	@"Go to the tank of tissue samples and get the tongs from the wall (just to right of tank).", //1204
	@"Use Gallagher’s card (or whichever card contains the virus) on the console to infect the tissue with the virus.", //1205
	@"Remove a sample of infected tissue with the tongs.", //1206
	@"Put the sample of tissue into the nitrogen tank to freeze it.", //1207
//48
	@"Go to the end of the pipes. Attach the cable to the pipe support.", //1208
	@"Use the rungs to descend to the feeding orifice.", //1209
	@"Drop the infected tissue into the orifice.", //1210
	@"Use the hanging rope to swing into the final room.", //1211
//49
	@"When Joey/Ken enters tell him to sit in the chair.", //1212

// Missing answers added later

//RECYCLING PLANT 1 
//50
	@"Explore the factory. Perhaps you'll be able to get Joey working again.", //1213

//INDUSTRIAL 1 
//51
	@"Take a look around - there must be someone around who can help.", //1214
//52
	@"Explore some more - there's sure to be more to find.", //1215
//53
	@"Take the elevator down to the level below, and then take the next elevator down to ground level.", //1216

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//User Interface and game controls - Help!  (no constraints on text length on these four lines)
	@"Moving around the environment", //1217
	@"Tap a point on the floor area and Foster will walk there - if he can. To leave an area, you will need to interact with the exit arrow icon.", //1218
	@"Interacting with the environment", //1219
	@"Slide your finger around the game screen to find areas of interest (hotspots). Animating blue circles will appear over hotspots as your finger gets close to them. Slide your finger over the blue circle and action icons will be displayed to indicate what actions Foster can perform. To perform that action, lift your finger and tap the specific icon.", //1220
//1268 Increasing the time before going into sleep mode
//1270 To increase the time before your device goes into sleep mode, go to your iPhone 'Settings', then 'General', then 'Auto-Lock'. Choose the desired time setting.  

	@"DUMMY LINE", //1221

//Inventory Instructions  (no constraints on text length on these four lines)
	@"The inventory – what is it?", //1222
	@"Items that Foster picks up go into the ‘inventory’. Tap the box icon to display the items in the inventory. Tap an item to get a description of it.", //1223
	@"How to use an inventory item on background objects and people", //1224
	@"Open the inventory and press on an item for a few moments until it appears above your finger. While continuing to press the screen, drag the item over a hotspot and release when it highlights with a blue outline.", //1225
	@"Combining inventory items", //1226
	@"Sometimes you will need to combine two inventory items to create a third item. To do this, select the first item by pressing on it for a few moments until it appears above your finger. Now drag the item straight onto the second item – release when both are highlighted with a blue outline.", //1227


//First Screen Walkthrough (no constraints on text length on these four lines)
	@"Walkthrough for getting Foster to open the fire-door", //1228
	@"Slide your finger over the rung that is to the far left of the screen. A blue circle will animate over the rung as you get close. When your finger is over the rung, two icons will appear – turning cogs (interact) and a blinking eye (examine), and the word 'Rung' will appear at the top of the screen. Lift your finger and tap the cogs. The cogs will flash, and Foster will walk to the rung and pull it off. He will automatically put the rung into his inventory - where it will appear as 'Metal Bar'.", //1229
	@"LINE DELETED", //1230
	@"Open the inventory by tapping on the box icon. Press on the metal bar icon until it is displayed above your finger with a blue outline, then drag it across to the fire door until your finger is over the blue circle and 'Door' is displayed at the top of the screen, then lift your finger. Foster will now use the metal bar to lever open the fire door. Foster will then automatically walk out. Good luck!", //1231

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Twitter Stuff

//twitter test message
	@"Send test message - “I've just started Playing Beneath a Steel Sky on the iPhone / iPod touch! Be Vigilant.”", //1232

//twitter info
	@"There are several special interactions hidden throughout the game for you to find. Set up your Twitter details so the game can tweet as you discover them.", //1233

//tweets
	@"I've just started playing Beneath a Steel Sky on the iPhone / iPod touch. Be Vigilant!", //1234
	@"Tweet sent!", //1235
	@"Couldn't send tweet - possible connection issue.", //1236
	@"Couldn't send tweet - please check username / password.", //1237
	@"On the run in Beneath a Steel Sky. I just nicked Hobbins's knackwurst - no idea why I would want it, but this is an adventure after all...", //1238
	@"I've picked up Lamb's dodgy cat video in Beneath a Steel Sky. I don't trust the fellow one little bit.", //1239
	@"Escaped the amorous advances of Danielle Piermont in Beneath a Steel Sky. Dunked her yapping mutt into a pond - just as well he can swim.", //1240
	@"I just burst a security computer's blood vessel in Beneath a Steel Sky. So this thing bleeds. Gross!", //1241
	@"I just completed Beneath a Steel Sky on iPhone/iPod touch and saved the world!", //1242

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// General Messages

//new game alert
	@"If at any time you need help with the controls or want puzzle hints then tap the blue question mark icon.", //1243

//various misc
	@"Speech", //1244
	@"Subtitles", //1245
	@"Username", //1246
	@"Password", //1247
	@"Unused", //1248
	@"Unnamed", //1249
	@"Game Saved", //1250
	@"Game data successfully saved", //1251
	@"Game Save Fail!", //1252
	@"Game data NOT successfully saved", //1253
	@"Hint %d of %d", //1254
	@"Controls help and puzzle hints", //1255
	@"OK", //1256
	@"Text Language", //1257
	@"Username", //1358
	@"Password", //1359

// Tell a friend email:
	@"A message from 'Beneath a Steel Sky'", //1260
	@"Hey!", //1261
	@"I'm playing the classic adventure 'Beneath a Steel Sky', revamped and updated exclusively for iPhone and iPod touch.", //1262
	@"Considered one of the best adventures ever written, the game now includes: stunning new animated movies from Dave Gibbons, co-creator of ‘Watchmen’; a context-sensitive help system; a special new touch interface; improved audio and - well, lots of cool stuff.", //1263
	@"Being such a wonderful, caring person, I wanted to share this with you. Just click on this link to see more about the game: http://www.revolution.co.uk/appstoreBASS", //1264
	@"Check it out! Be Vigilant.", //1265

	@"Twitter posting", //1266

// Added lines in Controls re sleep mode
	@"Increasing the time before screen fades", //1267
	@"To increase the time before your device goes into sleep mode, go to your iPhone 'Settings', then 'General', then 'Auto-Lock'. Choose the desired time setting.  ", //1268

	@"Foster Over: The old man was trying to tell the future. Looking for pictures in the campfire...", //1269
	@"Shaman: Ohhh, I see evil...", //1401
	@"Shaman: Evil born deep beneath the city... far from the light of day.", //1402
	@"Shaman: I see it growing, safe beneath a sky of steel...", //1403
	@"Shaman: Scheming in the dark... gathering strength.", //1404
	@"Shaman: And now... ohhh.... now the evil spreads...", //1405
	@"Shaman: It sends deadly feelers over the land above...", //1406
	@"Shaman: Across the gap... reaching towards this very place!", //1407
	@"Foster Over: I'd seen him do it a hundred times, but I humoured him.", //1408
	@"Foster Over: After all, he'd been like a father to me.", //1409
	@"Foster: And what does this evil want here?", //1410
	@"Shaman: Oh, my son. I fear...", //1411
	@"Shaman: I fear the evil wants you!", //1412
	@"Foster Over: That was when Joey piped up...", //1413
	@"Joey: Foster! Sensors detect incoming audio source!", //1414
	@"Shaman: The evil! The evil is nearly here...!", //1415
	@"Foster Over: It sounded more like a 'copter than a demon.", //1416
	@"Foster Over: But next thing, all hell let loose anyway...", //1417
	@"Shaman: Run, Foster! Run! Hide from the evil!", //1418
	@"Joey: Foster! (zzzt) H-Help!", //1419
	@"Joey: Better (zzzt) make my (zzzt) next body move (zzzt) faster...", //1420
	@"Foster Over: He was only a robot, but, well, I loved the little guy.", //1421
	@"Foster Over: Then, as suddenly as it started, the shooting stopped.", //1422
	@"Foster Over: There was a moment's silence as the copter cut its rotors, then...             ", //1423
	@"Reich: Whoever is in charge here, come forward...", //1424
	@"Foster Over: Only a fool would have argued with that firepower.", //1426
	@"Shaman: ... I am the leader of these people...", //1427
	@"Shaman: We are peaceful...", //1428
	@"Reich: Bring him here.", //1429
	@"Soldier: At once, Commander Reich.", //1430
	@"Reich: We're looking for someone...", //1431
	@"Reich: Someone who doesn't belong here...", //1432
	@"Reich: Who wasn't born in this garbage dump...", //1433
	@"Reich: Who came from the city as a child...", //1434
	@"Reich: We want to take him home again.", //1435
	@"Foster Over: My mind racing, I remembered where I'd seen that symbol before...", //1436
	@"Foster Over: It was the day the tribe found me...", //1437
	@"Foster Over: The day of the crash...", //1438
	@"Foster Over: The day my mother died.", //1439

	@"Tribesman: You alright, city boy?", //1440
	@"Shaman: Got a name, son?", //1441
	@"Foster: R-Robert.", //1442
	@"Shaman: Hah! Welcome to the Gap, Robert!", //1443
	@"Foster Over: As he patched me up, the old man had gently explained that there was no way back into the City...", //1445
	@"Foster Over: And I already knew there was nothing he could do for mother.", //1446
	@"Foster Over: His tribe was poor, but they treated me like one of their own...", //1447
	@"Foster Over: I learned how to survive in the wasteland they called the Gap...", //1448
	@"Foster Over: And scavenging from the City dumps.", //1449
	@"Foster Over: As the years passed, I forgot my life in the City.", //1450
	@"Foster Over: Discovered new talents...", //1451

	@"Joey: I'm your (zzzt) friend... call me (zzzt) Joey.", //1453
	@"Foster Over: And got a second name.", //1454
	@"Shaman: This is what we'll call you now you've come of age, son.", //1455
	@"Shaman: We found you... fostered you...", //1456
	@"Shaman: So that makes you Robert Foster.", //1457
	@"Reich: ...Wasted enough time!", //1458
	@"Reich: Give us the runaway or we'll shoot everyone...", //1459
	@"Reich: Starting with you, grandad!", //1460
	@"Foster Over: The old man had been right, for once...", //1461
	@"Foster Over: It was me they wanted.", //1462
	@"Shaman: No, my son! Don't let the evil take you! Run!", //1463
	@"DNA scan confirms it's him, sir.", //1464
	@"Foster Over: Evil had come to the Gap, just as he said.", //1465

	@"Reich: Take him.", //1466
	@"Foster Over: But had the old man seen why it wanted me?", //1467
	@"Foster Over: Or what it would do next?", //1468
	@"Foster Over: It was too late to ask him now.", //1469
	@"Pilot: Leaving destruction zone, Commander Reich.", //1470
	@"Reich: Good. Detonate.", //1471
	@"Foster Over: Much too late.", //1472

	@"Foster: Why, you murdering...", //1473
	@"Reich: Keep him quiet.", //1474
	@"Foster Over: All I could do was wait.", //1475
	@"Foster Over: Just like on a hunt. Just like the old man taught me.", //1476
	@"Foster Over: Wait... and be ready.", //1477

	@"Foster Over: It was dawn when we reached the City.", //1478
	@"Reich: Land in the central Security compound.", //1479
	@"Foster Over: A dawn my tribe would never see.", //1480
	@"Foster Over: They were no more than a note in Reich's book now.", //1481
	@"Pilot: Yes, sir. Locking on automatic landing beacon.", //1482
	@"Foster Over: But what was I? Why did...", //1483

	@"Pilot: Sir! The guidance system! It's gone crazy!", //1484
	@"Pilot: We're going to HIT!", //1485
	@"Foster Over: Maybe I'd get some answers now.", //1486
	@"Foster Over: If I survived another 'copter crash.", //1487

// Outro Movie text:
	@"A few years later…", //1488
	@"In a world were all are free, the price of liberty is enslavement.", //1489
	@"Be Vigilant", //1490
};


NSString	*swASCII[]=
{

//RECYCLING PLANT
// For 'elevator' see ref line 187
	@"Branddörren är låst – hur öppnar jag den?", //1000
// See line 1050 I've out-foxed the guard - what now?
	@"Om bara Joey var här… Vad ska jag göra?", //1001
	@"Hur får jag hissen att fungera?", //1002
	@"Hur kommer jag ner i hisschaktet?", //1003
// For 'furnace' see ref line 4221
	@"Hur tar jag mig ut från pannrummet?", //1004


//INDUSTRIAL 1 
// For 'welder' see ref line 8369
	@"Jag måste inaktivera svetsroboten. Hjälp!", //1005
	@"Hur ska jag hämta svetshöljet till Joey?", //1006
	@"Hur kan jag ta mig in på lagret?", //1007
// For 'storeroom' see ref line 9212/9221
	@"Hur förhindrar jag att sakerna konfiskeras?", //1008
	@"Hur blir jag av med mannen i styrrummet?", //1009
	@"Hur kan jag återställa strömmen?", //1010
// This is a lift elevator - ref 9379
	@"Hur får jag igång hissen?", //1011

//BELLEVUE 1 
// For 'travel agent' see ref line 12698
	@"Hur får jag en biljett av reseförsäljaren?", //1012
// For 'ticket' see ref line 12727
	@"Vad ska med den här biljetten till?", //1013

//INDUSTRIAL 2 
	@"Lamb har min biljett – vad händer nu?", //1014

//BELLEVUE 2 
// For 'surgery' see ref line 270
	@"Hur kommer jag till operationsrummet?", //1015
	@"Hur skaffar jag en Schriebmann-kontakt?", //1016
// For 'anchor' see ref line 539. Please note that anchor refers to the object, and is also the name of the travel agent. 
	@"Hur får jag tag på ankaret?", //1017
	@"Jag har ankaret – vad gör jag nu?", //1018

//INDUSTRIAL 3 
	@"Vad ska jag göra med gripkroken?", //1019
// For 'grappling hook' see ref line 320

//SECURITY CENTRE 
// For 'security HQ' see ref line 9018
	@"Jag är på säkerhetshögkvarteret. Och nu?", //1020

//LINC 1 
	@"Jag är fast i LINC-världen – vad ska jag göra?", //1021
	@"Jag står i en cyberlabyrint – hur tar jag mig ut?", //1022
	@"Jag är ute ur cyberlabyrinten – och nu?", //1023

//SECURITY CENTRE 
	@"Hur tar jag mig ut från LINC-rymden?", //1024

//HYDE PARK 
	@"Jag är på bottenvåningen. Vad gör jag nu?", //1025
// For 'dog buscuits' see ref line 198
	@"Hur kommer jag åt hundkexen?", //1026
	@"Hur kommer jag förbi säkerhetsvakten?", //1027
	@"Jag är i katedralen – vad ska jag göra?", //1028
	@"Anita är mördad. Vad ska jag göra?", //1029

//LINC 2 
	@"Jag har Anitas kort – lämnade hon ledtrådar?", //1030

//HYDE PARK 2 
	@"Jag läste Anitas brev – hur når jag Eduardo?", //1031
	@"Jag har kontaktat Eduardo. Vad ska jag göra nu?", //1032
// This is a drinking glass
	@"Jag har Colstons glas, men varför?", //1033

//HYDE PARK 3 
	@"Hur kommer jag till tunnelbanan?", //1034
// For 'subway' see ref line 16525
	@"Det är hål i gallret – hur gör jag det större?", //1035
	@"Det är hål i gallret – vad gör jag nu?", //1036
// For 'grill' see ref line 17376

//UNDERWORLD 
	@"En varelse stoppar mig, hur undviker jag den?", //1037
	@"Hur tar jag mig in genom ståldörren?", //1038
	@"Där är ett konstigt hål – vad ska jag göra nu?", //1039
	@"Vad gör jag här i den konstiga underjorden?", //1040
	@"Hur tar vi oss förbi androiden i labbet?", //1041
	@"Jag dödade androiden. Vad händer nu?", //1042
// For 'android' see ref line 20607
	@"Anita nämnde ett virus – hur får jag tag på det?", //1043
// For 'virus' see ref line 24591

//LINC 3 
	@"Jag är tillbaka i LINC, hur skaffar jag viruset?", //1044

//UNDERWORLD 
	@"Stackars Joey, hur ska jag få tillbaka honom?", //1045
	@"Joey är en android. Vad gör jag med honom?", //1046
	@"Hur får jag in viruset i den riktiga världen?", //1047
	@"Jag har smittad vävnad – vad gör jag nu?", //1048
// For 'tissue' (biological tissue) see ref line 20633/20634
	@"Jag har sett far – hur räddar jag mänskligheten?", //1049

//RECYCLING PLANT 1 
	@"Jag har överlistat vakten – vad händer nu?", //1050

//INDUSTRIAL 1 
	@"Jag är på ett industriområde. Vad ska jag göra?", //1051
	@"Jag har hittat ett slags kitt – vad gör jag nu?", //1052
// For 'putty' see ref line 168
	@"Jag har särskild säkerhetsstatus i LINC, och nu?", //1053
// For 'status' see ref line 89


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//CONTROLS HELP Subjects - should fit with the Text Box constraints specified above
	@"Användargränssnitt och spelkontroller – hjälp!", //1054
	@"Förrådsanvisningar", //1055
	@"Presentation av första skärmen", //1056

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//HINT ANSWERS
// No particular constraints on text length - but please not too much longer than English
//------------
	@"Hämta räcket ovanför trappan, till vänster om bryggan.", //1057
// Reference 4295 for term 'rung', 4177 for 'fire door'
	@"Öppna förrådet och bänd upp branddörren med räcket. Läs mer i \"Presentation av första skärmen\".", //1058
//1
// Reference 4194 for term used for 'robot shell', 4546 for 'junk'
	@"Leta efter robothöljet bland skrotet i förgrunden.", //1059
// Reference 16586 for term for 'circuit board', 4185 for 'robot shell'
	@"Använd kretskortet på robothöljet.", //1060
//2
	@"Undersök transportdroiden.", //1061
// Reference 4426, 4337 for transport robot / droid
	@"Prata med Hobbins tills du får chansen att fråga om transportdroiden. Han vet vad problemet är.", //1062
	@"Be Joey starta transportdroiden (du måste troligen kallprata med honom en bra stund först).", //1063
//3
	@"Klättra snabbt ner i hisschaktet när hissen har åkt ner.", //1064
//4
	@"Undersök låset i dörren.", //1065
	@"Be Joey öppna dörren när han kommer.", //1066

//INDUSTRIAL 1 
//5
	@"Du måste kasta in en skiftnyckel i verket.", //1067
	@"Hittade du skiftnyckeln i Hobbins verkstad? Gå annars tillbaka dit, öppna skåpet och hämta skiftnyckeln.", //1068
	@"Gå tillbaka till transportbandet. I rummet bakom svetsroboten finns en maskin med kugghjul.", //1069
	@"Prata med Anita och sedan med Lamb tills han går. Kasta in skiftnyckeln i kugghjulen.", //1070
//6
	@"Ta upp skiftnyckeln från kugghjulen.", //1071
	@"Använd skiftnyckeln på svetsroboten.", //1072
	@"Prata med Joey och erbjud honom ett nytt hölje.", //1073
//7
	@"Försök ta dig in i lagret.", //1074
	@"Säg åt Joey att ta en titt på lagret. När han hittar säkringsskåpet, säg åt honom att koppla ur säkringarna.", //1075
//8
	@"Lyft upp klaffen på golvet.", //1076
	@"Ta upp kittet (sprängmedlet) under klaffen. Det är det enda föremål du får ta med dig härifrån.", //1077
//9
	@"Använd skiftnyckeln på de båda knapparna under rören till höger.", //1078
	@"Säg åt Joey att trycka på den högra knappen. Tryck samtidigt på den vänstra.", //1079
//10
	@"Slå av strömbrytaren på kontrollpanelen till vänster.", //1080
	@"Skruva ur glödlampan.", //1081
	@"Sätt fast kittet i lamphållaren.", //1082
	@"Slå på strömbrytaren igen.", //1083
	@"Fäll ner den högra strömbrytaren så att hissen går igång.", //1084
//11
	@"Undersök kvarlevorna efter Reich i pannrummet och ta ID-kortet.", //1085
	@"Använd Reichs ID-kort till hissen.", //1086

//BELLEVUE 1 
//12
	@"Gå hem till Reich och leta rätt på motorcykeltidningen under kudden.", //1087
	@"Gå till reseförsäljaren och fråga om rundturerna.", //1088
	@"Fråga efter ekonomirundturen.", //1089
	@"Ge honom motorcykeltidningen i utbyte mot en biljett.", //1090
//13
	@"Ge biljetten till Lamb så att du får följa med på rundtur i rörfabriken.", //1091

//INDUSTRIAL 2 
//14
	@"Fråga Lamb om rundturen – han går när han ser att transportbandet har stannat.", //1092
	@"Prata med Anita.", //1093
	@"Hon erbjuder dig en störningsenhet – ge henne Reichs ID.", //1094
// A jammer is hacking software - see ref 8639
	@"Ta reda på mer om Schriebmann-kontakten.", //1095

//BELLEVUE 2 
//15
	@"Prata med receptionisten genom att klicka på projektorn.", //1096
	@"Be om en Schriebmann-kontakt.", //1097
	@"Be Joey prata med receptionisten om att komma in i operationsrummet.", //1098
//16
	@"Prata med Burke tills han erbjuder att sätta in en Schriebmann-kontakt.", //1099
//17
	@"Fortsätt prata med Burke efter operationen och ta reda på Ankarets “specialförsäkring”.", //1100
	@"Besök Ankaret på försäkringsbolaget och nämn Burkes namn så att han lämnar rummet.", //1101
	@"Be Joey ta ankaret på statyn.", //1102
	@"Plocka upp ankaret när Joey har smält armen på statyn.", //1103
//18
	@"Nu har du chansen att ta kabeln som hänger ner från fabriksvåningen.", //1104
	@"Be Joey klippa loss kabeln – men akta dig!", //1105
	@"Hämta kabeln som har fallit ner på Belle Vue-våningen.", //1106
	@"Använd ankaret på kabeln för att ordna en gripkrok.", //1107

//INDUSTRIAL 3 
//19
	@"Gå till branddörren i Hobbins återvinningsfabrik och gå ut på avsatsen.", //1108
	@"Fäst gripkropen i skylten på andra sidan.", //1109

//SECURITY CENTRE 
//20
	@"Dra ID-kortet genom läsaren i säkerhetshögkvarteret och sätt dig.", //1110

//LINC 1 
//21
// These are all specific software package names - please refer to original text files so they match
	@"Hämta bollen (komprimerad data) i område 1.", //1111
	@"Gå direkt till område 2 och använd ”öppna” (i förrådet) på väskan.", //1112
	@"Hämta julklappen (dekomprimera). Använd ”dekomprimera” på komprimerad data (i förrådet).", //1113
	@"Hämta förstoringsglaset (dekryptera) och använd det på report.doc och briefing.doc (i förrådet).", //1114
//22
// This is describing squares on a 3 * 3 grid
	@"Använd grönt lösenord på vänster ruta längst ner. Använd rött lösenord på mittenrutan längst ner.", //1115
	@"Hämta grönt lösenord och använd på vänster ruta på mittenraden.", //1116
	@"Hämta rött lösenord och använd på mittenrutan.", //1117
	@"Hämta grönt lösenord och använd på höger ruta längst ner.", //1118
//23
	@"Hämta boken (phoenix.doc).", //1119
	@"Använd ”dekryptera” på phoenix.doc.", //1120
	@"Hämta bysten (fenixprogrammet).", //1121
	@"Koppla från LINC.", //1122

//SECURITY CENTRE 
//24
	@"Använd ID-kortet i LINC-terminalen.", //1123
	@"Välj ”Säkerhetspolisen”. Välj ”Läs dokument”.", //1124
	@"Läs alla dokument. Du måste dekryptera dem i LINC-rymden.", //1125
	@"Välj ”Specialtjänster”. Välj ”Särskild status-begäran”.", //1126
	@"Välj ”Filjustering” och D-LINC:a Lamb.", //1127

//HYDE PARK 
//25
	@"Prata med utkastaren Henri och ta reda på hur man blir medlem i klubben.", //1128
	@"Prata med Danielle för att få följa med henne hem.", //1129
	@"Gå hem till Danielle.", //1130
//26
	@"Du måste få tag på kattvideon hos Lamb.", //1131
	@"D-LINC:a Lamb via “Filjustering” på LINC-terminalen och prata med honom.", //1132
	@"Spela upp videon medan Danielle är i telefonen.", //1133
	@"Hämta hundkexen medan hunden är distraherad.", //1134
//27
	@"Gå till gungbrädan vid sjön och använd hundkexen på brädan.", //1135
	@"Dra i repet när hunden är nära.", //1136
	@"Släpp repet när hunden har ställt sig på brädan.", //1137
//28
	@"Leta i skåpen på bottenvåningen tills du upptäcker den hemska sanningen.", //1138
//29
	@"Gå tillbaka till reaktorn i fabriken och ta på dig skyddsdräkten.", //1139
	@"Gå till terminalen och öppna reaktorn. Ta upp Anitas ID-kort inuti reaktorn.", //1140
	@"Gå tillbaka genom säkerhetspolisens byggnad.", //1141
	@"Gå in i LINC med hjälp av Anitas kort.", //1142

//LINC 2 
//30
	@"Använd “blindbock” på ögat i område 2.", //1143
	@"Använd “projektor” på den holografiska projektorn (Brunn) och läs Anitas brev.", //1144
	@"Koppla från LINC.", //1145

//HYDE PARK 2 
//31
	@"Gå tillbaka till Hyde Park. ", //1146
	@"Prata med Vincent och ta reda på mer om trädgårdsmästaren.", //1147
	@"Prata med trädgårdsmästaren tills han berättar om viruset.", //1148
//32
	@"Gå in i rättssalen och lyssna på rättegången mot Hobbins.", //1149
	@"Gå till klubben.", //1150
	@"Välj “Den som söker, han skall finna” på jukeboxen.", //1151
	@"Ta Colstons glas medan han är borta från bordet.", //1152
//33
	@"Ge glaset till Burke så att han kan få fram fingeravtrycken.", //1153

//HYDE PARK 3 
//34
	@"Tryck på plattan för att öppna dörren till vinkällaren.", //1154
	@"Öppna den stora lådan till vänster med kofoten.", //1155
	@"Använd locket från den stora lådan på den mindre.", //1156
	@"Ställ dig på lådan.", //1157
	@"Använd kofoten på gallret.", //1158
//35
	@"Gå till skjulet i parken om du inte har hittat sekatören.", //1159
	@"Titta på dörren.", //1160
	@"Lås upp dörren med ID-kortet.", //1161
	@"Gå in i skjulet och hämta sekatören.", //1162
//36
	@"Använd sekatören på gallret.", //1163
	@"Klättra ut genom gallret.", //1164

//UNDERWORLD 
//37
	@"Sätt i glödlampan i lamphållaren till vänster om hålet på varelsen.", //1165
//38
	@"Använd kofoten på murbruket och sedan på tegelväggen och ta loss en tegelsten.", //1166
	@"-", //1167
	@"Använd kofoten på blodklumpen i ådern.", //1168
	@"Använd tegelstenen på kofoten för att slå hål på klumpen.", //1169
	@"Vänta tills läkarroboten kommer för att reparera punkteringen och gå ut genom dörren till höger.", //1170
//39
	@"Stäng locket över hålet med hjälp av terminalen bredvid.", //1171
	@"Ställ dig på locket över hålet.", //1172
	@"Lyft regeln på gallret över huvudet och ta loss gallret.", //1173
	@"Gå tillbaka till rummet ovanför.", //1174
//40
	@"Håll uppsikt efter annalkande fara utanför gallret.", //1175
	@"Titta in genom det första galler du ser.", //1176
	@"Gå in i rummet där läkarroboten laddar upp sig.", //1177
	@"Använd kretskortet på läkarroboten.", //1178
//41
	@"Prata med Joey och skicka in honom i tankrummet.", //1179
	@"Fråga Joey vad han såg i tankrummet.", //1180
	@"Fråga Joey om tanken.", //1181
	@"Säg åt Joey att öppna kranen.", //1182
	@"Gå in i tankrummet och se på när androiden ramlar ner och dör.", //1183
//42
	@"Gå till höger om tankarna in i datorrummet.", //1184
	@"Använd Reichs ID-kort i terminalen (till vänster om datorerna).", //1185
	@"Öppna säkerhetsdörren.", //1186
	@"Lämna datorrummet och se på medan Joey förstörs igen.", //1187
	@"Hämta Gallaghers kort bland kvarlevorna.", //1188
//43
	@"Gå tillbaka till datorrummet.", //1189
	@"Gå in i LINC med Gallaghers kort.", //1190
//44
	@"Du måste gå in i LINC med Gallaghers kort. Gå ut och gå in igen.", //1191
	@"Använd ”blindblock” på ögat i område 1. Gå snabbt till område 2 och förblinda ögat.", //1192
	@"Hämta oscillatorn (stämgaffeln).", //1193
	@"Gå till korsriddarrummet. Använd “gudomlig vrede” och undanröj korsriddaren.", //1194
	@"Gå till kristallrummet. Använd oscillatorn på kristallen.", //1195
	@"Hämta viruset. Koppla från LINC.", //1196
//45
	@"Gå till androidrummet. Öppna skåpet på mittenkonsolen.", //1197
	@"Sätt in kretskortet i skåpet.", //1198
	@"Ladda ner data från kretskortet via skärmen.", //1199
	@"Kör androidernas startprogram.", //1200
//46
	@"Gå till rummet med de stora tankarna.", //1201
	@"Be Joey/Ken att sätta handen på dörrpanelen.", //1202
	@"Sätt din egen hand på dörrpanelen.", //1203
//47
	@"Gå till tanken med vävnadsprover och hämta tången från väggen (till höger om tanken).", //1204
	@"Använd Gallaghers kort (eller ett annat kort med virus) på konsolen och smitta vävnadsprovet med viruset.", //1205
	@"Ta loss en bit smittad vävnad med tången.", //1206
	@"Lägg ner vävnadsprovet i kvävetanken och frys ner den.", //1207
//48
	@"Gå till slutet på rören. Koppla fast kabeln i rörupphängningen.", //1208
	@"Gå ner till matöppningen med hjälp av räckena.", //1209
	@"Släpp ner den smittade vävnaden i öppningen.", //1210
	@"Svinga dig in i det sista rummet med hjälp av repet.", //1211
//49
	@"Be Joey/Ken sätta sig i stolen när han kommer in.", //1212

// Missing answers added later

//RECYCLING PLANT 1 
//50
	@"Utforska fabriken. Du kanske kan få Joey att fungera igen.", //1213

//INDUSTRIAL 1 
//51
	@"Se dig omkring – det måste finnas någon som kan hjälpa dig.", //1214
//52
	@"Leta noggrannare – det finns mer att hitta.", //1215
	@"Ta hissen ner till våningen under och ta nästa hiss till bottenvåningen.", //1216

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//User Interface and game controls - Help!  (no constraints on text length on these four lines)
	@"Gå runt i miljön", //1217
	@"Klicka på en plats på golvet så går Foster dit – om han kan. Klicka på utgångspilen om du vill lämna ett område.", //1218
	@"Interagera med miljön", //1219
	@"Dra fingret över spelskärmen om du vill hitta intressanta områden (hotspots). När du närmar dig en hotspot visas en animerad blå cirkel ovanför. När du drar fingret över cirkeln syns åtgärdsikoner som visar vad Foster kan göra. Klicka på ikonen för det du vill göra.", //1220
//1268 Öka tiden tills enheten sätts i viloläge
//1270 Om du vill öka tiden tills enheten sätts i viloläge väljer du ”Settings” på din iPhone, sedan ”General” och ”Auto-Lock”. Välj önskad tidsinställning.  

	@"DUMMY LINE", //1221

//Inventory Instructions  (no constraints on text length on these four lines)
	@"Vad är förrådet?", //1222
	@"Alla föremål som Foster plockar upp hamnar i förrådet. Klicka på skåpikonen om du vill se alla föremål i förrådet. Klicka på ett föremål om du vill läsa en beskrivning.", //1223
	@"Använda föremål i förrådet på föremål och personer i bakgrunden", //1224
	@"Öppna förrådet och tryck på ett föremål i några sekunder tills den visas ovanför ditt finger. Fortsätt att trycka på skärmen samtidigt som du drar föremålet över en hotspot. Släpp upp fingret när föremålet är markerat med blå kontur.", //1225
	@"Kombinera föremål i förrådet", //1226
	@"Ibland måste du kombinera två föremål i förrådet så att de bildar ett nytt föremål. Markera det första föremålet genom att trycka på det i några sekunder så att det visas ovanför ditt finger. Dra föremålet över det andra föremålet och släpp upp fingret när båda föremålen är markerade med blå kontur.", //1227


//First Screen Walkthrough (no constraints on text length on these four lines)
	@"Så får du Foster att öppna branddörren", //1228
	@"Dra fingret över räcket längst till vänster på skärmen. En animerad blå cirkel visas ovanför räcket när du kommer nära. När ditt finger är över räcket visas två ikoner – kugghjul (interagera) och ett blinkande öga (undersök) och ordet ”Räcke” visas högst upp på skärmen. Lyft fingret och knacka på kugghjulen. Kugghjulen blinkar och Foster går till räcket och drar loss det. Han lägger automatiskt räcket i förrådet, där det får beskrivningen ”Metallrör”.", //1229
	@"LINE DELETED", //1230
	@"Öppna förrådet genom att knacka på lådikonen. Tryck på metallrörsikonen så att den visas med blå kontur ovanför ditt finger. Dra den till branddörren så att ditt finger är över den blå cirkeln och ordet \"Dörr\" visas högst upp på skärmen. Lyft fingret. Foster använder metallröret för att bända upp branddörren och går sedan automatiskt ut därifrån. Lycka till!", //1231

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Twitter Stuff

//twitter test message
	@"Skicka testmeddelande – “Jag har just spelat Playing Beneath a Steel Sky på iPhone/iPod touch! Var vaksam.”", //1232

//twitter info
	@"Det finns flera specialhändelser gömda i spelet som du måste upptäcka. Ställ in twitter så att Beneath a Steel Sky visas på twitter allt eftersom du hittar dem.", //1233

//tweets
	@"Jag har just börjat spela Beneath a Steel Sky på iPhone/iPod touch. Var vaksam!", //1234
	@"Twittret har skickats!", //1235
	@"Kunde inte skicka twittret – det kan vara problem med anslutningen.", //1236
	@"Kunde inte skicka twittret – kontrollera användarnamn/lösenord.", //1237
	@"Jag är på språng med Beneath a Steel Sky. Jag snodde just Hobbins knackwurst – har ingen aning om varför, men det här är ju ett äventyr...", //1238
	@"Jag har plockat upp Lambs mystiska kattvideo i Beneath a Steel Sky. Jag litar inte ett ögonblick på den typen.", //1239
	@"Har just flytt från Danielle Piermonts amorösa närmanden i Beneath a Steel Sky. Jag slängde ner hennes gläfsande jycke i en damm – hoppas att han kan simma.", //1240
	@"Jag sprängde just en säkerhetsdators blodkärl i Beneath a Steel Sky. Den blöder som bara sjutton. Äckligt!", //1241
	@"Jag har just spelat klart Beneath a Steel Sky på iPhone/iPod touch och har räddat världen!", //1242

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// General Messages

//new game alert
	@"När du behöver hjälp med kontrollerna eller vill ha ledtrådar kan du när som helst knacka på det blå frågetecknet.", //1243

//various misc
	@"Tal", //1244
	@"Undertext", //1245
	@"Användarnamn", //1246
	@"Lösenord", //1247
	@"Ledig", //1248
	@"Namnlös", //1249
	@"Spelet har sparats", //1250
	@"Speldata har sparats", //1251
	@"Spelet kunde inte sparas!", //1252
	@"Speldata har INTE sparats", //1253
	@"Tips %d av %d", //1254
	@"Funktionshjälp och speltips", //1255
	@"OK", //1256
	@"Textspråk", //1257
	@"Användarnamn", //1358
	@"Lösenord", //1359

// Tell a friend email:
	@"Meddelande från ”Beneath a Steel Sky”", //1260
	@"Hej!", //1261
	@"Jag spelar det klassiska äventyrsspelet \"Beneath a Steel Sky\" som har gjorts om och uppdaterats särskilt för iPhone och iPod touch.", //1262
	@"Det är ett av tidernas bästa spel och innehåller nya animerade filmer av Dave Gibbons som var en av upphovsmännen bakom ”Watchmen”, sammanhangsberoende hjälpsystem, nytt touch-gränssnitt, bättre ljud och… en massa tuffa saker.", //1263
	@"Eftersom jag är en så fantastisk och omtänksam person vill jag dela med mig av spelet till dig. Klicka på den här länken om du vill läsa mer: http://www.revolution.co.uk/appstoreBASS", //1264
	@"Ta en titt! Var vaksam.", //1265

	@"Twitterinlägg", //1266

// Added lines in Controls re sleep mode
	@"Ökar tiden till viloläge", //1267
	@"Om du vill öka tiden tills enheten sätts i viloläge väljer du ”Settings” på din iPhone, sedan ”General” och ”Auto-Lock”. Välj önskad tidsinställning.  ", //1268

// Intro Text
	@"Foster, berättarröst: Gamlingen försökte sia om framtiden genom att titta in i elden...", //1400
	@"Schaman: Oooh, jag ser ondska...", //1401
	@"Schaman: Den har fötts djupt under staden... långt bortom dagens ljus.", //1402
	@"Schaman: Jag ser hur ondskan växer i skydd av en himmel av stål...", //1403
	@"Schaman: Den smider planer i mörkret... Den samlar kraft.", //1404
	@"Schaman: Och nu... oooh.... nu sprider den sig.", //1405
	@"Schaman: Den skickar ut sina dödliga spanare över jorden...", //1406
	@"Schaman: Över klyftan... ända hit!", //1407
	@"Foster, berättarröst: Jag har sett honom sån här hundratals gånger, men jag låter honom hållas.", //1408
	@"Foster, berättarröst: Han är som en far för mig.", //1409
	@"Foster: Vad är ondskan ute efter här?", //1410
	@"Schaman: Åh, min son, jag är rädd...", //1411
	@"Schaman: Jag är rädd att den är ute efter dig!", //1412
	@"Foster, berättarröst: Det var då som Joey dök upp.", //1413
	@"Joey: Foster! Sensorerna har plockat upp ljud utifrån!", //1414
	@"Schaman: Ondskan! Ondskan är snart här!", //1415
	@"Foster, berättarröst: Det lät snarare som en helikopter än som en demon.", //1416
	@"Foster, berättarröst: I nästa sekund brakade helvetet lös.", //1417
	@"Schaman: Spring, Foster! Spring! Låt inte ondskan hitta dig!", //1418
	@"Joey: Foster! (zzzt) H-hjälp!", //1419
	@"Joey: Min nästa (zzzt) kropp måste (zzzt) vara (zzzt) snabbare...", //1420
	@"Foster, berättarröst: Han var bara en robot, men jag älskade den lille krabaten.", //1421
	@"Foster, berättarröst: Skjutandet upphörde lika plötsligt som det började.", //1422
	@"Foster, berättarröst: Under ett ögonblick var det knäpptyst när rotorbladen på helikoptern stängdes av, men så...", //1423
	@"Reich: Du som för befäl här, visa dig!", //1424
	@"Foster, berättarröst: Bara en dåre skulle ha utmanat det motståndet.", //1426
	@"Schaman: Jag är folkets ledare.", //1427
	@"Schaman: Vi vill er inget ont.", //1428
	@"Reich: För hit honom.", //1429
	@"Soldat: Ska bli, överstelöjtnant Reich!", //1430
	@"Reich: Vi letar efter en person...", //1431
	@"Reich: Som inte är härifrån.", //1432
	@"Reich: Han föddes inte i den här hålan.", //1433
	@"Reich: Han flyttade hit från staden när han var barn.", //1434
	@"Reich: Vi vill föra honom hem igen.", //1435
	@"Foster, berättarröst: Tankarna rusade runt i huvudet medan jag försökte minnas var jag hade sett den där symbolen tidigare.", //1436
	@"Foster, berättarröst: Det var samma dag som stammen hittade mig.", //1437
	@"Foster, berättarröst: Samma dag som kraschen.", //1438
	@"Foster, berättarröst: Samma dag som min mor dog.", //1439

	@"Stammedlem: Hur är det med dig, stadsbarn?", //1440
	@"Schaman: Har du ett namn, min pojke?", //1441
	@"Foster: R-Robert.", //1442
	@"Schaman: Ha! Välkommen till Klyftan, Robert!", //1443
	@"Foster, berättarröst: Medan gamlingen plåstrade om mig berättade han vänligt att det inte fanns nån väg tillbaka till staden.", //1445
	@"Foster, berättarröst: Jag visste redan att min mor var bortom räddning.", //1446
	@"Foster, berättarröst: Stammen var fattig, men de behandlade mig som en av dem.", //1447
	@"Foster, berättarröst: Jag lärde mig överleva i den ödemark som de kallade Avgrunden.", //1448
	@"Foster, berättarröst: Jag hittade allt jag behövde på soptippen.", //1449
	@"Foster, berättarröst: Med åren glömde jag bort mitt tidigare liv i staden.", //1450
	@"Foster, berättarröst: Jag upptäckte nya talanger...", //1451

	@"Joey: Jag är din (zzzt) vän... Du kan kalla mig (zzzt) Joey.", //1453
	@"Foster, berättarröst: Jag fick ett nytt namn.", //1454
	@"Shaman: Det här är ditt nya namn, nu när du har blivit myndig.", //1455
	@"Schaman: Vi hittade dig och fostrade dig...", //1456
	@"Schaman: Så därför ska du heta Robert Foster.", //1457
	@"Reich: Nu är det sluttjafsat!", //1458
	@"Reich: Hit med flyktingen, annars skjuter vi er allihop.", //1459
	@"Reich: Och vi börjar med dig, farfar!", //1460
	@"Foster, berättarröst: Gamlingen hade haft rätt för en gångs skull.", //1461
	@"Foster, berättarröst: Det var mig de ville åt.", //1462
	@"Schaman: Nej, min son! Låt inte ondskan få tag på dig! Fly!", //1463
	@"Soldat: Enligt DNA-skanningen är det han.", //1464
	@"Foster, berättarröst: Ondskan hade kommit till Avgrunden, precis som han hade sagt.", //1465

	@"Reich: Grip honom!", //1466
	@"Foster, berättarröst: Såg gamlingen varför de ville ha mig?", //1467
	@"Foster, berättarröst: Eller vad de tänkte göra med mig?", //1468
	@"Foster, berättarröst: Det var för sent att fråga honom.", //1469
	@"Pilot: Vi lämnar målet, överstelöjtnant Reich.", //1470
	@"Reich: Bra. Detonera.", //1471
	@"Foster, berättarröst: Alldeles för sent...", //1472

	@"Foster: Varför, era mordlystna...", //1473
	@"Reich: Få tyst på honom.", //1474
	@"Foster, berättarröst: Jag hade inget annat val än att vänta.", //1475
	@"Foster, berättarröst: Precis som under en jakt. Precis som gamlingen hade lärt mig.", //1476
	@"Foster, berättarröst: Vänta... och vara beredd.", //1477

	@"Foster, berättarröst: Vi kom fram till staden i gryningen.", //1478
	@"Reich: Gå ner på säkerhetspolisens område.", //1479
	@"Foster, berättarröst: En gryning som min stam aldrig skulle få se.", //1480
	@"Foster, berättarröst: De var inte mer än en notering i Reichs anteckningsbok.", //1481
	@"Pilot: Ska bli. Jag aktiverar automatisk landning.", //1482
	@"Foster, berättarröst: Men vem var jag? Varför...", //1483

	@"Pilot: Kapten! Styrsystemet har fått fnatt!", //1484
	@"Pilot: Vi kraschar!", //1485
	@"Foster, berättarröst: Jag kanske skulle få svar nu.", //1486
	@"Foster, berättarröst: Om jag överlevde ännu en helikopterkrasch.", //1487

// Outro Movie text:

	@"Några år senare…", //1490
	@"I en värld där alla är fria, är frihetens pris slaveri.", //1491
	@"Var vaksam", //1492
};



NSString	*usASCII[]=
{
//RECYCLING PLANT
// For 'elevator' see ref line 187
	@"The Firedoor is locked – how do I open it?", //1000
// See line 1050 I've out-foxed the guard - what now?
	@"I do wish that Joey was with me – what should I do?", //1001
	@"How do I get that elevator working?", //1002
	@"How do I get down the elevator shaft?", //1003
// For 'furnace' see ref line 4221
	@"How do I get out of the furnace room?", //1004


//INDUSTRIAL 1 
// For 'welder' see ref line 8369
	@"I need to de-activate the welder robot. Help!", //1005
	@"How do I get the welder shell for Joey?", //1006
	@"How can I get into the storeroom?", //1007
// For 'storeroom' see ref line 9212/9221
	@"How can I stop things I get from the storeroom being confiscated?", //1008
	@"How can I get rid of the man in the power room?", //1009
	@"How can I restore power?", //1010
// This is a lift elevator - ref 9379
	@"How can I use that elevator?", //1011

//BELLEVUE 1 
// For 'travel agent' see ref line 12698
	@"How do I get a ticket from the travel agent?", //1012
// For 'ticket' see ref line 12727
	@"What should I do with this ticket?", //1013

//INDUSTRIAL 2 
	@"Lamb has my ticket – what now?", //1014

//BELLEVUE 2 
// For 'surgery' see ref line 270
	@"How do I get into the surgery?", //1015
	@"How do I get a Schriebmann port?", //1016
// For 'anchor' see ref line 539. Please note that anchor refers to the object, and is also the name of the travel agent. 
	@"How can I get that anchor?", //1017
	@"I’ve got the anchor – what now?", //1018

//INDUSTRIAL 3 
	@"What do I do with this grappling hook?", //1019
// For 'grappling hook' see ref line 320

//SECURITY CENTRE 
// For 'security HQ' see ref line 9018
	@"I’m in the security HQ. What next?", //1020

//LINC 1 
	@"I’m stuck in the LINC world – what should I do?", //1021
	@"I’m in a cyber maze – how do I get through it?", //1022
	@"I’m through the cyber maze – what now?", //1023

//SECURITY CENTRE 
	@"How do I get out of LINC space?", //1024

//HYDE PARK 
	@"I’ve got to ground level. What should I do now?", //1025
// For 'dog buscuits' see ref line 198
	@"How do I get those dog biscuits?", //1026
	@"How do I get past the security man?", //1027
	@"I’m in the cathedral – what now?", //1028
	@"Anita’s been murdered. What should I do?", //1029

//LINC 2 
	@"I’ve got Anita’s card – maybe she left some clues?", //1030

//HYDE PARK 2 
	@"I’ve read Anita’s message – how do I make contact with Eduardo?", //1031
	@"I’ve made contact with Eduardo. What now?", //1032
// This is a drinking glass
	@"I’ve got Colston’s glass, but why?", //1033

//HYDE PARK 3 
	@"How do get through to the subway?", //1034
// For 'subway' see ref line 16525
	@"I’ve made a hole in the grill – how do I enlarge the hole?", //1035
	@"I’ve made a hole in the grill – what now?", //1036
// For 'grill' see ref line 17376

//UNDERWORLD 
	@"There’s a creature that grabs me – how can I avoid it?", //1037
	@"How do I get through the big metal door?", //1038
	@"There’s a strange pit – what do I do with it?", //1039
	@"What do I do in this strange underworld?", //1040
	@"How can we get past the android in the lab?", //1041
	@"I killed the android. What next?", //1042
// For 'android' see ref line 20607
	@"Anita mentioned a virus – how do I get it?", //1043
// For 'virus' see ref line 24591

//LINC 3 
	@"I'm back in LINC – how do I get the virus?", //1044

//UNDERWORLD 
	@"Poor old Joey – how do I get resurrect him? Again!", //1045
	@"I’ve turned Joey into an android. What I do with him?", //1046
	@"I’ve got the virus from LINC – how do I get it into the real world?", //1047
	@"I’ve got some infected tissue – what now?", //1048
// For 'tissue' (biological tissue) see ref line 20633/20634
	@"I’ve met my own father – how do I save humanity?", //1049

//RECYCLING PLANT 1 
	@"I've out-foxed the guard - what now?", //1050

//INDUSTRIAL 1 
	@"I'm in an industrial area. What should I do?", //1051
	@"I've found some putty-like substance - but what now?", //1052
// For 'putty' see ref line 168
	@"I've given myself special security status on LINC - now what?", //1053
// For 'status' see ref line 89


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//CONTROLS HELP Subjects - should fit with the Text Box constraints specified above
	@"User interface and game controls – help!", //1054
	@"Inventory Instructions", //1055
	@"First screen walkthrough", //1056

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//HINT ANSWERS
// No particular constraints on text length - but please not too much longer than English
//------------
	@"Get the rung from the top of the stairs on the left of the gantry.", //1057
// Reference 4295 for term 'rung', 4177 for 'fire door'
	@"Open your inventory and use the rung on the fire door to lever it open. See the 'First Screen Walkthrough' for detailed explanation. ", //1058
//1
// Reference 4194 for term used for 'robot shell', 4546 for 'junk'
	@"Examine the junk in the foreground to reveal the robot shell.", //1059
// Reference 16586 for term for 'circuit board', 4185 for 'robot shell'
	@"Use the circuit board on the robot shell.", //1060
//2
	@"Examine the transport droid.", //1061
// Reference 4426, 4337 for transport robot / droid
	@"Talk to Hobbins until you get option to ask him about the transport droid – and he tells you what’s wrong with it.", //1062
	@"Ask Joey to start the transport droid (you may need to talk nicely to him about a range of subjects beforehand).", //1063
//3
	@"When the elevator descends, quickly climb down the shaft.", //1064
//4
	@"Examine the lock on the door.", //1065
	@"When Joey arrives, ask him to open the door.", //1066

//INDUSTRIAL 1 
//5
	@"You need to ‘throw a wrench in the works’.", //1067
	@"Did you find the wrench in Hobbins’s workshop? If not, then return to Hobbins’s workshop, open the cupboard and take the wrench.", //1068
	@"Return to the production line – in the room beyond the welder robot you will see some gears.", //1069
	@"If you haven’t done so, talk to Anita and then Lamb until he leaves. Then throw the wrench into the gears.", //1070
//6
	@"Retrieve the wrench from the cogs.", //1071
	@"Use the wrench on the welder robot.", //1072
	@"Talk to Joey, and offer him a new shell.", //1073
//7
	@"Attempt to enter the storeroom.", //1074
	@"Tell Joey to check out the storeroom. When he reports that he has found the fusebox, tell him to disable the fuse box.", //1075
//8
	@"Lift the gangway on the floor.", //1076
	@"Pick up the putty (plastic explosive) which was under the gangway. This is the only object that you can keep after leaving.", //1077
//9
	@"Use the wrench on each of the two buttons beneath the pipes on the right.", //1078
	@"Tell Joey to press the right hand button, then press the other as he does so.", //1079
//10
	@"Turn off the switch on the control panel on the left.", //1080
	@"Remove the light bulb.", //1081
	@"Put the putty in the light fitting.", //1082
	@"Turn the switch back on.", //1083
	@"Pull the right hand power switch down to restore power to the lift.", //1084
//11
	@"Examine Reich’s corpse in the furnace room to get his ID.", //1085
	@"Use Reich’s ID card on the lift slot.", //1086

//BELLEVUE 1 
//12
	@"Go to Reich’s apartment and lift the pillow to reveal a motorbiking magazine.", //1087
	@"Go to the travel agent and ask him about the tours.", //1088
	@"Ask for the economy tour.", //1089
	@"Give him the motorbiking magazine in return for a tour ticket.", //1090
//13
	@"Give the ticket to Lamb to be invited on a tour of the pipe factory.", //1091

//INDUSTRIAL 2 
//14
	@"Ask Lamb about the tour – he will leave when he sees that the conveyor has stopped.", //1092
	@"Talk to Anita.", //1093
	@"She will eventually offer you a “jammer” – give her Reich’s ID.", //1094
// A jammer is hacking software - see ref 8639
	@"Talk further to learn about the Schriebmann port.", //1095

//BELLEVUE 2 
//15
	@"Talk to the surgery receptionist by clicking on the projector.", //1096
	@"Ask for a Schriebmann port.", //1097
	@"Ask Joey to talk to the receptionist to gain admittance to the surgery.", //1098
//16
	@"Talk to Burke until you get an offer to fit a Schriebmann port.", //1099
//17
	@"After the operation, keep talking to Burke to learn about Anchor’s “special policy”.", //1100
	@"Visit Anchor in the insurance office and mention Burke’s name to get him out of the room.", //1101
	@"Ask Joey to get the anchor from the statue.", //1102
	@"Pick up the anchor after Joey has melted the statue’s arm.", //1103
//18
	@"If you don’t have it, now would be a good time to get the cable hanging from the Industrial level.", //1104
	@"Ask Joey to cut the loose cable - get out of his way.", //1105
	@"Retrieve the cable which has fallen onto the Belle Vue level.", //1106
	@"Use the anchor on the cable to create a grappling hook.", //1107

//INDUSTRIAL 3 
//19
	@"Go to the fire door in Hobbins's recycling plant and walk out on the ledge.", //1108
	@"Use the grappling hook on the security sign on the opposite wall.", //1109

//SECURITY CENTRE 
//20
	@"In the Security HQ, use the ID card on the slot and sit down.", //1110

//LINC 1 
//21
// These are all specific software package names - please refer to original text files so they match
	@"Pick up the ball (compressed data) in area 1.", //1111
	@"Go right to area 2 and use open (in inventory) on the carpet bag.", //1112
	@"Get the birthday surprise (decompress). Use decompress on compressed data (in inventory).", //1113
	@"Get magnifying glass (decrypt) and use it on report.doc and briefing.doc (in inventory).", //1114
//22
// This is describing squares on a 3 * 3 grid
	@"Use green password on lower row / left tile. Use red password on lower row / centre tile.", //1115
	@"Pick up the green password and use on middle row / left tile.", //1116
	@"Pick up the red password and use on central tile.", //1117
	@"Pick up the green password and use on lower row / right tile.", //1118
//23
	@"Get book (phoenix.doc).", //1119
	@"Use decrypt on phoenix.doc.", //1120
	@"Get bust (phoenix program).", //1121
	@"Disconnect from LINC.", //1122

//SECURITY CENTRE 
//24
	@"Use ID card on LINC terminal.", //1123
	@"Select “Security services”. Select “view documents”", //1124
	@"Read each document. Note that they need to have been decrypted in LINC space.", //1125
	@"Select “special operations”. Select “special status request”.", //1126
	@"Select “file adjustment” to D-LINC Lamb.", //1127

//HYDE PARK 
//25
	@"Talk to Henri, the bouncer, to find out about sponsorship for the club.", //1128
	@"Talk to Danielle to be invited back to her apartment.", //1129
	@"Go back to Danielle’s Apartment.", //1130
//26
	@"You will need the cat video from Lamb’s apartment.", //1131
	@"D-LINC Lamb from “file adjustment” on the LINC terminal, and then talk to him.", //1132
	@"While Danielle is on the phone, play the video.", //1133
	@"While the dog is distracted, get the dog biscuits.", //1134
//27
	@"Go to the see-saw by the lake and use the dog biscuits on the plank.", //1135
	@"When the dog is nearby, pull the rope.", //1136
	@"When the dog gets onto the plank, release the rope.", //1137
//28
	@"Explore the lockers in the lower level - until you discover the terrible truth.", //1138
//29
	@"Return to the reactor in the factory and put on the radiation suit.", //1139
	@"Go to the terminal and open the reactor. Inside, pick up Anita’s ID card.", //1140
	@"Go back through the Security building.", //1141
	@"Enter LINC using Anita’s card.", //1142

//LINC 2 
//30
	@"Use “blind” on the eyeball in area 2.", //1143
	@"Use “playback” on the holographic projector (“well”) to view Anita’s message.", //1144
	@"Disconnect from LINC.", //1145

//HYDE PARK 2 
//31
	@"Return to Hyde Park. ", //1146
	@"Talk to Vincent to find out about the gardener.", //1147
	@"Talk to the gardener until he tells you about the virus.", //1148
//32
	@"Walk into the courtroom to witness Hobbins’s trial.", //1149
	@"Go to the club.", //1150
	@"Select “You search, but find nothing” on jukebox.", //1151
	@"Get Colston’s glass while he is away from the table.", //1152
//33
	@"Give the glass to Burke to get fingerprints.", //1153

//HYDE PARK 3 
//34
	@"Touch the plate to open the door to the wine cellar.", //1154
	@"Use the crowbar on the large box on the left.", //1155
	@"Get the lid and use it on the smaller box.", //1156
	@"Climb on top of the box.", //1157
	@"Use the crowbar on the grill.", //1158
//35
	@"If you haven’t found the secateurs then go to the shed in the park.", //1159
	@"Look at the door.", //1160
	@"Use the ID card on the lock.", //1161
	@"Enter the shed and get the secateurs.", //1162
//36
	@"Use the secateurs on the grill.", //1163
	@"Climb through the grill.", //1164

//UNDERWORLD 
//37
	@"Use the light bulb on the light socket to the left of the creature’s hole.", //1165
//38
	@"Use the crowbar on the crumbling plaster, then again on the brickwork to obtain a brick.", //1166
	@"-", //1167
	@"Use the crowbar on the clot in the vein.", //1168
	@"Use the brick on the crowbar to puncture the clot.", //1169
	@"Wait until the medical robot comes to repair the puncture, then exit through the door to the right.", //1170
//39
	@"Close the cover over the pit using the terminal beside the pit.", //1171
	@"Climb on top of the pit cover.", //1172
	@"Pull the retaining bar on the grill above your head to loosen the grill.", //1173
	@"Return to the room above.", //1174
//40
	@"Look through the grills to warn of any impending danger.", //1175
	@"Look through the first grill that you encounter.", //1176
	@"Walk right to the room where the medical robot is recharging.", //1177
	@"Use the circuit board on the medical robot.", //1178
//41
	@"Talk to Joey and send him into the tank room.", //1179
	@"Ask Joey what he saw in the tank room.", //1180
	@"Ask Joey about the tank.", //1181
	@"Tell Joey to open the tap.", //1182
	@"Enter the tank room and watch the android plunge to his death.", //1183
//42
	@"Walk to the right of the tanks, into the computer room.", //1184
	@"Use Reich’s ID card on the terminal (to the left of the bank of computers).", //1185
	@"Open the access door.", //1186
	@"Leave the computer room and watch Joey get destroyed again.", //1187
	@"Take Gallagher’s card from his remains.", //1188
//43
	@"Return to the computer room.", //1189
	@"Enter LINC using Gallagher’s card.", //1190
//44
	@"You need to enter LINC using Gallagher’s card. Drop out, then return again.", //1191
	@"Use blind on the eyeball in area 1. Quickly go to area 2 and blind the eyeball.", //1192
	@"Get the oscillator (tuning fork).", //1193
	@"Go to the Crusader room. Use “divine wrath” to remove the Crusader.", //1194
	@"Enter the crystal room. Use the oscillator on the crystal.", //1195
	@"Get the virus. Disconnect from LINC.", //1196
//45
	@"Go to the special android room. Open the cabinet on the middle console.", //1197
	@"Insert the circuit board in the cabinet.", //1198
	@"Use the monitor to download the data from the board.", //1199
	@"Run the android start-up program.", //1200
//46
	@"Go right to the room with the large tanks.", //1201
	@"Ask Joey/Ken to put his hand on the door panel.", //1202
	@"Put your own hand on the other panel.", //1203
//47
	@"Go to the tank of tissue samples and get the tongs from the wall (just to right of tank).", //1204
	@"Use Gallagher’s card (or whichever card contains the virus) on the console to infect the tissue with the virus.", //1205
	@"Remove a sample of infected tissue with the tongs.", //1206
	@"Put the sample of tissue into the nitrogen tank to freeze it.", //1207
//48
	@"Go to the end of the pipes. Attach the cable to the pipe support.", //1208
	@"Use the rungs to descend to the feeding orifice.", //1209
	@"Drop the infected tissue into the orifice.", //1210
	@"Use the hanging rope to swing into the final room.", //1211
//49
	@"When Joey/Ken enters tell him to sit in the chair.", //1212

// Missing answers added later

//RECYCLING PLANT 1 
//50
	@"Explore the factory. Perhaps you'll be able to get Joey working again.", //1213

//INDUSTRIAL 1 
//51
	@"Take a look around - there must be someone around who can help.", //1214
//52
	@"Explore some more - there's sure to be more to find.", //1215
//53
	@"Take the elevator down to the level below, and then take the next elevator down to ground level.", //1216

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//User Interface and game controls - Help!  (no constraints on text length on these four lines)
	@"Moving around the environment", //1217
	@"Tap a point on the floor area and Foster will walk there - if he can. To leave an area, you will need to interact with the exit arrow icon.", //1218
	@"Interacting with the environment", //1219
	@"Slide your finger around the game screen to find areas of interest (hotspots). Animating blue circles will appear over hotspots as your finger gets close to them. Slide your finger over the blue circle and action icons will be displayed to indicate what actions Foster can perform. To perform that action, lift your finger and tap the specific icon.", //1220
//1268 Increasing the time before going into sleep mode
//1270 To increase the time before your device goes into sleep mode, go to your iPhone 'Settings', then 'General', then 'Auto-Lock'. Choose the desired time setting.  

	@"DUMMY LINE", //1221

//Inventory Instructions  (no constraints on text length on these four lines)
	@"The inventory – what is it?", //1222
	@"Items that Foster picks up go into the ‘inventory’. Tap the box icon to display the items in the inventory. Tap an item to get a description of it.", //1223
	@"How to use an inventory item on background objects and people", //1224
	@"Open the inventory and press on an item for a few moments until it appears above your finger. While continuing to press the screen, drag the item over a hotspot and release when it highlights with a blue outline.", //1225
	@"Combining inventory items", //1226
	@"Sometimes you will need to combine two inventory items to create a third item. To do this, select the first item by pressing on it for a few moments until it appears above your finger. Now drag the item straight onto the second item – release when both are highlighted with a blue outline.", //1227


//First Screen Walkthrough (no constraints on text length on these four lines)
	@"Walkthrough for getting Foster to open the fire-door", //1228
	@"Slide your finger over the rung that is to the far left of the screen. A blue circle will animate over the rung as you get close. When your finger is over the rung, two icons will appear – turning cogs (interact) and a blinking eye (examine), and the word 'Rung' will appear at the top of the screen. Lift your finger and tap the cogs. The cogs will flash, and Foster will walk to the rung and pull it off. He will automatically put the rung into his inventory - where it will appear as 'Metal Bar.'", //1229
	@"LINE DELETED", //1230
	@"Open the inventory by tapping on the box icon. Press on the metal bar icon until it is displayed above your finger with a blue outline, then drag it across to the fire door until your finger is over the blue circle and 'Door' is displayed at the top of the screen, then lift your finger. Foster will now use the metal bar to lever open the fire door. Foster will then automatically walk out. Good luck!", //1231

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Twitter Stuff

//twitter test message
	@"Send test message - “I've just started Playing Beneath a Steel Sky on the iPhone / iPod touch! Be Vigilant.”", //1232

//twitter info
	@"There are several special interactions hidden throughout the game for you to find. Set up your Twitter details so the game can tweet as you discover them.", //1233

//tweets
	@"I've just started playing Beneath a Steel Sky on the iPhone / iPod touch. Be Vigilant!", //1234
	@"Tweet sent!", //1235
	@"Couldn't send tweet - possible connection issue.", //1236
	@"Couldn't send tweet - please check username / password.", //1237
	@"On the run in Beneath a Steel Sky. I just nicked Hobbins's knackwurst - no idea why I would want it, but this is an adventure after all...", //1238
	@"I've picked up Lamb's dodgy cat video in Beneath a Steel Sky. I don't trust the fellow one little bit.", //1239
	@"Escaped the amorous advances of Danielle Piermont in Beneath a Steel Sky. Dunked her yapping mutt into a pond - just as well he can swim.", //1240
	@"I just burst a security computer's blood vessel in Beneath a Steel Sky. So this thing bleeds. Gross!", //1241
	@"I just completed Beneath a Steel Sky on iPhone/iPod touch and saved the world!", //1242

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// General Messages

//new game alert
	@"If at any time you need help with the controls or want puzzle hints then tap the blue question mark icon.", //1243

//various misc
	@"Speech", //1244
	@"Subtitles", //1245
	@"Username", //1246
	@"Password", //1247
	@"Unused", //1248
	@"Unnamed", //1249
	@"Game Saved", //1250
	@"Game data successfully saved", //1251
	@"Game Save Fail!", //1252
	@"Game data NOT successfully saved", //1253
	@"Hint %d of %d", //1254
	@"Controls help and puzzle hints", //1255
	@"OK", //1256
	@"Text Language", //1257
	@"Username", //1358
	@"Password", //1359

// Tell a friend email:
	@"A message from 'Beneath a Steel Sky'", //1260
	@"Hey!", //1261
	@"I'm playing the classic adventure 'Beneath a Steel Sky,' revamped and updated exclusively for iPhone and iPod touch.", //1262
	@"Considered one of the best adventures ever written, the game now includes: stunning new animated movies from Dave Gibbons, co-creator of ‘Watchmen’; a context-sensitive help system; a special new touch interface; improved audio and, well, lots of cool stuff.", //1263
	@"Being such a wonderful, caring person, I wanted to share this with you. Just click on this link to see more about the game: http://www.revolution.co.uk/appstoreBASS", //1264
	@"Check it out! Be Vigilant.", //1265

	@"Twitter posting", //1266

// Added lines in Controls re sleep mode
	@"Increasing the time before screen fades", //1267
	@"To increase the time before your device goes into sleep mode, go to your iPhone 'Settings', then 'General', then 'Auto-Lock'. Choose the desired time setting.  ", //1268

	@"Foster Over: The old man was trying to tell the future. Looking for pictures in the campfire...", //1269
	@"Shaman: Ohhh, I see evil...", //1401
	@"Shaman: Evil born deep beneath the city... far from the light of day.", //1402
	@"Shaman: I see it growing, safe beneath a sky of steel...", //1403
	@"Shaman: Scheming in the dark... gathering strength.", //1404
	@"Shaman: And now... ohhh.... now the evil spreads...", //1405
	@"Shaman: It sends deadly feelers over the land above...", //1406
	@"Shaman: Across the gap... reaching towards this very place!", //1407
	@"Foster Over: I'd seen him do it a hundred times, but I humoured him.", //1408
	@"Foster Over: After all, he'd been like a father to me.", //1409
	@"Foster: And what does this evil want here?", //1410
	@"Shaman: Oh, my son. I fear...", //1411
	@"Shaman: I fear the evil wants you!", //1412
	@"Foster Over: That was when Joey piped up...", //1413
	@"Joey: Foster! Sensors detect incoming audio source!", //1414
	@"Shaman: The evil! The evil is nearly here...!", //1415
	@"Foster Over: It sounded more like a 'copter than a demon.", //1416
	@"Foster Over: But next thing, all hell let loose anyway...", //1417
	@"Shaman: Run, Foster! Run! Hide from the evil!", //1418
	@"Joey: Foster! (zzzt) H-Help!", //1419
	@"Joey: Better (zzzt) make my (zzzt) next body move (zzzt) faster...", //1420
	@"Foster Over: He was only a robot, but, well, I loved the little guy.", //1421
	@"Foster Over: Then, as suddenly as it started, the shooting stopped.", //1422
	@"Foster Over: There was a moment's silence as the copter cut its rotors, then...             ", //1423
	@"Reich: Whoever is in charge here, come forward...", //1424
	@"Foster Over: Only a fool would have argued with that firepower.", //1426
	@"Shaman: ... I am the leader of these people...", //1427
	@"Shaman: We are peaceful...", //1428
	@"Reich: Bring him here.", //1429
	@"Soldier: At once, Commander Reich.", //1430
	@"Reich: We're looking for someone...", //1431
	@"Reich: Someone who doesn't belong here...", //1432
	@"Reich: Who wasn't born in this garbage dump...", //1433
	@"Reich: Who came from the city as a child...", //1434
	@"Reich: We want to take him home again.", //1435
	@"Foster Over: My mind racing, I remembered where I'd seen that symbol before...", //1436
	@"Foster Over: It was the day the tribe found me...", //1437
	@"Foster Over: The day of the crash...", //1438
	@"Foster Over: The day my mother died.", //1439

	@"Tribesman: You alright, city boy?", //1440
	@"Shaman: Got a name, son?", //1441
	@"Foster: R-Robert.", //1442
	@"Shaman: Hah! Welcome to the Gap, Robert!", //1443
	@"Foster Over: As he patched me up, the old man had gently explained that there was no way back into the City...", //1445
	@"Foster Over: And I already knew there was nothing he could do for mother.", //1446
	@"Foster Over: His tribe was poor, but they treated me like one of their own...", //1447
	@"Foster Over: I learned how to survive in the wasteland they called the Gap...", //1448
	@"Foster Over: And scavenging from the City dumps.", //1449
	@"Foster Over: As the years passed, I forgot my life in the City.", //1450
	@"Foster Over: Discovered new talents...", //1451

	@"Joey: I'm your (zzzt) friend... call me (zzzt) Joey.", //1453
	@"Foster Over: And got a second name.", //1454
	@"Shaman: This is what we'll call you now you've come of age, son.", //1455
	@"Shaman: We found you... fostered you...", //1456
	@"Shaman: So that makes you Robert Foster.", //1457
	@"Reich: ...Wasted enough time!", //1458
	@"Reich: Give us the runaway or we'll shoot everyone...", //1459
	@"Reich: Starting with you, grandad!", //1460
	@"Foster Over: The old man had been right, for once...", //1461
	@"Foster Over: It was me they wanted.", //1462
	@"Shaman: No, my son! Don't let the evil take you! Run!", //1463
	@"DNA scan confirms it's him, sir.", //1464
	@"Foster Over: Evil had come to the Gap, just as he said.", //1465

	@"Reich: Take him.", //1466
	@"Foster Over: But had the old man seen why it wanted me?", //1467
	@"Foster Over: Or what it would do next?", //1468
	@"Foster Over: It was too late to ask him now.", //1469
	@"Pilot: Leaving destruction zone, Commander Reich.", //1470
	@"Reich: Good. Detonate.", //1471
	@"Foster Over: Much too late.", //1472

	@"Foster: Why, you murdering...", //1473
	@"Reich: Keep him quiet.", //1474
	@"Foster Over: All I could do was wait.", //1475
	@"Foster Over: Just like on a hunt. Just like the old man taught me.", //1476
	@"Foster Over: Wait... and be ready.", //1477

	@"Foster Over: It was dawn when we reached the City.", //1478
	@"Reich: Land in the central Security compound.", //1479
	@"Foster Over: A dawn my tribe would never see.", //1480
	@"Foster Over: They were no more than a note in Reich's book now.", //1481
	@"Pilot: Yes, sir. Locking on automatic landing beacon.", //1482
	@"Foster Over: But what was I? Why did...", //1483

	@"Pilot: Sir! The guidance system! It's gone crazy!", //1484
	@"Pilot: We're going to HIT!", //1485
	@"Foster Over: Maybe I'd get some answers now.", //1486
	@"Foster Over: If I survived another 'copter crash.", //1487

// Outro Movie text:
	@"A few years later…", //1488
	@"In a world were all are free, the price of liberty is enslavement.", //1489
	@"Be Vigilant", //1490
};

/*
	#define SKY_ENGLISH		0
	#define SKY_GERMAN		1
	#define SKY_FRENCH		2
	#define SKY_USA			3
	#define SKY_SWEDISH		4
	#define SKY_ITALIAN		5
	#define SKY_PORTUGUESE	6
	#define SKY_SPANISH		7
*/

- (NSString	*)giveLine: (int) line
{
	//printf("ASCII %d\n", line);

	line-=1000;//heh

	switch (Sky::g_engine->giveLanguageFlag())
	{
		case	SKY_USA:
			return	usASCII[line];
			break;
		case	SKY_SWEDISH:
			return	swASCII[line];
			break;
		case	SKY_FRENCH:
			return	frASCII[line];
			break;
		case	SKY_GERMAN:
			return	deASCII[line];
			break;
			
		case	SKY_ITALIAN:
			return	itASCII[line];
			break;
		case	SKY_PORTUGUESE:
			return	ptASCII[line];
			break;
			
		case	SKY_SPANISH:
			return	esASCII[line];
			break;
	}

	return	ukASCII[line];	//stop those warnings
}

- (NSString	*)giveButton: (NSString *) button
{
	//printf("ASCII %d\n", line);

	switch (Sky::g_engine->giveLanguageFlag())
	{
		case	SKY_ENGLISH:
		case	SKY_USA:
			break;//move along, nothing to see here

		case	SKY_SWEDISH:
			button = [NSString stringWithFormat:@"sw_%@", button];
			break;
		case	SKY_ITALIAN:
			button = [NSString stringWithFormat:@"it_%@", button];
			break;
		case	SKY_SPANISH:
			button = [NSString stringWithFormat:@"es_%@", button];
			break;
		case	SKY_FRENCH:
			button = [NSString stringWithFormat:@"fr_%@", button];
			break;
		case	SKY_GERMAN:
			button = [NSString stringWithFormat:@"de_%@", button];
			break;
		case	SKY_PORTUGUESE:
			button = [NSString stringWithFormat:@"pt_%@", button];
			break;
	}

	//NSLog(button);
	return	button;
}
@end
