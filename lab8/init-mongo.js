db = db.getSiblingDB('flowershop');

db.flowers.drop();
db.decorations.drop();
db.bouquets.drop();
db.customers.drop();
db.employees.drop();
db.discounts.drop();
db.orders.drop();

db.flowers.insertMany([
    {
        _id: ObjectId("650a1111111111111111aaa1"),
        name: "Rose",
        color: "Red",
        freshDays: 7,
        price: 25.00,
        originCountry: "Netherlands",
        sku: "FL-ROSE-001"
    },
    {
        _id: ObjectId("650a1111111111111111aaa2"),
        name: "Tulip",
        color: "Yellow",
        freshDays: 5,
        price: 15.00,
        originCountry: "Netherlands",
        sku: "FL-TULIP-001"
    },
    {
        _id: ObjectId("650a1111111111111111aaa3"),
        name: "Lily",
        color: "White",
        freshDays: 10,
        price: 30.00,
        originCountry: "Japan",
        sku: "FL-LILY-001"
    },
    {
        _id: ObjectId("650a1111111111111111aaa4"),
        name: "Orchid",
        color: "Purple",
        freshDays: 14,
        price: 45.00,
        originCountry: "Thailand",
        sku: "FL-ORCH-001"
    }
]);

db.decorations.insertMany([
    {
        _id: ObjectId("650a2222222222222222bbb1"),
        name: "Silk Ribbon",
        color: "Gold",
        material: "Silk",
        reusable: true
    },
    {
        _id: ObjectId("650a2222222222222222bbb2"),
        name: "Crystal Beads",
        color: "Transparent",
        material: "Crystal",
        reusable: true
    },
    {
        _id: ObjectId("650a2222222222222222bbb3"),
        name: "Paper Wrapper",
        color: "Pink",
        material: "Paper",
        reusable: false
    },
    {
        _id: ObjectId("650a2222222222222222bbb4"),
        name: "Lace Trim",
        color: "White",
        material: "Cotton",
        reusable: true
    }
]);

db.bouquets.insertMany([
    {
        _id: ObjectId("650a3333333333333333ccc1"),
        style: "Classic Romance",
        price: 150.00,
        flowers: [
            {name: "Rose", color: "Red", quantity: 12},
            {name: "Lily", color: "White", quantity: 3}
        ],
        decorations: [
            {name: "Silk Ribbon", material: "Silk"},
            {name: "Crystal Beads", material: "Crystal"}
        ]
    },
    {
        _id: ObjectId("650a3333333333333333ccc2"),
        style: "Spring Garden",
        price: 95.00,
        flowers: [
            {name: "Tulip", color: "Yellow", quantity: 15},
            {name: "Tulip", color: "Pink", quantity: 10}
        ],
        decorations: [
            {name: "Paper Wrapper", material: "Paper"}
        ]
    },
    {
        _id: ObjectId("650a3333333333333333ccc3"),
        style: "Exotic Elegance",
        price: 200.00,
        flowers: [
            {name: "Orchid", color: "Purple", quantity: 5},
            {name: "Orchid", color: "White", quantity: 5}
        ],
        decorations: [
            {name: "Silk Ribbon", material: "Silk"},
            {name: "Lace Trim", material: "Cotton"}
        ]
    },
    {
        _id: ObjectId("650a3333333333333333ccc4"),
        style: "Simple Beauty",
        price: 60.00,
        flowers: [
            {name: "Rose", color: "Pink", quantity: 7}
        ],
        decorations: [
            {name: "Paper Wrapper", material: "Paper"}
        ]
    }
]);

db.employees.insertMany([
    {
        _id: ObjectId("650a4444444444444444ddd1"),
        name: "Olena Petrenko",
        position: "Manager",
        supervisorId: null
    },
    {
        _id: ObjectId("650a4444444444444444ddd2"),
        name: "Ivan Shevchenko",
        position: "Senior Florist",
        supervisorId: ObjectId("650a4444444444444444ddd1")
    },
    {
        _id: ObjectId("650a4444444444444444ddd3"),
        name: "Maria Kovalenko",
        position: "Florist",
        supervisorId: ObjectId("650a4444444444444444ddd2")
    },
    {
        _id: ObjectId("650a4444444444444444ddd4"),
        name: "Andriy Bondarenko",
        position: "Delivery",
        supervisorId: ObjectId("650a4444444444444444ddd1")
    }
]);

