package com.model;

public class Trilha {
    private String nome;
    private String descricao;
    private int votos;

    public Trilha(String nome, String descricao) {
        this.nome = nome;
        this.descricao = descricao;
        this.votos = 0;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public int getVotos() {
        return votos;
    }

    public void setVotos(int votos) {
        this.votos = votos;
    }

    public void adicionarVoto() {
        this.votos++;
    }
}