package com.example.booking_ms;


import org.springframework.web.bind.annotation.GetMapping;

public class bus {
    @GetMapping("/bus")
    public String getData() {return  "Please book your hotel ticket for shimla t 35% discount" ; }
}

