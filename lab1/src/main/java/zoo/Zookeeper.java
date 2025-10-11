package zoo;

import java.util.ArrayList;
import java.util.List;

public class Zookeeper {
    private String fullName;
    private List<String> responsibilities;

    public Zookeeper(String fullName) {
        this.fullName = fullName;
        this.responsibilities = new ArrayList<>();
    }

    public String getFullName() {
        return fullName;
    }

    public void addResponsibility(String task) {
        responsibilities.add(task);
    }

    public void showResponsibilities() {
        System.out.println(fullName + " has responsibilities: " + responsibilities);
    }

    private void secretNote() {
        System.out.println(fullName + " knows the secrets of animal care");
    }

    public void revealSecret() {
        secretNote();
    }
}
