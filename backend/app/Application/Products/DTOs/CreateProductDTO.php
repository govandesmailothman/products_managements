<?php

namespace App\Application\Products\DTOs;

/**
 * Data Transfer Object for creating a product.
 */
readonly class CreateProductDTO
{
    public function __construct(
        public string $title,
        public float $price,
        public ?string $description = null,
        public ?string $imageUrl = null,
    ) {}

    /**
     * Create DTO from an associative array.
     *
     * @param  array<string, mixed>  $data
     */
    public static function fromArray(array $data): self
    {
        return new self(
            title: (string) ($data['title'] ?? ''),
            price: (float) ($data['price'] ?? 0.0),
            description: isset($data['description']) ? (string) $data['description'] : null,
            imageUrl: isset($data['image_url']) ? (string) $data['image_url'] : null,
        );
    }

    /**
     * Convert DTO to Eloquent fillable array.
     *
     * @return array<string, mixed>
     */
    public function toArray(): array
    {
        return array_filter([
            'title' => $this->title,
            'price' => $this->price,
            'description' => $this->description,
            'image_url' => $this->imageUrl,
        ], fn ($val) => $val !== null);
    }
}
