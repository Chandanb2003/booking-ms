package com.example.booking_ms;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class flight {
    @GetMapping("/flight")
    public String getData() {
        return "Please book your vacation from Indigo kindly book ticket for New Delhi to anywhere at 10% discount";
    }
}
