package de.htwg.cloud.qrcode;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@SpringBootApplication
public class TerraformApplication {

    @GetMapping("/")
    public String hello() {
        return "Terraform microservice works! :)  - path: '/'";
    }

    public static void main(String[] args) {
        SpringApplication.run(TerraformApplication.class, args);
    }

}
