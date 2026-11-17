<?php

namespace App\Application\Products\UseCases;

use App\Domain\Products\Repositories\ProductRepositoryInterface;
use App\Models\Product;
use Illuminate\Database\Eloquent\Collection;

/**
 * Use Case: Retrieve all products in the catalog.
 */
class GetAllProductsUseCase
{
    public function __construct(
        protected ProductRepositoryInterface $repository
    ) {}

    /**
     * Execute the use case.
     *
     * @return Collection<int, Product>
     */
    public function execute(): Collection
    {
        return $this->repository->getAll();
    }
}
