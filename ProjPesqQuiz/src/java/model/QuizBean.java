package model;

/**
 * Bean que representa uma participação no quiz: quem respondeu (nome)
 * e a alternativa (1 a 4) escolhida em cada uma das 8 questões.
 */
public class QuizBean {
    private int id;
    private String nome;
    private int r1;
    private int r2;
    private int r3;
    private int r4;
    private int r5;
    private int r6;
    private int r7;
    private int r8;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public int getR1() {
        return r1;
    }

    public void setR1(int r1) {
        this.r1 = r1;
    }

    public int getR2() {
        return r2;
    }

    public void setR2(int r2) {
        this.r2 = r2;
    }

    public int getR3() {
        return r3;
    }

    public void setR3(int r3) {
        this.r3 = r3;
    }

    public int getR4() {
        return r4;
    }

    public void setR4(int r4) {
        this.r4 = r4;
    }

    public int getR5() {
        return r5;
    }

    public void setR5(int r5) {
        this.r5 = r5;
    }

    public int getR6() {
        return r6;
    }

    public void setR6(int r6) {
        this.r6 = r6;
    }

    public int getR7() {
        return r7;
    }

    public void setR7(int r7) {
        this.r7 = r7;
    }

    public int getR8() {
        return r8;
    }

    public void setR8(int r8) {
        this.r8 = r8;
    }

    /** Retorna as 8 respostas em um vetor (posição 0 = questão 1). */
    public int[] getRespostas() {
        return new int[]{r1, r2, r3, r4, r5, r6, r7, r8};
    }

    /** Define a resposta de uma questão (questao de 1 a 8). */
    public void setResposta(int questao, int valor) {
        switch (questao) {
            case 1: r1 = valor; break;
            case 2: r2 = valor; break;
            case 3: r3 = valor; break;
            case 4: r4 = valor; break;
            case 5: r5 = valor; break;
            case 6: r6 = valor; break;
            case 7: r7 = valor; break;
            case 8: r8 = valor; break;
            default: throw new IllegalArgumentException("Questão inválida: " + questao);
        }
    }

}
