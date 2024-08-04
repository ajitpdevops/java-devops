## Get the images built up locally

```bash
docker compose up -d mvn-coupon

docker compose up -d coupon-app

docker compose up -d mvn-product

docker compose up -d product-app

```

## Testing the API Paths

```bash
# Coupon APP 
POST - http://localhost:8090/couponapi/coupons
{
    "code":"FLASH",
    "discount":15,
    "expDate":"31/12/2024"
}

GET - http://localhost:8090/couponapi/coupons/FLASH 

Health - http://localhost:8090/health

#########################################
# Product APP
#########################################

POST - http://localhost:8091/productapi/products

{
    "name":"Slime",
    "description": "Kids gelly dough",
    "price": 89,
    "couponCode": "FLASH"
}


```