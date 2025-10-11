import animal.Lion;
import animal.Penguin;
import zoo.Zoo;
import zoo.Zookeeper;

public class ZooApp {
    public static void main(String[] args) {
        // Створюємо тварин
        Lion simba = new Lion("Simba", 5);
        Penguin pingu = new Penguin("Pingu", 2);

        // Створюємо працівників
        Zookeeper ivan = new Zookeeper("Ivan Petrov");
        ivan.addResponsibility("Годувати тварин");
        ivan.addResponsibility("Прибирати в клітках");

        Zookeeper olga = new Zookeeper("Olga Kovalenko");
        olga.addResponsibility("Guide tours");

        // Створюємо зоопарк
        Zoo zoo = new Zoo("Kyiv Zoo");
        zoo.addAnimal(simba);
        zoo.addAnimal(pingu);
        zoo.addZookeeper(ivan);
        zoo.addZookeeper(olga);

        // Виводимо інформацію
        zoo.showZooInfo();

        // Викликаємо методи
        simba.makeSound();
        simba.makeSound(3); // перевантаження
        pingu.makeSound();

        ivan.showResponsibilities();
        ivan.revealSecret(); // виклик приватного методу через публічний
    }
}
