<?php

namespace App\Application\Products\UseCases;

use App\Application\Products\DTOs\CreateProductDTO;
use App\Domain\Products\Repositories\ProductRepositoryInterface;
use App\Models\Product;

/**
 * Use Case: Create and persist a new product with domain validation.
 */
class CreateProductUseCase
{
    public function __construct(
        protected ProductRepositoryInterface $repository
    ) {}

    /**
     * Execute the use case.
     */
    public function execute(CreateProductDTO $dto): Product
    {
        return $this->repository->create($dto);
    }
}
