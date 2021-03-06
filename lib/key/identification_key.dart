import 'dart:collection';
import 'dart:io' as io;

import 'package:xml/xml.dart' as xml;

import 'package:insetos_em_ordem/key/key_option.dart';
import 'package:insetos_em_ordem/key/question_node.dart';
import 'result_node.dart';

/// Object describing an identification key and static methods to load from a XML file,
///   an identification key is described by a set of question nodes and a set of result nodes all
///   identified by a string. The result nodes are the terminal nodes that conclude an identification.
class IdentificationKey {

  List<String> _orders;
  HashMap<String, QuestionNode> _nodes;
  HashMap<String, ResultNode> _results;

  IdentificationKey instance;

  /// Getter for a list of Orders
  List<String> getOrders() {
    return _orders;
  }

  /// Creates and identification key object
  IdentificationKey()
  {
    this._nodes = new HashMap<String, QuestionNode>();
    this._results = new HashMap<String, ResultNode>();
    this._orders = new List<String>();
  }

  /// Creates a node option from the XML element
  KeyOption parseOption(xml.XmlElement e)
  {
  
    String gotoId = e.getAttribute("goto");
  
    String text = getValue(e.findElements("text")).toString();
    String description = getValue(e.findElements("description")).toString();
    String imageLocation = getValue(e.findElements("imageLocation")).toString();

    return new KeyOption(gotoId, description, imageLocation, text);
  }

  /// Creates a question node from the XML element
  QuestionNode parseQuestion (xml.XmlElement e) {

    String id = e.getAttribute("id").toString();
    //String question = e.findElements("question").toString();

    var questao = getValue(e.findElements('question'));

    xml.XmlElement options = e.findElements("options").first;
    xml.XmlElement eA = options.findElements("option").elementAt(0);
    xml.XmlElement eB = options.findElements("option").elementAt(1);

    KeyOption optionA = parseOption(eA);
    KeyOption optionB = parseOption(eB);

    return QuestionNode(id, questao, optionA, optionB);
  }
  
  /// Creates a question node from the XML element
  ResultNode parseResult (xml.XmlElement e) {

    String id = e.getAttribute("id");
    String order = getValue(e.findElements("ordem")).toString();
    String description = getValue(e.findElements("description")).toString();
    String imageLocation = getValue(e.findElements("imageLocation")).toString();

    return new ResultNode(id, order, description, imageLocation);
  }

  /// Adds a question node to the key
  void addQuestion(QuestionNode node) {
    this._nodes.putIfAbsent(node.getId(), () => node);
  }

  /// Adds a result node to the key
  void addResult(ResultNode node) {
    this._results.putIfAbsent(node.getId(), () => node);
        String s = node.getOrder();
        this._orders.add(s);
  }
    
  /// Gets a question node from the key with the id
  QuestionNode getQuestion(String id)
    {
        return this._nodes[id];
    }
  
  ///Gets a result node from the key with the id
  ResultNode getResult(String id)
    {
        return this._results[id];
    }
  
  ResultNode getResultByOrder(String order)
    {
        int id = this._orders.indexOf(order) + 1;
        String sId = "R" + id.toString();
        return this._results[sId];
    }

  /// Checks if the node with the id is a question node
  bool isResult(String id) {  return this._results.containsKey(id); } 

/// Checks if the node with the id is a result node
  bool isQuestion(String id) {  return this._nodes.containsKey(id); } 

