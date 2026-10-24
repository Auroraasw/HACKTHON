package com.repository;

import com.model.Trilha;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class TrilhaRepository {
    private String caminho;

    // Recebe o caminho absoluto do arquivo trilhas.txt no servidor
    public TrilhaRepository(String caminho) {
        this.caminho = caminho;
    }

    // Lê o arquivo físico e converte o texto em uma lista de objetos Trilha
    public List<Trilha> carregarTrilhas() {
        List<Trilha> trilhas = new ArrayList<>();

        // Try-with-resources: abre o arquivo e garante o fechamento automático após a leitura
        try (BufferedReader br = new BufferedReader(new FileReader(this.caminho))) {
            String line;

            // Percorre o arquivo linha por linha até o final
            while ((line = br.readLine()) != null) {

                // Ignora linhas em branco
                if (line.trim().isEmpty()) {
                    continue;
                }

                // Separa o texto pelo ponto e vírgula (formato esperada: Nome;Descrição)
                String[] partes = line.split(";");

                // Valida se a linha tem exatamente 2 partes antes de instanciar a Trilha
                if (partes.length == 2) {
                    String nome = partes[0].trim();
                    String descricao = partes[1].trim();

                    Trilha trilha = new Trilha(nome, descricao);
                    trilhas.add(trilha);
                }
            }
        } catch (IOException e) {
            // Trata falhas de leitura evitando que a aplicação quebre
            System.out.println("ERROR reading file: " + e.getMessage());
        }

        return trilhas;
    }
}