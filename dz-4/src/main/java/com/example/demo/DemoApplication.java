package com.example.demo;

import java.util.function.Supplier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.util.function.SingletonSupplier;

@SpringBootApplication
public class DemoApplication {

  @Value("${app.version}")
  private String version;

  public static void main(String[] args) {
    SpringApplication.run(DemoApplication.class, args);
  }

  @Bean
  public Supplier<String> version() {
    return SingletonSupplier.of("ver: " + version);
  }

}
