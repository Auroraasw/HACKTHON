package com.service;

import com.model.Trilha;
import com.repository.TrilhaRepository;

import java.util.ArrayList;
import java.util.List;

public class TrilhaService {
    // Lista estática compartilhada na memória durante toda a execução do servidor
    private static List<Trilha> trilhas = new ArrayList<>();
    private TrilhaRepository repositorio;

    // Construtor: se a lista em memória estiver vazia, carrega as trilhas do arquivo físico
    public TrilhaService(TrilhaRepository repositorio) {
        this.repositorio = repositorio;
        if (trilhas.isEmpty()) {
            trilhas = repositorio.carregarTrilhas();
        }
    }

    // Valida a posição recebida e adiciona +1 voto na trilha correspondente
    public boolean RegVoto(int indice) {
        if (indice >= 0 && indice < trilhas.size()) {
            trilhas.get(indice).adicionarVoto();
            return true;
        }
        return false;
    }

    // Gera o ranking: cria uma cópia da lista e ordena por votos em ordem decrescente
    public List<Trilha> TrilhaOrd() {
        List<Trilha> listaClassificada = new ArrayList<>(trilhas);
        listaClassificada.sort((t1, t2) -> Integer.compare(t2.getVotos(), t1.getVotos()));
        return listaClassificada;
    }

    // Retorna a lista completa com todas as trilhas na ordem original
    public List<Trilha> getTrilhas() {
        return trilhas;
    }
}