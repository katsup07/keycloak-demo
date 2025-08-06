package com.keycloakdemo.server;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class KeycloakDemoServerApplication {

	public static void main(String[] args) {
		SpringApplication.run(KeycloakDemoServerApplication.class, args);
	}

}
