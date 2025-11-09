Class Flowers.Utils.Populate
{

/// This method creates and saves sample objects for all classes.
ClassMethod Run() As %Status
{
    // 1) Flowers
    Set f1 = ##class(Flowers.Flower).%New()
    Set f1.Name = "Red Rose"
    Set f1.Color = "Red"
    Set f1.FreshDays = 10
    Set f1.Sku = "FL-001"
    Set f1.Price = 35
    Do f1.%Save()

    Set f2 = ##class(Flowers.Flower).%New()
    Set f2.Name = "White Lily"
    Set f2.Color = "White"
    Set f2.FreshDays = 7
    Set f2.Sku = "FL-002"
    Set f2.Price = 50
    Do f2.%Save()

    // 2) Decorations
    Set d1 = ##class(Flowers.Decoration).%New()
    Set d1.Name = "Paper Wrap"
    Set d1.Color = "Brown"
    Set d1.FreshDays = 0
    Set d1.Material = "Paper"
    Set d1.Reusable = 0
    Do d1.%Save()

    Set d2 = ##class(Flowers.Decoration).%New()
    Set d2.Name = "Silk Ribbon"
    Set d2.Color = "Pink"
    Set d2.FreshDays = 0
    Set d2.Material = "Silk"
    Set d2.Reusable = 1
    Do d2.%Save()

    // 3) Bouquets
    Set b1 = ##class(Flowers.Bouquet).%New()
    Set b1.Style = "Romantic"
    Do b1.Flowers.Insert(f1)
    Do b1.Flowers.Insert(f2)
    Do b1.Decorations.Insert(d2)
    Set b1.Price = 120
    Do b1.%Save()

    Set b2 = ##class(Flowers.Bouquet).%New()
    Set b2.Style = "Classic"
    Do b2.Flowers.Insert(f2)
    Do b2.Decorations.Insert(d1)
    Set b2.Price = 80
    Do b2.%Save()

    // 4) Customers
    Set c1 = ##class(Flowers.Customer).%New()
    Set c1.Name = "Alice Johnson"
    Set c1.Phone = "123-456"
    Set c1.Email = "alice@mail.com"
    Do c1.%Save()

    Set c2 = ##class(Flowers.Customer).%New()
    Set c2.Name = "Bob Smith"
    Set c2.Phone = "555-777"
    Set c2.Email = "bob@mail.com"
    Do c2.%Save()

    // 5) Employees
    Set e1 = ##class(Flowers.Employee).%New()
    Set e1.Name = "Emma Carter"
    Set e1.Position = "Florist"
    Do e1.%Save()

    Set e2 = ##class(Flowers.Employee).%New()
    Set e2.Name = "Mark Wilson"
    Set e2.Position = "Senior Florist"
    Set e2.Supervisor = e1
    Do e2.%Save()

    // 6) Orders
    Set o1 = ##class(Flowers.Order).%New()
    Set o1.OrderId = 1001
    Set o1.OrderDate = $Horolog
    Set o1.Customer = c1
    Set o1.HandledBy = e1
    Set o1.Total = 200
    Do o1.%Save()

    Set o2 = ##class(Flowers.Order).%New()
    Set o2.OrderId = 1002
    Set o2.OrderDate = $Horolog
    Set o2.Customer = c2
    Set o2.HandledBy = e2
    Set o2.Total = 150
    Do o2.%Save()

    // 7) OrderItems
    Set oi1 = ##class(Flowers.OrderItem).%New()
    Set oi1.Order = o1
    Set oi1.Bouquet = b1
    Set oi1.Quantity = 1
    Set oi1.Subtotal = 120
    Do oi1.%Save()

    Set oi2 = ##class(Flowers.OrderItem).%New()
    Set oi2.Order = o2
    Set oi2.Bouquet = b2
    Set oi2.Quantity = 2
    Set oi2.Subtotal = 160
    Do oi2.%Save()

    // 8) Discounts
    Set dis1 = ##class(Flowers.Discount).%New()
    Set dis1.Code = "LOVE10"
    Set dis1.Percent = 10
    Set dis1.Expiry = $ZDATEH("2025-05-10", 3) // Використовуємо $ZDATEH для коректної дати
    Do dis1.%Save()

    Set dis2 = ##class(Flowers.Discount).%New()
    Set dis2.Code = "SPRING20"
    Set dis2.Percent = 20
    Set dis2.Expiry = $ZDATEH("2025-05-30", 3)
    Do dis2.%Save()

    Write "Successfully created 18 objects!"
    Return $$$OK
}
}