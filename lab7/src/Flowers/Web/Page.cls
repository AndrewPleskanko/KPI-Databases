Class Flowers.Web.Page Extends %CSP.Page
{

ClassMethod OnPage() As %Status
{
    &html<<!DOCTYPE html>
<html>
<head>
    <title>Flower Shop - Lab 7</title>
    <style>
        body { font-family: Arial; margin: 20px; background: #f5f5f5; }
        h1 { color: #2e7d32; }
        table { border-collapse: collapse; width: 100%; background: white; margin: 10px 0; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background: #4caf50; color: white; }
        tr:hover { background: #f1f1f1; }
        .btn { padding: 8px 16px; margin: 5px; cursor: pointer; border: none; border-radius: 4px; }
        .btn-add { background: #4caf50; color: white; }
        .btn-edit { background: #ff9800; color: white; }
        .btn-del { background: #f44336; color: white; }
        .section { background: white; padding: 20px; margin: 20px 0; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        input { padding: 8px; margin: 5px; border: 1px solid #ddd; border-radius: 4px; }
        pre { background: #263238; color: #aed581; padding: 15px; border-radius: 4px; overflow-x: auto; }
    </style>
</head>
<body>
    <h1>Flower Shop - Lab 7</h1>
    
    <div class="section">
        <h2>Flowers Table (Direct DB Access)</h2>
        <button class="btn btn-add" onclick="showForm()">+ Add</button>
        <table>
            <tr><th>ID</th><th>Name</th><th>Color</th><th>Price</th><th>SKU</th><th>Actions</th></tr>>
    
    Set rs = ##class(%SQL.Statement).%ExecDirect(,"SELECT ID,Name,Color,Price,Sku FROM Flowers.Flower")
    While rs.%Next() {
        Set id=rs.ID, n=rs.Name, c=rs.Color, p=rs.Price, s=rs.Sku
        &html<<tr>
            <td>#(id)#</td><td>#(n)#</td><td>#(c)#</td><td>#(p)#</td><td>#(s)#</td>
            <td>
                <button class="btn btn-edit" onclick="editFlower(#(id)#,'#(n)#','#(c)#',#(p)#,'#(s)#')">Edit</button>
                <button class="btn btn-del" onclick="deleteFlower(#(id)#)">Delete</button>
            </td>
        </tr>>
    }
    
    &html<</table>
    </div>
    
    <div class="section" id="formSection" style="display:none">
        <h3 id="formTitle">Add Flower</h3>
        <input type="hidden" id="fId">
        <input id="fName" placeholder="Name">
        <input id="fColor" placeholder="Color">
        <input id="fPrice" type="number" placeholder="Price">
        <input id="fSku" placeholder="SKU">
        <button class="btn btn-add" onclick="saveFlower()">Save</button>
    </div>
    
    <div class="section">
        <h2>REST API Client</h2>
        <button class="btn btn-add" onclick="restGet()">GET /flowers</button>
        <pre id="restResult">Click button to test REST API</pre>
    </div>
    
    <div class="section">
        <h2>SOAP Client</h2>
        <button class="btn btn-add" onclick="soapGet()">GetAllFlowers</button>
        <pre id="soapResult">Click button to test SOAP</pre>
    </div>

<script>
const API = '/api/flowers/flowers';

function showForm() { 
    document.getElementById('formSection').style.display='block';
    document.getElementById('formTitle').textContent='Add Flower';
    document.getElementById('fId').value='';
}

function editFlower(id,n,c,p,s) {
    showForm();
    document.getElementById('formTitle').textContent='Edit Flower';
    document.getElementById('fId').value=id;
    document.getElementById('fName').value=n;
    document.getElementById('fColor').value=c;
    document.getElementById('fPrice').value=p;
    document.getElementById('fSku').value=s;
}

function saveFlower() {
    const id = document.getElementById('fId').value;
    const data = {
        name: document.getElementById('fName').value,
        color: document.getElementById('fColor').value,
        price: parseFloat(document.getElementById('fPrice').value),
        sku: document.getElementById('fSku').value
    };
    fetch(API + (id ? '/'+id : ''), {
        method: id ? 'PUT' : 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify(data)
    }).then(() => location.reload());
}

function deleteFlower(id) {
    if(confirm('Delete?')) fetch(API+'/'+id, {method:'DELETE'}).then(() => location.reload());
}

function restGet() {
    fetch(API).then(r=>r.json()).then(d => {
        document.getElementById('restResult').textContent = JSON.stringify(d, null, 2);
    });
}

function soapGet() {
    const envelope = `<?xml version="1.0"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Body><GetAllFlowers xmlns="http://flowers.example.com"/></soap:Body></soap:Envelope>`;
    fetch('/csp/user/Flowers.API.SOAP.cls', {
        method: 'POST',
        headers: {'Content-Type': 'text/xml', 'SOAPAction': 'http://flowers.example.com/GetAllFlowers'},
        body: envelope
    }).then(r=>r.text()).then(d => {
        document.getElementById('soapResult').textContent = d;
    });
}
</script>
</body>
</html>>
    Return $$$OK
}

}
