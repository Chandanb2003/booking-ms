package com.example.booking_ms;

public class Hotel {
    public static void main(String[] args) {
        double originalPrice = 1000.0; // Example original price
        double discountRate = 0.10;   // 10% discount
        double offerPrice = calculateOfferPrice(originalPrice, discountRate);

        System.out.printf("Book your hotel at a %d%% discount rate: ₹%.2f%n",
                (int) (discountRate * 100), offerPrice);
    }

    /**
     * Method to calculate the discounted price.
     * @param price The original price.
     * @param discountRate The discount rate (e.g., 0.10 for 10%).
     * @return The price after applying the discount.
     */
    private static double calculateOfferPrice(double price, double discountRate) {
        return price * (1 - discountRate);
    }
}