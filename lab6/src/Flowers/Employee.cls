Class Flowers.Employee Extends (%Persistent)
{
Property Name As %String;
Property Position As %String;
Property Supervisor As Flowers.Employee;
Query AllEmployees() As %SQLQuery
{
    SELECT ID, Name, Position, Supervisor FROM Flowers.Employee ORDER BY Name
}
Query EmployeesWithSupervisors() As %Query(ROWSPEC = "Name:%String,SupervisorName:%String")
{
}
ClassMethod EmployeesWithSupervisorsExecute(ByRef qHandle As %Binary) As %Status
{
    Set qHandle = ""
    Quit $$$OK
}
ClassMethod EmployeesWithSupervisorsFetch(ByRef qHandle As %Binary, ByRef Row As %List, ByRef AtEnd As %Integer = 0) As %Status
{
    Set id = $Order(^Flowers.EmployeeD(qHandle))
    If id = "" { Set AtEnd = 1, Row = "" Quit $$$OK }
    Set qHandle = id
    Set emp = ##class(Flowers.Employee).%OpenId(id)
    Set supName = ""
    If $IsObject(emp.Supervisor) Set supName = emp.Supervisor.Name
    Set Row = $ListBuild(emp.Name, supName)
    Quit $$$OK
}
ClassMethod EmployeesWithSupervisorsClose(ByRef qHandle As %Binary) As %Status
{
    Quit $$$OK
}
}
