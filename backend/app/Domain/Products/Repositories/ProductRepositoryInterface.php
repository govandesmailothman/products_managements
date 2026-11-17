<?php

namespace App\Domain\Products\Repositories;

use App\Application\Products\DTOs\CreateProductDTO;
use App\Models\Product;
use Illuminate\Database\Eloquent\Collection;

/**
 * Domain Contract for Product Repository.
 * Decouples domain logic from persistence mechanisms (DIP).
 */
interface ProductRepositoryInterface
{
    /**
     * Retrieve all products ordered by the most recently created.
     *
     * @return Collection<int, Product>
     */
    public function getAll(): Collection;

    /**
     * Create and persist a new product.
     */
    public function create(CreateProductDTO $dto): Product;
}
