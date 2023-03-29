import ballerina/http;

type Product record {
    string id;
    string name;
    string description;
    string imageUrl;
    decimal price;
    string 'type;
};

table<Product> products = table[];
service / on new http:Listener(9090) {

    resource function get products() returns Product[]|error {
        Product[] prod = from Product p in products select p;
        return prod;
    }

    resource function get products/[string id]() returns Product|error {
        Product[] prodc = from Product p in products where p.id == id limit 1 select p;
        return prodc[0];
    }

    resource function post products(@http:Payload Product p) returns error|http:Created {
        products.add(p);
        return http:CREATED;
    }

    resource function put products/[string id](@http:Payload Product p) returns http:Accepted|error {
        Product[] prodc = from Product pp in products where p.id == id limit 1 select pp;
        prodc[0].name = p.name;
        prodc[0].description = p.description;
        prodc[0].imageUrl = p.imageUrl;
        prodc[0].price = p.price;
        prodc[0].'type = p.'type;
        return http:ACCEPTED;
    }

    resource function delete products/[string id]() {
        
    }
}
