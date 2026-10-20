package com.repository;

import com.model.Trilha;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class TrilhaRepository {
    private String caminho;

    public TrilhaRepository(String caminho) {
        this.caminho = caminho;
    }

    public List<Trilha> carregarTrilhas() {
        List<Trilha> trilhas = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(this.caminho))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.trim().isEmpty()) {
                    continue;
                }

                String[] partes = line.split(";");
                if (partes.length == 2) {
                    String nome = partes[0].trim();
                    String descricao = partes[1].trim();

                    Trilha trilha = new Trilha(nome, descricao);
                    trilhas.add(trilha);
                }
            }
        } catch (IOException e) {
            System.out.println("ERROR reading file: " + e.getMessage());
        }
        return trilhas;
    }
}