<?php

namespace App\Domain\Products\Entities;

/**
 * Domain entity representing a Product business model.
 * Independent of Eloquent ORM or HTTP frameworks.
 */
class ProductEntity
{
    public function __construct(
        public readonly ?int $id,
        public readonly string $title,
        public readonly float $price,
        public readonly ?string $description = null,
        public readonly ?string $imageUrl = null,
        public readonly ?\DateTimeInterface $createdAt = null,
        public readonly ?\DateTimeInterface $updatedAt = null,
    ) {
        if (trim($this->title) === '') {
            throw new \InvalidArgumentException('Product title cannot be empty.');
        }

        if ($this->price < 0) {
            throw new \InvalidArgumentException('Product price cannot be negative.');
        }
    }

    /**
     * Convert entity to plain array.
     *
     * @return array<string, mixed>
     */
    public function toArray(): array
    {
        return [
            'id' => $this->id,
            'title' => $this->title,
            'price' => $this->price,
            'description' => $this->description,
            'image_url' => $this->imageUrl,
            'created_at' => $this->createdAt?->format(\DateTimeInterface::ATOM),
            'updated_at' => $this->updatedAt?->format(\DateTimeInterface::ATOM),
        ];
    }
}
