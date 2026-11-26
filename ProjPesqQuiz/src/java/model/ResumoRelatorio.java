package model;

/**
 * Dados do relatório-resumo: total de entrevistados e quantas vezes cada
 * alternativa (1 a 4) foi escolhida em cada questão (1 a 8).
 */
public class ResumoRelatorio {

    private int totalParticipantes;
    private final int[][] contagem =
            new int[QuizConteudo.TOTAL_QUESTOES][QuizConteudo.TOTAL_ALTERNATIVAS];

    public int getTotalParticipantes() {
        return totalParticipantes;
    }

    public void setTotalParticipantes(int totalParticipantes) {
        this.totalParticipantes = totalParticipantes;
    }

    public int getContagem(int questao, int alternativa) {
        return contagem[questao - 1][alternativa - 1];
    }

    public void setContagem(int questao, int alternativa, int valor) {
        contagem[questao - 1][alternativa - 1] = valor;
    }

    /** Percentual (0 a 100) de entrevistados que escolheram a alternativa. */
    public double getPercentual(int questao, int alternativa) {
        if (totalParticipantes == 0) {
            return 0.0;
        }
        return getContagem(questao, alternativa) * 100.0 / totalParticipantes;
    }

}
