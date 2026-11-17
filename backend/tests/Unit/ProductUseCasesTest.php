<?php

namespace Tests\Unit;

use App\Application\Products\DTOs\CreateProductDTO;
use App\Application\Products\UseCases\CreateProductUseCase;
use App\Application\Products\UseCases\GetAllProductsUseCase;
use App\Domain\Products\Repositories\ProductRepositoryInterface;
use App\Models\Product;
use Illuminate\Database\Eloquent\Collection;
use PHPUnit\Framework\TestCase;

class ProductUseCasesTest extends TestCase
{
    public function test_get_all_products_use_case_delegates_to_repository(): void
    {
        $mockCollection = new Collection([
            new Product(['title' => 'Product 1', 'price' => 10.0]),
            new Product(['title' => 'Product 2', 'price' => 20.0]),
        ]);

        $mockRepo = $this->createMock(ProductRepositoryInterface::class);
        $mockRepo->expects($this->once())
            ->method('getAll')
            ->willReturn($mockCollection);

        $useCase = new GetAllProductsUseCase($mockRepo);
        $result = $useCase->execute();

        $this->assertCount(2, $result);
    }

    public function test_create_product_use_case_delegates_dto_to_repository(): void
    {
        $dto = new CreateProductDTO(
            title: 'Mechanical Keyboard',
            price: 99.99,
            description: 'RGB Backlit',
            imageUrl: 'https://example.com/keyboard.png',
        );

        $mockProduct = new Product([
            'id' => 1,
            'title' => 'Mechanical Keyboard',
            'price' => 99.99,
            'description' => 'RGB Backlit',
            'image_url' => 'https://example.com/keyboard.png',
        ]);

        $mockRepo = $this->createMock(ProductRepositoryInterface::class);
        $mockRepo->expects($this->once())
            ->method('create')
            ->with($dto)
            ->willReturn($mockProduct);

        $useCase = new CreateProductUseCase($mockRepo);
        $result = $useCase->execute($dto);

        $this->assertEquals('Mechanical Keyboard', $result->title);
        $this->assertEquals(99.99, $result->price);
    }
}
