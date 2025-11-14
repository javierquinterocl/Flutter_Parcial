package com.proyecto.demo.controller;
import org.springframework.web.bind.annotation.*;
import com.proyecto.demo.dto.ProductRequest;
import com.proyecto.demo.dto.ProductResponse;
import com.proyecto.demo.service.ProductService;

import java.util.List;

@RestController
@RequestMapping("/product")
@CrossOrigin(origins = "*")
public class ProductController {

    private final ProductService service;

    public ProductController(ProductService service){

        this.service = service;
    }

    @PostMapping
    public ProductResponse crear(@RequestBody ProductRequest request){
        return service.crear(request);
    }
    //http: //localhost:8080/product

    @GetMapping
    public List<ProductResponse> listar(){
        return service.listar();
    }
    //http: //localhost:8080/product/id

    @GetMapping("/{id}")
    public ProductResponse buscarPorId(@PathVariable Long id){
        return service.buscarPorId(id);
    }
    //http: //localhost:8080/product/id

    @PutMapping("/{id}")
    public ProductResponse actualizar(@PathVariable Long id, @RequestBody ProductRequest request){
        return service.actualizar(id, request);
    }
    //http: //localhost:8080/product/id

    @DeleteMapping("/{id}")
    public void eliminar(@PathVariable Long id){
        service.eliminar(id);
    }

}

