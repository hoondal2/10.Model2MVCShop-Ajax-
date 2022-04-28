package com.model2.mvc.web.product;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;


@RestController
@RequestMapping("/product/*")
public class ProductRestController {

	///Field
		@Autowired
		@Qualifier("productServiceImpl")
		private ProductService productService;
		//setter Method 구현 않음
		
		public ProductRestController(){
			System.out.println(this.getClass());
		}
		
		@Value("#{commonProperties['pageUnit']}")
		int pageUnit;
		@Value("#{commonProperties['pageSize']}")
		int pageSize;
		
		@RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET )
		public Product getProduct( @PathVariable int prodNo ) throws Exception{
			
			System.out.println("/product/json/getProduct : GET");
			
			//Business Logic
			return productService.getProduct(prodNo);
		}
		
		@RequestMapping( value="json/addProduct", method=RequestMethod.POST )
		public Product addProduct( @RequestBody Product product) throws Exception{
			
			System.out.println("/product/json/addProduct : POST");
			
			//Business Logic
			productService.addProduct(product);
			
			return product;
		}
		
		@RequestMapping( value="json/updateProduct", method=RequestMethod.POST )
		public Product updateProduct( @RequestBody Product product) throws Exception{
			
			System.out.println("/product/json/updateProduct : POST");
			
			//Business Logic
			productService.updateProduct(product);
			
			return product;
		}
		
		@RequestMapping(value="json/listProduct")
		public Map<String, Object> listProduct( @RequestBody Search search) throws Exception{
			
			System.out.println("/product/listProduct : GET / POST");
			
			if(search.getCurrentPage() ==0 ){
				search.setCurrentPage(1);
			}
			
			search.setPageSize(pageSize);
			
			// Business logic 수행
			Map<String , Object> map=productService.getProductList(search);
			
			Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
			System.out.println(resultPage);
			
			return map;
		}
		
}
