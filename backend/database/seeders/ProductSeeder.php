<?php

namespace Database\Seeders;

use App\Models\Product;
use Illuminate\Database\Seeder;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $products = [
            [
                'title' => 'Wireless Noise-Canceling Headphones',
                'description' => 'Premium over-ear wireless headphones with active noise cancellation, 30-hour battery life, and crystal-clear sound quality.',
                'price' => 199.99,
                'image_url' => 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600&auto=format&fit=crop&q=80',
            ],
            [
                'title' => 'Minimalist Mechanical Keyboard',
                'description' => 'Custom mechanical keyboard with hot-swappable switches, RGB backlighting, and durable PBT keycaps.',
                'price' => 129.50,
                'image_url' => 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=600&auto=format&fit=crop&q=80',
            ],
            [
                'title' => 'Ergonomic Precision Mouse',
                'description' => 'Comfortable ergonomic wireless mouse designed for productivity, featuring dual connectivity and ultra-fast scrolling.',
                'price' => 79.99,
                'image_url' => 'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=600&auto=format&fit=crop&q=80',
            ],
            [
                'title' => 'Ultra HD 4K Monitor 27-inch',
                'description' => 'Vibrant IPS display with 99% sRGB color accuracy, USB-C connectivity, and height-adjustable ergonomic stand.',
                'price' => 389.00,
                'image_url' => 'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=600&auto=format&fit=crop&q=80',
            ],
            [
                'title' => 'Smart Fitness Watch',
                'description' => 'Advanced fitness tracker with AMOLED touch screen, heart rate monitor, sleep tracking, and 7-day battery life.',
                'price' => 149.95,
                'image_url' => 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600&auto=format&fit=crop&q=80',
            ],
            [
                'title' => 'Leather Laptop Sleeve',
                'description' => 'Handcrafted genuine leather sleeve with soft microfiber interior lining suitable for up to 14-inch laptops.',
                'price' => 45.00,
                'image_url' => 'https://images.unsplash.com/photo-1544816155-12df9643f363?w=600&auto=format&fit=crop&q=80',
            ],
            [
                'title' => 'Portable Bluetooth Speaker',
                'description' => 'Compact waterproof Bluetooth speaker with 360-degree sound projection and built-in power bank.',
                'price' => 59.99,
                'image_url' => 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=600&auto=format&fit=crop&q=80',
            ],
            [
                'title' => 'USB-C Multiport Docking Station',
                'description' => '10-in-1 USB-C hub with 4K HDMI, Gigabit Ethernet, 100W Power Delivery, and SD card reader.',
                'price' => 64.99,
                'image_url' => 'https://images.unsplash.com/photo-1616440347437-b1c73416efc2?w=600&auto=format&fit=crop&q=80',
            ],
        ];

        foreach ($products as $product) {
            Product::create($product);
        }
    }
}
