<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreProductRequest;
use App\Http\Resources\ProductResource;
use App\Services\ProductService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Symfony\Component\HttpFoundation\Response;

class ProductController extends Controller
{
    /**
     * Inject the ProductService for clean separation of concerns.
     */
    public function __construct(
        protected ProductService $productService
    ) {}

    /**
     * Display a listing of all products.
     *
     * GET /api/products
     */
    public function index(): AnonymousResourceCollection
    {
        $products = $this->productService->getAllProducts();

        return ProductResource::collection($products);
    }

    /**
     * Store a newly created product in storage.
     *
     * POST /api/products
     */
    public function store(StoreProductRequest $request): JsonResponse
    {
        $product = $this->productService->createProduct($request->validated());

        return (new ProductResource($product))
            ->additional([
                'message' => 'Product created successfully',
            ])
            ->response()
            ->setStatusCode(Response::HTTP_CREATED);
    }
}
