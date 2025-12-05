package org.example;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import org.bson.Document;
import org.bson.conversions.Bson;

import java.util.Arrays;
import java.util.List;

public class MongoDemo {
    
    private static final String CONNECTION_STRING = "mongodb://admin:admin123@localhost:27017";
    private static final String DATABASE_NAME = "flowershop";
    
    public static void main(String[] args) {
        try (MongoClient mongoClient = MongoClients.create(CONNECTION_STRING)) {
            MongoDatabase database = mongoClient.getDatabase(DATABASE_NAME);
            
            System.out.println("╔══════════════════════════════════════════════════════════════╗");
            System.out.println("║           FLOWER SHOP - MongoDB Demo                         ║");
            System.out.println("╚══════════════════════════════════════════════════════════════╝");
            
            printAllCollections(database);
            performKeyValueQueries(database);
            performAggregation(database);
            
        } catch (Exception e) {
            System.err.println("Error connecting to MongoDB: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    private static void printAllCollections(MongoDatabase database) {
        System.out.println("\n");
        System.out.println("════════════════════════════════════════════════════════════════");
        System.out.println("              1. ALL DOCUMENTS IN COLLECTIONS                   ");
        System.out.println("════════════════════════════════════════════════════════════════");
        
        String[] collections = {"flowers", "decorations", "bouquets", "employees", "customers", "discounts", "orders"};
        
        for (String collectionName : collections) {
            printCollection(database, collectionName);
        }
    }
    
    private static void printCollection(MongoDatabase database, String collectionName) {
        MongoCollection<Document> collection = database.getCollection(collectionName);
        
        System.out.println("\n┌─────────────────────────────────────────────────────────────┐");
        System.out.println("│ Collection: " + collectionName.toUpperCase());
        System.out.println("├─────────────────────────────────────────────────────────────┤");
        
        long count = 0;
        for (Document doc : collection.find()) {
            System.out.println("  " + doc.toJson());
            count++;
        }
        
        System.out.println("├─────────────────────────────────────────────────────────────┤");
        System.out.println("│ Total documents: " + count);
        System.out.println("└─────────────────────────────────────────────────────────────┘");
    }
    
    private static void performKeyValueQueries(MongoDatabase database) {
        System.out.println("\n");
        System.out.println("════════════════════════════════════════════════════════════════");
        System.out.println("              2. KEY-VALUE QUERIES (2+ CONDITIONS)              ");
        System.out.println("════════════════════════════════════════════════════════════════");
        
        System.out.println("\n┌─────────────────────────────────────────────────────────────┐");
        System.out.println("│ Query 1: Flowers from Netherlands with price > 20           │");
        System.out.println("├─────────────────────────────────────────────────────────────┤");
        
        MongoCollection<Document> flowers = database.getCollection("flowers");
        Bson flowerFilter = Filters.and(
            Filters.eq("originCountry", "Netherlands"),
            Filters.gt("price", 20)
        );
        
        for (Document doc : flowers.find(flowerFilter)) {
            System.out.println("  Name: " + doc.getString("name") + 
                             ", Color: " + doc.getString("color") + 
                             ", Price: $" + (doc.get("price") instanceof Number ? ((Number)doc.get("price")).doubleValue() : doc.get("price")) +
                             ", Origin: " + doc.getString("originCountry"));
        }
        System.out.println("└─────────────────────────────────────────────────────────────┘");
        
        System.out.println("\n┌─────────────────────────────────────────────────────────────┐");
        System.out.println("│ Query 2: Orders with total >= 200 AND discount applied      │");
        System.out.println("├─────────────────────────────────────────────────────────────┤");
        
        MongoCollection<Document> orders = database.getCollection("orders");
        Bson orderFilter = Filters.and(
            Filters.gte("total", 200),
            Filters.ne("discountCode", null)
        );
        
        for (Document doc : orders.find(orderFilter)) {
            System.out.println("  Order ID: " + doc.getObjectId("_id").toString().substring(20) + 
                             ", Date: " + doc.getDate("orderDate") +
                             ", Total: $" + (doc.get("total") instanceof Number ? ((Number)doc.get("total")).doubleValue() : doc.get("total")) +
                             ", Discount: " + doc.getString("discountCode"));
        }
        System.out.println("└─────────────────────────────────────────────────────────────┘");
        
        System.out.println("\n┌─────────────────────────────────────────────────────────────┐");
        System.out.println("│ Query 3: Bouquets $100-$200 with 'Romance' or 'Elegance'    │");
        System.out.println("├─────────────────────────────────────────────────────────────┤");
        
        MongoCollection<Document> bouquets = database.getCollection("bouquets");
        Bson bouquetFilter = Filters.and(
            Filters.gte("price", 100),
            Filters.lte("price", 200),
            Filters.or(
                Filters.regex("style", "Romance"),
                Filters.regex("style", "Elegance")
            )
        );
        
        for (Document doc : bouquets.find(bouquetFilter)) {
            System.out.println("  Style: " + doc.getString("style") + 
                             ", Price: $" + (doc.get("price") instanceof Number ? ((Number)doc.get("price")).doubleValue() : doc.get("price")));
        }
        System.out.println("└─────────────────────────────────────────────────────────────┘");
        
        System.out.println("\n┌─────────────────────────────────────────────────────────────┐");
        System.out.println("│ Query 4: Florists with a supervisor                         │");
        System.out.println("├─────────────────────────────────────────────────────────────┤");
        
        MongoCollection<Document> employees = database.getCollection("employees");
        Bson employeeFilter = Filters.and(
            Filters.regex("position", "Florist"),
            Filters.ne("supervisorId", null)
        );
        
        for (Document doc : employees.find(employeeFilter)) {
            System.out.println("  Name: " + doc.getString("name") + 
                             ", Position: " + doc.getString("position"));
        }
        System.out.println("└─────────────────────────────────────────────────────────────┘");
    }
    
    private static void performAggregation(MongoDatabase database) {
        System.out.println("\n");
        System.out.println("════════════════════════════════════════════════════════════════");
        System.out.println("        3. AGGREGATION (4+ STAGES WITH $lookup AND $group)      ");
        System.out.println("════════════════════════════════════════════════════════════════");
        
        MongoCollection<Document> orders = database.getCollection("orders");
        
        System.out.println("\n┌─────────────────────────────────────────────────────────────┐");
        System.out.println("│ Aggregation: Customer Order Statistics                      │");
        System.out.println("│ Stages: $lookup → $unwind → $lookup → $unwind → $group → $sort │");
        System.out.println("├─────────────────────────────────────────────────────────────┤");
        
        List<Bson> pipeline = Arrays.asList(
            new Document("$lookup", new Document()
                .append("from", "customers")
                .append("localField", "customerId")
                .append("foreignField", "_id")
                .append("as", "customer")),
            new Document("$unwind", "$customer"),
            new Document("$lookup", new Document()
                .append("from", "employees")
                .append("localField", "handledById")
                .append("foreignField", "_id")
                .append("as", "employee")),
            new Document("$unwind", "$employee"),
            new Document("$group", new Document()
                .append("_id", "$customer.name")
                .append("customerEmail", new Document("$first", "$customer.email"))
                .append("totalSpent", new Document("$sum", "$total"))
                .append("orderCount", new Document("$sum", 1))
                .append("avgOrderValue", new Document("$avg", "$total"))
                .append("handledBy", new Document("$addToSet", "$employee.name"))),
            new Document("$sort", new Document("totalSpent", -1))
        );
        
        System.out.println("\n  📊 Customer Order Statistics:");
        System.out.println("  ─────────────────────────────────────────────────────────────");
        
        for (Document doc : orders.aggregate(pipeline)) {
            String customerName = doc.getString("_id");
            String email = doc.getString("customerEmail");
            Double totalSpent = doc.get("totalSpent") instanceof Number ? ((Number)doc.get("totalSpent")).doubleValue() : null;
            Integer orderCount = doc.getInteger("orderCount");
            Double avgOrder = doc.get("avgOrderValue") instanceof Number ? ((Number)doc.get("avgOrderValue")).doubleValue() : null;
            List<?> handlers = doc.getList("handledBy", String.class);
            
            System.out.println("\n  👤 Customer: " + customerName);
            System.out.println("     Email: " + email);
            System.out.println("     Orders: " + orderCount);
            System.out.println("     Total Spent: $" + (totalSpent != null ? String.format("%.2f", totalSpent) : "N/A"));
            System.out.println("     Avg Order: $" + (avgOrder != null ? String.format("%.2f", avgOrder) : "N/A"));
            System.out.println("     Served by: " + handlers);
        }
        
        System.out.println("\n└─────────────────────────────────────────────────────────────┘");
        
        System.out.println("\n┌─────────────────────────────────────────────────────────────┐");
        System.out.println("│ Aggregation 2: Bouquet Sales Analysis                       │");
        System.out.println("│ Stages: $unwind → $group → $lookup → $unwind → $project     │");
        System.out.println("├─────────────────────────────────────────────────────────────┤");
        
        List<Bson> bouquetPipeline = Arrays.asList(
            new Document("$unwind", "$items"),
            new Document("$group", new Document()
                .append("_id", "$items.bouquetId")
                .append("bouquetStyle", new Document("$first", "$items.bouquetStyle"))
                .append("totalQuantitySold", new Document("$sum", "$items.quantity"))
                .append("totalRevenue", new Document("$sum", "$items.subtotal"))
                .append("timesOrdered", new Document("$sum", 1))),
            new Document("$lookup", new Document()
                .append("from", "bouquets")
                .append("localField", "_id")
                .append("foreignField", "_id")
                .append("as", "bouquetDetails")),
            new Document("$unwind", new Document()
                .append("path", "$bouquetDetails")
                .append("preserveNullAndEmptyArrays", true)),
            new Document("$project", new Document()
                .append("_id", 0)
                .append("bouquetStyle", 1)
                .append("unitPrice", "$bouquetDetails.price")
                .append("totalQuantitySold", 1)
                .append("totalRevenue", 1)
                .append("timesOrdered", 1)),
            new Document("$sort", new Document("totalRevenue", -1))
        );
        
        System.out.println("\n  💐 Bouquet Sales Report:");
        System.out.println("  ─────────────────────────────────────────────────────────────");
        
        for (Document doc : orders.aggregate(bouquetPipeline)) {
            String style = doc.getString("bouquetStyle");
            Double unitPrice = doc.get("unitPrice") instanceof Number ? ((Number)doc.get("unitPrice")).doubleValue() : null;
            Integer qtySold = doc.getInteger("totalQuantitySold");
            Double revenue = doc.get("totalRevenue") instanceof Number ? ((Number)doc.get("totalRevenue")).doubleValue() : null;
            Integer timesOrdered = doc.getInteger("timesOrdered");
            
            System.out.println("\n  🌸 " + style);
            System.out.println("     Unit Price: $" + (unitPrice != null ? String.format("%.2f", unitPrice) : "N/A"));
            System.out.println("     Quantity Sold: " + qtySold);
            System.out.println("     Times Ordered: " + timesOrdered);
            System.out.println("     Total Revenue: $" + (revenue != null ? String.format("%.2f", revenue) : "N/A"));
        }
        
        System.out.println("\n└─────────────────────────────────────────────────────────────┘");
        
        System.out.println("\n");
        System.out.println("╔══════════════════════════════════════════════════════════════╗");
        System.out.println("║                    Demo Complete!                            ║");
        System.out.println("╚══════════════════════════════════════════════════════════════╝");
    }
}
