package com.model;

public class Trilha {
    // Atributos privados garantindo o encapsulamento do objeto
    private String nome;
    private String descricao;
    private int votos;

    // Construtor: inicializa a trilha com nome, descrição e zera o contador de votos
    public Trilha(String nome, String descricao) {
        this.nome = nome;
        this.descricao = descricao;
        this.votos = 0;
    }

    // Métodos Getters e Setters para leitura e alteração dos atributos
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

    // Regra simples para incrementar +1 voto no contador
    public void adicionarVoto() {
        this.votos++;
    }
}