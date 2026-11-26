package model;

/**
 * Conteúdo do quiz (enunciados, alternativas e gabarito) em um único lugar.
 * Para trocar o tema do quiz, basta alterar os vetores abaixo:
 * todas as páginas (formulário, edição e relatórios) leem daqui.
 */
public class QuizConteudo {

    public static final int TOTAL_QUESTOES = 8;
    public static final int TOTAL_ALTERNATIVAS = 4;

    private static final String[] ENUNCIADOS = {
        "Qual é o planeta mais próximo do Sol?",
        "Qual planeta é conhecido como \"planeta vermelho\"?",
        "Qual é o maior planeta do Sistema Solar?",
        "Qual planeta é mais famoso pelos seus anéis?",
        "Como se chama a galáxia em que o Sistema Solar está localizado?",
        "Qual é o único satélite natural da Terra?",
        "Quanto tempo, aproximadamente, a luz do Sol leva para chegar até a Terra?",
        "Qual é o planeta mais quente do Sistema Solar?"
    };

    private static final String[][] ALTERNATIVAS = {
        {"Vênus", "Mercúrio", "Marte", "Terra"},
        {"Júpiter", "Mercúrio", "Marte", "Netuno"},
        {"Saturno", "Júpiter", "Urano", "Terra"},
        {"Marte", "Vênus", "Saturno", "Mercúrio"},
        {"Andrômeda", "Via Láctea", "Triângulo", "Redemoinho"},
        {"Fobos", "Europa", "Titã", "Lua"},
        {"8 minutos", "8 segundos", "8 horas", "8 dias"},
        {"Mercúrio", "Vênus", "Marte", "Júpiter"}
    };

    /** Número (1 a 4) da alternativa correta de cada questão. */
    private static final int[] GABARITO = {2, 3, 2, 3, 2, 4, 1, 2};

    /** Enunciado da questão (questao de 1 a 8). */
    public static String getEnunciado(int questao) {
        return ENUNCIADOS[questao - 1];
    }

    /** Texto da alternativa (questao de 1 a 8, alternativa de 1 a 4). */
    public static String getAlternativa(int questao, int alternativa) {
        return ALTERNATIVAS[questao - 1][alternativa - 1];
    }

    /** Número da alternativa correta da questão. */
    public static int getGabarito(int questao) {
        return GABARITO[questao - 1];
    }

    /** Quantidade de acertos de uma participação. */
    public static int calcularAcertos(QuizBean bean) {
        int[] respostas = bean.getRespostas();
        int acertos = 0;
        for (int i = 0; i < TOTAL_QUESTOES; i++) {
            if (respostas[i] == GABARITO[i]) {
                acertos++;
            }
        }
        return acertos;
    }

}
