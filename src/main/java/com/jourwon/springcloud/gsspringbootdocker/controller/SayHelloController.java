package com.jourwon.springcloud.gsspringbootdocker.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;
import java.util.Random;

@RestController
public class SayHelloController {
    private static final Logger log = LoggerFactory.getLogger(SayHelloController.class);
    @GetMapping("/greeting")
    public String greet() {
       log.info("Access /greeting");

        List<String> greetings = Arrays.asList("Hi there", "Greetings", "Salutations");
        Random rand = new Random();

        int randomNum = rand.nextInt(greetings.size());
        return greetings.get(randomNum);
    }

    @GetMapping("/")
    public String home() {
       log.info("Access /");
        return "Hi!";
    }
}
