package com.service;

import com.model.Trilha;
import com.repository.TrilhaRepository;
import java.util.ArrayList;
import java.util.List;

public class TrilhaService {
    private static List<Trilha> trilhas = new ArrayList<>();
    private TrilhaRepository repositorio;

    public TrilhaService(TrilhaRepository repositorio) {
        this.repositorio = repositorio;
        if (trilhas.isEmpty()) {
            trilhas = repositorio.carregarTrilhas();
        }
    }

    public boolean RegVoto(int indice) {
        if (indice >= 0 && indice < trilhas.size()) {
            trilhas.get(indice).adicionarVoto();
            return true;
        }
        return false;
    }

    public List<Trilha> TrilhaOrd() {
        List<Trilha> listaClassificada = new ArrayList<>(trilhas);
        listaClassificada.sort((t1, t2) -> Integer.compare(t2.getVotos(), t1.getVotos()));
        return listaClassificada;
    }

    public List<Trilha> getTrilhas() {
        return trilhas;
    }
    public void resetarTodosVotos() {
        trilhas = repositorio.carregarTrilhas(); // Sobrescreve a lista em memória pela original
    }
}