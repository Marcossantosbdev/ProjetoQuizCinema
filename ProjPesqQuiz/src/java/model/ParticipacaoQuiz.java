package model;

import java.sql.Timestamp;

public class ParticipacaoQuiz {

    private int id;
    private String nomeEntrevistado;
    private int q1;
    private int q2;
    private int q3;
    private int q4;
    private int q5;
    private int q6;
    private int q7;
    private int q8;
    private Timestamp dataRegistro;

    public ParticipacaoQuiz() {
    }

    public ParticipacaoQuiz(String nomeEntrevistado, int q1, int q2, int q3, int q4,
                            int q5, int q6, int q7, int q8) {
        this.nomeEntrevistado = nomeEntrevistado;
        setQ1(q1);
        setQ2(q2);
        setQ3(q3);
        setQ4(q4);
        setQ5(q5);
        setQ6(q6);
        setQ7(q7);
        setQ8(q8);
    }

    private int validarAlternativa(int valor) {
        if (valor < 1 || valor > 4) {
            throw new IllegalArgumentException("A alternativa deve estar entre 1 e 4. Valor recebido: " + valor);
        }
        return valor;
    }

    public int getResposta(int numeroQuestao) {
        switch (numeroQuestao) {
            case 1: return q1;
            case 2: return q2;
            case 3: return q3;
            case 4: return q4;
            case 5: return q5;
            case 6: return q6;
            case 7: return q7;
            case 8: return q8;
            default: throw new IllegalArgumentException("Questão inválida: " + numeroQuestao);
        }
    }

    public void setResposta(int numeroQuestao, int valor) {
        switch (numeroQuestao) {
            case 1: setQ1(valor); break;
            case 2: setQ2(valor); break;
            case 3: setQ3(valor); break;
            case 4: setQ4(valor); break;
            case 5: setQ5(valor); break;
            case 6: setQ6(valor); break;
            case 7: setQ7(valor); break;
            case 8: setQ8(valor); break;
            default: throw new IllegalArgumentException("Questão inválida: " + numeroQuestao);
        }
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNomeEntrevistado() {
        return nomeEntrevistado;
    }

    public void setNomeEntrevistado(String nomeEntrevistado) {
        this.nomeEntrevistado = nomeEntrevistado;
    }

    public int getQ1() {
        return q1;
    }

    public void setQ1(int q1) {
        this.q1 = validarAlternativa(q1);
    }

    public int getQ2() {
        return q2;
    }

    public void setQ2(int q2) {
        this.q2 = validarAlternativa(q2);
    }

    public int getQ3() {
        return q3;
    }

    public void setQ3(int q3) {
        this.q3 = validarAlternativa(q3);
    }

    public int getQ4() {
        return q4;
    }

    public void setQ4(int q4) {
        this.q4 = validarAlternativa(q4);
    }

    public int getQ5() {
        return q5;
    }

    public void setQ5(int q5) {
        this.q5 = validarAlternativa(q5);
    }

    public int getQ6() {
        return q6;
    }

    public void setQ6(int q6) {
        this.q6 = validarAlternativa(q6);
    }

    public int getQ7() {
        return q7;
    }

    public void setQ7(int q7) {
        this.q7 = validarAlternativa(q7);
    }

    public int getQ8() {
        return q8;
    }

    public void setQ8(int q8) {
        this.q8 = validarAlternativa(q8);
    }

    public Timestamp getDataRegistro() {
        return dataRegistro;
    }

    public void setDataRegistro(Timestamp dataRegistro) {
        this.dataRegistro = dataRegistro;
    }
}