package com.ideas.springcloud.controllers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import com.ideas.springcloud.dto.Coupon;
import com.ideas.springcloud.model.Product;
import com.ideas.springcloud.repos.ProductRepo;

@RestController
@RequestMapping("/productapi")
public class ProductRestController {

    @Autowired
    private ProductRepo repo;

	@Autowired
	private RestTemplate restTemplate;

	// @Value("${couponService.url}")
	// private String couponServiceURL;

    private String couponServiceURL = System.getenv("COUPON_SERVICE_URL");

    @RequestMapping(value = "/products", method = RequestMethod.POST)
    public Product create(@RequestBody Product product) {
        Coupon coupon = restTemplate.getForObject(couponServiceURL + product.getCouponCode(), Coupon.class);
		product.setPrice(product.getPrice().subtract(coupon.getDiscount()));
        // Coupon coupon = restTemplate.getForObject(couponServiceURL + product.getCouponCode(), Coupon.class);
        // product.setPrice(product.getPrice().subtract(coupon.getDiscount()));
        return repo.save(product);
    }
}
