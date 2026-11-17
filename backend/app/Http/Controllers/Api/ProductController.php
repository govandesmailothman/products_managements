<?php

namespace App\Http\Controllers\Api;

use App\Application\Products\DTOs\CreateProductDTO;
use App\Application\Products\UseCases\CreateProductUseCase;
use App\Application\Products\UseCases\GetAllProductsUseCase;
use App\Http\Controllers\Controller;
use App\Http\Requests\StoreProductRequest;
use App\Http\Resources\ProductResource;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Symfony\Component\HttpFoundation\Response;

class ProductController extends Controller
{
    /**
     * Inject Application Use Cases according to Clean Architecture.
     */
    public function __construct(
        protected GetAllProductsUseCase $getAllProductsUseCase,
        protected CreateProductUseCase $createProductUseCase,
    ) {}

    /**
     * Display a listing of all products.
     *
     * GET /api/products
     */
    public function index(): AnonymousResourceCollection
    {
        $products = $this->getAllProductsUseCase->execute();

        return ProductResource::collection($products);
    }

    /**
     * Store a newly created product in storage.
     *
     * POST /api/products
     */
    public function store(StoreProductRequest $request): JsonResponse
    {
        $dto = CreateProductDTO::fromArray($request->validated());
        $product = $this->createProductUseCase->execute($dto);

        return (new ProductResource($product))
            ->additional([
                'message' => 'Product created successfully',
            ])
            ->response()
            ->setStatusCode(Response::HTTP_CREATED);
    }
}
