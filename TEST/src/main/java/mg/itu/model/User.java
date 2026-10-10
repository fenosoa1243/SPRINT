package mg.itu.model;

public class User {
    private int id;
    private String nom;

    public User() {
    }

    public User(int id, String nom) {
        this.id = id;
        this.nom = nom;
    }

    public int getId() {
        return id;
    }

    public String getNom() {
        return nom;
    }
}