  /// Loads the XML and parse it to xmlParsed, and separe them into two.
  IdentificationKey loadXML() {

    IdentificationKey key = new IdentificationKey();

    ///String contents = new io.File('./assets/data/chave.xml').readAsStringSync();
    String contents = '''<?xml version="1.0" encoding="UTF-8"?>
            <key><nodes><node id="Q1"><question>Compare o seu exemplar com as imagens abaixo para fazer a sua escolha (se necessitar, pode ampliar as imagens)</question><options><option goto="Q2"><text>Asas anteriores (mais próximas da cabeça) delicadas e membranosas e com nervuras bem visíveis</text><description>Asas anteriores (mais próximas da cabeça) delicadas e membranosas e com nervuras bem visíveis</description><imageLocation>hintImages/1/asas_membranosas.jpg</imageLocation></option><option goto="Q14"><text>Asas anteriores robustas e duras, sem nervuras visíveis. Se as nervuras forem visíveis, tem um par de patas diferente dos outros. Sem asas</text><description>Asas anteriores (mais próximas da cabeça)robustas e duras, sem nervuras visíveis. Se as nervuras das asas forem visíveis, o inseto tem um par de patas diferente dos outros. Sem asas.</description><imageLocation>hintImages/1/asas_duras.jpg</imageLocation></option></options></node><node id="Q2"><question>Observe, com atenção, as asas do seu inseto</question><options><option goto="Q3"><text>Um par de asas (anteriores)</text><description>Um par de asas (anteriores)</description><imageLocation>hintImages/2/duas asas.jpg</imageLocation></option><option goto="Q4"><text>Dois pares de asas (anteriores e posteriores)</text><description>Dois pares de asas (anteriores e posteriores )</description><imageLocation>hintImages/2/quatro asas.jpg</imageLocation></option></options></node><node id="Q3"><question>Observe, com atenção, as antenas do seu inseto</question><options><option goto="R1"><text>Antenas formadas por três segmentos ou menos</text><description>Antenas formadas por três segmentos ou menos.</description><imageLocation>hintImages/3/cabeca mosca.jpg</imageLocation></option><option goto="R2"><text>Antenas formadas por mais de três segmentos</text><description>Antenas formadas por mais de três segmentos.</description><imageLocation>hintImages/3/cabeca mosquito.jpg</imageLocation></option></options></node><node id="Q4"><question>Observe, com atenção, as antenas do seu inseto</question><options><option goto="Q5"><text>Antenas Curtas (menores ou iguais à cabeça)</text><description>Antenas curtas.(menores ou iguais à cabeça)</description><imageLocation>hintImages/4/cabeca cigarra.jpg</imageLocation></option><option goto="Q8"><text>Antenas Compridas (maiores do que a cabeça)</text><description>Antenas compridas. (maiores do que a cabeça)</description><imageLocation>hintImages/4/cabeca formiga-leao.jpg</imageLocation></option></options></node><node id="Q5"><question>Observe, com atenção, as asas anteriores (mais próximas da cabeça)</question><options><option goto="Q6"><text>Asas anteriores ovais</text><description>Asas anteriores ovais.</description><imageLocation>hintImages/5/odonata oval.jpg</imageLocation></option><option goto="R3"><text>Asas anteriores triangulares</text><description>Asas anteriores triangulares.</description><imageLocation>hintImages/5/ephemeroptera triangular.jpg</imageLocation></option></options></node><node id="Q6"><question>Observe, com atenção, a boca do seu inseto</question><options><option goto="Q7"><text>Boca com grandes mandíbulas</text><description>Boca com grandes mandíbulas.</description><imageLocation>hintImages/6/boca libelula.jpg</imageLocation></option><option goto="R4"><text>Boca em forma de estilete (ou agulha)</text><description>Boca em forma de estilete (ou agulha).</description><imageLocation>hintImages/6/boca cigarra.jpg</imageLocation></option></options></node><node id="Q7"><question>Observe, com atenção, as asas do seu inseto</question><options><option goto="R5"><text>Asas anteriores mais estreitas que as posteriores</text><description>Asas anteriores mais estreitas que as posteriores.</description><imageLocation>hintImages/7/libelulas_diferentes.jpg</imageLocation></option><option goto="R6"><text>Asas anteriores e posteriores semelhantes</text><description>Asas anteriores e posteriores semelhantes.</description><imageLocation>hintImages/7/libelinha iguais.jpg</imageLocation></option></options></node><node id="Q8"><question>Observe, com atenção, as asas do seu inseto</question><options><option goto="Q9"><text>Asas sem revestimento, translúcidas (deixam passar a luz)</text><description>Asas sem revestimento, translúcidas. (deixam passar a luz)</description><imageLocation>hintImages/8/asas translucidas.jpg</imageLocation></option><option goto="Q12"><text>Asas revestidas, opacas (que dificultam a passagem da luz)</text><description>Asas revestidas, opacas (que dificultam a passagem da luz)</description><imageLocation>hintImages/8/asas opacas.jpg</imageLocation></option></options></node><node id="Q9"><question>Observe, com atenção, as asas do seu inseto</question><options><option goto="Q10"><text>Asas com poucas nervuras, quase sem nervuras transversais</text><description>Asas com poucas nervuras, quase sem nervuras transversais.</description><imageLocation>hintImages/9/poucas nervuras.jpg</imageLocation></option><option goto="Q11"><text>Asas com aspeto de rede, com muitas nervuras transversais e longitudinais</text><description>Asas com aspeto de rede, muitas nervuras transversais e longitudinais.</description><imageLocation>hintImages/9/muitas nervuras.jpg</imageLocation></option></options></node><node id="Q10"><question>Observe, com atenção, a região entre o tórax e o abdómen</question><options><option goto="R8"><text>Estrangulamento entre o tórax e o abdómen (com cintura)</text><description>Estrangulamento entre o tórax e o abdómen.(com cintura)</description><imageLocation>hintImages/10/hymenoptera com cintura.jpg</imageLocation></option><option goto="R7"><text>Sem estrangulamento entre o tórax e o abdómen (sem cintura)</text><description>Sem estrangulamento entre o tórax e o abdómen.(sem cintura)</description><imageLocation>hintImages/10/hymenoptera sem cintura.jpg</imageLocation></option></options></node><node id="Q11"><question>Observe, com atenção, a cabeça do seu inseto</question><options><option goto="R9"><text>Cabeça sem prolongamento</text><description>Cabeça sem prolongamento.</description><imageLocation>hintImages/11/sem prolongamento.jpg</imageLocation></option><option goto="R10"><text>Parte da frente da cabeça prolongada num “focinho”</text><description>Parte da frente da cabeça prolongada num “focinho”.</description><imageLocation>hintImages/11/focinho.jpg</imageLocation></option></options></node><node id="Q12"><question>Observe, com atenção, as asas do seu inseto</question><options><option goto="Q13"><text>Asas cobertas por escamas</text><description>Asas cobertas por escamas.</description><imageLocation>hintImages/12/escamas.jpg</imageLocation></option><option goto="R11"><text>Asas cobertas por pelos (sem escamas)</text><description>Asas cobertas por pelos.(sem escamas)</description><imageLocation>hintImages/12/pelos.jpg</imageLocation></option></options></node><node id="Q13"><question>Observe, com atenção, as antenas do seu inseto</question><options><option goto="R12"><text>Antenas em forma de maça, ou seja, que terminam numa dilatação arredondada</text><description>Antenas em forma de maça, ou seja, que terminam numa dilatação arredondada.</description><imageLocation>hintImages/13/antenas maca.jpg</imageLocation></option><option goto="R13"><text>Antenas de várias formas, mas nunca em forma de maça</text><description>Antenas de várias formas, mas nunca em forma de maça.</description><imageLocation>hintImages/13/antenas diversas.jpg</imageLocation></option></options></node><node id="Q14"><question>Observe, com atenção, as patas do seu inseto</question><options><option goto="Q16"><text>Terceiro par de patas com forma e tamanho semelhantes aos restantes</text><description>Terceiro par de patas com forma e tamanho semelhantes aos restantes.</description><imageLocation>hintImages/14/patas semelhantes.jpg</imageLocation></option><option goto="Q15"><text>Terceiro par de patas comprido e adaptado ao salto</text><description>Terceiro par de patas comprido e adaptado ao salto.</description><imageLocation>hintImages/14/patas salto.jpg</imageLocation></option></options></node><node id="Q15"><question>Observe, com atenção, as antenas do seu inseto</question><options><option goto="R15"><text>Antenas compridas, com tamanho superior ao do corpo</text><description>Antenas compridas, com tamanho superior ao do corpo.</description><imageLocation>hintImages/15/antenas compridas.jpg</imageLocation></option><option goto="R14"><text>Antenas de tamanho claramente inferior ao do corpo</text><description>Antenas de tamanho claramente inferior ao do corpo.</description><imageLocation>hintImages/15/antenas curtas.jpg</imageLocation></option></options></node><node id="Q16"><question>Observe, com atenção, as asas do seu inseto</question><options><option goto="Q18"><text>Com asas</text><description>Com asas.</description><imageLocation>hintImages/16/com asas.jpg</imageLocation></option><option goto="Q17"><text>Sem asas</text><description>Sem asas.</description><imageLocation>hintImages/16/sem asas.jpg</imageLocation></option></options></node><node id="Q17"><question>Observe, com atenção, o corpo do seu inseto</question><options><option goto="R16"><text>Forma do corpo semelhante a um pau</text><description>Forma do corpo semelhante a um pau.</description><imageLocation>hintImages/17/phasmida.jpg</imageLocation></option><option goto="R22"><text>Corpo sem aspeto de pau</text><description>Corpo sem aspecto de pau.</description><imageLocation>hintImages/17/formiga.jpg</imageLocation></option></options></node><node id="Q18"><question>Observe, com atenção, o abdómen do seu inseto</question><options><option goto="Q19"><text>Abdómen sem apêndices, ou, quando os tem, não são em forma de pinça</text><description>Abdómen sem apêndices, ou quando os tem, não são em forma de pinça.</description><imageLocation>hintImages/18/apendices sem forma de pinca.jpg</imageLocation></option><option goto="R17"><text>Abdómen a terminar em pinças</text><description>Abdómen a terminar em pinças.</description><imageLocation>hintImages/18/pincas.jpg</imageLocation></option></options></node><node id="Q19"><question>Observe, com atenção, o final do abdómen</question><options><option goto="Q20"><text>Final do abdómen com apêndices (cercos)</text><description>Final do abdómen com apêndices.(cercos)</description><imageLocation>hintImages/19/apendices .jpg</imageLocation></option><option goto="Q21"><text>Final do abdómen sem apêndices</text><description>Final do abdómen sem apêndices.(cercos)</description><imageLocation>hintImages/19/sem apendices.jpg</imageLocation></option></options></node><node id="Q20"><question>Observe, com atenção, as patas do seu inseto</question><options><option goto="R18"><text>Três pares de patas de aspeto semelhante</text><description>Três pares de patas de aspecto semelhante.</description><imageLocation>hintImages/20/patas semelhantes metade.jpg</imageLocation></option><option goto="R19"><text>Primeiro par de patas mais largo e espinhoso do que os restantes e com aspeto de garras</text><description>Primeiro par de patas mais largo e espinhoso do que as restantes e com aspecto de garras.</description><imageLocation>hintImages/20/patas anteriores garras.jpg</imageLocation></option></options></node><node id="Q21"><question>Observe, com atenção, a boca do seu inseto</question><options><option goto="Q22"><text>Boca em forma de estilete (ou agulha)</text><description>Boca em forma de bico.</description><imageLocation>hintImages/21/boca percevejo.jpg</imageLocation></option><option goto="R20"><text>Boca com mandíbulas visíveis</text><description>Boca com mandíbulas visíveis.</description><imageLocation>hintImages/21/boca coleoptera.jpg</imageLocation></option></options></node><node id="Q22"><question>Observe, com atenção, as asas do seu inseto</question><options><option goto="R21"><text>Asas anteriores divididas em duas áreas: mais perto da cabeça, de aspeto robusto e forte; na extremidade, mais delicada, translúcida e com nervuras visíveis</text><description>Asas anteriores divididas em duas áreas: mais perto da cabeça, a asa tem um aspeto robusto e forte; na extremidade, a asa é mais delicada, translúcida e tem as nervuras visíveis</description><imageLocation>hintImages/22/asa anterior percevejo.jpg</imageLocation></option><option goto="R23"><text>Asas anteriores com o mesmo aspeto em toda a sua extensão</text><description>Asas anteriores com o mesmo aspecto em toda a sua extensão.</description><imageLocation>hintImages/22/asa anterior cigarrinha.jpg</imageLocation></option></options></node></nodes><results><result id="R1"><ordem>Moscas: Ordem Diptera – Subordem Brachycera</ordem><description>Ordem Diptera: significa que tem duas (di) asas (ptera).

              As moscas e mosquitos, tal como as melgas e os moscardos, pertencem à Ordem Diptera. Têm apenas duas asas membranosas, encontrando-se as asas posteriores transformadas em balancetes, estruturas características da ordem. A boca dos mosquitos é do tipo sugadora, adaptada à sucção de líquidos. Os adultos de algumas espécies alimentam-se de sangue e outros não se alimentam de todo. As larvas podem ser aquáticas ou terrestres e neste caso podem alimentar-se de fungos e de matéria orgânica em decomposição.

              Subordem Brachycera
              Esta subordem (juntamente com a subordem Cyclorrapha) caracteriza-se pelas antenas, que nunca têm mais de 3 segmentos.

              Mais informação no Catálogo da Exposição “Insetos em Ordem” (goo.gl/bEFYPM).</description><imageLocation>resultImages/Diptera/moscas/Lucilia sp.jpg</imageLocation></result><result id="R2"><ordem>MOSQUITOS E MELGAS: Ordem Diptera – Subordem Nematocera</ordem><description>Ordem Diptera: significa que tem duas (di) asas (ptera).

              As moscas e mosquitos, tal como as melgas e os moscardos, pertencem à Ordem Diptera. Têm apenas duas asas membranosas, encontrando-se as asas posteriores transformadas em balancetes, estruturas características da ordem. A boca dos mosquitos é do tipo sugadora, adaptada à sucção de líquidos. Os adultos de algumas espécies alimentam-se de sangue e outros não se alimentam de todo. As larvas podem ser aquáticas ou terrestres e neste caso podem alimentar-se de fungos e de matéria orgânica em decomposição.

              Subordem Nematocera
              Os insetos desta subordem são os mais antigos da Ordem Diptera. Reconhecem-se pelas antenas formadas por mais de três segmentos e pelo corpo esguio. Os mosquitos e as melgas, devido à dependência da água e da humidade para o desenvolvimento das suas larvas, estão normalmente associados a habitats húmidos e sombrios, nas proximidades de cursos de água.

              Mais informação no Catálogo da Exposição “Insetos em Ordem” (goo.gl/bEFYPM).</description><imageLocation>resultImages/Diptera/mosquitos/Tipula sp asas castanhas.jpg</imageLocation></result><result id="R3"><ordem>EFÉMERAS: Ordem Ephemeroptera</ordem><description>Ordem Ephemeroptera: significa que vive um dia (ephemera).

              As efémeras distinguem‐se pelas antenas curtas, pela presença de duas ou três longas «caudas» no final do abdómen e por um ou dois pares de asas muito delicadas. Quando estão presentes, as asas anteriores são sempre muito maiores do que as posteriores. Na Europa há cerca de 200 espécies, mas a maior diversidade encontra-se nos trópicos. As efémeras europeias são mais pequenas e encontram-se normalmente na proximidade de água doce.

              Mais informação no Catálogo da Exposição “Insetos em Ordem” (goo.gl/bEFYPM).</description><imageLocation>resultImages/Ephemeroptera/Ephemera glaucops carta.jpg</imageLocation></result><result id="R4"><ordem>CIGARRAS: Ordem Homoptera</ordem><description>Ordem Homoptera: significa que tem asas (ptera) iguais (homo).

              As cigarras e as cigarrinhas formam um grupo de insetos muito heterogéneo, com muitas formas e estilos de vida, mas que partilha uma característica muito importante: a boca está transformada num longo estilete ou bico que serve para sugar líquidos. Em muitos casos, este bico está localizado numa posição muito inferior da cabeça, quase ao nível das patas da frente. Todas as espécies de homópteros se alimentam de plantas, constituindo em muitos casos pragas de culturas agrícolas. Estes insetos debilitam as plantas ao sugarem grandes quantidades de seiva e muitos injetam toxinas e microrganismos que são prejudiciais às plantas.

              Mais informação no Catálogo da Exposição “Insetos em Ordem” (goo.gl/bEFYPM).</description><imageLocation>resultImages/Hemiptera/Homoptera/Cicada orni.jpg</imageLocation></result><result id="R5"><ordem>LIBÉLULAS: Ordem Odonata – Subordem Anisoptera</ordem><description>Ordem Odonata: significa que tem dentes (odonto).

              A ordem Odonata divide-se em dois grupos: as libelinhas (subordem Zygoptera) e as libélulas (subordem Anisoptera). As libelinhas e as libélulas têm uma excelente capacidade de visão, proporcionada por dois enormes olhos compostos. Poderosas mandíbulas dotadas de dentes permitem-lhes comer animais duros, como os besouros. Ao contrário do que muitas vezes se pensa, as libélulas não têm ferrão (e por isso não picam). Apesar de serem animais de aspeto bizarro, são muito úteis pois alimentam-se de grande quantidade de moscas e de mosquitos. As libélulas e as libelinhas são insetos inconfundíveis: distinguem-se pelos longos e finos corpos e por terem dois pares de asas, nos quais se pode ver um complexo sistema de nervuras. As antenas são muito curtas. Em todo o mundo existem cerca de 6000 espécies de Odonata. Na Europa vivem perto de 120 espécies, das quais 65 se encontram em Portugal.

              Subordem Anisoptera: significa que tem asas (ptera) diferentes (aniso).
              Quando estão em repouso, as libélulas mantêm as asas abertas e na horizontal. Têm músculos fortes que permitem um voo rápido e caçar com grande eficácia. Sendo animais fundamentalmente aquáticos, precisam da água para completar o seu ciclo de vida. Contudo, os adultos são avistados muitas vezes longe dos rios e ribeiros onde nasceram, devido à sua grande capacidade de voo. É fácil encontrar libélulas nas clareiras de florestas a caçar insetos, em locais aquecidos pelo sol.

              Mais informação no Catálogo da Exposição “Insetos em Ordem” (goo.gl/bEFYPM).</description><imageLocation>resultImages/Odonata/Anisoptera/Libellula depressa.jpg</imageLocation></result><result id="R6"><ordem>LIBELINHAS: Ordem Odonata – Subordem Zygoptera</ordem><description>Ordem Odonata: significa que tem dentes (odonto).

              A ordem Odonata divide-se em dois grupos: as libelinhas (subordem Zygoptera) e as libélulas (subordem Anisoptera). As libelinhas e as libélulas têm uma excelente capacidade de visão, proporcionada por dois enormes olhos compostos. Poderosas mandíbulas dotadas de dentes permitem-lhes comer animais duros, como os besouros. Ao contrário do que muitas vezes se pensa, as libélulas não têm ferrão (e por isso não picam). Apesar de serem animais de aspeto bizarro, são muito úteis pois alimentam-se de grande quantidade de moscas e de mosquitos. As libélulas e as libelinhas são insetos inconfundíveis: distinguem-se pelos longos e finos corpos e por terem dois pares de asas, nos quais se pode ver um complexo sistema de nervuras. As antenas são muito curtas. Em todo o mundo existem cerca de 6000 espécies de Odonata. Na Europa vivem perto de 120 espécies, das quais 65 se encontram em Portugal.

              Subordem Zygoptera: significa que tem asas (ptera) iguais (zygo).
              As libelinhas têm dois pares de asas idênticos. Quando estão em repouso mantêm as asas na vertical, fechadas ou ligeiramente abertas. Os olhos compostos encontram-se numa posição oposta, criando uma estrutura que faz lembrar um pequeno martelo. As libelinhas são insetos delicados, com um voo gracioso e lento. Por serem pouco velozes, caçam as suas presas quando estas estão em repouso, geralmente sobre a vegetação.

              Mais informação no Catálogo da Exposição “Insetos em Ordem” (goo.gl/bEFYPM).</description><imageLocation>resultImages/Odonata/Zygoptera/Lestes viridis.jpg</imageLocation></result><result id="R7"><ordem>VESPAS-PORTA-SERRA: Ordem Hymenoptera – Subordem Symphyta</ordem><description>Ordem Hymenoptera: significa que tem asas (ptera) mebranosas (hymen).

              Os himenópteros caracterizam-se pela presença de dois pares de asas membranosas com poucas nervuras, sendo as anteriores maiores do que as posteriores. Alguns himenópteros, como as formigas, podem não ter asas. A Ordem Hymenoptera é a segunda maior com cerca de 200 000 espécies conhecidas. Em Portugal estão registadas pouco mais de 1000 espécies, provavelmente um número muito abaixo da realidade. Os himenópteros desempenham importantes funções nos ecossistemas como polinizadores e agentes de controlo biológico das populações de outros insetos.

              Subordem Symphyta
              As vespas-porta-serra distinguem-se dos restantes himenópteros por não terem um estreitamento entre o tórax e o abdómen (a «cintura de vespa»). O seu nome comum faz referência ao ovipositor da fêmea, em forma de serra, que serve para cortar os tecidos das plantas onde deposita os ovos. Os adultos alimentam‐se de pólen.

              Mais informação no Catálogo da Exposição “Insetos em Ordem” (goo.gl/bEFYPM).</description><imageLocation>resultImages/Hymenoptera/Symphyta/Macrophya montana.jpg</imageLocation></result><result id="R8"><ordem>ABELHAS, VESPAS, VESPAS PARASITAS E PARASITÓIDES: Ordem Hymenoptera – Subordem Apocrita</ordem><description>Ordem Hymenoptera: significa que tem asas (ptera) mebranosas (hymen).

              Os himenópteros caracterizam-se pela presença de dois pares de asas membranosas com poucas nervuras, sendo as anteriores maiores do que as posteriores. Alguns himenópteros, como as formigas, podem não ter asas. A Ordem Hymenoptera é a segunda maior com cerca de 200 000 espécies conhecidas. Em Portugal estão registadas pouco mais de 1000 espécies, provavelmente um número muito abaixo da realidade. Os himenópteros desempenham importantes funções nos ecossistemas como polinizadores e agentes de controlo biológico das populações de outros insetos.

              Subordem Apocrita
              A maior parte dos himenópteros, entre os quais as populares vespas, abelhas e formigas, pertencem a esta subordem. Este grupo caracteriza‐se por possuir um pronunciado estreitamento entre o tórax e o abdómen – a «cinturinha de vespa». As larvas estão sempre rodeadas de comida e por isso não precisam de se mover, razão pela qual a cabeça é reduzida e não possuem patas.

              Mais informação no Catálogo da Exposição “Insetos em Ordem” (goo.gl/bEFYPM).</description><imageLocation>resultImages/Hymenoptera/Apocrita/Megascolia maculata.jpg</imageLocation></result><result id="R9"><ordem>CRISOPAS, LIBELÓIDES E FORMIGAS-LEÃO: Ordem Neuroptera</ordem><description>Ordem Neuroptera: significa que tem nervuras (neuro) nas asas (ptera).

              Os insetos desta Ordem têm as asas membranosas com muitas nervuras longitudinais e transversais, formando uma rede de malha apertada. As antenas são compridas e a boca tem poderosas mandíbulas adaptadas à mastigação de materiais rijos. A maior parte das espécies são predadoras em todas as fases do ciclo de vida. Em todo o mundo existem mais de 4500 espécies.

              Mais informação no Catálogo da Exposição “Insetos em Ordem” (goo.gl/bEFYPM).</description><imageLocation>resultImages/Neuroptera/Nemoptera bipennis.jpg</imageLocation></result><result id="R10"><ordem>MOSCAS-ESCORPIÃO E MOSCAS-BALOIÇO: Ordem Mecoptera</ordem><description>Ordem Mecoptera: significa que tem asas (ptera) longas (meco).

              A forma da cabeça destes insetos, projetada para baixo formando um focinho com mandíbulas na extremidade, torna-os inconfundíveis. A maioria das espécies tem dois pares de asas membranosas, longas e com manchas escuras. As patas são muito finas. As antenas são longas, com muitos segmentos. Os olhos são compostos e bem desenvolvidos. Existem cerca de 500 espécies descritas das quais cerca de 30 se encontram na Europa. A fauna portuguesa é representada por duas famílias com apenas um sp. conhecido em cada uma delas: a mosca-escorpião (Panorpa sp., família Panorpidae) e a mosca-baloiço (Bittacus italicus, família Bittacidae).

              Mais informação no Catálogo da Exposição “Insetos em Ordem” (goo.gl/bEFYPM).</description><imageLocation>resultImages/Mecoptera/mosca-escorpiao Panorpa meridionalis.jpg</imageLocation></result><result id="R11"><ordem>FRIGâNIOS: Ordem Trichoptera</ordem><description>Ordem Trichoptera: significa que tem pelos (trichos) nas asas (ptera).

              As asas dos frigânios ou tricópteros possuem poucas nervuras transversais e estão cobertas por pelos. Quando o inseto está em repouso mantém as asas sobre o corpo como se fossem um telhado. As antenas são finas e por vezes muito longas. Os frigânios podem lembrar algumas borboletas. Distinguem-se destas pela presença de pelos a revestir as asas e por terem mandíbulas na boca. Os adultos são pouco conhecidos, têm cores e padrões pouco vistosos, e voam habitualmente ao anoitecer. A diversidade mundial ronda as 13 000 espécies, mas em muitas regiões o número real é ainda desconhecido. As larvas de frigânios são aquáticas e os adultos vivem na proximidade de massas de água doce. Os casulos construídos pelas larvas são fáceis de encontrar em rios e ribeiros, por isto, é esta a fase do ciclo de vida dos tricópteros mais popular e conhecida.

              Mais informação no Catálogo da Exposição “Insetos em Ordem” (goo.gl/bEFYPM).</description><imageLocation>resultImages/Trichoptera/Mosca-de-Agua.jpg</imageLocation></result><result id="R12"><ordem>BORBOLETAS DIURNAS: Ordem Lepidoptera – Grupo Rhopalocera</ordem><description>Ordem Lepidoptera: significa que tem escamas (lepido) nas asas (ptera).

              As borboletas são insetos muito característicos: possuem dois pares de asas membranosas, encontrando‐se estas e o corpo cobertos por escamas. A boca da grande maioria das espécies é formada por uma probóscide ou espirotromba, que é um tubo que permite aos animais sugar líquidos (água e néctar), como se fosse uma palhinha. A probóscide permanece enrolada em espiral por baixo da cabeça quando o animal não se alimenta. A diversidade de lepidópteros atualmente conhecida é estimada entre 160 000 a 175 000 espécies. No entanto, pensa‐se que o total de espécies poderá chegar a meio milhão.

              Grupo Rhopalocera: significa que tem as antenas (cera) em forma de maça (rhopalo).
              Tal como o nome comum indica, estes animais têm hábitos diurnos. O nome científico remete para a forma das antenas que são lineares e terminam em forma de maça ou clava, ou seja, têm uma dilatação na extremidade. A maioria das espécies não faz um casulo para proteger a pupa ou crisálida. Outra característica que distingue este grupo é a ausência de qualquer sistema de ligação entre as asas anteriores e posteriores.
              Os ropalóceros ou borboletas diurnas são o grupo de insetos melhor conhecido. Na Europa há 420 espécies, especialmente concentradas na região mediterrânica e nas zonas montanhosas (Alpes e Pirinéus). A Península Ibérica, com 239 espécies, é dos locais mais ricos em borboletas. Em Portugal ocorrem 135 espécies.

              Mais informação no Catálogo da Exposição “Insetos em Ordem” (goo.gl/bEFYPM).</description><imageLocation>resultImages/Lepidoptera/Rhopalocera/Vanessa atalanta.jpg</imageLocation></result><result id="R13"><ordem>BORBOLETAS NOTURNAS: Ordem Lepidoptera – Grupo Heterocera</ordem><description>Ordem Lepidoptera: significa que tem escamas (lepido) nas asas (ptera).

              As borboletas são insetos muito característicos: possuem dois pares de asas membranosas, encontrando‐se estas e o corpo cobertos por escamas. A boca da grande maioria das espécies é formada por uma probóscide ou espirotromba, que é um tubo que permite aos animais sugar líquidos (água e néctar), como se fosse uma palhinha. A probóscide permanece enrolada em espiral por baixo da cabeça quando o animal não se alimenta. A diversidade de lepidópteros atualmente conhecida é estimada entre 160 000 a 175 000 espécies. No entanto, pensa‐se que o total de espécies poderá chegar a meio milhão.
              Grupo Heterocera: significa que tem as antenas (cera) com diferentes formas (hetero).
              Cerca de 90% dos lepidópteros estão incluídos no grupo das borboletas noturnas. Este nome genérico atribuído ao grupo pode ser enganador. Apesar de ser associado a borboletas com actividade noturna e de cores escuras (como as que visitam as lâmpadas de candeeiros), a verdade é que este grupo também inclui borboletas que voam durante o dia e têm, por isso, asas muito coloridas. A principal característica deste grupo é a forma das antenas, que pode ser muito variada (em forma de pente, corda ou fio), mas nunca em maça como sucede nas borboletas diurnas.
              Em Portugal encontram-se inventariadas cerca de 2600 espécies e todos os anos são descobertas novas espécies, fruto do trabalho de investigadores nacionais e estrangeiros. Para mais informação sobre a nossa fauna pode consultar www.lusoborboletas.org. Seguem-se imagens de algumas espécies emblemáticas em diversas fases do ciclo de vida.

              Mais informação no Catálogo da Exposição “Insetos em Ordem” (goo.gl/bEFYPM).</description><imageLocation>resultImages/Lepidoptera/Heterocera/Catocala elocata.jpg</imageLocation></result><result id="R14"><ordem>GAFANHOTOS: Ordem Orthoptera – Subordem Caelifera</ordem><description>Ordem Orthoptera: significa que tem asas (ptera) direitas (ortho).

              Insetos com a cabeça grande e o primeiro segmento do tórax (pronoto) bem visível e parecido com uma sela de montar. As patas traseiras são muito maiores do que as restantes e estão adaptadas para saltar. Os adultos possuem geralmente dois pares de asas, sendo as anteriores duras ou coriáceas. Conhecem‐se mais de 15 000 espécies no mundo, sendo as regiões tropicais as mais ricas. Na Europa, a maior diversidade de espécies encontra-se na região Mediterrânica. Existem mais de 300 espécies na Península Ibérica e cerca de 140 em Portugal.

              Subordem Caelifera: significa «gravar em relevo» (caelare).
              A maioria das espécies de gafanhotos prefere prados e zonas abertas com clima quente e seco.

              Mais informação no Catálogo da Exposição “Insetos em Ordem” (goo.gl/bEFYPM).</description><imageLocation>resultImages/Orthoptera/curtas/Calliptamus barbarus.jpg</imageLocation></result><result id="R15"><ordem>GRILOS E SALTÕES: Ordem Orthoptera – Subordem Ensifera</ordem><description>Ordem Orthoptera: significa que tem asas (ptera) direitas (ortho).

              Insetos com a cabeça grande e o primeiro segmento do tórax (pronoto) bem visível e parecido com uma sela de montar. As patas traseiras são muito maiores do que as restantes e estão adaptadas para saltar. Os adultos possuem geralmente dois pares de asas, sendo as anteriores duras ou coriáceas. Conhecem‐se mais de 15 000 espécies no mundo, sendo as regiões tropicais as mais ricas. Na Europa, a maior diversidade de espécies encontra-se na região Mediterrânica. Existem mais de 300 espécies na Península Ibérica e cerca de 140 em Portugal.

              Subordem Ensifera: significa «portador de espada» (ensifer).
              A maioria das espécies deste grupo prefere locais com vegetação densa como bosques e matos, pelo que a sua conservação depende da manutenção destes habitats.

              Mais informação no Catálogo da Exposição “Insetos em Ordem” (goo.gl/bEFYPM).</description><imageLocation>resultImages/Orthoptera/compridas/Tettigonia viridissima.jpg</imageLocation></result><result id="R16"><ordem>BICHO-PAU: Ordem Phasmida</ordem><description>Ordem Phasmida: significa «espírito» ou «aparição» (phasma).

              Os bichos-pau são inconfundíveis: são insetos esguios, com longas patas, mandíbulas fortes e um par de antenas compridas. Na Europa não há nenhuma espécie com asas. As patas, todas idênticas, são constituídas por cinco segmentos. São animais herbívoros: as fortes mandíbulas são necessárias para mastigar as plantas de que se alimentam.

              Mais informação no Catálogo da Exposição “Insetos em Ordem” (goo.gl/bEFYPM).</description><imageLocation>resultImages/Phasmidae/bicho-pau Leptynia attenuata carta.jpg</imageLocation></result><result id="R17"><ordem>BICHAS-CADELA: Ordem Dermaptera</ordem><description>Ordem Dermaptera: significa que tem as asas (ptera) semelhantes a pele (derma).

              São insetos alongados, com antenas longas e finas. No tórax encontram-se dois pares de asas, sendo as anteriores curtas e duras e designadas por tégminas. As asas posteriores são grandes e membranosas. Quando estão em repouso, as asas posteriores ficam dobradas de uma forma complicada debaixo das tégminas. O abdómen possui bastante mobilidade e tem um par de segmentos terminais modificados em forma de pinças. Nos machos adultos estas pinças são fortemente curvadas. As pinças têm várias funções: podem ser usadas para abrir as asas, para capturar presas e também como arma de defesa contra predadores. Os Dermaptera são uma ordem relativamente pequena, com cerca de 1800 espécies no mundo inteiro.

              Mais informação no Catálogo da Exposição “Insetos em Ordem” (goo.gl/bEFYPM).</description><imageLocation>resultImages/Dermaptera/Forficula auriculata.jpg</imageLocation></result><result id="R18"><ordem>BARATAS: Ordem Blattodea</ordem><description>Ordem Blattodea: significa que foge da luz (blatta).

              As baratas têm um corpo oval, achatado e uma coloração escura. Caracterizam-se por terem um pronoto (primeiro segmento do tórax) em forma de escudo e que cobre grande parte da cabeça. Muitas espécies de baratas possuem dois pares de asas: as anteriores são duras e as posteriores são membranosas. A boca é do tipo mastigador. A maioria das espécies tem antenas longas e finas.

              Mais informação no Catálogo da Exposição “Insetos em Ordem” (goo.gl/bEFYPM).</description><imageLocation>resultImages/Blatodea/Periplaneta americana.jpg</imageLocation></result><result id="R19"><ordem>LOUVA-A-DEUS: Ordem Mantodea</ordem><description>Ordem Mantodea: significa que tem a forma de um «profeta».

              Os louva-a-deus distinguem-se facilmente pelas patas anteriores espinhosas e desenvolvidas de maneira a poderem caçar. O primeiro segmento do tórax (pronoto) é muito comprido e estreito. Algumas espécies possuem dois pares de asas perfeitamente funcionais, noutras apenas o macho consegue voar e existem mesmo espécies sem asas. Existem cerca de 2300 espécies de louva-a-deus, que se encontram sobretudo nas regiões tropicais. Na Europa são conhecidas doze espécies e em Portugal foram registadas nove.

              Mais informação no Catálogo da Exposição “Insetos em Ordem” (goo.gl/bEFYPM).</description><imageLocation>resultImages/Mantodea/louva-a-deus Iris oratoria carta.jpg</imageLocation></result><result id="R20"><ordem>BESOUROS OU ESCARAVELHOS: Ordem Coleoptera</ordem><description>Ordem Coleoptera: significa que têm asas (ptera) protetoras (coleo).

              Os adultos desta ordem possuem normalmente dois pares de asas. As asas anteriores estão endurecidas, e não servem para voar, mas sim para proteger o abdómen. Quando estão pousados, o par de asas posterior e o abdómen não se vêem, pois estão ocultos pelas asas endurecidas.
              Os besouros são muito abundantes quer em número de indivíduos, quer em número de espécies. Estima‐se que existam mais de 350 000 espécies em todo o mundo. A sua diversidade manifesta‐se na variedade de habitats que podem colonizar e também na capacidade para explorar diferentes tipos de recursos alimentares. Esta capacidade está relacionada com o grupo a que pertencem e, por este motivo, serão apresentados tendo em conta as suas preferências alimentares.
              Todos os estádios de desenvolvimento dos besouros, desde as larvas aos adultos, têm a boca adaptada para mastigar, com mandíbulas bem desenvolvidas. Ao primeiro par de asas dos besouros dá‐se o nome de élitros. A presença dos élitros foi determinante para o sucesso deste grupo, conferindo‐lhe uma grande resistência e capacidade de colonizar diversos meios.

              Mais informação no Catálogo da Exposição “Insetos em Ordem” (goo.gl/bEFYPM).</description><imageLocation>resultImages/Coleoptera/Copris de asa aberta.jpg</imageLocation></result><result id="R21"><ordem>PERCEVEJOS: Ordem Heteroptera</ordem><description>Ordem Heteroptera: significa que tem asas (ptera) diferentes (hetero).

              O nome desta ordem refere-se às características das asas anteriores destes insetos, em que a parte superior é dura e a parte inferior membranosa. De uma maneira geral, o corpo dos percevejos é achatado e as asas estão dobradas sobre o corpo quando os animais estão em repouso. À semelhança das cigarras e das cigarrinhas, todas as espécies desta ordem possuem a boca em forma de estilete. Muitas famílias têm a capacidade de segregar substâncias, que são libertadas por glândulas existentes nas patas posteriores e que produzem um cheiro desagradável.

              Mais informação no Catálogo da Exposição “Insetos em Ordem” (goo.gl/bEFYPM)</description><imageLocation>resultImages/Hemiptera/Heteroptera/Rhinocoris iracundus.jpg</imageLocation></result><result id="R22"><ordem>FORMIGAS: Ordem Hymenoptera – Subordem Apocrita</ordem><description>Ordem Hymenoptera: significa que tem asas (ptera) mebranosas (hymen).

              Os himenópteros caracterizam-se pela presença de dois pares de asas membranosas com poucas nervuras, sendo as anteriores maiores do que as posteriores. Alguns himenópteros, como as formigas, podem não ter asas. A Ordem Hymenoptera é a segunda maior com cerca de 200 000 espécies conhecidas. Em Portugal estão registadas pouco mais de 1000 espécies, provavelmente um número muito abaixo da realidade. Os himenópteros desempenham importantes funções nos ecossistemas como polinizadores e agentes de controlo biológico das populações de outros insetos.

              Subordem Apocrita
              A maior parte dos himenópteros, entre os quais as populares vespas, abelhas e formigas, pertencem a esta subordem. Este grupo caracteriza‐se por possuir um pronunciado estreitamento entre o tórax e o abdómen – a «cinturinha de vespa». As larvas estão sempre rodeadas de comida e por isso não precisam de se mover, razão pela qual a cabeça é reduzida e não possuem patas.

              Mais informação no Catálogo da Exposição “Insetos em Ordem” (goo.gl/bEFYPM).</description><imageLocation>resultImages/Hymenoptera/Apocrita/Cataglyphis sp.jpg</imageLocation></result><result id="R23"><ordem>CIGARRINHAS: Ordem Homoptera</ordem><description>Ordem Homoptera: significa que tem asas (ptera) iguais (homo)
              As cigarras e as cigarrinhas formam um grupo de insetos muito heterogéneo, com muitas formas e estilos de vida, mas que partilha uma característica muito importante: a boca está transformada num longo estilete ou bico que serve para sugar líquidos. Em muitos casos, este bico está localizado numa posição muito inferior da cabeça, quase ao nível das patas da frente. Todas as espécies de homópteros se alimentam de plantas, constituindo em muitos casos pragas de culturas agrícolas. Estes insetos debilitam as plantas ao sugarem grandes quantidades de seiva e muitos injetam toxinas e microrganismos que são prejudiciais às plantas.

              Mais informação no Catálogo da Exposição “Insetos em Ordem” (goo.gl/bEFYPM).</description><imageLocation>resultImages/Hemiptera/Homoptera/Cicadella viridis.jpg</imageLocation></result></results></key>

    ''';

    var xmlParsed = xml.parse(contents);
    
    var nodes = xmlParsed.findAllElements("nodes").first.findAllElements("node");
    
    for(xml.XmlElement node in nodes) {
        QuestionNode questionNode = parseQuestion(node);
      key.addQuestion(questionNode);
    }

    var results = xmlParsed.findAllElements("results").first.findAllElements("result");
    
    for(xml.XmlElement result in results) {
        ResultNode resultNode = parseResult(result);
      key.addResult(resultNode);
    }

    return key;
  }

  getValue(Iterable<xml.XmlElement> items) {
      var textValue;
      items.map((xml.XmlElement node) {
        textValue = node.text;
      }).toList();
      return textValue;
    }

  /* IdentificationKey getInstance() {
    if(instance==null) {
      
      String contents = new io.File('./assets/data/chave.xml').readAsStringSync();

      instance = IdentificationKey.loadXML(contents);
      return instance;
    }
    return null;
  } */
  
}