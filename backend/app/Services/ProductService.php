<?php

namespace App\Services;

use App\Models\Product;
use Illuminate\Database\Eloquent\Collection;

class ProductService
{
    /**
     * Retrieve all products ordered by the most recently created.
     *
     * @return Collection<int, Product>
     */
    public function getAllProducts(): Collection
    {
        return Product::latest('id')->get();
    }

    /**
     * Create a new product with validated data.
     *
     * @param  array<string, mixed>  $data
     */
    public function createProduct(array $data): Product
    {
        return Product::create($data);
    }
}
