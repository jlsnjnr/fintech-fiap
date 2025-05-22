package br.com.jxtech.fiapfintech.model;

public class TransferRegister {
    private int codigo;
    public String name;
    public boolean isDeposity;
    public  String category;
    public String card;
    public String typeTransaction;
    public int value;

    public TransferRegister() {}

    public TransferRegister(int codigo, String name, boolean isDeposity, String category, String card, String typeTransaction, int value) {
        this.codigo = codigo;
        this.name = name;
        this.isDeposity = isDeposity;
        this.category = category;
        this.card = card;
        this.typeTransaction = typeTransaction;
        this.value = value;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isDeposity() {
        return isDeposity;
    }

    public void setDeposity(boolean deposity) {
        isDeposity = deposity;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getCard() {
        return card;
    }

    public void setCard(String card) {
        this.card = card;
    }

    public String getTypeTransaction() {
        return typeTransaction;
    }

    public void setTypeTransaction(String typeTransaction) {
        this.typeTransaction = typeTransaction;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }
}
