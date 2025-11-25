Class Flowers.Utils.Populate
{

ClassMethod Run() As %Status
{
    Set sc = $$$OK
    Set count = 0

    ; --- Якщо хочеш повністю очистити базу перед наповненням, розкоментуй наступний рядок
    ; Do ..ClearAll()

    Write "Creating Flowers...",!
    Set flowerData = $ListBuild(
        $ListBuild("Red Rose", "Red", 10, "FL-001", 35.50, "Netherlands"),
        $ListBuild("White Lily", "White", 7, "FL-002", 50.00, "Colombia"),
        $ListBuild("Yellow Tulip", "Yellow", 5, "FL-003", 25.75, "Netherlands"),
        $ListBuild("Pink Carnation", "Pink", 12, "FL-004", 18.90, "Ecuador"),
        $ListBuild("Blue Orchid", "Blue", 14, "FL-005", 75.25, "Thailand")
    )
    
    Kill flowers
    For i = 1:1:$ListLength(flowerData) {
        Set data = $ListGet(flowerData, i)
        Set rawSku = $ListGet(data,4)
        Set sku = $Translate(rawSku," ","")
        Set flower = ##class(Flowers.Flower).%New()
        Set flower.Name = $ListGet(data, 1)
        Set flower.Color = $ListGet(data, 2)
        Set flower.FreshDays = $ListGet(data, 3)
        Set flower.Sku = sku
        Set flower.Price = $ListGet(data, 5)
        Set flower.OriginCountry = $ListGet(data, 6)
        Set sc = flower.%Save()
        If $$$ISERR(sc) { Write "Error saving flower: ", $System.Status.GetErrorText(sc),! Return sc }
        Set flowers(i) = flower
        Set count = count + 1
    }

    Write "Creating Decorations...",!
    Set decorationData = $ListBuild(
        $ListBuild("Paper Wrap", "Brown", 1, "Paper", 0),
        $ListBuild("Silk Ribbon", "Pink", 1, "Silk", 1),
        $ListBuild("Lace Wrap", "White", 1, "Lace", 1),
        $ListBuild("Burlap Wrap", "Beige", 1, "Burlap", 0)
    )
    
    Kill decorations
    For i = 1:1:$ListLength(decorationData) {
        Set data = $ListGet(decorationData, i)
        Set decoration = ##class(Flowers.Decoration).%New()
        Set decoration.Name = $ListGet(data, 1)
        Set decoration.Color = $ListGet(data, 2)
        Set decoration.FreshDays = $Select($ListGet(data, 3) < 1:1, 1:$ListGet(data, 3))
        Set decoration.Material = $ListGet(data, 4)
        Set decoration.Reusable = $ListGet(data, 5)
        Set sc = decoration.%Save()
        If $$$ISERR(sc) { Write "Error saving decoration: ", $System.Status.GetErrorText(sc),! Return sc }
        Set decorations(i) = decoration
        Set count = count + 1
    }

    Write "Creating Bouquets...",!
    Set bouquetData = $ListBuild(
        $ListBuild("Romantic", 120.00, $ListBuild(1, 2), $ListBuild(2)),
        $ListBuild("Classic", 80.00, $ListBuild(2), $ListBuild(1)),
        $ListBuild("Modern", 150.00, $ListBuild(3, 4, 5), $ListBuild(3, 4)),
        $ListBuild("Elegant", 200.00, $ListBuild(1, 5), $ListBuild(2, 3))
    )
    
    Kill bouquets
    For i = 1:1:$ListLength(bouquetData) {
        Set data = $ListGet(bouquetData, i)
        Set bouquet = ##class(Flowers.Bouquet).%New()
        Set bouquet.Style = $ListGet(data, 1)
        Set bouquet.Price = $ListGet(data, 2)
        
        Set flowerIndices = $ListGet(data, 3)
        For j = 1:1:$ListLength(flowerIndices) {
            Set flowerIdx = $ListGet(flowerIndices, j)
            Set flower = flowers(flowerIdx)
            Do bouquet.Flowers.Insert(flower)
        }
        
        Set decorationIndices = $ListGet(data, 4)
        For j = 1:1:$ListLength(decorationIndices) {
            Set decorationIdx = $ListGet(decorationIndices, j)
            Set decoration = decorations(decorationIdx)
            Do bouquet.Decorations.Insert(decoration)
        }
        
        Set sc = bouquet.%Save()
        If $$$ISERR(sc) { Write "Error saving bouquet: ", $System.Status.GetErrorText(sc),! Return sc }
        Set bouquets(i) = bouquet
        Set count = count + 1
    }

    Write "Creating Customers...",!
    Set customerData = $ListBuild(
        $ListBuild("Alice Johnson", "123-456-7890", "alice@mail.com"),
        $ListBuild("Bob Smith", "555-777-1234", "bob@mail.com"),
        $ListBuild("Carol Williams", "234-567-8901", "carol@mail.com"),
        $ListBuild("David Brown", "345-678-9012", "david@mail.com"),
        $ListBuild("Eva Davis", "456-789-0123", "eva@mail.com")
    )
    
    Kill customers
    For i = 1:1:$ListLength(customerData) {
        Set data = $ListGet(customerData, i)
        Set customer = ##class(Flowers.Customer).%New()
        Set customer.Name = $ListGet(data, 1)
        Set customer.Phone = $ListGet(data, 2)
        Set customer.Email = $ListGet(data, 3)
        Set sc = customer.%Save()
        If $$$ISERR(sc) { Write "Error saving customer: ", $System.Status.GetErrorText(sc),! Return sc }
        Set customers(i) = customer
        Set count = count + 1
    }

    Write "Creating Employees...",!
    Set employeeData = $ListBuild(
        $ListBuild("Emma Carter", "Florist", ""),
        $ListBuild("Mark Wilson", "Senior Florist", 1),
        $ListBuild("Sarah Johnson", "Manager", 1),
        $ListBuild("Tom Anderson", "Florist", 2)
    )
    
    Kill employees
    For i = 1:1:$ListLength(employeeData) {
        Set data = $ListGet(employeeData, i)
        Set employee = ##class(Flowers.Employee).%New()
        Set employee.Name = $ListGet(data, 1)
        Set employee.Position = $ListGet(data, 2)
        Set supervisorIdx = $ListGet(data, 3)
        If (supervisorIdx '= "") {
            Set employee.Supervisor = employees(supervisorIdx)
        }
        Set sc = employee.%Save()
        If $$$ISERR(sc) { Write "Error saving employee: ", $System.Status.GetErrorText(sc),! Return sc }
        Set employees(i) = employee
        Set count = count + 1
    }

    Write "Creating Orders...",!
    Set orderData = $ListBuild(
        $ListBuild(1001, 200.00, 1, 1),
        $ListBuild(1002, 150.00, 2, 2),
        $ListBuild(1003, 300.00, 3, 1),
        $ListBuild(1004, 250.00, 4, 3),
        $ListBuild(1005, 180.00, 5, 2)
    )
    
    Kill orders
    For i = 1:1:$ListLength(orderData) {
        Set data = $ListGet(orderData, i)
        Set order = ##class(Flowers.Order).%New()
        Set order.OrderId = $ListGet(data, 1)
        Set order.OrderDate = $Piece($HOROLOG, ",", 1)
        Set order.Total = $ListGet(data, 2)
        Set order.Customer = customers($ListGet(data, 3))
        Set order.HandledBy = employees($ListGet(data, 4))
        Set sc = order.%Save()
        If $$$ISERR(sc) { Write "Error saving order: ", $System.Status.GetErrorText(sc),! Return sc }
        Set orders(i) = order
        Set count = count + 1
    }

    Write "Creating OrderItems...",!
    Set orderItemData = $ListBuild(
        $ListBuild(1, 1, 1, 120.00),
        $ListBuild(1, 2, 1, 80.00),
        $ListBuild(2, 2, 2, 160.00),
        $ListBuild(3, 3, 1, 150.00),
        $ListBuild(3, 4, 1, 200.00),
        $ListBuild(4, 1, 2, 240.00),
        $ListBuild(5, 2, 1, 80.00),
        $ListBuild(5, 3, 1, 150.00)
    )
    
    For i = 1:1:$ListLength(orderItemData) {
        Set data = $ListGet(orderItemData, i)
        Set orderItem = ##class(Flowers.OrderItem).%New()
        Set orderItem.Order = orders($ListGet(data, 1))
        Set orderItem.Bouquet = bouquets($ListGet(data, 2))
        Set orderItem.Quantity = $ListGet(data, 3)
        Set orderItem.Subtotal = $ListGet(data, 4)
        Set sc = orderItem.%Save()
        If $$$ISERR(sc) { Write "Error saving order item: ", $System.Status.GetErrorText(sc),! Return sc }
        Set count = count + 1
    }

    Write "Creating Discounts...",!
    Set discountData = $ListBuild(
        $ListBuild("LOVE10", 10, "2025-05-10"),
        $ListBuild("SPRING20", 20, "2025-05-30"),
        $ListBuild("SUMMER15", 15, "2025-06-15"),
        $ListBuild("WINTER25", 25, "2025-12-31")
    )
    
    For i = 1:1:$ListLength(discountData) {
        Set data = $ListGet(discountData, i)
        Set discount = ##class(Flowers.Discount).%New()
        Set discount.Code = $ListGet(data, 1)
        Set discount.Percent = $ListGet(data, 2)
        Set discount.Expiry = $ZDATEH($ListGet(data, 3), 3)
        Set sc = discount.%Save()
        If $$$ISERR(sc) { Write "Error saving discount: ", $System.Status.GetErrorText(sc),! Return sc }
        Set count = count + 1
    }
    
    Write !, "Successfully created ", count, " objects!"
    Return sc
}

ClassMethod ClearAll() As %Status
{
    // Видаляємо в правильному порядку (спочатку дочірні)
    Do ##class(Flowers.OrderItem).%KillExtent()
    Do ##class(Flowers.Order).%KillExtent()
    Do ##class(Flowers.Bouquet).%KillExtent()
    Do ##class(Flowers.Customer).%KillExtent()
    Do ##class(Flowers.Employee).%KillExtent()
    Do ##class(Flowers.Discount).%KillExtent()
    Do ##class(Flowers.Flower).%KillExtent()
    Do ##class(Flowers.Decoration).%KillExtent()
    Return $$$OK
}
}