db.customers.insertMany([
    {
        _id: ObjectId("650a5555555555555555eee1"),
        name: "Viktoria Lysenko",
        phone: "+380501234567",
        email: "viktoria.lysenko@gmail.com"
    },
    {
        _id: ObjectId("650a5555555555555555eee2"),
        name: "Dmytro Moroz",
        phone: "+380672345678",
        email: "dmytro.moroz@ukr.net"
    },
    {
        _id: ObjectId("650a5555555555555555eee3"),
        name: "Natalia Sydorenko",
        phone: "+380933456789",
        email: "natalia.s@gmail.com"
    },
    {
        _id: ObjectId("650a5555555555555555eee4"),
        name: "Oleksandr Melnyk",
        phone: "+380664567890",
        email: "o.melnyk@outlook.com"
    }
]);

db.discounts.insertMany([
    {
        _id: ObjectId("650a66666666666666660001"),
        code: "SPRING20",
        percentage: 20,
        expiry: new Date("2025-05-31")
    },
    {
        _id: ObjectId("650a66666666666666660002"),
        code: "WELCOME10",
        percentage: 10,
        expiry: new Date("2025-12-31")
    },
    {
        _id: ObjectId("650a66666666666666660003"),
        code: "VIP30",
        percentage: 30,
        expiry: new Date("2025-06-30")
    },
    {
        _id: ObjectId("650a66666666666666660004"),
        code: "HOLIDAY15",
        percentage: 15,
        expiry: new Date("2025-03-08")
    }
]);

db.orders.insertMany([
    {
        _id: ObjectId("650a77777777777777770001"),
        orderDate: new Date("2025-02-14"),
        customerId: ObjectId("650a5555555555555555eee1"),
        handledById: ObjectId("650a4444444444444444ddd2"),
        items: [
            {
                bouquetId: ObjectId("650a3333333333333333ccc1"),
                bouquetStyle: "Classic Romance",
                quantity: 2,
                note: "Please add a card saying 'Happy Valentine's Day!'",
                subtotal: 300.00
            }
        ],
        discountCode: "SPRING20",
        total: 240.00
    },
    {
        _id: ObjectId("650a77777777777777770002"),
        orderDate: new Date("2025-03-08"),
        customerId: ObjectId("650a5555555555555555eee2"),
        handledById: ObjectId("650a4444444444444444ddd3"),
        items: [
            {
                bouquetId: ObjectId("650a3333333333333333ccc2"),
                bouquetStyle: "Spring Garden",
                quantity: 1,
                note: "For my mother",
                subtotal: 95.00
            },
            {
                bouquetId: ObjectId("650a3333333333333333ccc4"),
                bouquetStyle: "Simple Beauty",
                quantity: 1,
                note: "For my sister",
                subtotal: 60.00
            }
        ],
        discountCode: "HOLIDAY15",
        total: 131.75
    },
    {
        _id: ObjectId("650a77777777777777770003"),
        orderDate: new Date("2025-01-20"),
        customerId: ObjectId("650a5555555555555555eee3"),
        handledById: ObjectId("650a4444444444444444ddd2"),
        items: [
            {
                bouquetId: ObjectId("650a3333333333333333ccc3"),
                bouquetStyle: "Exotic Elegance",
                quantity: 1,
                note: "Corporate gift",
                subtotal: 200.00
            }
        ],
        discountCode: null,
        total: 200.00
    },
    {
        _id: ObjectId("650a77777777777777770004"),
        orderDate: new Date("2025-02-28"),
        customerId: ObjectId("650a5555555555555555eee4"),
        handledById: ObjectId("650a4444444444444444ddd3"),
        items: [
            {
                bouquetId: ObjectId("650a3333333333333333ccc1"),
                bouquetStyle: "Classic Romance",
                quantity: 1,
                note: "Anniversary celebration",
                subtotal: 150.00
            },
            {
                bouquetId: ObjectId("650a3333333333333333ccc3"),
                bouquetStyle: "Exotic Elegance",
                quantity: 1,
                note: "",
                subtotal: 200.00
            }
        ],
        discountCode: "VIP30",
        total: 245.00
    }
]);

print("=== Flower Shop Database Initialized Successfully! ===");
print("Collections created: flowers, decorations, bouquets, employees, customers, discounts, orders");
print("Each collection has 4 documents.");

