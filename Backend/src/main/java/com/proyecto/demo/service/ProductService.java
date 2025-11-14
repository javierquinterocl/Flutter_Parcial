package com.proyecto.demo.service;

import com.proyecto.demo.dto.ProductRequest;
import com.proyecto.demo.dto.ProductResponse;
import com.proyecto.demo.model.Product;
import com.proyecto.demo.repository.ProductRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ProductService {
    private final ProductRepository repository;
    public ProductService(ProductRepository repository) {
        this.repository = repository;
    }

    //CREAR UN NUEVO PRODUCTO
    public ProductResponse crear(ProductRequest request){
        Product entity = new Product();
        entity.setTitle(request.getTitle());
        entity.setPrice(request.getPrice());
        entity.setDescription(request.getDescription());
        entity.setImages(request.getImages() != null ? request.getImages() : new ArrayList<>());
        entity.setCategory(request.getCategory());

        Product guardado = repository.save(entity);
        return new ProductResponse(guardado.getId(),guardado.getTitle(),guardado.getPrice(),guardado.getDescription(),guardado.getImages(),guardado.getCategory(),guardado.getCreatedAt(),guardado.getUpdatedAt());
    }

    //LISTAR TODOS LOS PRODUCTOS
    public List<ProductResponse> listar(){
        return repository.findAll().stream().map(p -> new ProductResponse(p.getId(),p.getTitle(),p.getPrice(),p.getDescription(),p.getImages(),p.getCategory(),p.getCreatedAt(),p.getUpdatedAt())).collect(Collectors.toList());
    }

    //LISTAR POR ID

    public ProductResponse buscarPorId(Long id){
        Product entity = repository.findById(id).orElseThrow(() -> new RuntimeException("Producto no encontrado con el id de la entida de "+id));
        return new ProductResponse(entity.getId(),entity.getTitle(),entity.getPrice(),entity.getDescription(),entity.getImages(),entity.getCategory(),entity.getCreatedAt(),entity.getUpdatedAt());
    }


    //Actualizar producto por ID

    public ProductResponse actualizar(Long id, ProductRequest request){
        Product  entity = repository.findById(id).orElseThrow(() -> new RuntimeException("Producto no encontrado con el id de la entida de "+id));
        entity.setTitle(request.getTitle());
        entity.setPrice(request.getPrice());
        entity.setDescription(request.getDescription());
        entity.setImages(request.getImages() != null ? request.getImages() : new ArrayList<>());
        entity.setCategory(request.getCategory());

        Product actualizado = repository.save(entity);
        return new ProductResponse(actualizado.getId(),actualizado.getTitle(),actualizado.getPrice(),actualizado.getDescription(),actualizado.getImages(),actualizado.getCategory(),actualizado.getCreatedAt(),actualizado.getUpdatedAt());
    }

    //Eliminar Producto

    public void eliminar(Long id){
        if(!repository.existsById(id)){
            throw new RuntimeException("El producto no existe con id " +id);
        }
        repository.deleteById(id);

    }
}
