package animal;

public abstract class Animal {
    private String name;
    private int age;

    public Animal(String name, int age) {
        this.name = name;
        this.age = age;
    }

    // Геттери
    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    // Абстрактний метод
    public abstract void makeSound();

    // Перевантаження методу
    public void makeSound(int times) {
        for (int i = 0; i < times; i++) {
            makeSound();
        }
    }
}