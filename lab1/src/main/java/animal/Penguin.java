package animal;

public class Penguin extends Animal {
    public Penguin(String name, int age) {
        super(name, age);
    }

    @Override
    public void makeSound() {
        System.out.println(getName() + " Honk!");
    }
}
