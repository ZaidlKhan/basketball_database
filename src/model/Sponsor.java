package model;

public class Sponsor {
    private final String name;
    private final int contributions;

    public Sponsor(String name, int contributions) {
        this.name = name;
        this.contributions = contributions;
    }

    public String getName() {
        return name;
    }

    public int getContributions() {
        return contributions;
    }
}