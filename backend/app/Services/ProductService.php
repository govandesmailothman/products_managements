<?php

namespace App\Services;

use App\Application\Products\DTOs\CreateProductDTO;
use App\Application\Products\UseCases\CreateProductUseCase;
use App\Application\Products\UseCases\GetAllProductsUseCase;
use App\Models\Product;
use Illuminate\Database\Eloquent\Collection;

/**
 * Service facade delegating to Clean Architecture Use Cases.
 */
class ProductService
{
    public function __construct(
        protected GetAllProductsUseCase $getAllProductsUseCase,
        protected CreateProductUseCase $createProductUseCase,
    ) {}

    /**
     * Retrieve all products ordered by the most recently created.
     *
     * @return Collection<int, Product>
     */
    public function getAllProducts(): Collection
    {
        return $this->getAllProductsUseCase->execute();
    }

    /**
     * Create a new product with validated data.
     *
     * @param  array<string, mixed>  $data
     */
    public function createProduct(array $data): Product
    {
        return $this->createProductUseCase->execute(CreateProductDTO::fromArray($data));
    }
}
