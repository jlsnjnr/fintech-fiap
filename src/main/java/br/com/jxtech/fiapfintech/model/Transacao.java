package br.com.jxtech.fiapfintech.model;

import java.time.LocalDate;
import java.sql.Date;

public class Transacao {
    private int id;
    private String tipo;
    private String descricao;
    private double valor;
    private LocalDate data;
    private Integer idUsuario;

    public Transacao() {
    }

    public Transacao(int id, String tipo, String descricao, double valor, Date data, Integer idUsuario) {
        this.id = id;
        this.tipo = tipo;
        this.descricao = descricao;
        this.valor = valor;
        this.data = data != null ? data.toLocalDate() : null;
        this.idUsuario = idUsuario;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public double getValor() {
        return valor;
    }

    public void setValor(double valor) {
        this.valor = valor;
    }

    public LocalDate getData() {
        return data;
    }

    public void setData(LocalDate data) {
        this.data = data;
    }

    public void setIdUsuario(Integer idUsuario) {
        this.idUsuario = idUsuario;
    }

    public Integer getIdUsuario() {
        return idUsuario;
    }

    // Getter para retornar a data como java.util.Date para compatibilidade com JSTL
    public java.util.Date getUtilDate() {
        if (this.data == null) {
            return null;
        }
        // Convertendo LocalDate para java.util.Date
        return java.util.Date.from(this.data.atStartOfDay(java.time.ZoneId.systemDefault()).toInstant());
    }
}
