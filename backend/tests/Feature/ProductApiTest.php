<?php

namespace Tests\Feature;

use App\Models\Product;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ProductApiTest extends TestCase
{
    use RefreshDatabase;

    /**
     * Test GET /api/products returns empty array when no products exist.
     */
    public function test_can_get_empty_products_list(): void
    {
        $response = $this->getJson('/api/products');

        $response->assertStatus(200)
            ->assertExactJson([
                'data' => [],
            ]);
    }

    /**
     * Test GET /api/products returns all products formatted by ProductResource.
     */
    public function test_can_get_all_products(): void
    {
        Product::factory()->count(3)->create();

        $response = $this->getJson('/api/products');

        $response->assertStatus(200)
            ->assertJsonCount(3, 'data')
            ->assertJsonStructure([
                'data' => [
                    '*' => [
                        'id',
                        'title',
                        'description',
                        'price',
                        'image_url',
                        'created_at',
                        'updated_at',
                    ],
                ],
            ]);
    }

    /**
     * Test POST /api/products creates a product successfully with all fields.
     */
    public function test_can_create_product_with_valid_data(): void
    {
        $payload = [
            'title' => 'Mechanical Keyboard Pro',
            'description' => 'A custom mechanical keyboard with tactile brown switches.',
            'price' => 149.99,
            'image_url' => 'https://images.unsplash.com/photo-1587829741301-dc798b83add3',
        ];

        $response = $this->postJson('/api/products', $payload);

        $response->assertStatus(201)
            ->assertJsonStructure([
                'data' => [
                    'id',
                    'title',
                    'description',
                    'price',
                    'image_url',
                    'created_at',
                    'updated_at',
                ],
                'message',
            ])
            ->assertJsonPath('data.title', 'Mechanical Keyboard Pro')
            ->assertJsonPath('data.price', 149.99);

        $this->assertDatabaseHas('products', [
            'title' => 'Mechanical Keyboard Pro',
            'price' => 149.99,
        ]);
    }

    /**
     * Test POST /api/products allows nullable description and image_url.
     */
    public function test_can_create_product_with_nullable_fields(): void
    {
        $payload = [
            'title' => 'Minimal Stand',
            'price' => 25.50,
            'description' => null,
            'image_url' => null,
        ];

        $response = $this->postJson('/api/products', $payload);

        $response->assertStatus(201)
            ->assertJsonPath('data.title', 'Minimal Stand')
            ->assertJsonPath('data.price', 25.50)
            ->assertJsonPath('data.description', null)
            ->assertJsonPath('data.image_url', null);

        $this->assertDatabaseHas('products', [
            'title' => 'Minimal Stand',
            'price' => 25.50,
            'description' => null,
            'image_url' => null,
        ]);
    }

    /**
     * Test POST /api/products returns 422 when required fields are missing.
     */
    public function test_validation_fails_when_title_or_price_missing(): void
    {
        $response = $this->postJson('/api/products', []);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['title', 'price']);
    }

    /**
     * Test POST /api/products returns 422 when price is negative or non-numeric.
     */
    public function test_validation_fails_when_price_is_negative(): void
    {
        $response = $this->postJson('/api/products', [
            'title' => 'Invalid Product',
            'price' => -10.00,
        ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['price']);
    }

    /**
     * Test POST /api/products returns 422 when image_url is not a valid URL.
     */
    public function test_validation_fails_when_image_url_is_invalid(): void
    {
        $response = $this->postJson('/api/products', [
            'title' => 'Valid Title',
            'price' => 29.99,
            'image_url' => 'not-a-valid-url',
        ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['image_url']);
    }

    /**
     * Test POST /api/products allows valid long image URLs up to 2048 characters.
     */
    public function test_can_create_product_with_long_image_url(): void
    {
        $longUrl = 'https://images.unsplash.com/photo-example?param='.str_repeat('a', 300);

        $response = $this->postJson('/api/products', [
            'title' => 'Product with Long URL',
            'price' => 49.99,
            'image_url' => $longUrl,
        ]);

        $response->assertStatus(201)
            ->assertJsonPath('data.image_url', $longUrl);
    }

    /**
     * Test POST /api/products returns 422 when image_url exceeds 2048 characters.
     */
    public function test_validation_fails_when_image_url_exceeds_max_length(): void
    {
        $excessiveUrl = 'https://example.com/?query='.str_repeat('x', 2050);

        $response = $this->postJson('/api/products', [
            'title' => 'Product with Excessive URL',
            'price' => 49.99,
            'image_url' => $excessiveUrl,
        ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['image_url']);
    }
}
