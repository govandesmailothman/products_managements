<?php

namespace App\Infrastructure\Persistence\Repositories;

use App\Application\Products\DTOs\CreateProductDTO;
use App\Domain\Products\Repositories\ProductRepositoryInterface;
use App\Models\Product;
use Illuminate\Database\Eloquent\Collection;

/**
 * Infrastructure implementation of [ProductRepositoryInterface] using Eloquent ORM.
 */
class EloquentProductRepository implements ProductRepositoryInterface
{
    /**
     * Retrieve all products ordered by latest ID.
     *
     * @return Collection<int, Product>
     */
    public function getAll(): Collection
    {
        return Product::latest('id')->get();
    }

    /**
     * Persist a new product from DTO.
     */
    public function create(CreateProductDTO $dto): Product
    {
        return Product::create($dto->toArray());
    }
}
