package zoo;

import animal.Animal;

import java.util.ArrayList;
import java.util.List;

public class Zoo {
    private String name;
    private List<Animal> animals;   // список об’єктів
    private List<Zookeeper> staff;  // список об’єктів

    public Zoo(String name) {
        this.name = name;
        this.animals = new ArrayList<>();
        this.staff = new ArrayList<>();
    }

    public void addAnimal(Animal a) {
        animals.add(a);
    }

    public void addZookeeper(Zookeeper z) {
        staff.add(z);
    }

    public void showZooInfo() {
        System.out.println("Zoo: " + name);
        System.out.println("Animals:");
        for (Animal a : animals) {
            System.out.println(" - " + a.getName() + " (" + a.getAge() + " років)");
        }
        System.out.println("Staff:");
        for (Zookeeper z : staff) {
            System.out.println(" - " + z.getFullName());
        }
    }
}